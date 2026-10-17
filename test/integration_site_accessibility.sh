#!/usr/bin/env bash
set -euo pipefail

# Reuse the production output when available; otherwise build a fresh site.
if [[ $# -gt 0 ]]; then
  site_dir="$1"
else
  tmp_dir="$(mktemp -d)"
  trap 'rm -rf "${tmp_dir}"' EXIT
  printf 'imagemagick:\n  enabled: false\n' >"${tmp_dir}/config.yml"
  site_dir="${tmp_dir}/site"
  JEKYLL_ENV=production bundle exec jekyll build \
    --config "_config.yml,${tmp_dir}/config.yml" -d "${site_dir}" >/dev/null
fi

bundle exec ruby - "${site_dir}" <<'RUBY'
require 'nokogiri'
require 'yaml'
require 'date'

site = ARGV.fetch(0)
config = YAML.load_file('_config.yml', permitted_classes: [Date, Time])
abort 'Full publication author names must remain visible' unless config['max_author_limit'].nil?
baseurl = config['baseurl'].to_s.sub(%r{/+$}, '')
stylesheet_url = baseurl + '/assets/css/site-accessibility.css'
stylesheet_path = File.join(site, 'assets/css/site-accessibility.css')
abort 'Missing accessibility stylesheet' unless File.file?(stylesheet_path)
stylesheet = File.read(stylesheet_path)
abort 'Missing non-color link cue' unless stylesheet.match?(/text-decoration:\s*underline/)

paths = %w[index.html research/index.html lab/index.html awards/index.html contact/index.html
           publications/index.html news/index.html ja/index.html ja/research/index.html
           ja/lab/index.html ja/awards/index.html ja/contact/index.html]
documents = Dir.glob(File.join(site, '{projects,news}', '**', '*.html')).map do |path|
  path.delete_prefix(site.sub(%r{/+$}, '') + '/')
end
abort 'Research collection pages missing' unless documents.any? { |path| path.start_with?('projects/') }

(paths + documents).uniq.each do |path|
  document = Nokogiri::HTML(File.read(File.join(site, path)))
  abort "Expected one native main: #{path}" unless document.css('main').length == 1
  abort "Legacy main wrapper remains: #{path}" unless document.css('div[role="main"]').empty?
  abort "Page header lost its main scope: #{path}" unless
    document.css('header.post-header').all? { |header| header.ancestors('main').length == 1 }
  abort "Top-level site banner changed: #{path}" unless document.css('body > header').length == 1
  links = document.css('head link[rel="stylesheet"]')
  custom = links.select { |link| link['id'] == 'site-accessibility-styles' }
  abort "Wrong accessibility stylesheet: #{path}" unless
    custom.length == 1 && custom.first['href'] == stylesheet_url
  core_index = links.find_index { |link| link['href'].to_s.split('?').first == baseurl + '/assets/css/main.css' }
  custom_index = links.find_index { |link| link['id'] == 'site-accessibility-styles' }
  abort "Core stylesheet missing or reordered: #{path}" unless core_index && core_index < custom_index
  abort "Mouse-only author control remains: #{path}" unless document.css('.more-authors').empty?
end

publication_text = Nokogiri::HTML(File.read(File.join(site, 'publications/index.html'))).text
['Nirattaya Khamsemanan', 'Cholwich Nattee'].each do |author|
  abort "Previously hidden author missing: #{author}" unless publication_text.include?(author)
end
puts "Site accessibility integration passed: #{(paths + documents).uniq.length} pages, native landmarks, additive CSS, full authors"
RUBY
