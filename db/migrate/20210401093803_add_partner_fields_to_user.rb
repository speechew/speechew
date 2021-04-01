class AddPartnerFieldsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :in_call, :boolean, :default => false
    add_column :users, :partner_token, :string
    add_column :users, :partner_token_expiry, :datetime
  end
end
