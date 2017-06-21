require 'rails_helper'

RSpec.describe Blogs::AutocompletesController do
  let!(:blogs) { create_list(:blog, 5) }

  before(:each) { Blog.reindex }

  describe 'GET #index' do
    subject! { get :index, params: { query: 'article' }, format: :json }

    it { is_expected.to have_http_status(:ok) }

    it 'should return search results' do
      expect(assigns(:blogs).results).to eq blogs
    end
  end
end
