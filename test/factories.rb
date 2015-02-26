FactoryGirl.define do
  factory :category do
    name "Category One"
  end

  factory :coach do
    association :user
    association :organization
  	first_name "Rob"
  	last_name "Stanton"
  	phone "0123456789"
  	email nil
  	active true
  end

  factory :division do
  	name "Senior A"
  end

  factory :event do
    start_date Date.today
    end_date nil
    start_time Time.now
    num_rounds 1
  end

  factory :organization_student do
  	association :student
  	association :organization
  	start_date Date.today
  	end_date nil
  end

  factory :organization do
  	name "Org One"
  	short_name "ACAC"	
  	street_1 "5000 Forbes Avenue"
  	street_2 nil
  	city "Pittsburgh"
  	state "Pennsylvania"
  	zip "15213"
  	latitude nil
  	longitude nil
    active true
    primary_contact 1  
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
  	division_id 1
  	event_id 1
  	room_num nil
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
  	num_answered nil
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
    first_name "John"
    last_name "Smith"
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
  	division_id 1
  	name "Team One"
  	active true
  	organization_id 1  	
  	
  end

  factory :user do
    sequence :user_name do |n|
      "user#{n}"
    end
    role "coach"
    password_hash "secret"
    password_salt "secret"
    active true
  end
  
end

# the below is for potential future reference
  
#   factory :customer do
#     first_name "Ed"
#     last_name "Gruberman"
#     phone { rand(10 ** 10).to_s.rjust(10,'0') }
#     email { |u| "#{u.first_name[0]}#{u.last_name}#{(1..99).to_a.sample}@example.com".downcase }
#     association :user
#     active true
#   end

#   factory :address do
#     recipient "Ted Gruberman"
#     street_1 "5000 Forbes Avenue"
#     street_2 nil
#     city "Pittsburgh"
#     state "PA"
#     zip "15213"
#     association :customer
#     is_billing false
#     active true
#   end

#   factory :order do
#     date Date.today
#     association :customer
#     association :address
#     grand_total 0.00
#     payment_receipt nil
#   end

#   factory :order_item do
#     shipped_on nil
#     association :order
#     association :item
#     quantity 1
#   end

#end
