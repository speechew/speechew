class Language < ApplicationRecord
	validates :name, presence: true, uniqueness: true
	validates :language_code, presence: true, uniqueness: true
end
