class AddRealPathToDataFile < ActiveRecord::Migration
  def change
    add_column :data_files, :real_path, :string
  end
end
