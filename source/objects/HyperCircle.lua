HyperCircle = Circle:extend()

function HyperCircle:new(posX, posY, radius, outerRadius, lineWidth)
    HyperCircle.super.new(self, posX, posY, radius)
    self.OuterRadius = outerRadius
    self.LineWidth = lineWidth

end

-- HyperCircle:update()

function HyperCircle:draw()

    if self.Print then
        love.graphics.setColor(0.5, 1.0, 0.5)
        love.graphics.circle("fill", self.PosistionX, self.PosistionY, self.OuterRadius)

        love.graphics.setColor(0.0, 0.0, 0.0)
        love.graphics.circle("fill", self.PosistionX, self.PosistionY, self.OuterRadius - self.LineWidth)

        love.graphics.setColor(1.0, 0.5, 0.5)
        love.graphics.circle("fill", self.PosistionX, self.PosistionY, self.Radius)
    end

end
