json.array!(@complaints) do |complaint|
  json.extract! complaint, :id, :latitude, :longitude, :body, :address, :title, :category_id, :user_id, :city, :likes
  json.url complaint_url(complaint, format: :json)
end
