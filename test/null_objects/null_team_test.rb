require 'test_helper'

class NullTeamTest < ActiveSupport::TestCase
  def test_name
    assert_equal "N/A", NullTeam.new.name
  end

  def test_active
    deny NullTeam.new.active
  end

  def test_division
    assert_equal NullDivision, NullTeam.new.division.class
  end

  def test_organization
    assert_equal NullOrganization, NullTeam.new.organization.class
  end

  def test_students
    assert_equal 1, NullTeam.new.students.size
    assert_equal NullStudent, NullTeam.new.students.first.class
  end

  def test_quizzes
    assert_equal 1, NullTeam.new.quizzes.size
    assert_equal NullQuiz, NullTeam.new.quizzes.first.class
  end
  
  def test_coaches
    assert_equal 1, NullTeam.new.coaches.size
    assert_equal NullCoach, NullTeam.new.coaches.first.class
  end

  def test_current_students
    assert_equal 1, NullTeam.new.current_students.size
    assert_equal NullStudent, NullTeam.new.current_students.first.class
  end

end