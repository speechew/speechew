# frozen_string_literal: true

class Page < ApplicationRecord
  default_scope { where(deleted: false) }
  validates :code, presence: true, uniqueness: { unless: :deleted?, scope: :deleted }
  validates :title, presence: true, uniqueness: { unless: :deleted?, scope: :deleted }
  has_rich_text :content
end
