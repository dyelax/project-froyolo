class CreateVotecounts < ActiveRecord::Migration
  def change
    create_table :votecounts do |t|
      t.integer :netvotes

      t.timestamps
    end
  end
end
