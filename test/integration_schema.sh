#!/usr/bin/env bash
set -euo pipefail

tmp_dir="$(mktemp -d)"
trap 'rm -rf "${tmp_dir}"' EXIT
printf 'imagemagick:\n  enabled: false\n' >"${tmp_dir}/config.yml"
JEKYLL_ENV=production bundle exec jekyll build \
  --config "_config.yml,${tmp_dir}/config.yml" -d "${tmp_dir}/site" >/dev/null

bundle exec ruby - "${tmp_dir}/site" <<'RUBY'
require 'json'
require 'nokogiri'

expected = [
  'https://researchmap.jp/kaorusumi?lang=en',
  'https://scholar.google.com/citations?user=6D0WgUMAAAAJ',
  'https://orcid.org/0000-0002-0514-1510',
  'https://www.linkedin.com/in/kaoru-sumi-38862110'
]

%w[index.html publications/index.html ja/index.html].each do |path|
  page = Nokogiri::HTML(File.read(File.join(ARGV.fetch(0), path)))
  scripts = page.css('script[type="application/ld+json"]')
  abort "Missing JSON-LD in #{path}" if scripts.empty?
  schemas = scripts.map { |script| JSON.parse(script.content) }
  schema = schemas.find { |data| data.is_a?(Hash) && data['@type'] == 'WebSite' }
  abort "Unexpected sameAs in #{path}: #{schema.inspect}" unless schema && schema['sameAs'] == expected
end

home = Nokogiri::HTML(File.read(File.join(ARGV.fetch(0), 'index.html')))
abort 'CV PDF link missing from home page' unless
  home.css('a').any? { |link| link['href'].to_s.end_with?('/assets/pdf/Kaoru_Sumi_CV.pdf') }
abort 'CV PDF asset missing' unless File.file?(File.join(ARGV.fetch(0), 'assets/pdf/Kaoru_Sumi_CV.pdf'))
puts 'Schema integration test passed: valid JSON-LD, four profile URLs, and CV link preserved.'
RUBY
