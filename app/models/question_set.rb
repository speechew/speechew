class QuestionSet < ApplicationRecord
  has_many :question_set_topics
  has_many :topics, through: :question_set_topics
end
