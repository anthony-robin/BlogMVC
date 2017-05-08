class BlogPage < ApplicationPage
  TEXTS = {
    site_name: 'BlogMVC'
  }.freeze

  def has_page_title?(action:)
    page.has_title? "#{I18n.t("blogs.#{action}.title")} | #{TEXTS[:site_name]}"
  end

  def has_h1_title?(action:)
    page.has_text? I18n.t("blogs.#{action}.title")
  end
end
