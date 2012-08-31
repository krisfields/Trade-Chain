namespace :db do
  desc "Fill database with sample data"
  task populate_wants: :environment do
    99.times do |n|
      user_id  = n+7
      25.times do |i|
        value = rand(11...150)
        possession = Possession.all.sample
        possession_id = possession.id
        if possession.user_id != user_id 
          Want.create!(user_id: user_id,
                       value: value,
                       possession_id: possession_id)
        end
      end
    end
  end
end