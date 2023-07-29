class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for different user roles
    if user.admin?
      can :manage, :all # Admin can manage all resources
    else
      can :read, :all
      can :manage, Post, author_id: user.id
      can :manage, Comment, author_id: user.id
      can :create, Like
      can :destroy, Post do |post|
        post.author_id == user.id
      end
      can :destroy, Comment do |comment|
        comment.author_id == user.id
      end
    end
  end
end
