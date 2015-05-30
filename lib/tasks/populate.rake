namespace :db do
  desc "Erase and fill database"
  # creating a rake task within db namespace called 'populate'
  # executing 'rake db:populate' will cause this script to run
  task :populate => :environment do
    # Connect to database of choice...
    # include DatabaseSwitcher
    # connect_to_db('pgh')

    # Drop the old db and recreate from scratch
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    # Invoke rake db:migrate
    Rake::Task['db:migrate'].invoke
    Rake::Task['db:test:prepare'].invoke
    # Need gem to make this work when adding students later: faker
    # Docs at: http://faker.rubyforge.org/rdoc/
    require 'faker'
    require 'factory_girl_rails'

    p ActiveRecord::Base.configurations["#{Rails.env}"]

    # Step 1a: Create an admin and area_admin
    admin = User.new
    admin.username = "profh"
    admin.email = "profh@cmu.edu"
    admin.password = "question1question..."
    admin.password_confirmation = "question1question..."
    admin.role = "admin"
    admin.active = true
    admin.active_after = Time.now
    admin.save!

    area_admin = User.new
    area_admin.username = "tmreay"
    area_admin.email = "tmreay@example.com"
    area_admin.password = "secret"
    area_admin.password_confirmation = "secret"
    area_admin.role = "area_admin"
    area_admin.active = true
    area_admin.active_after = Time.now
    area_admin.save!

    # Step 2: Set up area settings, divisions and category
    area = Setting.new
    area.roster_lock_date = Date.new(2015,1,1)
    area.drop_lowest_score = true
    area.roster_lock_toggle = true
    area.auto_promote_students = true
    area.area_name = "Pittsburgh Area Quizzing"
    area.admin_name = "Tom Reay"
    area.admin_email = "tmreay@example.com"
    area.intro = "This site provides information for Pittsburgh area C&MA quizzing, including student and team performance for all area quizzes. If you break this application, we will punish you most severely; best advice is to play nice and behave yourself."

    jrs = Division.new
    jrs.name = 'juniors'
    jrs.start_grade = 3
    jrs.end_grade = 6
    jrs.active = true
    jrs.save!

    srs = Division.new
    srs.name = 'seniors'
    srs.start_grade = 7
    srs.end_grade = 12
    srs.active = true
    srs.save!

    srb = Division.new
    srb.name = 'seniorb'
    srb.start_grade = 7
    srb.end_grade = 12
    srb.active = true
    srb.save!

    divisions = Division.active.all

    category = FactoryGirl.create(:category, name: "Prelims")
    championship = FactoryGirl.create(:category, name: "Championship")
    consolation = FactoryGirl.create(:category, name: "Consolation")
    xyz = FactoryGirl.create(:category, name: "XYZ Quiz")

    # Step 3: Create some organizations
    orgs = [["Allegheny Center Alliance Church","250 E Ohio Street","Piitsburgh","PA","15212","ACAC",true],["Somerset Alliance Church","708 Stoystown Road","Somerset","PA","15501","Somerset",true],["Dorseyville Alliance Church","3703 Saxonburg Blvd","Indiana Twp","PA","15238","Dorseyville",true],["Broadway Alliance Church","1000 Broadway Street","East Mc Keesport","PA","15035","Broadway",true],["Murrysville Alliance Church","4130 Old William Penn Highway","Murrysville","PA","15668","MAC",true],["Indiana Alliance Church","2510 Warren Road","Indiana","PA","15701","Indiana",true],["Cherry Tree Alliance Church","640 Cherry Tree Lane","Uniontown","PA","15401","Cherry Tree",true],["Washington Alliance Church","246 Sanitarium Road","Washington","PA","15301","Washington",true],["Sculton Alliance Church","1033 Scullton Rd","Rockwood","PA","15557","Sculton",false],["Chicora Alliance Church","310 E Slippery Rock St","Chicora","PA","16025","Chicora",true],["Norwin Alliance Church","10585 Farview Drive","Irwin","PA","15642","Norwin",true],["Glenshaw Alliance Church","3601 Mount Royal Blvd","Glenshaw","PA","15116","Glenshaw",false],["Greensburg Alliance Church","4428 Route 136","Greensburg","PA","15601","Greensburg",true],["Urban Impact Foundation","801 Union Avenue","Pittsburgh","PA","15212","UIF",false],["McKeesport Alliance Church","938 Summitt Street","Mckeesport","PA","15132","McKeesport",true],["Elkins Alliance","PO Box 2904","Elkins","WV","26241","Elkins",true],["First Alliance (New Castle)","111 Mission Meade Street","New Castle","PA","16105","New Castle",true]]
    puts "CREATING ORGANIZATIONS"
    orgs.each do |organization|
      org = Organization.new
      org.name = organization[0]
      org.street_1 = organization[1]
      org.city = organization[2]
      org.state = organization[3]
      org.zip = organization[4]
      org.short_name = organization[5]
      org.active = organization[6]
      if org.save!
        p "#{org.short_name} created"
      else
        p "#{org.short_name} -- FAIL TO SAVE"
      end
      sleep 1
    end

    active_orgs = Organization.active.alphabetical.all

    # Step 4: Create some events at some of those locations
    # -- all past events from this year and one upcoming event
    dates = [Date.new(2014,10,04),Date.new(2014,11,01),Date.new(2014,12,06),Date.new(2015,01,03),Date.new(2015,02,07),Date.new(2015,03,07),Date.new(2015,04,11),Date.new(2015,06,27)]

    dates.each do |edate|
      if edate.past?
        event = Event.new
        event.start_date = Date.today
        event.end_date = Date.today
        event.start_time = Time.new(2015, 06, 01, 9, 0, 0, "-04:00") #i.e., 9:00am EDT
        event.num_rounds = 6
        event.organization_id = active_orgs.sample.id
        event.save!
        event.update_attribute(:start_date, edate)
        event.update_attribute(:end_date, edate)
      else
        event = Event.new
        event.start_date = edate
        event.end_date = edate
        event.start_time = Time.new(2015, 06, 01, 9, 0, 0, "-04:00") #i.e., 9:00am EDT
        event.num_rounds = 6
        event.organization_id = active_orgs.sample.id
        event.save!
      end
    end

    all_events = Event.chronological.all

    # Step 5: Create 1-3 coaches for each active org
    puts "CREATING COACHES"
    all_coaches = Array.new
    active_orgs.each do |org|
      coaches = Array.new
      [1,1,1,2,2,2,2,3,3,4].sample.times do |i|
        first_name = Faker::Name.first_name
        last_name = Faker::Name.last_name
        user = FactoryGirl.create(:user, username: "#{first_name[0]}#{last_name}#{rand(9)+1}")
        coach = FactoryGirl.create(:coach, first_name: first_name, last_name: last_name, organization: org, user: user)
        coaches << coach
      end
      all_coaches << coaches
    end
    organization_coaches = active_orgs.zip(all_coaches).to_h
    # for each active org, make the first coach the primary contact
    active_orgs.each do |org|
      org.primary_contact_id = organization_coaches[org].first.id
      org.save!
    end

    # Step 6: create some teams for each division for each active org
    puts "CREATING TEAMS"
    active_orgs.each do |org|
      divisions.each do |div|
        if org.short_name == "ACAC" && ( div.name == "juniors" || div.name == "seniors")
          num_teams = [5,6,7,8].sample
        elsif div.name == "seniorb"
          num_teams = [1,1,1,2].sample
        else
          num_teams = [1,2,3].sample
        end

        num_teams.times do |i|
          team = Team.new
          team.division_id = div.id
          team.organization_id = org.id
          team.name = "#{org.short_name} #{i+1}"
          team.active
          if team.save!
            p "#{team.name} :: #{team.division.name} created"
          else
            p "#{team.name} -- FAIL TO SAVE"
          end
        end
      end
    end
    jr_teams = Team.for_division(jrs).alphabetical.all
    sr_teams = Team.for_division(srs).alphabetical.all
    srb_teams = Team.for_division(srb).alphabetical.all
    puts "Junior teams: #{jr_teams.count}"
    puts "Senior teams: #{sr_teams.count}"
    puts "Senior B teams: #{srb_teams.count}"
    puts " "

    # Step 7: Add students to each team (first student is captain)
    puts "CREATING STUDENTS"
    jr_student_count = 0
    jr_teams.each do |team|
      num_students = [3,3,3,4,4,4,4,5].sample
      num_students.times do |n|
        first_name = Faker::Name.first_name
        last_name = Faker::Name.last_name
        grade = [3,4,5,6].sample
        captain = n.zero?
        student = FactoryGirl.create(:student, first_name: first_name, last_name: last_name, grade: grade)
        jr_student_count += 1 if student
        FactoryGirl.create(:student_team, student: student, team: team, is_captain: captain, start_date: Date.new(2014,9,1))
      end
    end

    sr_student_count = 0
    sr_teams.each do |team|
      num_students = [1,2,2,2,3,3,3,3,4,4].sample
      num_students.times do |n|
        first_name = Faker::Name.first_name
        last_name = Faker::Name.last_name
        grade = [7,8,9,10,11,12].sample
        captain = n.zero?
        student = FactoryGirl.create(:student, first_name: first_name, last_name: last_name, grade: grade)
        sr_student_count += 1 if student
        FactoryGirl.create(:student_team, student: student, team: team, is_captain: captain, start_date: Date.new(2014,9,1))
      end
    end

    srb_student_count = 0
    srb_teams.each do |team|
      num_students = [3,3,3,4,4].sample
      num_students.times do |n|
        first_name = Faker::Name.first_name
        last_name = Faker::Name.last_name
        grade = [7,8,9,10,11,12].sample
        captain = n.zero?
        student = FactoryGirl.create(:student, first_name: first_name, last_name: last_name, grade: grade)
        srb_student_count += 1 if student
        FactoryGirl.create(:student_team, student: student, team: team, is_captain: captain, start_date: Date.new(2014,9,1))
      end
    end
    puts "Junior students: #{jr_student_count}"
    puts "Senior students: #{sr_student_count}"
    puts "Senior B students: #{srb_student_count}"
    puts " "
    # Step 8: Add some quizzes to each past event
    puts "CREATING QUIZZES TO EVENTS"
    all_events.pop # to remove the future event
    all_events.each do |event|
      puts "============================"
      puts "EVENT: #{event.start_date}"
      num_jr_rooms = 8
      num_jr_rounds = (jr_teams.count * 6.0/3/num_jr_rooms).ceil
      num_sr_rooms = 7
      num_sr_rounds = (sr_teams.count * 6.0/3/num_sr_rooms).ceil
      num_srb_rooms = 5
      num_srb_rounds = (srb_teams.count * 6.0/3/num_srb_rooms).ceil

      num_jr_rounds.times do |r|
        round = r + 1
        num_jr_rooms.times do |x|
          room = x + 1
          quiz = FactoryGirl.create(:quiz, event: event, division: jrs, room_num: room, round_num: round, category: category)
          puts "Quiz: #{quiz.division.name} #{quiz.room_num}-#{quiz.round_num}"
        end
      end

      num_sr_rounds.times do |r|
        round = r + 1
        num_sr_rooms.times do |x|
          room = x + 1
          quiz = FactoryGirl.create(:quiz, event: event, division: srs, room_num: room, round_num: round, category: category)
          puts "Quiz: #{quiz.division.name} #{quiz.room_num}-#{quiz.round_num}"
        end
      end

      num_srb_rounds.times do |r|
        round = r + 1
        num_srb_rooms.times do |x|
          room = x + 1
          quiz = FactoryGirl.create(:quiz, event: event, division: srb, room_num: room, round_num: round, category: category)
          puts "Quiz: #{quiz.division.name} #{quiz.room_num}-#{quiz.round_num}"
        end
      end
    end

    # Step 9: Assign teams to each quiz

    # Step 10: Assign points to students and teams in each quiz

  end
end
