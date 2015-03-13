require 'test_helper'

class NullOrganizationTest < ActiveSupport::TestCase
  def test_name
    assert_equal "N/A", NullOrganization.new.name
  end

  def test_short_name
    assert_equal "N/A", NullOrganization.new.short_name
  end

  def test_street_1
    assert_equal "N/A", NullOrganization.new.street_1
  end

  def test_street_2
    assert_equal "N/A", NullOrganization.new.street_2
  end

  def test_city
    assert_equal "N/A", NullOrganization.new.city
  end

  def test_state
    assert_equal "N/A", NullOrganization.new.state
  end

  def test_zip
    assert_equal "N/A", NullOrganization.new.zip
  end

  def test_latitude
    assert_equal 0.0000, NullOrganization.new.latitude
  end

  def test_longitude
    assert_equal 0.0000, NullOrganization.new.longitude
  end

  def test_active
    deny NullOrganization.new.active
  end

  def test_primary_contact
    assert_equal NullCoach, NullOrganization.new.primary_contact.class
  end

  def test_students
    assert_equal 1, NullOrganization.new.students.size
    assert_equal NullStudent, NullOrganization.new.students.first.class
  end

  def test_teams
    assert_equal 1, NullOrganization.new.teams.size
    assert_equal NullTeam, NullOrganization.new.teams.first.class
  end
  
  def test_coaches
    assert_equal 1, NullOrganization.new.coaches.size
    assert_equal NullCoach, NullOrganization.new.coaches.first.class
  end

  def test_current_students
    assert_equal 1, NullOrganization.new.current_students.size
    assert_equal NullStudent, NullOrganization.new.current_students.first.class
  end

end