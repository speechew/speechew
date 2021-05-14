# frozen_string_literal: true

class CreateQuestionSets < ActiveRecord::Migration[6.0]
  def change
    create_table :question_sets do |t|
      t.text :title
      t.boolean :deleted, default: false

      t.timestamps
    end
  end
end
