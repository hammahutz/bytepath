Player = GameObject:extend()

function Player:new(area, x, y, options)
    Player.super:new(area, x, y, options)

    self.width = 25
    self.collider = self.area.world:newCircleCollider(self.area, self.x, self.y, self, self.width)

    --Movement
    self.direction = 0
    self.angle_velocity = 1.66 * math.pi
    self.velocity = 0
    self.max_velocity = 1
    self.acceleration = 0.05


    --Attack
    self.attack_speed = 1
    -- self.timer:every(5, function ()
    --     self.attack_speed = random(1, 1)

    --     local attack_rate = 0.24 / self.attack_speed

    --     self.timer:every(attack_rate, function () self:shoot() end, 5 / attack_rate)

    -- end)
    self.timer:every(1, function () self:shoot() end)

end

function Player:update(dt)
    Player.super.update(self, dt)
 
    if input:down("left") then self.direction = self.direction - self.angle_velocity * dt end
    if input:down("right") then self.direction = self.direction + self.angle_velocity * dt end

    self.velocity = math.min(self.velocity + self.acceleration * dt, self.max_velocity)

    local x = self.velocity * math.cos(self.direction)
    local y = self.velocity * math.sin(self.direction)

    self.collider:setLinearVelocity(x, y)
    print(self.x)
end

function Player:draw()
    Player.super:draw()
    love.graphics.circle("line", self.x, self.y, self.width)
    love.graphics.line(self.x, self.y, self.x + 20 * math.cos(self.direction), self.y + 20 * math.sin(self.direction))
end

function Player:shoot()
    local delta = self.width * 1.2
    local deltaX = self.x + delta * math.cos(self.direction)
    local deltaY = self.y + delta * math.sin(self.direction)

    self.area:addGameObject("ShootEffect", deltaX, deltaY, {player = self, delta = delta, deltaY = deltaY})
    self.area:addGameObject("Projectile", deltaX, deltaY, {direction = self.direction})
end