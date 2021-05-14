# frozen_string_literal: true

class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :content
      t.belongs_to :user, null: false, foreign_key: true
      t.boolean :deleted, default: false

      t.timestamps
    end
  end
end
