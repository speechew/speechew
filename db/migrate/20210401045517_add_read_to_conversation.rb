class AddReadToConversation < ActiveRecord::Migration[6.0]
  def change
    add_column :conversations, :read, :boolean, :default => false
  end
end
