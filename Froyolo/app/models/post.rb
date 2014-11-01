class Post < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  
  class_attribute :importance 
  class_attribute :age
end
