class Language < ApplicationRecord
	default_scope { where(deleted: false) }
	
	validates :name, presence: true, uniqueness: true
	validates :language_code, presence: true, uniqueness: true
end
