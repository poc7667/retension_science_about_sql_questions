namespace :prepare_data do
  def get_day_range
      (Date.today-1.month..Date.today+1.month).to_a
  end

  task :events => :environment do
    puts "generate 5 affairs among 3 unique event type"
    (1..5).each do
      day = get_day_range.sample
      eids = (1..3).to_a
      e = Event.create(
        eid: eids.sample,
        dt: day
      )
    end
  end

  task :users => :environment do
    (1..5).each do
      User.create(
        name: Forgery::Name.full_name
      )
    end
  end

  task :orders => :environment do
    user_ids= User.all.pluck(:id)
    (1..3).each do
      Order.create(
        user_id: user_ids.sample,
        amount: (100..1000).to_a.sample
      )
    end
  end

end