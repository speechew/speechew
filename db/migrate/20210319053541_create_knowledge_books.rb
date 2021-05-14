# frozen_string_literal: true

class CreateKnowledgeBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :knowledge_books do |t|
      t.string :code
      t.string :title
      t.text :content
      t.boolean :deleted, default: false

      t.timestamps
    end
  end
end
