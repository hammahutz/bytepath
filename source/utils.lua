function UUID()
    local fn = function (x)
        local random = love.math.random(16) - 1
        random = (x == "x") and (random + 1) or (r % 4) + 9
        return ("0123456789abcdef"):sub(random, random)
    end
    return (("xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"):gsub("[xy]", fn))
end

function random(min, max)
    return love.math.random() * (max - min) + min
end