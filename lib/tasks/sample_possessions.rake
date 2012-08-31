namespace :db do
  desc "Fill database with sample data"
  task populate_possessions: :environment do
    99.times do |n|
      user_id  = n+7
      trade_id = 1
      10.times do |i|
        name  = Faker::Lorem.sentence(word_count = 3)
        description = Faker::Lorem.paragraph(sentence_count = 4)
        value = rand(1..50)
        Possession.create!(name: name,
                     description: description,
                     user_id: user_id,
                     value: value,
                     trade_id: trade_id,
                     new_owner: nil)
      end
    end
  end
end