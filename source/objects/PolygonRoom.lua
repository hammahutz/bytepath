PolygonRoom = Object:extend()

local polygon

function PolygonRoom:new()
    -- self.circle = {x = love.graphics.getWidth() / 2, y = love.graphics.getHeight() / 2, radius = (((love.graphics.getWidth() + love.graphics.getHeight()) / 2) /2 )}
    polygon = {100, 100, 200, 100, 150, 200}
end

function PolygonRoom:update(dt)

end

function PolygonRoom:draw()
    love.graphics.polygon("fill", polygon)
end