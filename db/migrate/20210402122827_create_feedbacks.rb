# frozen_string_literal: true

class CreateFeedbacks < ActiveRecord::Migration[6.0]
  def change
    create_table :feedbacks do |t|
      t.integer :given_to_id
      t.integer :given_by_id
      t.integer :fluency
      t.integer :vocabulary
      t.integer :grammar
      t.text :notes
      t.boolean :deleted, default: false

      t.timestamps
    end
  end
end
