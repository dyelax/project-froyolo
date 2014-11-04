json.array!(@posts) do |post|
  json.extract! post, :id, :xcoord, :ycoord, :score
  json.url post_url(post, format: :json)
end
