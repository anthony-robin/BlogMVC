RSpec.shared_examples_for :ok_request do |template|
  it { is_expected.to have_http_status(200) }
  it { is_expected.to render_template(template) }
end

RSpec.shared_examples_for :redirected_request do |url|
  it { is_expected.to have_http_status(302) }
  it { is_expected.to redirect_to(send(url)) }
end

RSpec.shared_examples_for :cancan_unauthorized_request do |url, path|
  it_behaves_like :redirected_request, url

  it 'has correct flash message' do
    expect(controller).to set_flash[:alert].to(t(path))
  end
end

RSpec.shared_examples_for :unauthorized_request do
  it { is_expected.to have_http_status(401) }
end

RSpec.shared_examples_for :forbidden_request do
  it { is_expected.to have_http_status(403) }
end

RSpec.shared_examples_for :not_found_request do
  it { is_expected.to have_http_status(404) }
end
