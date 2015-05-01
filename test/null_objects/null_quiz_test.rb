require 'test_helper'

class NullQuizTest < ActiveSupport::TestCase

  def test_round_num
    assert_equal 0, NullQuiz.new.round_num
  end

  def test_room_num
    assert_equal 0, NullQuiz.new.room_num
  end

  def test_active
    deny NullQuiz.new.active
  end

  def test_inactive
    assert NullQuiz.new.inactive
  end  

  def test_division
    assert_equal NullDivision, NullQuiz.new.division.class
  end

  def test_event
    assert_equal NullEvent, NullQuiz.new.event.class
  end

  def test_students
    assert_equal 1, NullQuiz.new.students.size
    assert_equal NullStudent, NullQuiz.new.students.first.class
  end

  def test_teams
    assert_equal 1, NullQuiz.new.teams.size
    assert_equal NullTeam, NullQuiz.new.teams.first.class
  end

end