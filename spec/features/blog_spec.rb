require 'rails_helper'

feature 'Blog page' do
  let!(:blogs) { create_list(:blog, 3) }

  subject { BlogPage.new }
  before { visit blogs_path }

  context 'the index page' do
    it { is_expected.to have_page_title(action: 'index') }
    it { is_expected.to have_h1_title(action: 'index') }

    it 'lists the lasts articles' do
      blogs.each do |blog|
        expect(page).to have_content(blog.title)
      end
    end
  end
end
