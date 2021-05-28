# frozen_string_literal: true

json.extract! country, :id, :name, :country_code, :continent_name, :deleted, :created_at,
              :updated_at
json.url country_url(country, format: :json)
