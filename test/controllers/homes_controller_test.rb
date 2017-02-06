require 'test_helper'

class HomesControllerTest < ActionDispatch::IntegrationTest
  context 'Anyone' do
    should 'get index' do
      get root_url
      assert_response :success
    end
  end
end
