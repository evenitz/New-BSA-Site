namespace :db do
  
  desc "load user data from csv"
  task :load_csv_student_data => :environment do
    require 'csv'

    CSV.foreach("public/active_undergraduates_fall_2012.csv") do |row|
      if row[1] == "Spring 2016"
      User.create(
        :name => row[0],
        :email => row[2],
        :year => row[1]
      )
      end
    end
  end
end
