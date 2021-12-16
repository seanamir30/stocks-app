# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
admin = User.new(
    email: 'admin@test.com',
    first_name: 'admin',
    last_name:'admin',
    password: 'password',
    password_confirmation: 'password',
    admin:true
)

admin.skip_confirmation!
admin.save

user = User.new(
    email: 'user@test.com',
    first_name: 'user',
    last_name:'user',
    password: 'password',
    password_confirmation: 'password',
    admin:false
)

user.skip_confirmation!
user.save