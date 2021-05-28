# frozen_string_literal: true

module CategoriesHelper
  def category_name(name)
    Category.where(name: name).first.name
  end
end
