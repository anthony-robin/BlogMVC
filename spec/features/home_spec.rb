require 'rails_helper'

RSpec.describe 'Home page', type: :feature do
  subject { HomePage.new }

  describe 'the index page' do
    before { visit root_path }

    it { is_expected.to have_correct_page_title }
    it { is_expected.to have_correct_h1_title }
  end
end
