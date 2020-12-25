-- OOD classes/libraries
Object = require "/libraries/classic/classic"
require "/objects/Objects"
Input = require "/libraries/boipushy/Input"
Timer = require "/libraries/hump/timer"
Moses = require "/libraries/Moses/moses"
Lume = require "/libraries/lume/lume"
Utils = require "/utils"
Camera = require "/libraries/STALKER-X/Camera"

debug = true

function love.load()
    setupGameWindow()
    Objects.load()
    timer = Timer()
    camera = Camera()
    input = Input()
    input:bind("f3", function()
        camera:shake(200, 1, 200)
    end)
    input:bind("left", "left")
    input:bind("right", "right")

    rooms = {}
    current_room = nil
    goToRoom("Stage", 0)
    --debug
    input:bind('f1', function()
        print("Before collection: " .. collectgarbage("count")/1024)
        collectgarbage()
        print("After collection: " .. collectgarbage("count")/1024)
        print("Object count: ")
        local counts = type_count()
        for k, v in pairs(counts) do print(k, v) end
        print("-------------------------------------")
    end)

    input:bind('f2', function()
        goToRoom("Stage", 1)
    end)



end

function love.update(dt)
    if current_room then
        current_room:update(dt)
    end
    camera:update(dt)
end

function love.draw()
    love.graphics.clear()
    if current_room then
        current_room:draw()
    end
end

function addRoom(room_type, room_name, ...)
    local room = _G[room_type](room_name, ...)
    rooms[room_name] = room
    return room
end

function goToRoom(room_type, room_name, ...)

    if current_room and current_room.destroy then current_room:destroy() end
    current_room = _G[room_type](...)

    -- if current_room and rooms[room_name] then

    --     if current_room.deactivate then
    --         current_room:deactivate()
    --     end

    --     current_room = rooms[room_name]

    --     if current_room.activate then
    --         current_room:activate()
    --     end
    -- else
    --     current_room = addRoom(room_type, room_name, ...)
    -- end
end

function setupGameWindow()
    local windowMode = {love.window.getMode()}
    local width, height = love.window.getDesktopDimensions(windowMode[3].display)

    love.graphics.setDefaultFilter("nearest")
    love.graphics.setLineStyle("rough")

    game_screen_width = width / game_screen_resulution_denominator
    game_screen_height = height / game_screen_resulution_denominator
    love.window.setMode(game_screen_width, game_screen_height, windowMode[3])

    resizeScreen(game_screen_resulution_upscale)
end

function resizeScreen(scale)
    game_screen_width_scale, game_screen_height_scale = scale, scale
    love.window.setMode(game_screen_width * game_screen_width_scale, game_screen_height * game_screen_height_scale) -- , flags)
end
