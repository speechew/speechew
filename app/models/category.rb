class Category < ApplicationRecord
	default_scope { where(deleted: false) }
	validates :name, presence: true, uniqueness: true
end
