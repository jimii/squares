FactoryGirl.define do
  factory :spot do
    name { Faker::Name.name }
    position_x { rand(100..900) }
    position_y { rand(100..900) }
  end

end
