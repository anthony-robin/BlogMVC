class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    alias_action :create, :read, :update, :destroy, to: :crud
    alias_action :create, :read, to: :cr
    alias_action :update, :destroy, to: :ud

    # User.new
    can :read, [User, Blog, Comment]
    return unless user.persisted?

    # Persisted user
    if user.master_role?
      can :manage, :all
      cannot :ud, [Blog, Comment], user: { role: 0 }
      cannot :update, [Comment]
    elsif user.admin_role?
      can :crud, [Category]
      can :ud, Blog, user: { role: 2 }
    end

    can :manage, [User], id: user.id
    can :create, [Blog, Comment]
    can :ud, [Blog], user: { id: user.id }
    can :destroy, [Comment], user: { id: user.id }
  end
end
