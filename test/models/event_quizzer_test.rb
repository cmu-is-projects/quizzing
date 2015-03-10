require 'test_helper'

class EventQuizzerTest < ActiveSupport::TestCase
  context "Creating a context" do
    setup do
      create_one_event
      create_one_division
      # build_context
    end

    teardown do
      delete_one_event
      delete_one_division
      # destroy_context
    end

    

  end
end