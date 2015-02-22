json.array!(@organizations) do |organization|
  json.extract! organization, :id, :name, :short_name, :street_1, :street_2, :city, :state, :zip, :latitutde, :longitude, :active
  json.url organization_url(organization, format: :json)
end
