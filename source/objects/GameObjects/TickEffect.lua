TickEffect = GameObject:extend()

function TickEffect:new(area, x, y, opts)
    TickEffect.super.new(self, area, x, y, opts)

    self.depth = 75

    self.width, self.height = self.parent.width * 3 or 48, self.parent.width * 2 or 32
    self.y_offset = 0

    self.timer:tween(0.13, self, {height = 0, y_offset = self.height}, "in-out-cubic", function() self.dead = true end)
end

function TickEffect:update(dt)
    TickEffect.super.update(self, dt)
    if self.parent then self.x, self.y = self.parent.x, self.parent.y - self.y_offset end
end

function TickEffect:draw()
    love.graphics.setColor(default_color)
    love.graphics.rectangle("fill", self.x - self.width / 2, self.y - self.height / 2, self.width, self.height)
end

function TickEffect:destroy()
    TickEffect.super.destroy(self)
end