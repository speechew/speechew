class AddAboutToArticles < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :about, :text
  end
end
