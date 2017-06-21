require 'rails_helper'

RSpec.describe HomesController do
  describe 'GET #index' do
    subject! { get :index }
    it_behaves_like :ok_request, 'index'
  end
end
