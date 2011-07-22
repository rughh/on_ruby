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

end
