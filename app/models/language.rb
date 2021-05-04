class Language < ApplicationRecord
	default_scope { where(deleted: false) }
	
	validates :name, presence: true, :uniqueness => {:unless => :deleted?, :scope => :deleted}
	validates :language_code, presence: true, :uniqueness => {:unless => :deleted?, :scope => :deleted}
end
