# frozen_string_literal: true

class Feedback < ApplicationRecord
  belongs_to :given_by, foreign_key: :given_by_id, class_name: 'User'
  belongs_to :given_to, foreign_key: :given_to_id, class_name: 'User'
end
