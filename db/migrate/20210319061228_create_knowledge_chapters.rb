class CreateKnowledgeChapters < ActiveRecord::Migration[6.0]
  def change
    create_table :knowledge_chapters do |t|
      t.belongs_to :knowledge_book, null: false, foreign_key: true
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
