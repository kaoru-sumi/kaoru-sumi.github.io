#!/usr/bin/env bash
set -euo pipefail

# Exercise Scholar's editor-only CSL rendering without a core layout override.
if [[ $# -gt 0 ]]; then
  site_dir="$1"
else
  tmp_dir="$(mktemp -d)"
  trap 'rm -rf "${tmp_dir}"' EXIT
  printf 'imagemagick:\n  enabled: false\n' >"${tmp_dir}/config.yml"
  JEKYLL_ENV=production bundle exec jekyll build \
    --config "_config.yml,${tmp_dir}/config.yml" -d "${tmp_dir}/site" >/dev/null
  site_dir="${tmp_dir}/site"
fi

bundle exec ruby - "${site_dir}/publications/index.html" <<'RUBY'
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
abort 'Missing proceedings DOI link' unless
  nodes.first.ancestors('li').first.css('a').any? { |a| a['href'] == 'https://doi.org/10.1007/978-3-032-19687-3' }

# Ensure the exclusion query does not lose any other recent publications.
bib.query('@*[year>=2024 && category!=book2026]').each do |item|
  abort "Publication missing or duplicated: #{item.key}" unless
    page.css("[id='#{item.key}']").length == 1
end
# Springer cites the Satellite Events paper as 2027 despite its 2026 online date.
# Verify the generated page, since future-year entries must remain visible.
paper_key = 'Salem_2027_Designing_Persuasive_Social_Robots'
paper = bib[paper_key]
abort 'Satellite paper must use the official citation year' unless
  paper.type == :inproceedings && paper[:year].to_s == '2027'
abort 'Online publication date must be recorded separately' unless
  paper[:note].to_s == 'First online: 2 September 2026'
paper_nodes = page.css("[id='#{paper_key}']")
abort 'Satellite paper must appear exactly once' unless paper_nodes.length == 1
paper_text = paper_nodes.first.text.gsub(/\s+/, ' ').strip
puts "Rendered satellite paper: #{paper_text}"
[
  'Designing Persuasive Social Robots: Modulating Embarrassment Through Personality and Appearance',
  'Ahmed Salem', 'Kaoru Sumi', '2027',
  'Persuasive Technology. PERSUASIVE 2026 Satellite Events', '2896'
].each do |expected|
  abort "Missing satellite paper metadata: #{expected}" unless paper_text.include?(expected)
end
abort 'Missing satellite paper page range' unless paper_text.match?(/178\s*[–-]+\s*190/)
abort 'Missing satellite paper DOI link' unless
  paper_nodes.first.css('a').any? { |a| a['href'] == 'https://doi.org/10.1007/978-3-032-27235-5_13' }
abort 'Satellite paper incorrectly appears in edited proceedings' unless
  paper_nodes.first.xpath("preceding::h2[@id][1]").first&.[]('id') == 'recent-publications'
puts 'Proceedings editor and satellite paper integration test passed.'
RUBY
