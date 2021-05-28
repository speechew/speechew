# frozen_string_literal: true

class Article < ApplicationRecord
  default_scope { where(deleted: false) }
  scope :published, -> { where(status: 'Published') }

  validates :title, uniqueness: { unless: :deleted?, scope: :deleted }
  validates :about, presence: true
  validates :content, presence: true
  has_many :article_categories
  has_many :categories, through: :article_categories
  belongs_to :user, optional: true

  has_rich_text :content
  before_create :set_author
  enum status: { 'In progress': 0, Review: 1, Published: 2 }

  def set_author
    self.user_id = User.current.id
  end

  def display_status
    if status.nil?
      'N/A'
    elsif status == 'In progress'
      '<span class="badge badge-primary">In progress</span>'.html_safe
    elsif status == 'Review'
      '<span class="badge badge-warning">Review</span>'.html_safe
    elsif status == 'Published'
      '<span class="badge badge-success">Published</span>'.html_safe
    end
  end
end
