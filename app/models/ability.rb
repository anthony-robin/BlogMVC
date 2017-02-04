class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    alias_action :create, :read, :update, :destroy, to: :crud

    can :read, Blog

    return unless user.persisted?
    can :crud, [Blog, Category]
    can :manage, [User], id: user.id
  end
end
