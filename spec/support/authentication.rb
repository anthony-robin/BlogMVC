module Authentication
  def login_user(user = nil)
    @request.env['devise.mapping'] = Devise.mappings[:user]

    user ||= create :user
    sign_in user
  end
end
