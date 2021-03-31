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

  enum gender: { 'Female': 0, 'Male': 1}

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
    self.full_name = "#{self.first_name} #{self.last_name}"
  end

  def ability
    @ability ||= Ability.new(self)
  end
  delegate :can?, :cannot?, :to => :ability
  
  def self.current=(user)
  	Thread.current[:current_user] = user
  end

  def self.current
  	Thread.current[:current_user]
  end

  def display_roles
    rl = ""
    if self.roles.collect(&:name).any?
      self.roles.collect(&:name).each do |r|
        if r.to_s == "admin"
          rl = rl + " " + '<span class="badge badge-success">'+r.to_s+'</span>'
        elsif r.to_s == "tutor"
          rl = rl + " " + '<span class="badge badge-info">'+r.to_s+'</span>'
        elsif r.to_s == "editor"
          rl = rl + " " + '<span class="badge badge-primary">'+r.to_s+'</span>'
        else
          rl = rl + " " + '<span class="badge badge-dark">'+r.to_s+'</span>'
        end
      end
    end
    return rl.html_safe
  end

  def update_blocking_details
    if blocked_was != self.blocked
      if self.blocked == true
        self.last_blocked_at = Time.now
        self.no_of_times_blocked+=1
      end
    end
  end
  def self.online
    ids = ActionCable.server.pubsub.redis_connection_for_subscriptions.smembers "online"
    where(id: ids)
  end

  def set_suggestion_chat
    Conversation.create(:sender_id => self.id, :recipient_id => 1)
  end
end
