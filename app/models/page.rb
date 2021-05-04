class Page < ApplicationRecord
	default_scope { where(deleted: false) }
	validates :code, presence: true, uniqueness: true
	validates :title, presence: true, uniqueness: true
	has_rich_text :content
end
