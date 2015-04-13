module ApplicationHelper
  # create a helper to get the correct team names and divisions for the team select menu
    # will return an array with key being team_name - division_name so
    # coach can see the divisions and choose the right team
  def get_team_options(student)
    Team.not_at_capacity(student.current_organization).map{|t| ["#{t.name} - (#{t.division.name})", t.id] }
  end
end




