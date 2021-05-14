# frozen_string_literal: true

class CreateGiveFeedbacks < ActiveRecord::Migration[6.0]
  def change
    create_table :give_feedbacks, &:timestamps
  end
end
