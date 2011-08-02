namespace :cleanup do

  desc 'remove all the trash people enter as their github username'
  task :user_github => :environment do
    User.where("github LIKE '%htt%'").each do |u| 
      puts u.github
      u.github = u.github.gsub(%r{https?://(www.)?github(.com)?/([^/]+)/?}, '\3')
      puts u.github
      u.save!
    end
  end

  desc 'remove all broken participants'
  task :participant => :environment do
    Participant.all.select{|p| p.user.nil? or p.event.nil?}.map(&:destroy)
  end

end
