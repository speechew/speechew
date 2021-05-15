# frozen_string_literal: true

class Category < ApplicationRecord
  default_scope { where(deleted: false) }
  validates :name, presence: true, uniqueness: { unless: :deleted?, scope: :deleted }

  has_many :article_categories
  has_many :articles, :through => :article_categories
end
