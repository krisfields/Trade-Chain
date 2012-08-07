namespace :db do
  desc "Fill database with sample data"
  task populate_wants: :environment do
    Want.create!(user_id: 1,
                 possession_id: 1,
                 value: 20)
    99.times do |n|
      user_id  = rand(1...100)
      value = rand(11...100)
      possession_id = rand(1...100)
      Want.create!(user_id: user_id,
                   value: value,
                   possession_id: possession_id)
    end
  end
end