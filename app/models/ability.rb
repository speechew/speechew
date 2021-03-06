# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.has_role? :admin
      can :manage, :all
      can :update, User
      cannot :my_articles, Article
    elsif user.has_role? :editor
      can :create, Message
      can :read, Message, conversation: { sender_id: user.id }
      can :read, Conversation, sender_id: user.id
      can :update, Conversation, sender_id: user.id

      can :index, SpeakNow
      can :index, GiveFeedback
      can :create, Feedback
      can :delete, Feedback, given_to_id: user.id
      can :read, Feedback, given_to_id: user.id
      # Article Access
      can :new, Article
      can :create, Article
      can :edit, Article, user_id: user.id, status: 'In progress'
      can :update, Article, user_id: user.id, status: 'In progress'
      can :read, Article, user_id: user.id
      can :read, Article, status: 'Published'
      can :my_articles, Article
      # User Settings Access
      can :index, UserSetting
      # User Guides Access
      can :index, UserGuide
      can :update, User, id: user.id
    elsif user.has_role? :student
      can :create, Message
      can :read, Message, conversation: { sender_id: user.id }
      can :read, Conversation, sender_id: user.id
      can :update, Conversation, sender_id: user.id

      can :manage, Room
      can :index, SpeakNow
      can :index, GiveFeedback
      can :create, Feedback
      can :delete, Feedback, given_to_id: user.id
      can :read, Feedback, given_to_id: user.id
      # Article Access
      can :read, Article, status: 'Published'
      # User Settings Access
      can :index, UserSetting
      # User Guides Access
      can :index, UserGuide
      can :update, User, id: user.id
    else
      can :read, Article, status: 'Published'
    end
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
