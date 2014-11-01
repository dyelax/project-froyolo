require 'open-uri'
json.extract! @post, :id, :xcoord, :ycoord, :altitude, :horizontalaccuracy, :verticalaccuracy, :created_at, :updated_at
json.imagedata Base64.encode64(File.open(@post.image.path).read)

