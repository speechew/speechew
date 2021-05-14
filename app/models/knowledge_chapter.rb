# frozen_string_literal: true

class KnowledgeChapter < ApplicationRecord
  belongs_to :knowledge_book
  has_rich_text :content
end
