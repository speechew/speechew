# frozen_string_literal: true

json.array! @question_sets, partial: 'question_sets/question_set', as: :question_set
