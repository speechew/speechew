class Question < ApplicationRecord
  validates :content, presence: true, uniqueness: true
  belongs_to :question_set
end
