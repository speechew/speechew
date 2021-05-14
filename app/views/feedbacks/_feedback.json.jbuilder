# frozen_string_literal: true

json.extract! feedback, :id, :given_to_id, :given_by_id, :fluency, :vocabulary, :grammar, :notes, :deleted,
              :created_at, :updated_at
json.url feedback_url(feedback, format: :json)
