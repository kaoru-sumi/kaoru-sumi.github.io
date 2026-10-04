# frozen_string_literal: true

# al_folio_core 1.0.13 reads site.lang for both attributes, ignoring page.lang.
# Keep this site-specific adapter until core supports page language and locale.
# Do not shadow core layouts/includes or mutate the shared site configuration.
Jekyll::Hooks.register :pages, :post_render do |page|
  next unless %w[/ja/ /ja/research/ /ja/lab/ /ja/awards/ /ja/contact/].include?(page.url)
  next unless page.data['lang'] == 'ja' && page.data['og_locale'] == 'ja_JP'

  page.output = page.output.sub(/(<html\b[^>]*\slang=)(["'])[^"']*\2/i) do
    "#{Regexp.last_match(1)}\"ja\""
  end
  page.output = page.output.sub(/(<meta\b[^>]*\bproperty=["']og:locale["'][^>]*\bcontent=)(["'])[^"']*\2/i) do
    "#{Regexp.last_match(1)}\"ja_JP\""
  end
end

# Only these published pages have English/Japanese counterparts. Publications
# deliberately has no pair. No x-default is declared: this site has no separate
# language-neutral landing page or explicit fallback-language policy.
Jekyll::Hooks.register :pages, :post_render do |page|
  pairs = [
    %w[/ /ja/],
    %w[/research/ /ja/research/],
    %w[/lab/ /ja/lab/],
    %w[/awards/ /ja/awards/],
    %w[/contact/ /ja/contact/]
  ]
  pair = pairs.find { |urls| urls.include?(page.url) }
  next unless pair
  next unless pair.all? { |url| page.site.pages.any? { |candidate| candidate.url == url } }

  # Use the same absolute_url filter as core's canonical link (url + baseurl).
  template = Liquid::Template.parse(<<~HTML)
    <link rel="alternate" hreflang="en" href="{{ en_url | absolute_url | escape }}">
    <link rel="alternate" hreflang="ja" href="{{ ja_url | absolute_url | escape }}">
  HTML
  links = template.render!({ 'en_url' => pair[0], 'ja_url' => pair[1] }, registers: { site: page.site })
  page.output = page.output.sub(%r{</head>}i) { "#{links}</head>" }
end
