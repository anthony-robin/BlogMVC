require 'rails_helper'

RSpec.describe 'Blog page', type: :feature do
  subject { BlogPage.new }

  let!(:blogs) { create_list(:blog, 3) }

  before { visit blogs_path }

  describe 'the index page' do
    it { is_expected.to have_page_title(action: 'index') }
    it { is_expected.to have_h1_title(action: 'index') }

    it 'lists the lasts articles' do
      blogs.each do |blog|
        expect(page).to have_content(blog.title)
      end
    end
  end
end
