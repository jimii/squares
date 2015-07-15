class Spot < ActiveRecord::Base

  #data values
  DIMENSION = 24
  H_DIMENSION = (DIMENSION/2).floor

  #validators
  validates :name, presence: true, uniqueness: true
  validates :position_x, presence: true, numericality: true
  validates :position_y, presence: true, numericality: true
  validates_inclusion_of :position_x, in: 0..1000, message: "should be in the range of 0..1000"
  validates_inclusion_of :position_y, in: 0..1000, message: "should be in the range of 0..1000"

  #before
  before_create :check
  before_update :check

  # Corners
  #
  # returns hash with corners
  def corners
    {
        up_left_x:    self.position_x-H_DIMENSION,
        up_left_y:    self.position_y-H_DIMENSION,
        up_right_x:   self.position_x+H_DIMENSION,
        up_right_y:   self.position_y-H_DIMENSION,
        down_left_x:  self.position_x-H_DIMENSION,
        down_left_y:  self.position_y-H_DIMENSION,
        down_right_x: self.position_x+H_DIMENSION,
        down_right_y: self.position_y-H_DIMENSION
    }
  end

  private

  # Check
  #
  # checks existing spots in near area
  # updates name
  #
  # * get all spots except self
  # * iterate over existing spots & check collision
  # * return false if found
  # * correct name
  def check
    spots = Spot.where.not(id: self.id)

    spots.each do |spot|
      check = ((self.position_x - spot.position_x).abs < (DIMENSION + DIMENSION) / 2) && ((self.position_y - spot.position_y).abs < (DIMENSION + DIMENSION) / 2)
      return false if check === true
    end

    self.name = "Spot##{self.position_x}x#{self.position_y}"

    return true
  end


end
