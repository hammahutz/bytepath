Circle = Object:extend()

function Circle:new(posX, posY, radius)
    self.PosistionX = posX or 0
    self.PosistionY = posY or 0
    self.Radius = radius or 0

    self.CreationTime = 2
    self.Print = false
end

function Circle:update(dt)
    self.CreationTime = self.CreationTime - love.timer.getDelta()
    if self.CreationTime < 0 then self.Print = true end
end

function Circle:draw()
    if self.Print then
        love.graphics.setColor(1, 1, 1)
        love.graphics.circle("fill", self.PosistionX, self.PosistionY, self.Radius)
    end
end
