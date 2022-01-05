FactoryBot.define do
  
  factory(:user) do   
    email { "try@email.com" } 
    first_name {'firstname'}
    last_name {'lastname'}
    password { "password" }
    balance { 99999 }
    is_approved { true }
  end
  
end
