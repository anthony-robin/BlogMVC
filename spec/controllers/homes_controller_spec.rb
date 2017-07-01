require 'rails_helper'

RSpec.describe HomesController do
  describe 'GET #index' do
    subject { get :index }

    it { is_expected.to have_http_status(200) }
    it { is_expected.to render_template :index }
  end
end
