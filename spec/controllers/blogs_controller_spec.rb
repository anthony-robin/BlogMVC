require 'rails_helper'

RSpec.describe BlogsController do
  let(:format) { :html }

  before { create(:blog) }

  describe 'GET #index' do
    subject { get :index, format: format }

    it { is_expected.to have_http_status(200) }
    it { is_expected.to render_template :index }
  end
end
