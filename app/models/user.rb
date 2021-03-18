class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
	rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  enum gender: { 'Female': 0, 'Male': 1}

  before_save :set_fullname

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
end
