class CreateSuggestionPanels < ActiveRecord::Migration[6.0]
  def change
    create_table :suggestion_panels do |t|

      t.timestamps
    end
  end
end
