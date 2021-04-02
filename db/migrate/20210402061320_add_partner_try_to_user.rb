class AddPartnerTryToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :search_partner_try, :integer, :default => 0
  end
end
