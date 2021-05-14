# frozen_string_literal: true

class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.boolean :deleted, default: false

      t.timestamps
    end
  end
end
