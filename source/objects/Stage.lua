Stage = GameObject:extend()

function Stage:new()
    self.area = Area(self)
    self.main_canvas = love.graphics.newCanvas(game_screen_width, game_screen_height)
end

function Stage:draw()
    love.graphics.setCanvas(self.main_canvas)
    love.graphics.clear()
    love.graphics.circle('line', game_screen_width/2, game_screen_height/2, 50)
    self.area:draw()
    love.graphics.setCanvas()

    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.setBlendMode('alpha', 'premultiplied')
    love.graphics.draw(self.main_canvas, 0, 0, 0, game_screen_width_scale, game_screen_width_scale)
    love.graphics.setBlendMode('alpha')
end