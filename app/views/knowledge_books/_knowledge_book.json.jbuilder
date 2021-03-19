json.extract! knowledge_book, :id, :code, :title, :content, :deleted, :created_at, :updated_at
json.url knowledge_book_url(knowledge_book, format: :json)
