class Vehicle < ApplicationRecord
  validates :brand_car, :color, :licence_plate, :year, presence: true
end
