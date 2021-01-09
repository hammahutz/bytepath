function UUID()
    local fn = function(x)
        local r = love.math.random(16) - 1
        r = (x == "x") and (r + 1) or (r % 4) + 9
        return ("0123456789abcdef"):sub(r, r)
    end
    return (("xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"):gsub("[xy]", fn))
end

function random(min, max)
    local min, max = min or 0, max or 1
    return (min < max and (love.math.random() * (max - min) + min)) or (love.math.random() * (min - max) + max)
end

function printf(...)
    local output = ""
    for key, value in ipairs(arg) do
        -- output = output .. " key: " .. key .. " value: " .. value
        print(tostring(value))
    end
end


function count_all(f)
    local seen = {}
    local count_table
    count_table = function(t)
        if seen[t] then return end
            f(t)
	    seen[t] = true
	    for k,v in pairs(t) do
	        if type(v) == "table" then
		    count_table(v)
	        elseif type(v) == "userdata" then
		    f(v)
	        end
	end
    end
    count_table(_G)
end

function type_count()
    local counts = {}
    local enumerate = function (o)
        local t = type_name(o)
        counts[t] = (counts[t] or 0) + 1
    end
    count_all(enumerate)
    return counts
end

global_type_table = nil
function type_name(o)
    if global_type_table == nil then
        global_type_table = {}
            for k,v in pairs(_G) do
	        global_type_table[v] = k
	    end
	global_type_table[0] = "table"
    end
    return global_type_table[getmetatable(o) or 0] or "Unknown"
end

function pushRotate(x, y, rotate)
    love.graphics.push()
    love.graphics.translate(x, y)
    love.graphics.rotate(rotate or 0)
    love.graphics.translate(-x, -y)
end

function pushRotateScale(x, y, rotate, scaleX, scaleY)
    love.graphics.push()
    love.graphics.translate(x, y)
    love.graphics.rotate(rotate or 0)
    love.graphics.scale(scaleX or 1, scaleY or 1)
    love.graphics.translate(-x, -y)
end