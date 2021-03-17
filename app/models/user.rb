class User < ApplicationRecord
	rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

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
