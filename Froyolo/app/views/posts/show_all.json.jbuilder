require 'open-uri'

json.array!(@posts) do |post|
  json.extract! post, :id, :xcoord, :ycoord, :score
  json.url post_url(post, format: :json)
  json.imagedata Base64.encode64(File.open(post.image.path).read)
end

