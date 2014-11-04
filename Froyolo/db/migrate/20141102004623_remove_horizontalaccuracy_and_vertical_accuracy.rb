class RemoveHorizontalaccuracyAndVerticalAccuracy < ActiveRecord::Migration
  def change
    remove_column :posts, :horizontalaccuracy
    remove_column :posts, :verticalaccuracy
  end
end
