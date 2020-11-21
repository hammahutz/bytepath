CircleRoom = Object:extend()

local circle

function CircleRoom:new()
    -- self.circle = {x = love.graphics.getWidth() / 2, y = love.graphics.getHeight() / 2, radius = (((love.graphics.getWidth() + love.graphics.getHeight()) / 2) /2 )}
    circle = {x = love.graphics.getWidth() / 2, y = love.graphics.getHeight() / 2, radius = (((love.graphics.getWidth() + love.graphics.getHeight()) / 2) /2 )}
end

function CircleRoom:update(dt)

end

function CircleRoom:draw()
    
    love.graphics.circle("fill", circle.x,  circle.y, circle.radius)
end