class QuestionSet < ApplicationRecord

  validates :title, presence: true, uniqueness: true

  has_many :question_set_topics
  has_many :topics, through: :question_set_topics

  has_many :questions, inverse_of: :question_set
  accepts_nested_attributes_for :questions, reject_if: :all_blank, allow_destroy: true
end
