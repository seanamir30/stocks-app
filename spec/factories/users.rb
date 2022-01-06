FactoryBot.define do
  
  factory(:user) do   
    email { "try@email.com" } 
    first_name {'firstname'}
    last_name {'lastname'}
    password { "password" }
<<<<<<< HEAD
    first_name { 'firstname'}
    last_name { 'lastname'}
=======
    balance { 99999 }
    is_approved { true }
>>>>>>> baf69dab29c4757f727be584b34a491898fb7cb2
  end
  
end
