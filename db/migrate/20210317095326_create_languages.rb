# frozen_string_literal: true

class CreateLanguages < ActiveRecord::Migration[6.0]
  def change
    create_table :languages do |t|
      t.string :name
      t.string :language_code
      t.boolean :deleted, default: false

      t.timestamps
    end
  end
end
