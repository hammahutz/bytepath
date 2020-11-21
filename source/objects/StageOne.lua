StageOne = Object:extend()

function StageOne:new()
    self.area = Area()
    self.timer = Timer()

    self.timer:every(2, function () self.area:addGameObject("RandomCircle", random(0, love.graphics.getWidth()), random(0, love.graphics.getHeight())) end)
end

function StageOne:update(dt)
    self.area:update(dt)
    self.timer:update(dt)
end

function StageOne:draw()
    self.area:draw()
end