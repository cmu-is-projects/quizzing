require 'test_helper'

class NullCoachTest < ActiveSupport::TestCase

  def test_first_name
    assert_equal "Unknown", NullCoach.new.first_name
  end
  
  def test_last_name
    assert_equal "Coach", NullCoach.new.last_name
  end
  
  def test_email
    assert_equal "N/A", NullCoach.new.email
  end
  
  def test_phone
    assert_equal "N/A", NullCoach.new.phone
  end
  
  def test_active
    deny NullCoach.new.active
  end

  def test_inactive
    assert NullCoach.new.inactive    
  end
  
  def test_user
    assert_equal NullUser, NullCoach.new.user.class
  end
  
  def test_organization
    assert_equal NullOrganization, NullCoach.new.organization.class
  end

  def test_teams
    assert_equal 1, NullCoach.new.teams.size
    assert_equal NullTeam, NullCoach.new.teams.first.class
  end

  def test_name
    assert_equal "Coach, Unknown", NullCoach.new.name
  end

  def test_proper_name
    assert_equal "Unknown Coach", NullCoach.new.proper_name
  end
end
