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
