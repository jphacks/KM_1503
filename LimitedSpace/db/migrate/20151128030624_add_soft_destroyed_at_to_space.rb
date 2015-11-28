class AddSoftDestroyedAtToSpace < ActiveRecord::Migration
  def change
    add_column :spaces, :soft_destroyed_at, :datetime
    add_index :spaces, :soft_destroyed_at
  end
end
