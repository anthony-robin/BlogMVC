require 'rails_helper'

feature 'Home page' do
  subject { HomePage.new }

  context '#index' do
    before { visit root_path }

    it { is_expected.to have_correct_page_title }
    it { is_expected.to have_correct_h1_title }
  end
end
