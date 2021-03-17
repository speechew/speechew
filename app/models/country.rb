class Country < ApplicationRecord
	enum continent_name: { 'Africa': 0, 'Antarctica': 1, 'Asia': 2, 'Australia': 3, 'Europe': 4, 'North America': 5, 'South America': 6}
end
