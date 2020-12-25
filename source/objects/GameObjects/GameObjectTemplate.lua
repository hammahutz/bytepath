GameObjectTemplate = GameObject:extend()

function GameObjectTemplate:new(area, x, y, opts)
    GameObjectTemplate.super.new(self, area, x, y, opts)
end

function GameObjectTemplate:update(dt)
    GameObjectTemplate.super.update(self, dt)
end

function GameObjectTemplate:draw()

end

function GameObjectTemplate:destroy()
    GameObjectTemplate.super.destroy(self)
end