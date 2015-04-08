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
end
