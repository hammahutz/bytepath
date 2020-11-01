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
    timer = Timer()

    -- timer:every(1, function()print(love.math.random()) end, 5)
    timer:tween(3, circle3, {radius = 96}, 'in-out-back')
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
end

function InitGameObjects()
    ObjectsInstance = Objects()
    ObjectsInstance.load()
end

--Debug
function love.keypressed(key)
    keys = key
end

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
