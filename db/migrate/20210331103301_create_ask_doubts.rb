class CreateAskDoubts < ActiveRecord::Migration[6.0]
  def change
    create_table :ask_doubts do |t|

      t.timestamps
    end
  end
end
