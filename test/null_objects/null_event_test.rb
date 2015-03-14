require 'test_helper'

class NullEventTest < ActiveSupport::TestCase

  def test_start_date
    assert_equal Date.today, NullEvent.new.start_date
  end
  
  def test_end_date
    assert_equal Date.today, NullEvent.new.end_date
  end

  def test_start_time
    assert_equal Time, NullEvent.new.start_time.class
  end
  
  def test_num_rounds
    assert_equal 6, NullEvent.new.num_rounds
  end

  def test_organization
    assert_equal NullOrganization, NullEvent.new.organization.class
  end

  def test_quizzes
    assert_equal 1, NullEvent.new.quizzes.size
    assert_equal NullQuiz, NullEvent.new.quizzes.first.class
  end

end