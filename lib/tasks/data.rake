namespace :data do
  desc "creates test-data"
  task create: :setup do
    Whitelabel.with_label(Whitelabel.labels.first) do
      5.times { FactoryGirl.create(:location) }
      5.times { FactoryGirl.create(:topic) }
      5.times { FactoryGirl.create(:event, date: rand(100).days.ago) }
      5.times { FactoryGirl.create(:participant) }
    end
    puts "now open your browser at http://hamburg.onruby.dev:5000/"
  end

  task setup: ["environment", "db:migrate"] do
    require "factory_girl"
    Dir[Rails.root.join("spec/support/factories/*.rb")].each {|f| require f}
  end
end
