class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
	rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  enum gender: { 'Female': 0, 'Male': 1}

  belongs_to :country, optional: true
  belongs_to :language, optional: true
  before_save :set_fullname
  after_create :promote_editor

  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  def set_fullname
    self.full_name = "#{self.first_name} #{self.last_name}"
  end

  def promote_editor
    self.add_role "student"
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
        rl = rl + " " + '<span class="badge badge-dark">'+r.to_s+'</span>'
      end
    end
    return rl.html_safe
  end
end
