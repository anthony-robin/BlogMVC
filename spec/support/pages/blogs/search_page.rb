module Blogs
  class SearchPage < ApplicationPage
    SELECTORS = {
      form: 'form[role="search"]',
      submit: 'input[type="submit"]'
    }.freeze

    def fill_form(query:)
      within SELECTORS[:form] do
        fill_in 'term', with: query
        find(SELECTORS[:submit]).click
      end
    end

    def has_found_records?(title:)
      page.has_content?(title)
    end

    def has_not_found_records?
      page.has_content? I18n.t('blogs.index.empty_records')
    end
  end
end
