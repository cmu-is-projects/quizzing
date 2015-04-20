module ApplicationHelper

	def options_for_time_select
		start_time = Array.new
		for $h in 7..11 do
			for $m in ['00 AM', '30 AM'] do
				start_time.push [$h.to_s + ":" + $m.to_s, "%02d" % $h + ":" + $m + ":00"]
			end
		end
		start_time
	end

  # create a helper to get the correct team names and divisions for the team select menu
    # will return an array with key being team_name - division_name so
    # coach can see the divisions and choose the right team
  def get_team_options(student)
    Team.not_at_capacity(student.current_organization).map{|t| ["#{t.name} - (#{t.division.name})", t.id] }
  end

end




