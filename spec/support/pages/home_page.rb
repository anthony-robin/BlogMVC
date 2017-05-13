class HomePage < ApplicationPage
  TEXTS = {
    page_title: "#{I18n.t('homes.index.title')} | BlogMVC",
    h1_title: I18n.t('homes.index.title')
  }.freeze

  def has_correct_page_title?
    page.has_title? TEXTS[:page_title]
  end

  def has_correct_h1_title?
    page.has_text? TEXTS[:h1_title]
  end
end
