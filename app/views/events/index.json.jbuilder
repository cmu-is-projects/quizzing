json.array!(@events) do |event|
  json.extract! event, :id, :start_date, :end_date, :start_time, :num_rounds
  json.url event_url(event, format: :json)
end
