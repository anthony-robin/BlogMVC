require 'rails_helper'

RSpec.describe BlogsController do
  let(:user) { create(:user) }
  let!(:blog) { create(:blog) }
  let(:format) { :html }

  before { login_user user }

  describe 'GET #index' do
    subject { get :index, format: format }

    it { is_expected.to have_http_status(200) }
    it { is_expected.to render_template :index }
  end

  describe 'GET #show' do
    subject do
      get :show,
        params: { id: blog, category_id: blog.category },
        format: format
    end

    it { is_expected.to have_http_status(200) }
    it { is_expected.to render_template :show }
  end
end
