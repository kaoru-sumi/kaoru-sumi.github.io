#!/usr/bin/env bash
set -euo pipefail

# Check either the actual deployment output or a fresh production build.
if [[ $# -gt 0 ]]; then
  site_dir="$1"
else
  tmp_dir="$(mktemp -d)"
  trap 'rm -rf "${tmp_dir}"' EXIT
  site_dir="${tmp_dir}/site"
  JEKYLL_ENV=production bundle exec jekyll build -d "${site_dir}" >/dev/null
fi

python3 - "${site_dir}" <<'PY'
from pathlib import Path
import re
import sys
from urllib.parse import urlparse
import xml.etree.ElementTree as ET

site = Path(sys.argv[1])
demo_roots = ('people', 'teaching', 'teachings', 'blog', 'plugins', 'repositories', 'books', 'dropdown')
for root in demo_roots:
    assert not (site / root).exists(), f'Demo route generated: /{root}/'
for root in ('_posts', '_books', '_teachings', 'test'):
    assert not (site / root).exists(), f'Fixture source published: {root}'

required = ('index.html', 'research/index.html', 'lab/index.html', 'publications/index.html',
            'news/index.html', 'ja/index.html', 'ja/research/index.html', 'ja/lab/index.html',
            'ja/awards/index.html', 'ja/contact/index.html')
for path in required:
    assert (site / path).is_file(), f'Real page missing: {path}'
assert list((site / 'projects').rglob('index.html')), 'Research project pages missing'

sitemap = ET.parse(site / 'sitemap.xml')
urls = [node.text for node in sitemap.iter() if node.tag.endswith('}loc')]
assert urls, 'Empty sitemap'
for url in urls:
    parts = urlparse(url).path.strip('/').split('/')
    assert not any(root in parts for root in demo_roots), f'Demo in sitemap: {url}'

# al_search embeds its index as ninja.data in each HTML page.
search_indexes = []
for path in site.rglob('*.html'):
    search_indexes.extend((path, match.group(1)) for match in re.finditer(
        r'<script[^>]*>(.*?)</script>', path.read_text(), re.S)
        if 'ninja.data' in match.group(1))
assert search_indexes, 'Generated inline search index missing'
markers = ('a post with plotly.js', 'google-gemini-update-flash-ai-assistant',
           '555 your office number', '123 your address street', 'test@gmail.com',
           'The Godfather', 'Introduction to Machine Learning', 'Data Science Fundamentals')
for path, content in search_indexes:
    assert 'nav-research' in content and 'nav-publications' in content, f'Real search navigation missing: {path}'
    assert not re.search(r'id:\s*["\']post-', content), f'Sample post in search index: {path}'
    for marker in markers:
        assert marker.lower() not in content.lower(), f'Demo search content in {path}: {marker}'
    assert not re.search(r'/(?:people|teaching|teachings|blog|plugins|repositories|books)/', content), f'Demo URL in {path}'

# Feeds and generated HTML must not retain external/demo post content either.
for path in [*site.rglob('*.html'), site / 'feed.xml']:
    if path.is_file():
        content = path.read_text()
        for marker in markers[:5]:
            assert marker.lower() not in content.lower(), f'Demo content in {path}: {marker}'
print(f'Production content checks passed: routes, {len(urls)} sitemap URLs, {len(search_indexes)} inline search indexes, real pages and projects')
PY
