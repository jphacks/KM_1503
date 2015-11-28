class CreateSpaces < ActiveRecord::Migration
  def change
    create_table :spaces do |t|
      t.string :name, limit: 100
      t.integer :span, limit: 3
      t.float :lat
      t.float :lng
      t.integer :radius, limit: 4

      t.timestamps
    end
  end
end
