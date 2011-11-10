class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
    if user.has_role?("Provider")
      can :manage, [Post, Comment]
      can :new, [Post, Comment]
      can :create, [Post, Comment]
      can :update, [Post, Comment]
      can :edit, [Post, Comment]
      can :mine, Post
      can :destroy, [Post, Comment]
      can :load_query_type, Post
    elsif user.has_role?("General User") or user.has_role?("Contacts")
      can :read, [Post, Comment]
      can :new, Comment
      can :create, Comment
      can :create_comment, [Post, Comment]
      can :load_query_type, Post
    else
      can :read, [Post, Comment]
      can :load_query_type, Post
      
    end
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
