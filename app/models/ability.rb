# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # can :read, Farm
    # can :read, Lot
    # can :read, Microlot
    # can :read, Profile
    # can :read, Zone

    return unless user.present?

    if user.client?
      can [:show], Account, {user: user, status: "activated"}
      can [:create], Loan, account: { user: user }
      can [:deposit, :transfer, :withdraw, :create], Transaction, account: { user: user }
    end

    if user.admin?
      can :manage, :all
    end
  end
end
