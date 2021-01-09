ShootEffect = GameObject:extend()

function ShootEffect:new(area, x, y, opts)
    ShootEffect.super.new(self, area, x, y, opts)
    self.width = 8
    self.timer:tween(0.1, self, {width = 0}, "in-out-cubic", function () self.dead = true end)
end

function ShootEffect:update(dt)
    ShootEffect.super.update(self, dt)
    if self.player then
        self.x = self.player.x + self.delta * math.cos(self.player.direction)
        self.y = self.player.y + self.delta * math.sin(self.player.direction)
    end
end

function ShootEffect:draw()
    pushRotate(self.x, self.y, self.player.direction + math.pi / 4)
    love.graphics.setColor(default_color)
    love.graphics.rectangle("fill", self.x - self.width / 2, self.y - self.width / 2, self.width, self.width)
    love.graphics.pop()
end

function ShootEffect:destroy()
    ShootEffect.super.destroy(self)
end

