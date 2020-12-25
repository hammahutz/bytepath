Collider = GameObject:extend()

function Collider:new(area, x, y, option)
    Collider.super:new(area, x, y, option)
    return self
end

function Collider:setLinearVelocity(x, y)
    self.x = self.x + x
    self.y = self.y + y
end

function Collider:getPosition()
    return self.x, self.y
end

function Collider:destroy()
    self = nil
end