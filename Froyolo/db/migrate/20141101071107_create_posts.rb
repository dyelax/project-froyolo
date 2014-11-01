class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.decimal :xcoord
      t.decimal :ycoord
      t.decimal :altitude
      t.decimal :horizontalaccuracy
      t.decimal :verticalaccuracy

      t.timestamps
    end
  end
end
