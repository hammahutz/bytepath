TrailParticle = GameObject:extend()

function TrailParticle:new(area, x, y, opts)
    TrailParticle.super.new(self, area, x, y, opts)

    self.radius = opts.radius or random(4, 6)
    self.color = opts.color or skill_point_color
    self.timer:tween(opts.duration or random(0.3, 0.5), self, {radius = 0}, "linear", function () self.dead = true end)
end

function TrailParticle:update(dt)
    TrailParticle.super.update(self, dt)
end

function TrailParticle:draw()
    love.graphics.setColor(self.color)
    love.graphics.circle("fill", self.x, self.y, self.radius)
end

function TrailParticle:destroy()
    TrailParticle.super.destroy(self)
end