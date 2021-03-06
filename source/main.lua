require "global"

-- OOD classes/libraries
Object = require "/libraries/classic/classic"
require "/objects/Objects"

Input = require "/libraries/boipushy/Input"
Timer = require "/libraries/EnhancedTimer/EnhancedTimer"
Moses = require "/libraries/Moses/moses"
Lume = require "/libraries/lume/lume"
Utils = require "/utils"
Camera = require "/libraries/STALKER-X/Camera"
Draft = require "/libraries/draft/draft"
Lurker = require "/libraries/lurker/lurker"


debug = false

--if pcall(require, "lldebugger") then require("lldebugger").start() end  --Visual studio code
--if pcall(require, "mobdebug") then require("mobdebug").start() end      --ZeroBrane Studio

function love.load()
  --Zerobrain debug
  if arg[#arg] == "-debug" then require("mobdebug").start() end

    setupGameWindow()
    Objects.load()

    input = Input()
    fn = Moses()
    timer = Timer()
    camera = Camera()
    draft = Draft()

    rooms = {}
    current_room = nil
    goToRoom("Stage", 0)
    time_slow_amount = 1 --Timeslow for both timer, camera and room

    input:bind("left", "left")
    input:bind("right", "right")
    input:bind("up", "up")
    input:bind("down", "down")
    input:bind("p", "p")
end

function love.update(dt)
    camera:update(dt * time_slow_amount)
    timer:update(dt * time_slow_amount)
    if current_room then current_room:update(dt * time_slow_amount) end
end

local function draw_screen_flash()
    if flash_frames then
        flash_frames = flash_frames - 1
        if flash_frames <= -1 then
            flash_frames = nil
        end
    end
    if flash_frames then
        love.graphics.setColor(background_color)
        love.graphics.rectangle("fill", 0, 0, game_screen_width * game_screen_width_scale, game_screen_height * game_screen_height_scale)
        love.graphics.setColor(default_color)
    end
end

function love.draw()
    love.graphics.clear()
    if current_room then current_room:draw() end
    draw_screen_flash()
end

function addRoom(room_type, room_name, ...)
    local room = _G[room_type](room_name, ...)
    rooms[room_name] = room
    return room
end

function goToRoom(room_type, room_name, ...)
    if current_room and current_room.destroy then current_room:destroy() end
    current_room = _G[room_type](...)
end

function setupGameWindow()
    local windowMode = {love.window.getMode()}
    local width, height = love.window.getDesktopDimensions(windowMode[3].display)

    love.graphics.setDefaultFilter("nearest")
    love.graphics.setLineStyle("rough")

    love.graphics.setColor(default_color)

    game_screen_width = width / game_screen_resulution_denominator
    game_screen_height = height / game_screen_resulution_denominator
    love.window.setMode(game_screen_width, game_screen_height, windowMode[3])

    resizeScreen(game_screen_resulution_upscale)
end

function resizeScreen(scale)
    game_screen_width_scale, game_screen_height_scale = scale, scale
    love.window.setMode(game_screen_width * game_screen_width_scale, game_screen_height * game_screen_height_scale) -- , flags)
end

--Global Function
------------------------------------------------------------------------------------------------
function slow_time(amount, duration)
    time_slow_amount = amount
    timer:tween("slow_time", duration, _G, {time_slow_amount = 1}, 'in-out-cubic')
end

function screen_flash(frames)
    flash_frames = frames
end
