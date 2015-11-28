class CreateDataFiles < ActiveRecord::Migration
  def change
    create_table :data_files do |t|
      t.string :path
      t.integer :size
      t.integer :space_id
      t.integer :download_sum
      t.integer :type
      t.datetime :soft_destroyed_at

      t.timestamps
    end
    add_index :data_files, :soft_destroyed_at
  end
end
