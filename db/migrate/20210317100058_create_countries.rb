class CreateCountries < ActiveRecord::Migration[6.0]
  def change
    create_table :countries do |t|
      t.string :name
      t.string :country_code
      t.integer :continent_name
      t.boolean :deleted, :default => false

      t.timestamps
    end
  end
end
