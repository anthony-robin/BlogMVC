require 'rails_helper'

describe HomesController, bullet: true do
  describe 'GET #index' do
    before(:each) { get :index }
    it_behaves_like :ok_request, 'index'
  end
end
