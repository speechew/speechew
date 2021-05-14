# frozen_string_literal: true

class CreateTopics < ActiveRecord::Migration[6.0]
  def change
    create_table :topics do |t|
      t.string :name
      t.boolean :deleted, default: false

      t.timestamps
    end
  end
end
