json.extract! page, :id, :code, :title, :content, :deleted, :created_at, :updated_at
json.url page_url(page, format: :json)
