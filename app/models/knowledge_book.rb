class KnowledgeBook < ApplicationRecord
	default_scope { where(deleted: false) }
	validates :code, presence: true, :uniqueness => {:unless => :deleted?, :scope => :deleted}
	validates :title, presence: true, :uniqueness => {:unless => :deleted?, :scope => :deleted}
	has_rich_text :content
	has_many :knowledge_chapters, inverse_of: :knowledge_book
  	accepts_nested_attributes_for :knowledge_chapters, reject_if: :all_blank, allow_destroy: true
end
