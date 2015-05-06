require 'test_helper'

class NullStudentTest < ActiveSupport::TestCase

  def test_first_name
    assert_equal "Unknown", NullStudent.new.first_name
  end
  
  def test_last_name
    assert_equal "Student", NullStudent.new.last_name
  end

  def test_grade
    assert_equal 0, NullStudent.new.grade
  end

  def test_active
    deny NullStudent.new.active
  end

  def test_inactive
    assert NullStudent.new.inactive
  end

  def test_name
    assert_equal "Student, Unknown", NullStudent.new.name
  end

  def test_proper_name
    assert_equal "Unknown Student", NullStudent.new.proper_name
  end

  def test_organizations
    assert_equal 1, NullStudent.new.organizations.size
    assert_equal NullOrganization, NullStudent.new.organizations.first.class
  end

  def test_current_organization
    assert_equal NullOrganization, NullStudent.new.current_organization.class
  end

  def test_teams
    assert_equal 1, NullStudent.new.teams.size
    assert_equal NullTeam, NullStudent.new.teams.first.class
  end

  def test_current_team
    assert_equal NullTeam, NullStudent.new.current_team.class
  end

  def test_quizzes
    assert_equal 1, NullStudent.new.quizzes.size
    assert_equal NullQuiz, NullStudent.new.quizzes.first.class
  end

end