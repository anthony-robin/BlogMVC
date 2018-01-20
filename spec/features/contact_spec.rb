require 'rails_helper'

RSpec.describe 'Contact page', type: :feature do
  subject(:page) { ContactPage.new }

  let(:valid_attributes) do
    { contact: { name: 'John Doe',
                 email: 'johndoe@test.fr',
                 message: 'My contact message' } }
  end

  before { visit new_contact_path }

  describe 'the new page' do
    it { is_expected.to have_correct_page_title }
    it { is_expected.to have_correct_h1_title }
  end

  describe '#valid?' do
    before { page.fill_form(valid_attributes[:contact]) }

    it { is_expected.to_not have_form_errors }
    it { is_expected.to have_submitted_form }
  end

  describe '#invalid?' do
    before { page.fill_form(valid_attributes[:contact].merge!(nickname: 'I am a robot !')) }

    it { is_expected.to have_form_errors }
    it { is_expected.to_not have_submitted_form }
  end
end
