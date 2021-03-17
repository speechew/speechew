class QuestionSetTopic < ApplicationRecord
  belongs_to :question_set
  belongs_to :topic
end
