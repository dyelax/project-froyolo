require 'open-uri'

json.array!(@posts) do |post|
  json.extract! post, :id, :xcoord, :ycoord, :score
  json.timestamp post.created_at.to_time.to_i
  json.url post_url(post, format: :json)
  json.importance post.importance
  json.imagedata Base64.encode64(File.open(post.image.path).read)
end

