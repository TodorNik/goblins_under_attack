Gob = Object:extend()

function Gob:new(a,b)
   self.x = a
   self.y = b
   self.t = -0.2
end

function Gob:update(dt)
end

function Gob:draw(a,b)
    --draws the goblns
    gimg = love.graphics.newImage("gobmust.png")
    print("we got here")
    --draws goblins at slightly different positions for extra movement
    if a % 2 == 0 then
        love.graphics.draw(gimg, 300 + (self.x * 20 + b), 100 + (self.y * 20) + 4, 0, 3, 3)
    else
        love.graphics.draw(gimg, 300 + (self.x * 20 + b), 100 + (self.y * 20), 0, 3, 3)
    end
end