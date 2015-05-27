FactoryGirl.define do
  factory :category do
    name "Category One"
  end

  factory :coach do
    association :user
    association :organization
  	first_name "Rob"
  	last_name "Stanton"
    phone { rand(10 ** 10).to_s.rjust(10,'0') }
  	active true
  end

  factory :division do
  	name "Senior A"
    start_grade 7
    end_grade 12
    active true
  end

  factory :event do
    start_date Date.today
    end_date Date.today
    start_time Time.now
    num_rounds 6
    association :organization
  end

  factory :organization_student do
  	association :student
  	association :organization
  	start_date Date.today
  	end_date nil
  end

  factory :organization do
   	name "Allegheny Center Alliance Church"
  	short_name "ACAC"	
  	street_1 "250 East Ohio Street"
  	street_2 nil
  	city "Pittsburgh"
  	state "Pennsylvania"
  	zip "15212"
  	latitude nil
  	longitude nil
    active true
    primary_contact nil  
  end

  factory :quiz_team do
  	association :quiz
  	association :team
  	position 1
  	raw_score nil
  	points nil
  	failed_challenges 0
  end

  factory :quiz do
  	association :division
  	association :event
    association :category
  	room_num 1
  	round_num 1
  	active true
  end

  factory :setting do
  	roster_lock_date Date.today
  	drop_lowest_score false
  	roster_lock_toggle false
  	auto_promote_students false
  end

  factory :student_quiz do
  	association :student
  	association :quiz
  	num_correct nil
  	num_attempts nil
  	num_fouls nil
  end

  factory :student_team do
  	association :student
  	association :team
  	is_captain false
  	active true
  	start_date Date.today
  	end_date nil
  end

  factory :student do
    first_name "Mark"
    last_name "Heimann"
    grade 9
    active true
  end

  factory :team_coach do
  	association :team
  	association :coach
  	start_date Date.today
  	end_date nil
  end

  factory :team do
  	association :division
    association :organization
  	name "Team One"
  	active true
  end

  factory :user do
    sequence :username do |n|
      "user#{n}"
    end
    role "coach"
    password "secret"
    password_confirmation "secret"
    email { |u| "#{u.username}@example.com".downcase }
    active true
  end
  
end

