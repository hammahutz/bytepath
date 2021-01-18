ExplodeParticle = GameObject:extend()

function ExplodeParticle:new(area, x, y, options)
    ExplodeParticle.super.new(self, area, x, y, options)

    self.color = options.color or default_color
    self.direction = random(0, 2 * math.pi)
    self.size = options.s or random(2, 3)
    self.velocity = options.velocity or random(75, 150)
    self.line_width = options.line_width or 2
    self.duration = options.duration or random(0.3 or 0.5)

    self.timer:tween(self.duration, self, {size = 0, velocity = 0, line_width = 0}, "linear", function() self.dead = true end)
end

function ExplodeParticle:update(dt)
    ExplodeParticle.super.update(self, dt)
    local deltaX = self.velocity * math.cos(self.direction) * dt
    local deltaY = self.velocity * math.sin(self.direction) * dt

    self.x = self.x + deltaX
    self.y = self.y + deltaY
end

function ExplodeParticle:draw()
    pushRotate(self.x, self.y, self.direction)

    love.graphics.setLineWidth(self.line_width)
    love.graphics.setColor(self.color)

    love.graphics.line(self.x - self.size, self.y, self.x + self.size, self.y)

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setLineWidth(1)

    love.graphics.pop()
end