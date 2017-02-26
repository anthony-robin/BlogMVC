require 'rails_helper'

describe CommentsController do
  describe 'POST #create' do
    it 'returns http success' do
      post :create, params: {}
      expect(response).to have_http_status(:success)
    end
  end
end
