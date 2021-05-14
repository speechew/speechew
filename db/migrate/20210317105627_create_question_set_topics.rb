# frozen_string_literal: true

class CreateQuestionSetTopics < ActiveRecord::Migration[6.0]
  def change
    create_table :question_set_topics do |t|
      t.belongs_to :question_set, null: false, foreign_key: true
      t.belongs_to :topic, null: false, foreign_key: true

      t.timestamps
    end
  end
end
