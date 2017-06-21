require 'rails_helper'

RSpec.feature 'Contact page' do
  let(:valid_attributes) do
    { contact: { name: 'John Doe',
                 email: 'johndoe@test.fr',
                 message: 'My contact message' } }
  end

  subject { ContactPage.new }
  before { visit new_contact_path }

  context '#new' do
    it { is_expected.to have_correct_page_title }
    it { is_expected.to have_correct_h1_title }
  end

  context '#valid?' do
    before { subject.fill_form(valid_attributes[:contact]) }

    it { is_expected.to_not have_form_errors }
    it { is_expected.to have_submitted_form }
  end

  context '#invalid?' do
    before { subject.fill_form(valid_attributes[:contact].merge!(nickname: 'I am a robot !')) }

    it { is_expected.to have_form_errors }
    it { is_expected.to_not have_submitted_form }
  end
end
