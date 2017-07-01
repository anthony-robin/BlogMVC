require 'rails_helper'

RSpec.describe Categories::BlogsController do
  let(:format) { :html }
  let!(:blog) { create(:blog) }

  describe 'GET #index' do
    subject do
      get :index,
        params: { category_id: blog.category },
        format: format
    end

    it { is_expected.to have_http_status(200) }
    it { is_expected.to render_template 'blogs/index' }
  end

  describe 'GET #show' do
    subject do
      get :show,
        params: { category_id: blog.category, id: blog },
        format: format
    end

    it { is_expected.to have_http_status(200) }
    it { is_expected.to render_template :show }
  end
end
