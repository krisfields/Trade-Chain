namespace :db do
  desc "Fill database with sample data"
  task populate_simple: :environment do
    User.create!(name: "Kris Fields",
                 email: "kris@avalaunch.com",
                 password: "please",
                 password_confirmation: "please")  
    Trade.create!(name: "San Francisco Exchange",
                  description: "We'll meet in the middle of the Golden Gate Bridge at midnight.",
                  user_id: 3)                   
    Possession.create!(name: "My Dignity",
                 description: "I'm not really using it anyway",
                 user_id: 1,
                 value: 10,
                 new_owner: nil,
                 trade_id: 1)
    Possession.create!(name: "My Brother's TV",
                 description: "I'm not really using it anyway",
                 user_id: 2,
                 value: 10,
                 new_owner: nil,
                 trade_id: 1)
    Possession.create!(name: "My Cat",
                 description: "I'm not really using it anyway",
                 user_id: 3,
                 value: 10,
                 new_owner: nil,
                 trade_id: 1)                                      
    Want.create!(user_id: 1,
                 possession_id: 2,
                 value: 20)
    Want.create!(user_id: 2,
                 possession_id: 3,
                 value: 20)
    Want.create!(user_id: 3,
                 possession_id: 1,
                 value: 20) 
  end
end