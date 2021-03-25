class Article < ApplicationRecord
  validates :title, uniqueness: true
  validates :about, presence: true
  validates :content, presence: true
  has_many :article_categories
  has_many :categories, through: :article_categories
  belongs_to :user, optional: true

  has_rich_text :content
  before_create :set_author
  enum status: { 'In progress': 0, 'Review': 1, 'Published': 2}

  def set_author
    self.user_id = User.current.id
  end
end
