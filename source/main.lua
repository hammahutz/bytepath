-- OOD classes/libraries
Object = require "/libraries/classic/classic"
require "/objects/Objects"
Input = require "/libraries/boipushy/Input"
Timer = require "/libraries/hump/timer"
Moses = require "/libraries/Moses/moses"
Lume = require "/libraries/lume/lume"
Utils = require "/utils"

debug = true


function love.load()
    setupGameWindow()

    Objects.load()

    input = Input()

    timer = Timer()

    rooms = {}
    current_room = nil
    goToRoom("Stage", 0)
end

function love.update(dt)
    if current_room then
        current_room:update(dt)
    end
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
    if current_room and rooms[room_name] then

        if current_room.deactivate then 
            current_room:deactivate() 
        end

        current_room = rooms[room_name]

        if current_room.activate then 
            current_room:activate() 
        end
    else 
        current_room = addRoom(room_type, room_name, ...) 
    end
end

function setupGameWindow()
    local windowMode = {love.window.getMode()}
    local width, height = love.window.getDesktopDimensions(windowMode[3].display)

    if debug then
        print("Screen width: " .. width .. " Screen height: " .. height)
    end

    game_screen_width = width / game_screen_resulution_denominator
    game_screen_height = height / game_screen_resulution_denominator
    love.window.setMode(game_screen_width, game_screen_height, windowMode[3])

    if debug then
        print("Window width: " .. game_screen_width .. " Window height: " .. game_screen_height)
    end

    resizeScreen(game_screen_resulution_upscale)
end

function resizeScreen(scale)
    game_screen_width_scale, game_screen_height_scale = scale, scale
    if debug then
        print(game_screen_width)
        print(game_screen_height)
        print(game_screen_width_scale)
        print(game_screen_height_scale)
    end

    -- local _, _, flags = love.window.getMode()
    love.window.setMode(game_screen_width * game_screen_width_scale, game_screen_height * game_screen_height_scale)--, flags)
end