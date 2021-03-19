class Article < ApplicationRecord
  has_many :article_categories
  has_many :categories, through: :article_categories
  belongs_to :user, optional: true

  before_create :set_author

  def set_author
    self.user_id = User.current.id
  end
end
