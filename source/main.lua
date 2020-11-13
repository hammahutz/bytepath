--OOD classes/libraries
Object = require "/libraries/classic/classic"
require "/objects/Objects"
Input = require "/libraries/boipushy/Input"
Timer = require "/libraries/hump/timer"

local circle, circle2, hyperCircle

--Debug
local mouseP, keys

ClockTimer = 0
DisplayTime = 0

function love.load()
    InitGameObjects()
    circle = Circle(200, 200, 20)
    circle2 = Circle(200, 300, 20)
    hyperCircle = HyperCircle(400, 300, 50, 120, 10)
    
    circle3 = {radius = 24}
    
    keys = ""
    mouseP = {0, 0, 0}
    
    input = Input()
    input:bind(1, 'test')
    input:bind('d', 'damage')

    timer = Timer()
    
    -- timer:every(1, function()print(love.math.random()) end, 5)
    timer:tween(3, circle3, {radius = 96}, 'in-out-back')
    
    rect_1 = {x = 400, y = 300, w = 50, h = 200}
    rect_2 = {x = 400, y = 300, w = 200, h = 50}
    start_cross_animation()
    
    health_top = {x = 600, y = 500, w = 200, h = 50, color = {red = 1.0, green = 0.0, blue =  0.0}}
    health_bottom = {x = 600, y = 500, w = 200, h = 50, color = {red = 0.5, green = 0.0, blue =  0.0}}
end

function love.update(dt)
    circle:update(dt)
    circle2:update(dt)
    hyperCircle:update(dt)
    
    
    ClockTimer = ClockTimer + dt
    DisplayTime = math.floor(ClockTimer)
    
    if input:pressed('test') then print('pressed') end
    if input:released('test') then print('released') end
    if input:down('test') then print('down') end
    
    timer:update(dt)

    if input:pressed('damage') then
        local damage = 50
        timer:tween(0.25, health_top, {w = health_top.w - damage, x = health_top.x - damage / 2}, 'in-cubic', function ()
            timer:tween(2, health_bottom, {w = health_bottom.w - damage, x = health_bottom.x - damage / 2}, 'in-cubic')       
        end)
    end


end

function love.draw()
    circle:draw()
    circle2:draw()
    hyperCircle:draw()
    
    love.graphics.circle('fill', 600, 200, circle3.radius)
    
    --Debug
    love.graphics.print("FPS: " .. love.timer.getFPS(), 0, 0)
    love.graphics.print("Time: " .. DisplayTime, 0, 20)
    love.graphics.print("keys: " .. keys, 0, 40)
    love.graphics.print("mouseX: " .. mouseP[001] .. " mouseY: " .. mouseP[002] .. " mouseButton: " .. mouseP[003], 0, 60)
    
    love.graphics.rectangle('fill', rect_1.x - rect_1.w / 2, rect_1.y - rect_1.h / 2, rect_1.w, rect_1.h)
    love.graphics.rectangle('fill', rect_2.x - rect_2.w / 2, rect_2.y - rect_2.h / 2, rect_2.w, rect_2.h)

    love.graphics.setColor(health_bottom.color.red, health_bottom.color.green, health_bottom.color.blue)
    love.graphics.rectangle('fill', health_bottom.x - health_bottom.w / 2, health_bottom.y - health_bottom.h / 2, health_bottom.w, health_bottom.h)

    love.graphics.setColor(health_top.color.red, health_top.color.green, health_top.color.blue)
    love.graphics.rectangle('fill', health_top.x - health_top.w / 2, health_top.y - health_top.h / 2, health_top.w, health_top.h)
end

function InitGameObjects()
    ObjectsInstance = Objects()
    ObjectsInstance.load()
end

--Debug
function love.keypressed(key)
    keys = key
end

function love.keyreleased(key)
    keys = key
    print(key)
end

function love.mousepressed(x, y, button)
    mouseP = {x, y, button}
end

function love.mousereleased(x, y, button)
    mouseP = {x, y, button}
end

function start_cross_animation()
    timer:tween(1, rect_1, {w = 0}, 'in-out-cubic', function()
        timer:tween(1, rect_2, {h = 0}, 'in-out-cubic', function()
            timer:tween(1, rect_1, {w = 50}, 'in-out-cubic')
            timer:tween(1, rect_2, {h = 50}, 'in-out-cubic')
        end)
    end)
end
