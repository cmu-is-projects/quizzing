require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

	should have_many(:quizzes)

  # context "Creating a context" do
  #   setup do
  #     # build_context
  #   end

  #   teardown do
  #     # destroy_context
  #   end

  # end

end
