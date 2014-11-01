class Post < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  
  class_attribute :importance 
  class_attribute :age
  class_attribute :ageadjustedscore
end
