#!/usr/bin/env bash
set -euo pipefail

if [[ $# -gt 0 ]]; then
  site_dir="$1"
else
  tmp_dir="$(mktemp -d)"
  trap 'rm -rf "${tmp_dir}"' EXIT
  site_dir="${tmp_dir}/site"
  JEKYLL_ENV=production bundle exec jekyll build -d "${site_dir}" >/dev/null
fi

bundle exec ruby - "${site_dir}" <<'RUBY'
require 'nokogiri'
require 'uri'
require 'jekyll'

root = ARGV.fetch(0)
forbidden = %r{\A/(?:blog|books|teaching|teachings|people|plugins|repositories|test|_posts|_books|_teachings)(?:/|\z)|\A/_pages/(?:dropdown|about_einstein)}
sitemap = Nokogiri::XML(File.read(File.join(root, 'sitemap.xml'))) { |c| c.strict }
paths = sitemap.xpath('//*[local-name()="loc"]').map { |node| URI(node.text).path }
leaked = paths.grep(forbidden)
abort "Demo URLs in sitemap: #{leaked.join(', ')}" unless leaked.empty?

%w[assets/plotly/demo.html assets/html/relativity.html assets/jupyter/blog.ipynb assets/json/resume.json assets/json/table_data.json].each do |path|
  abort "Demo asset published: #{path}" if File.exist?(File.join(root, path))
end

files = Dir.glob(File.join(root, '**', '*')).select { |path| File.file?(path) }
leaked_files = files.select { |path| ('/' + path.delete_prefix(root + '/')).match?(forbidden) }
abort "Demo files published: #{leaked_files.join(', ')}" unless leaked_files.empty?

required = %w[/ /ja/ /research/ /ja/research/ /lab/ /ja/lab/ /awards/ /ja/awards/ /contact/ /ja/contact/ /publications/ /news/]
# Verify every real research project and news document, not just the landing pages.
site = Jekyll::Site.new(Jekyll.configuration('source' => Dir.pwd, 'destination' => root, 'quiet' => true))
site.read
%w[news projects].each do |name|
  docs = site.collections.fetch(name).docs
  abort "Missing #{name} source documents" if docs.empty?
  docs.each do |doc|
    if name == 'news' && doc.data['inline']
      rendered = site.find_converter_instance(Jekyll::Converters::Markdown).convert(doc.content)
      expected_text = Nokogiri::HTML.fragment(rendered).text.gsub(/\s+/, ' ').strip
      news_text = Nokogiri::HTML(File.read(File.join(root, 'news/index.html'))).text.gsub(/\s+/, ' ')
      abort "Inline news missing: #{doc.relative_path}" unless news_text.include?(expected_text)
      next
    end
    abort "Missing output for #{doc.relative_path}" unless File.file?(doc.destination(root))
    required << doc.url
  end
end
required.uniq.each do |url|
  abort "Real content absent from sitemap: #{url}" unless paths.include?(url)
  next unless url.end_with?('/')
  abort "Missing real page: #{url}" unless File.file?(File.join(root, url.sub(%r{\A/}, ''), 'index.html'))
end

feed = Nokogiri::XML(File.read(File.join(root, 'feed.xml'))) { |c| c.strict }
abort 'Sample posts remain in feed' unless feed.xpath('//*[local-name()="entry"]').empty?
abort 'Incorrect feed title' unless feed.at_xpath('/*[local-name()="feed"]/*[local-name()="title"]').text == 'Kaoru Sumi'

# Search output and generated HTML must also be free of demo titles/placeholders.
markers = /a post with plotly\.js|555 your office number|123 your address street|test@gmail\.com|Google Gemini|Lorem ipsum dolor sit amet/i
files.select { |path| path.match?(/\.(html|json|xml)$/) && !path.include?('/assets/') }.each do |path|
  abort "Sample text in #{path}" if File.read(path).match?(markers)
end
search_indexes = files.grep(/\.html$/).flat_map do |path|
  Nokogiri::HTML(File.read(path)).css('script').map(&:text).select { |text| text.include?('ninja.data') }
end
abort 'Search indexes missing' if search_indexes.empty?
search_indexes.each do |text|
  abort 'Real search navigation missing' unless text.include?('nav-research') && text.include?('nav-publications')
  abort 'Demo search entry remains' if text.match?(%r{/(?:people|teaching|teachings|blog|plugins|repositories|books)/}) || text.match?(/id:\s*["']post-/)
end
puts "Production content checks passed: #{paths.size} sitemap URLs; 0 demo URLs/files; 0 feed entries; #{required.uniq.size} real URLs preserved."
RUBY
