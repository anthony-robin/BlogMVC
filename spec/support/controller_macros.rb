module ControllerMacros
  def login_user(login_as = :admin)
    before(:each) do
      user = login_as.is_a?(Symbol) ? create(:user, login_as) : login_as
      unless user.nil?
        @request.env['devise.mapping'] = Devise.mappings[:user]

        if login_as.is_a?(Symbol)
          instance_variable_set(:"@#{login_as}", user)
          sign_in instance_variable_get(:"@#{login_as}")
        else
          instance_variable_set(:"@#{user.role}", user)
          sign_in instance_variable_get(:"@#{user}")
        end
      end
    end
  end
end
