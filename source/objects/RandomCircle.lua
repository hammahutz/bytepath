RandomCircle = GameObject:extend()

function RandomCircle:new(area, x, y, options)
    RandomCircle.super.new(self, area, x, y, options)
    self.radius = 50
    self.timer:after(random(2, 4), function () self.dead = true end)
end

function RandomCircle:draw()
    love.graphics.circle("fill", self.x, self.y, self.radius)
end