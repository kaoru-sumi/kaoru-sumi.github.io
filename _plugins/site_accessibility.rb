# frozen_string_literal: true

require 'nokogiri'

# Site-specific compatibility for al_folio_core 1.0.13. Keep the gem's layouts
# and styles intact; remove this adapter when the core supplies these fixes.
module PahaiSiteAccessibility
  STYLESHEET_ID = 'site-accessibility-styles'

  def self.apply(item)
    return unless item.output_ext == '.html' && item.output.match?(/<html(?:\s|>)/i)

    document = Nokogiri::HTML(item.output, nil, 'UTF-8')
    head = document.at_css('head')
    return unless head

    # A native main scopes the page header correctly, instead of exposing a
    # second banner landmark inside the core's div[role="main"] wrapper.
    document.css('div[role="main"]').each do |main|
      main.name = 'main'
      main.remove_attribute('role')
    end

    # Use a new asset, not assets/css/main.scss: the gem owns compiled main.css.
    # Appending after existing styles preserves core CSS and cascade order.
    stylesheet = head.at_css("link##{STYLESHEET_ID}")
    unless stylesheet
      stylesheet = Nokogiri::XML::Node.new('link', document)
      stylesheet['id'] = STYLESHEET_ID
      head.add_child(stylesheet)
    end
    stylesheet['rel'] = 'stylesheet'
    stylesheet['href'] = Liquid::Template.parse(
      '{{ "/assets/css/site-accessibility.css" | relative_url }}'
    ).render!({}, registers: { site: item.site })

    item.output = document.to_html
  end
end

[:pages, :documents].each do |owner|
  Jekyll::Hooks.register owner, :post_render do |item|
    PahaiSiteAccessibility.apply(item)
  end
end
