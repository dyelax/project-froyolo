class AddPostIdToVotecount < ActiveRecord::Migration
  def change
    add_column :votecounts, :post_id, :integer
  end
end
