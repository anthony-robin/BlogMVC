require 'rails_helper'

RSpec.describe 'Blogs::Autocomplete', type: :feature, js: true do
  subject(:autocomplete) { Blogs::AutocompletePage.new }

  let!(:blog) { create(:blog, title: 'Lorem ipsum dolor') }

  before do
    Blog.reindex
    visit blogs_path
  end

  context 'when a record does not exist' do
    let(:query) { 'query without record' }

    before { autocomplete.fill_form(query: query) }

    it { is_expected.to have_not_found_records }
  end

  context 'when a record exists' do
    let(:query) { 'ipsum' }

    before { autocomplete.fill_form(query: query) }

    context 'without picture' do
      it { is_expected.to have_found_records(title: blog.title) }
    end

    context 'with picture' do
      before { create(:picture, attachable: blog) }

      it { is_expected.to have_found_records(title: blog.title) }
    end
  end
end
