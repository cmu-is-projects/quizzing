FactoryGirl.define do

	factory :students do
	first_name "John"
    last_name "Smith"
    grade 6
    is_captain false
    active true
	end

  factory :organizations do
  	primary_contact 1
  	short_name "ACAC"
  	street_1 "5000 Forbes Avenue"
  	street_2 "SMC 0000"
  	city "Pittsburgh"
  	state "Pennsylvania"
  	zip "15213"
  	latitude nil
  	longitude nil
    active true
  end

  factory :events do
    start_date Date.today
    end_date nil
    start_time Time.now
    num_rounds 1
  end

  factory :quizzes do
  	event_id 1
  	division_id 1
  	room_num nil
  	round_num 1
  	active true
  end

  factory :team_quizzes do
  	association :team
	association :quiz
  	score_raw nil
  	score_calc nil
  	num_timeouts 0
  	num_challenges_lost 0
  end

  factory :student_quizzes do
  	association :student
  	association :quiz
  	num_correct nil
  	num_answered nil
  	num_fouls nil
  end

  factory :student_teams do
  	association :student
  	association :team
  	start_date Date.today
  	end_date nil
  end

  factory :organization_students do
  	association :student
  	association :organization
  	start_date Date.today
  	end_date nil
  end


end


#   factory :student do
#     first_name "Honey Wheat Bread"
#     last_name "A most tasty treat from the bakers at Bread Express. Your family will love it!"
#     grade nil
#     category "bread"
#     units_per_item 1
#     weight 1.0
#     active true
#   end

#       t.string   "first_name"
#     t.string   "last_name"
#     t.integer  "grade"
#     t.boolean  "captain"
#     t.boolean  "active"
#     t.datetime "created_at"
#     t.datetime "updated_at"

#   factory :item_price do
#     association :item
#     price 1.00
#     start_date Date.today
#     end_date nil
#   end
  
#   factory :user do
#     sequence :username do |n|
#       "user#{n}"
#     end
#     password "secret"
#     password_confirmation "secret"
#     role "customer"
#     active true
#   end

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