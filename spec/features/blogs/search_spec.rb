require 'rails_helper'

RSpec.feature 'Blogs::Search', js: true do
  let!(:blogs) { create_list(:blog, 3) }
  let!(:blog) { create(:blog, title: 'Lorem ipsum') }

  subject { Blogs::SearchPage.new }
  before { visit blogs_path }
  before(:each) { Blog.reindex }

  context 'when a record does not exist' do
    let(:query) { 'query without record' }
    before { subject.fill_form(query: query) }

    it { is_expected.to have_not_found_records }
  end

  context 'when a record exists' do
    let(:query) { 'ipsum' }
    before { subject.fill_form(query: query) }

    it { is_expected.to have_found_records(title: blog.title) }
  end
end
