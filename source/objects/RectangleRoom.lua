RectangleRoom = Object:extend()

local rectangle

function RectangleRoom:new()
    -- self.circle = {x = love.graphics.getWidth() / 2, y = love.graphics.getHeight() / 2, radius = (((love.graphics.getWidth() + love.graphics.getHeight()) / 2) /2 )}
    rectangle = {x = love.graphics.getWidth() / 2, y = love.graphics.getHeight() / 2, radius = (((love.graphics.getWidth() + love.graphics.getHeight()) / 2) /2 )}
end

function RectangleRoom:update(dt)

end

function RectangleRoom:draw()
    love.graphics.rectangle("fill", rectangle.x, rectangle.y, rectangle.radius, rectangle.radius)
end