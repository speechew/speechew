class CreateGiveFeedbacks < ActiveRecord::Migration[6.0]
  def change
    create_table :give_feedbacks do |t|

      t.timestamps
    end
  end
end
