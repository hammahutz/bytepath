--OOD classes/libraries
Object = require "/libraries/classic"
require "/objects/Objects"

local circle, circle2, hyperCircle

--Debug
local mouseP, keys

Timer = 0
DisplayTime = 0

function love.load()
    InitGameObjects()
    circle = Circle(200, 200, 20)
    circle2 = Circle(200, 300, 20)
    hyperCircle = HyperCircle(400, 300, 50, 120, 10)

    keys = ""
    mouseP = {0, 0, 0}
end

function love.update(dt)
    circle:update(dt)
    circle2:update(dt)
    hyperCircle:update(dt)


    Timer = Timer + dt
    DisplayTime = math.floor( Timer )
end

function love.draw()
    circle:draw()
    circle2:draw()
    hyperCircle:draw()

    --Debug
    love.graphics.print("FPS: " .. love.timer.getFPS(), 0, 0)
    love.graphics.print("Time: " .. DisplayTime, 0, 20)
    love.graphics.print("keys: " .. keys, 0, 40)
    love.graphics.print("mouseX: " .. mouseP[001] .. " mouseY: " .. mouseP[002] .." mouseButton: " .. mouseP[003], 0, 60)
end

function InitGameObjects()
    ObjectsInstance = Objects()
    ObjectsInstance.load()
end

--Debug
function  love.keypressed(key)
    keys = key
end

function love.keypressed(key)
    keys = key
end

function love.keyreleased(key)
    keys = key
end

function love.mousepressed(x, y, button)
    mouseP = {x, y, button}
end

function love.mousereleased(x, y, button)
    mouseP = {x, y, button}
end