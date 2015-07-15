require 'rails_helper'

RSpec.describe Spot, type: :model do

  describe "basic validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:position_x) }
    it { should validate_presence_of(:position_y) }
    it { should validate_numericality_of(:position_x) }
    it { should validate_numericality_of(:position_y) }
  end

  describe "uniqueness" do
    subject { FactoryGirl.create(:spot) }
    it { should validate_uniqueness_of(:name) }
  end

  describe "collisions detection" do
    before {
      FactoryGirl.create(:spot, position_x: Spot::DIMENSION+100, position_y: Spot::DIMENSION+100)
    }

    it "should be correct" do
      expect{ FactoryGirl.create(:spot, position_x: Spot::DIMENSION+200, position_y: Spot::DIMENSION+200) }.to change(Spot,:count).by(1)
    end

  end

  describe "corner methods validation" do

    before {
      @spot = FactoryGirl.build(:spot, position_x: 100, position_y: 100)
      @corners = @spot.corners
    }
    it "should return correct values" do

      expect(@corners[:up_left_x]).to eq(100-(Spot::DIMENSION/2))
      expect(@corners[:up_left_y]).to eq(100-(Spot::DIMENSION/2))
      expect(@corners[:up_right_x]).to eq(100+(Spot::DIMENSION/2))
      expect(@corners[:up_right_y]).to eq(100-(Spot::DIMENSION/2))
      expect(@corners[:down_left_x]).to eq(100-(Spot::DIMENSION/2))
      expect(@corners[:down_left_y]).to eq(100-(Spot::DIMENSION/2))
      expect(@corners[:down_right_x]).to eq(100+(Spot::DIMENSION/2))
      expect(@corners[:down_right_y]).to eq(100-(Spot::DIMENSION/2))

    end

  end


end
