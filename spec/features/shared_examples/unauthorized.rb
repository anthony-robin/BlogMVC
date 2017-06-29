RSpec.shared_examples_for :unauthorized do |message|
  it { is_expected.to have_http_status(302) }
  it { is_expected.to redirect_to root_url }

  describe 'flash message' do
    before { subject }

    it { expect(controller).to set_flash[:alert].to message }
  end
end
