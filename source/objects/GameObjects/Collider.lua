Collider = GameObject:extend()

function Collider:new(area, x, y, option)
  Collider.super.new(self, area, x, y, option)

  self.delta_x = 0
  self.delta_y = 0
  self.angular_speed = 0

  self.collider_class = {}


  return self
end

function Collider:update(dt)
  Collider.super.update(self, dt)
  self.x = self.x + self.delta_x
  self.y = self.y + self.delta_y
end

function Collider:draw()

     love.graphics.setColor(1,0,0,0.3)
     love.graphics.circle("fill", self.x, self.y, self.radius)

end

function Collider:setLinearVelocity(x, y)
  self.x = self.x + x
  self.y = self.y + y
end

function Collider:setConstantLinearVelocity(delta_x, delta_y)
  self.delta_x = delta_x
  self.delta_y = delta_y
end

function Collider:getPosition()
  return self.x, self.y
end

-- function Collider:destroy()
--   self = nil
-- end

function Collider:setAngularImpulse(angular_speed)
  pushRotate(self.x, self.y, angular_speed)
end

function Collider:setColliderClass(collider_class, ignores)
  self.collider_class.name = collider_class
  self.collider_class.ignores = ignores
end
