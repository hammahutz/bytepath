Collider = GameObject:extend()

function Collider:new(area, x, y, option)
    Collider.super.new(self, area, x, y, option)
    return self
end

function Collider:update(dt)
  
end

function Collider:draw()
  if self.collider_type == "circle" then love.graphics.circle("line", self.collider.x, self.collider.y, self.collider.radius) end
end

function Collider:setLinearVelocity(x, y)
  print(self.id)
  self.x = self.x + x
  self.y = self.y + y
end

function Collider:getPosition()
    return self.x, self.y
end

function Collider:destroy()
    self = nil
end