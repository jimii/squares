# 5 random spots
while Spot.all.count<5 do
  x = rand(100..900)
  y = rand(100..900)
  Spot.create(name: "Spot##{x}x#{y}", position_x: x, position_y: y)
end