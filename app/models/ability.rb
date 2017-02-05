class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    alias_action :create, :read, :update, :destroy, to: :crud
    alias_action :create, :read, to: :cr
    alias_action :update, :destroy, to: :ud

    can :read, Blog

    return unless user.persisted?
    can :crud, [Category]
    can :cr, Blog
    can :ud, Blog, user: { id: user.id }
    can :manage, [User], id: user.id
  end
end
