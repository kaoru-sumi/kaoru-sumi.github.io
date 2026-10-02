#!/usr/bin/env bash
set -euo pipefail

# Exercise Scholar's editor-only CSL rendering without a core layout override.
tmp_dir="$(mktemp -d)"
trap 'rm -rf "${tmp_dir}"' EXIT
printf 'imagemagick:\n  enabled: false\n' >"${tmp_dir}/config.yml"
JEKYLL_ENV=production bundle exec jekyll build \
  --config "_config.yml,${tmp_dir}/config.yml" -d "${tmp_dir}/site" >/dev/null

bundle exec ruby - "${tmp_dir}/site/publications/index.html" <<'RUBY'
require 'bibtex'
require 'nokogiri'

key = 'Sumi_2026_Persuasive_Technology'
bib = BibTeX.open('_bibliography/papers.bib')
entry = bib[key]
abort 'Proceedings must retain editor metadata without an author field' unless
  entry.type == :proceedings && entry[:editor] && !entry[:author]

page = Nokogiri::HTML(File.read(ARGV.fetch(0)))
nodes = page.css("[id='#{key}']")
abort 'Proceedings must appear exactly once' unless nodes.length == 1
text = nodes.first.text.gsub(/\s+/, ' ').strip
abort "Missing full editor names: #{text}" unless
  text.include?('Kaoru Sumi, Raian Ali, and Roberto Legaspi')
abort "Missing editor role: #{text}" unless text.match?(/\(eds?\.\)/i)
abort 'Missing proceedings title' unless text.include?('Persuasive Technology')
abort 'Missing DOI' unless text.include?('10.1007/978-3-032-19687-3')

# Ensure the exclusion query does not lose any other recent publications.
bib.query('@*[year>=2024 && category!=book2026]').each do |item|
  abort "Publication missing or duplicated: #{item.key}" unless
    page.css("[id='#{item.key}']").length == 1
end
puts 'Proceedings editor integration test passed.'
RUBY
