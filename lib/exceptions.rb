module Exceptions
  # a general quizzing error
  class Error < StandardError; end

  # a custom exception when no database for subdomain
  class NoDatabaseExists < Error; end

  # a custom exception when no password reset token found
  class NoPasswordResetToken < Error; end

  # a custom exception when user is timed out
  class UserIsTimedOut < Error; end

  # a custom exception when authentication being hammered
  class AttemptedHammering < Error; end
  
end