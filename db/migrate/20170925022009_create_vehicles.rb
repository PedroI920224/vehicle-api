class CreateVehicles < ActiveRecord::Migration[5.1]
  def change
    create_table :vehicles do |t|
      t.string :licence_plate
      t.string :color
      t.string :brand_car
      t.integer :year

      t.timestamps
    end
  end
end
