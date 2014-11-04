require 'open-uri'
json.extract! @post, :id, :xcoord, :ycoord, :altitude, :created_at, :updated_at, :score
json.imagedata Base64.encode64(File.open(@post.image.path).read)

