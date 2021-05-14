# frozen_string_literal: true

class Country < ApplicationRecord
  default_scope { where(deleted: false) }
  validates :name, presence: true, uniqueness: { unless: :deleted?, scope: :deleted }
  validates :country_code, presence: true, uniqueness: { unless: :deleted?, scope: :deleted }
  validates :continent_name, presence: true

  enum continent_name: { 'Africa': 0, 'Antarctica': 1, 'Asia': 2, 'Australia': 3, 'Europe': 4, 'North America': 5,
                         'South America': 6 }
end
