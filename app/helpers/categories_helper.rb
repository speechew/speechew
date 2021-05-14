# frozen_string_literal: true

module CategoriesHelper
	def category_name(name)
		return Category.where(:name => name).first.name
	end
end
