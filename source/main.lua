-- OOD classes/libraries
Object = require "/libraries/classic/classic"
require "/objects/Objects"
Input = require "/libraries/boipushy/Input"
Timer = require "/libraries/hump/timer"
Moses = require "/libraries/Moses/moses"
Lume = require "/libraries/lume/lume"
Utils = require "/utils"


function love.load()
    Objects.load()

    input = Input()

    timer = Timer()

    rooms = {}
    current_room = nil
    gotoRoom("StageOne", 10)

    printAll(1, 2, 3, 4, 5, 6, 7, 8, 9)
    printText(1, 2, 3, 4, 5, 6, 7, 8, 9)
end

function printAll(...)
    local localArg = {...}
    local printResultat = ""
    for key, value in ipairs(localArg) do
        printResultat = printResultat .. tostring(value) .. ("\n")
    end
    print(printResultat)
end

function printText(...)
    local localArg = {...}
    local printResult = ""
    for key, value in ipairs(localArg) do
        printResult = printResult .. tostring(value)
    end
    print(printResult)
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

function gotoRoom(room_type, room_name, ...)
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
