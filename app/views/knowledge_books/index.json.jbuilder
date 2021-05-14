# frozen_string_literal: true

json.array! @knowledge_books, partial: 'knowledge_books/knowledge_book', as: :knowledge_book
