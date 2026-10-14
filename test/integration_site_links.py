#!/usr/bin/env python3
"""Check local links, assets and fragments in the exact generated site."""
from html.parser import HTMLParser
from pathlib import Path
from urllib.parse import unquote, urljoin, urlsplit
import sys


class Document(HTMLParser):
    def __init__(self, path):
        super().__init__(convert_charrefs=True)
        self.ids = set()
        self.links = []
        self.feed(path.read_text(encoding="utf-8"))

    def handle_starttag(self, tag, attrs):
        attrs = dict(attrs)
        if attrs.get("id"):
            self.ids.add(attrs["id"])
        if tag == "a" and attrs.get("name"):
            self.ids.add(attrs["name"])
        for name in ("href", "src"):
            if attrs.get(name):
                self.links.append((tag, attrs[name]))


root = Path(sys.argv[1] if len(sys.argv) > 1 else "_site").resolve()
origin = "https://kaoru-sumi.github.io"
html = {path: Document(path) for path in root.rglob("*.html") if "assets" not in path.relative_to(root).parts}
assert html, "No generated HTML files to check"
errors = []
checked = 0
for path, doc in html.items():
    route = "/" + path.relative_to(root).as_posix()
    if route.endswith("index.html"):
        route = route[:-10]
    for tag, link in doc.links:
        target = urlsplit(urljoin(origin + route, link))
        if target.scheme not in ("http", "https") or target.netloc != urlsplit(origin).netloc:
            continue
        local = root / unquote(target.path).lstrip("/")
        if local.is_dir():
            local /= "index.html"
        checked += 1
        if not local.is_file():
            errors.append(f"{route}: missing {tag} target {link}")
        elif tag == "a" and target.fragment and not target.fragment.startswith(":~:text="):
            fragment = unquote(target.fragment)
            # Empty # and #top are permitted browser document-top links.
            if fragment != "top" and local.suffix == ".html":
                destination = html.get(local) or Document(local)
                if fragment not in destination.ids:
                    errors.append(f"{route}: missing fragment {link}")
if errors:
    raise SystemExit("\n".join(sorted(set(errors))))
print(f"Local links passed: {len(html)} pages, {checked} local links/assets/fragments.")
