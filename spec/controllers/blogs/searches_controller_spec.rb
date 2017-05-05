require 'rails_helper'

describe Blogs::SearchesController do
  let!(:blogs) { create_list(:blog, 3) }
  let!(:blog) { create(:blog, title: 'Lorem ipsum') }

  before(:each) { Blog.reindex }

  describe 'GET #index' do
    context 'without query' do
      subject! { get :index }
      it_behaves_like :redirected_request, 'blogs_path'
    end

    context 'with empty query' do
      subject! { get :index, params: { term: '' } }
      it_behaves_like :redirected_request, 'blogs_path'
    end

    context 'with query' do
      subject! { get :index, params: { term: 'title' } }

      it_behaves_like :ok_request, 'blogs/index'

      it 'has correct articles' do
        assigned = assigns(:blogs).results
        expect(assigned).to include(blogs[0], blogs[1], blogs[2])
        expect(assigned).to_not include(blog)
      end
    end
  end
end
