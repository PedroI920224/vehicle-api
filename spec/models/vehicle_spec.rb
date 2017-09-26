require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  it {should validate_presence_of(:licence_plate)}
  it {should validate_presence_of(:color)}
  it {should validate_presence_of(:brand_car)}
  it {should validate_presence_of(:year)}
end
