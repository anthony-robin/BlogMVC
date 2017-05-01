class Blogs::AutocompletePage < ApplicationPage
  SELECTORS = {
    form: 'form[role="search"]',
    input: 'input#blogs_search--input'
  }.freeze

  def fill_form(query:)
    within SELECTORS[:form] do
      fill_in 'term', with: query
      find(:css, SELECTORS[:input]).trigger('focus')
    end
  end

  def has_found_records?(title:)
    suggestion = page.find('.tt-suggestion')
    suggestion.has_content?(title)
  end

  def has_not_found_records?
    page.has_content? 'Not found'
  end
end
