# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Country.create(:name => "India",:country_code => "IN",:continent_name => "Asia")
Language.create(:name => "English",:language_code => "en")
admin = User.new(
 email: 'admin@admin.com',
 password: '123456',
 password_confirmation: '123456', 
 first_name: 'Emmanu', 
 last_name: 'Varghese',
 dob:Date.today,
 gender: 1,
 country_id:1,
 language_id:1,
 bio: "hello world!",
 confirmed_at: Time.now
)
admin.save
admin.add_role "admin"
