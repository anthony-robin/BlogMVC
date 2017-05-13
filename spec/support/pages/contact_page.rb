class ContactPage < ApplicationPage
  TEXTS = {
    page_title: "#{I18n.t('contacts.new.title')} | BlogMVC",
    h1_title: I18n.t('contacts.new.title')
  }.freeze

  SELECTORS = {
    form: 'form#new_contact',
    name: 'input#contact_name',
    email: 'input#contact_email',
    message: 'textarea#contact_message',
    submit: 'input[type="submit"]'
  }.freeze

  def has_correct_page_title?
    page.has_title? TEXTS[:page_title]
  end

  def has_correct_h1_title?
    page.has_text? TEXTS[:h1_title]
  end

  # Form
  def fill_form(name:, email:, message:, nickname: nil)
    within SELECTORS[:form] do
      fill_in 'contact[name]', with: name
      fill_in 'contact[email]', with: email
      fill_in 'contact[message]', with: message
      fill_in 'contact[nickname]', with: nickname

      find(SELECTORS[:submit]).click
    end
  end

  def has_submitted_form?
    page.has_text? I18n.t('contacts.create.notice')
  end

  def has_form_errors?
    page.has_css? "#{SELECTORS[:form]} .error"
  end
end
