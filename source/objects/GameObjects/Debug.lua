Debug = GameObject:extend()

function Debug:new(area, x, y, opts)
    Debug.super.new(self, area, x, y, opts)

    self.game_time = 0
    self.display_time = 0
    self.fps = 0

    input:bind('f1', function()
        print("Before collection: " .. collectgarbage("count")/1024)
        collectgarbage()
        print("After collection: " .. collectgarbage("count")/1024)
        print("Object count: ")
        local counts = type_count()
        for k, v in pairs(counts) do print(k, v) end
        print("-------------------------------------")
    end)
end

function Debug:update(dt)
    Debug.super.update(self, dt)

    self.game_time = self.game_time + dt
    self.display_time = math.floor(self.game_time)
    self.fps = love.timer.getFPS()
end

function Debug:draw()
    love.graphics.print("Game Time: " .. self.display_time, 0, 0, 0, 1, 1, 0, 0, 0, 0)
    love.graphics.print("FPS: " .. self.fps, 0, 15, 0, 1, 1, 0, 0, 0, 0)
end

function Debug:destroy()
    Debug.super.destroy(self)
end