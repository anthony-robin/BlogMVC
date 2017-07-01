require 'rails_helper'

RSpec.describe Blogs::TagsController do
  let!(:blogs) { create_list(:blog, 3, :foo) }
  let!(:blog) { create_list(:blog, 3, :bar) }

  describe 'GET #show' do
    subject! do
      get :show,
        params: { id: tag }
    end

    context 'when filled' do
      let(:tag) { 'foo' }

      it 'has correct articles' do
        assigned = assigns(:blogs)
        expect(assigned).to include(blogs[0], blogs[1], blogs[2])
        expect(assigned).to_not include(blog)
      end

      it { is_expected.to have_http_status(200) }
      it { is_expected.to render_template 'blogs/index' }
    end
  end
end
