# require needed files
require 'helpers/validations'
require 'helpers/individual_scoring'

module QuizHelpers
  include QuizHelpers::Validations
  include QuizHelpers::IndividualScoring
end