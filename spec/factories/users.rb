FactoryBot.define do
  factory :user do   
    email { "try@email.com" }
    password { "password" }
    first_name { 'firstname'}
    last_name { 'lastname'}
  end
end
