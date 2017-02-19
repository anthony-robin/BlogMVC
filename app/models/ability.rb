class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    alias_action :create, :read, :update, :destroy, to: :crud
    alias_action :create, :read, to: :cr
    alias_action :update, :destroy, to: :ud

    can :read, [Blog, User]
    can :manage, [User], id: user.id

    if user.master_role?
      can :manage, :all
      cannot :ud, Blog, user: { role: 0 }
    elsif user.admin_role?
      can :crud, [Category]
      can :ud, Blog, user: { role: 2 }
    end

    return unless user.persisted?

    can :create, Blog
    can :ud, Blog, user: { id: user.id }
  end
end
