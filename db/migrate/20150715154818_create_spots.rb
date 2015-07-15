class CreateSpots < ActiveRecord::Migration
  def self.up
    create_table :spots do |t|
      t.string :name, null: false
      t.integer :position_x, null: false
      t.integer :position_y, null: false

      t.timestamps null: false
    end

    add_index(:spots, :name, unique: true)
  end
  def self.down
    drop_table :spots
  end
end
