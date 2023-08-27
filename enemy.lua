Enemy = Object:extend()

function Enemy:new(a,b)
self.x = a
self.y = b
end

function Enemy:update()
end

function Enemy:draw(t)
    --sets picture and draws the enemy
    eimg = love.graphics.newImage("enemust.png")
    love.graphics.draw(eimg, 300 + (self.x * 20), 400 + (self.y * 20) - (t*24), 0, 3, 3)
end