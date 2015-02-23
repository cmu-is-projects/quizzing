require 'test_helper'

class EventTest < ActiveSupport::TestCase

  #VALIDATONS
  should have_many(:quizzes)
  should validate_presence_of(:start_date)
  should validate_presence_of(:start_time)
  should validate_presence_of(:num_rounds)

  should allow_value(Date.today).for(:start_date)
  should allow_value(1.day.from_now.to_date).for(:start_date)
  should_not allow_value(1.day.ago.to_date).for(:start_date)
  should_not allow_value("bad").for(:start_date)
  should_not allow_value(2).for(:start_date)
  should_not allow_value(3.14159).for(:start_date)
  
  should_not allow_value("bad").for(:end_date)
  should_not allow_value(2).for(:end_date)
  should_not allow_value(3.14159).for(:end_date) 

  should validate_numericality_of(:num_rounds)
  #unsure of a realistic cap for num_rounds
  should allow_value(120).for(:num_rounds)
  should_not allow_value(0).for(:num_rounds)
  should_not allow_value("bad").for(:num_rounds)
  should_not allow_value(-20).for(:num_rounds)
  should_not allow_value(3.14159).for(:num_rounds)

  should allow_value("am").for(:time_slot)
  should allow_value("pm").for(:time_slot)
  should_not allow_value("bad").for(:time_slot)
  should_not allow_value("1:00").for(:time_slot)  
  should_not allow_value(900).for(:time_slot)

  
  should validate_numericality_of(:max_students)
  should allow_value(nil).for(:max_students)
  should allow_value(1).for(:max_students)
  should allow_value(12).for(:max_students)
  should_not allow_value("bad").for(:max_students)
  should_not allow_value(0).for(:max_students)
  should_not allow_value(-1).for(:max_students)
  should_not allow_value(3.14159).for(:max_students)

end
