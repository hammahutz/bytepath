Projectile = GameObject:extend()

function Projectile:new(area, x, y, opts)
    Projectile.super.new(self, area, x, y, opts)

    self.radius = opts.radius or 10
    self.velocity = opts.velocity or 2

    self.collider = self.area.world:newCircleCollider(self.x, self.y, self.radius)
    -- self.collider:setObjecet(self)
    -- self.collider:setLinearVelocity(self.velocity * math.cos(self.direction), self.velocity * math.sin(self.direction))

end

function Projectile:update(dt)
    Projectile.super:update(dt)
    self.collider:setLinearVelocity(self.velocity * math.cos(self.direction), self.velocity * math.sin(self.direction))
end

function Projectile:draw()
    love.graphics.setColor(default_color)
    love.graphics.circle("line", self.x, self.y, self.radius)
end

function Projectile:destroy()
    Projectile.super.destroy(self)
end