Player = GameObject:extend()

function Player:new(area, x, y, options)
    Player.super:new(area, x, y, options)
    print(self.id)
end

function Player:update(dt)
    Player.super:update(dt)
end

function Player:draw()
    love.graphics.circle("line", self.x, self.y, 25)
end