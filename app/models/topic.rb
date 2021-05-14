# frozen_string_literal: true

class Topic < ApplicationRecord
  default_scope { where(deleted: false) }
  validates :name, presence: true, uniqueness: true
end
