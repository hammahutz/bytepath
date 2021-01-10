GameObject = Object:extend()

function GameObject:new(area, x, y, options)

    local options = options or {}
    if options then
        for key, value in pairs(options) do
            self[key] =  value
        end
    end

    self.area = area
    self.x, self.y = x, y
    self.id = UUID()
    self.dead = false
    self.timer = Timer()
end

function GameObject:update(dt)
    if self.timer then self.timer:update(dt) end
    if self.collider then self.x, self.y = self.collider:getPosition() end
end

function GameObject:draw()
  
end

function GameObject:destroy()
    self.timer = nil
    if self.collider then self.collider.destroy() end
    self.collider = nil
end