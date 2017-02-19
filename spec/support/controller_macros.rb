module ControllerMacros
  def login_user(login_as = :admin)
    before(:each) do
      login_as ||= nil
      user = login_as.class.is_a?(Symbol) ? create(:user, login_as) : login_as
      unless login_as.nil?
        @request.env['devise.mapping'] = Devise.mappings[:user]
        instance_variable_set(:"@#{login_as}", user)
        sign_in instance_variable_get(:"@#{user}")
      end
    end
  end

  # Shared
  shared_examples_for :ok_request do |template|
    it { is_expected.to respond_with 200 }
    it { is_expected.to render_template(template) }
  end

  shared_examples_for :redirected_request do |url|
    it { is_expected.to respond_with 302 }
    it { is_expected.to redirect_to(send(url)) }
  end

  shared_examples_for :not_found_request do
    it { is_expected.to respond_with 404 }
  end

  shared_examples_for :cancan_unauthorized_request do |url, path|
    it { is_expected.to respond_with 302 }
    it { is_expected.to redirect_to(send(url)) }
    it { is_expected.to set_flash[:alert].to(t(path)) }
  end
end
