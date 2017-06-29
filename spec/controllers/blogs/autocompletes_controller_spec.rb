require 'rails_helper'

RSpec.describe Blogs::AutocompletesController do
  let!(:blogs) { create_list(:blog, 5) }
  before(:each) { Blog.reindex }

  describe 'GET #index' do
    subject! do
      get :index,
        params: { query: 'article' },
        format: :json
    end

    it { is_expected.to have_http_status(200) }

    it 'should return search results' do
      expect(assigns(:blogs).results).to eq blogs
    end
  end
end
