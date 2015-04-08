require 'test_helper'

class StandingsControllerTest < ActionController::TestCase
  test "should get individual" do
    get :individual
    assert_response :success
  end

  test "should get team" do
    get :team
    assert_response :success
  end

end
