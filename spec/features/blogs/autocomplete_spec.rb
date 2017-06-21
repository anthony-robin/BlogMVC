require 'rails_helper'

RSpec.feature 'Blogs::Autocomplete', js: true do
  let!(:blog) { create(:blog, title: 'Lorem ipsum dolor') }

  subject { Blogs::AutocompletePage.new }
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

    context 'without picture' do
      it { is_expected.to have_found_records(title: blog.title) }
    end

    context 'with picture' do
      let!(:picture) { create(:picture, attachable: blog) }
      it { is_expected.to have_found_records(title: blog.title) }
    end
  end
end
