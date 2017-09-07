RSpec.shared_examples_for :unauthorized do
  it { is_expected.to have_http_status(302) }
  it { is_expected.to redirect_to root_url }

  it_behaves_like :flash_message
end
