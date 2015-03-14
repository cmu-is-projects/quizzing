require 'test_helper'

class NullDivisionTest < ActiveSupport::TestCase

  def test_name
    assert_equal "N/A", NullDivision.new.name
  end
  
  def test_start_grade
    assert_equal 0, NullDivision.new.start_grade
  end
  
  def test_end_grade
    assert_equal 0, NullDivision.new.end_grade
  end
  
  def test_active
    deny NullDivision.new.active
  end

  def test_teams
    assert_equal 1, NullDivision.new.teams.size
    assert_equal NullTeam, NullDivision.new.teams.first.class
  end

  def test_quizzes
    assert_equal 1, NullDivision.new.quizzes.size
    assert_equal NullQuiz, NullDivision.new.quizzes.first.class
  end

end