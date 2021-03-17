class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.belongs_to :question_set, null: false, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
