# frozen_string_literal: true

json.extract! question_set, :id, :title, :deleted, :created_at, :updated_at
json.url question_set_url(question_set, format: :json)
