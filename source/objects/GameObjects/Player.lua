Player = GameObject:extend()

function Player:new(area, x, y, options)
    Player.super.new(self, area, x, y, options)

    input:bind("f4", function() self:die() end)

    self.width = 12
    self.collider = self.area.world:newCircleCollider(self.area, self.x, self.y, self.width)
    self.trail_color = skill_point_color

    --Movement
    self.direction = 0
    self.angle_velocity = 1.66 * math.pi

    self.velocity = 0
    self.base_max_velocity = 100
    self.max_velocity = self.base_max_velocity

    self.acceleration = 100

    --Attack
    self.attack_speed = 1


    self.timer:every(0.24, function () self:shoot() end)
    self.timer:every(5, function() self:tick() end)

    self.ship = "Fighter"
    self.polygons = {}
    if self.ship == "Fighter" then

        self.polygons[1] = {
            self.width, 0, -- 1
            self.width/2, -self.width/2, -- 2
            -self.width/2, -self.width/2, -- 3
             -self.width, 0, -- 4
             -self.width/2, self.width/2, -- 5
             self.width/2, self.width/2, -- 6
        }
        
         self.polygons[2] = {
             self.width/2, -self.width/2, -- 7
             0, -self.width, -- 8
             -self.width - self.width/2, -self.width, -- 9
             -3*self.width/4, -self.width/4, -- 10
             -self.width/2, -self.width/2, -- 11
         }
        
         self.polygons[3] = {
             self.width/2, self.width/2, -- 12
             -self.width/2, self.width/2, -- 13
             -3*self.width/4, self.width/4, -- 14
             -self.width - self.width/2, self.width, -- 15
             0, self.width, -- 16
         }


         self.timer:every(0.01, function () self:add_trail(0.9, 0.2) end)
         self.timer:every(0.01, function () self:add_trail(0.9, -0.2) end)
    end
end

function Player:update(dt)
    Player.super.update(self, dt)
 
    if input:down("left") then self.direction = self.direction - self.angle_velocity * dt end
    if input:down("right") then self.direction = self.direction + self.angle_velocity * dt end

    self.max_velocity = self.base_max_velocity
    self.boosting = false
    self.trail_color = skill_point_color
    if input:down("up") then
        self.boosting = true
        self.trail_color = boost_color
        self.max_velocity = self.base_max_velocity * 1.5
    end
    if input:down("down") then
        self.boosting = true
        self.trail_color = slow_color
        self.max_velocity = self.base_max_velocity * 0.5
    end



    self.velocity = math.min(self.velocity + self.acceleration * dt, self.max_velocity)
    local delatX = self.velocity * math.cos(self.direction) * dt
    local deltaY = self.velocity * math.sin(self.direction) * dt
    self.collider:setLinearVelocity(delatX, deltaY)

    if self.x < 0 then self:die() end
    if self.y < 0 then self:die() end
    if self.x > game_screen_width then self:die() end
    if self.y > game_screen_height then self:die() end
end

function Player:draw()
    Player.super.draw(self)
    pushRotate(self.x, self.y, self.direction)
    love.graphics.setColor(default_color)
    for _, polygon in ipairs(self.polygons) do
        local points = fn.map(polygon, function(v, k)
        	if k % 2 == 1 then 
          		return self.x + v + random(-1, 1)
        	else 
          		return self.y + v + random(-1, 1)
        	end 
      	end)
        love.graphics.polygon('line', points)
    end
    love.graphics.pop()
end

function Player:shoot()
    local delta = self.width * 1.2
    local deltaX = self.x + delta * math.cos(self.direction)
    local deltaY = self.y + delta * math.sin(self.direction)

    self.area:addGameObject("ShootEffect", deltaX, deltaY, {player = self, delta = delta, deltaY = deltaY})
    self.area:addGameObject("Projectile", deltaX, deltaY, {direction = self.direction, radius = 5, velocity = 200 + self.velocity})
end

function Player:tick()
    self.area:addGameObject("TickEffect", self.x, self.y, {parent = self})
end

function Player:add_trail(delta_axis, delta_perpendicular)
    self.area:addGameObject(
        "TrailParticle",
        self.x - delta_axis * self.width * math.cos(self.direction) + delta_perpendicular * self.width * math.cos(self.direction + math.pi/2),
        self.y - delta_axis * self.width * math.sin(self.direction) + delta_perpendicular * self.width * math.sin(self.direction + math.pi/2),
        {parent = self, radius = random(2, 4), duration = random(0.15, 0.25), color = self.trail_color}
    )
end

function Player:die()
    self.dead = true
    slow_time(0.15, 1)
    camera:shake(10, 1.5, 50)
    screen_flash(10)

    for i = 1, love.math.random(8, 12) do
        self.area:addGameObject("ExplodeParticle", self.x, self.y)
    end
end