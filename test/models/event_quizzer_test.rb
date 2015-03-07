require 'test_helper'

class EventQuizzerTest < ActiveSupport::TestCase
  include Contexts::EventQuizzerContexts
  context "Creating a context" do
    setup do
      build_context
    end

    teardown do
      destroy_context
    end

    

  end
end