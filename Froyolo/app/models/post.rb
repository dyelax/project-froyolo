class Post < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  
  class_attribute :importance
end
