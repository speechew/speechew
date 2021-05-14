# frozen_string_literal: true

class QuestionSet < ApplicationRecord
  default_scope { where(deleted: false) }
  validates :title, presence: true, uniqueness: { unless: :deleted?, scope: :deleted }

  has_many :question_set_topics
  has_many :topics, through: :question_set_topics

  has_many :questions, inverse_of: :question_set
  accepts_nested_attributes_for :questions, reject_if: :all_blank, allow_destroy: true
end
