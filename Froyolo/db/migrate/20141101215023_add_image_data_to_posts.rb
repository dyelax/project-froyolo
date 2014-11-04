class AddImageDataToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :imagedata, :string
  end
end
