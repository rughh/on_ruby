namespace :data do
  desc "creates test-data"
  task create: :setup do
    Whitelabel.each_label do
      5.times { FactoryBot.create(:location) }
      5.times { FactoryBot.create(:topic) }
      5.times { FactoryBot.create(:event, date: rand(100).days.ago) }
      5.times { FactoryBot.create(:participant) }
    end
    puts "now open your browser at http://hamburg.onruby.test:5000/"
  end

  task setup: ["environment", "db:migrate"] do
    require "factory_bot"
    Dir[Rails.root.join("spec/support/factories/*.rb")].each {|f| require f}
  end
end
