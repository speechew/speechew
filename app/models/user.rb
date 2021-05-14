# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :confirmable
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum gender: { 'Female': 0, 'Male': 1 }

  belongs_to :country, optional: true
  belongs_to :language, optional: true
  before_save :set_fullname
  before_save :update_blocking_details
  after_create :set_suggestion_chat

  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :dob, presence: true
  validates :gender, presence: true
  validates :bio, presence: true

  has_many :messages
  has_many :conversations, foreign_key: :sender_id

  def set_fullname
    self.full_name = "#{first_name} #{last_name}"
  end

  def ability
    @ability ||= Ability.new(self)
  end
  delegate :can?, :cannot?, to: :ability

  def self.current=(user)
    Thread.current[:current_user] = user
  end

  def self.current
    Thread.current[:current_user]
  end

  def display_roles
    rl = ''
    if roles.collect(&:name).any?
      roles.collect(&:name).each do |r|
        rl = case r.to_s
             when 'admin'
               "#{rl} <span class=\"badge badge-success\">#{r}</span>"
             when 'tutor'
               "#{rl} <span class=\"badge badge-info\">#{r}</span>"
             when 'editor'
               "#{rl} <span class=\"badge badge-primary\">#{r}</span>"
             else
               "#{rl} <span class=\"badge badge-dark\">#{r}</span>"
             end
      end
    end
    rl.html_safe
  end

  def update_blocking_details
    if blocked_was != blocked && (blocked == true)
      self.last_blocked_at = Time.now
      self.no_of_times_blocked += 1
    end
  end

  def self.online
    ids = ActionCable.server.pubsub.redis_connection_for_subscriptions.smembers 'online'
    where(id: ids)
  end

  def set_suggestion_chat
    Conversation.create(sender_id: id, recipient_id: 1)
  end
end
