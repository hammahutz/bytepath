Projectile = GameObject:extend()

function Projectile:new(area, x, y, opts)
    Projectile.super.new(self, area, x, y, opts)

    self.radius = opts.radius or 10
    self.velocity = opts.velocity or 2

    self.collider = self.area.world:newCircleCollider(self.area, self.x, self.y, self.radius)
    -- self.collider:setObjecet(self)
    -- self.collider:setLinearVelocity(self.velocity * math.cos(self.direction), self.velocity * math.sin(self.direction))

end

function Projectile:update(dt)
    Projectile.super.update(self, dt)
    self.collider:setLinearVelocity(self.velocity * math.cos(self.direction), self.velocity * math.sin(self.direction))
    
    if self.x < 10 then self:die() end
    if self.y < 10 then self:die() end
    if self.x > game_screen_width then self:die() end
    if self.y > game_screen_height then self:die() end
end

function Projectile:draw()
    love.graphics.setColor(default_color)
    love.graphics.circle("line", self.x, self.y, self.radius)
end

function Projectile:destroy()
    Projectile.super.destroy(self)
end

function Projectile:die()
    self.dead = true
    self.area:addGameObject("ProjectileDeathEffect", self.x, self.y, {color = boost_color, width = 3 * self.radius})
end