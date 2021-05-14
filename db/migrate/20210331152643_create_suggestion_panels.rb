# frozen_string_literal: true

class CreateSuggestionPanels < ActiveRecord::Migration[6.0]
  def change
    create_table :suggestion_panels, &:timestamps
  end
end
