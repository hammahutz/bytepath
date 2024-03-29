Stage = GameObject:extend()

local function drawToMainCanvas(self)
    love.graphics.setCanvas(self.main_canvas)
    love.graphics.clear()
    camera:attach(0, 0, game_screen_width, game_screen_height)

    self.area:draw()

    camera:detach()
    love.graphics.setCanvas()

    input:bind("p", function ()
        self.area:addGameObject("Ammo", random(0, game_screen_width), random(0, game_screen_height))
    end)

end

function Stage:new()
    self.area = Area(self)
    self.area:addPhysicsWorld()

    self.player = self.area:addGameObject("Player", game_screen_width / 2, game_screen_height / 2, {name = "player"})
    input:bind("f2", function() self.player.dead = true end)

    self.main_canvas = love.graphics.newCanvas(game_screen_width, game_screen_height)

    self.area:addGameObject("Debug", 0, 0)
end

function Stage:update(dt)
    self.area:update(dt)
    self.super.update(self, dt)
end

function Stage:draw()
    drawToMainCanvas(self)

    love.graphics.setColor(default_color)
    love.graphics.setBlendMode('alpha', 'premultiplied')
    love.graphics.draw(self.main_canvas, 0, 0, 0, game_screen_width_scale, game_screen_width_scale)
    love.graphics.setBlendMode('alpha')
end

function Stage:destroy()
    self.area:destroy()
    self.area = nil
end