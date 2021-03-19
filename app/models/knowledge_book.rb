class KnowledgeBook < ApplicationRecord
	validates :code, presence: true, uniqueness: true
	validates :title, presence: true, uniqueness: true
	has_rich_text :content
	has_many :knowledge_chapters, inverse_of: :knowledge_book
  	accepts_nested_attributes_for :knowledge_chapters, reject_if: :all_blank, allow_destroy: true
end