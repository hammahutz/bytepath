Ammo = GameObject:extend()

function Ammo:new(area, x, y, opts)
    Ammo.super.new(self, area, x, y, opts)

    self.width, self.height =  8, 8
    self.direction = random(0, 2 * math.pi)
    self.velocity = random(5, 40)
    self.angular_speed =  random(-10, 10)
    self.angle = 0

    self.collider = self.area.world:newCircleCollider(self.area, self.x, self.y, self.width)
    self.collider:setColliderClass("Collectable", {"Collectable", "Projectile"})
end

function Ammo:update(dt)
    Ammo.super.update(self, dt)

    self.angle = self.angle + self.angular_speed * dt
    self.collider:setLinearVelocity(self.velocity * math.cos(self.direction) * dt, self.velocity * math.sin(self.direction) * dt)
end

function Ammo:draw()
    love.graphics.setColor(ammo_color)
    self.collider:setAngularImpulse(self.angle)
    draft:rhombus(self.x, self.y, self.width, self.height, "line")
    love.graphics.pop()
end

function Ammo:destroy()
    Ammo.super.destroy(self)
end

function Ammo:handleCollision()
    self.dead = true
end
