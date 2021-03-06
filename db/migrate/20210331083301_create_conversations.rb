# frozen_string_literal: true

class CreateConversations < ActiveRecord::Migration[6.0]
  def change
    create_table :conversations do |t|
      t.integer :recipient_id
      t.integer :sender_id

      t.timestamps
    end
    add_index :conversations, %i[recipient_id sender_id], unique: true
  end
end
