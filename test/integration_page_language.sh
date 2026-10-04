#!/usr/bin/env bash
set -euo pipefail

# An existing build can be checked by passing its destination as the first argument.
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

config = YAML.load_file('_config.yml')
abort 'The site-wide language must remain English' unless config['lang'] == 'en'

japanese_paths = %w[ja/index.html ja/research/index.html ja/lab/index.html ja/awards/index.html ja/contact/index.html]
english_paths = %w[index.html research/index.html lab/index.html awards/index.html contact/index.html publications/index.html]

(japanese_paths + english_paths).each do |path|
  expected_lang, expected_locale = japanese_paths.include?(path) ? %w[ja ja_JP] : %w[en en]
  document = Nokogiri::HTML(File.read(File.join(ARGV.fetch(0), path)))
  html = document.css('html')
  locales = document.css('meta[property="og:locale"]')
  abort "Wrong HTML language: #{path}" unless html.length == 1 && html.first['lang'] == expected_lang
  abort "Wrong OG locale: #{path}" unless locales.length == 1 && locales.first['content'] == expected_locale
  puts "#{path}: lang=#{expected_lang}, og:locale=#{expected_locale}"
end
puts 'Page language integration test passed.'
RUBY
