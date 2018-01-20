require 'rails_helper'

RSpec.describe 'Blogs::Search', type: :feature, js: true do
  subject(:search) { Blogs::SearchPage.new }

  let!(:blog) { create(:blog, title: 'Lorem ipsum') }

  before do
    create_list(:blog, 3)
    Blog.reindex
    visit blogs_path
  end

  context 'when a record does not exist' do
    let(:query) { 'query without record' }

    before { search.fill_form(query: query) }

    it { is_expected.to have_not_found_records }
  end

  context 'when a record exists' do
    let(:query) { 'ipsum' }

    before { search.fill_form(query: query) }

    it { is_expected.to have_found_records(title: blog.title) }
  end
end
