namespace :db do
  desc "Fill database with sample data"
  task populate_possessions: :environment do
    Possession.create!(name: "My Dignity",
                 description: "I'm not really using it anyway",
                 user_id: 1,
                 value: 10,
                 new_owner: nil,
                 trade_id: 2)
    99.times do |n|
      name  = Faker::Lorem.sentence(word_count = 3)
      description = Faker::Lorem.paragraph(sentence_count = 4)
      user_id  = rand(1...100)
      value = 10
      trade_id = 2
      Possession.create!(name: name,
                   description: description,
                   user_id: user_id,
                   value: value,
                   trade_id: trade_id,
                   new_owner: nil)
    end
  end
end