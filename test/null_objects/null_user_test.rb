require 'test_helper'

class NullUserTest < ActiveSupport::TestCase

  def test_username
    assert_equal "N/A", NullUser.new.username
  end
  
  def test_role
    assert_equal "guest", NullUser.new.role
  end
  
  def test_active
    deny NullUser.new.active
  end

  def test_inactive
    assert NullUser.new.inactive
  end

  def test_coach
    assert_equal NullCoach, NullUser.new.coach.class
  end

end