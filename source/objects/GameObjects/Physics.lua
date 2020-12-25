Physics = GameObject:extend()

function Physics:new(area, x, y, options)
    Physics.super:new(area, x, y, options)
    self.colliders = {}
    return self
end

function Physics:update(dt)
    for _, collider_a in ipairs(self.colliders) do
        for _, collider_b in ipairs(self.colliders) do
            if collider_a ~= collider_b then
                Physics:checkCollision(collider_a, collider_b)
            end
        end
    end
end

function Physics:draw()
    if self.colliders then
        for _, collider in ipairs(self.colliders) do
            love.graphics.circle("line", collider.x, collider.y, collider.radius)
        end
    end
end

function Physics:newCircleCollider(area, x, y, attach, radius)
    local collider = Collider:new(area, x, y, {attach = attach, circle = "Cicle", radius = radius})
    table.insert(self.colliders, collider)
    return collider
end

function Physics:checkCollision(collider_a, collider_b)
    local delta_x, delta_y

    delta_x = math.abs(collider_a.x - collider_b.x)
    delta_y = math.abs(collider_a.y - collider_b.y)

    --Om hypotenusa är minder än cirklarnas radier så är det kollision
    local katet_a =  delta_x * delta_x
    local katet_b = delta_y * delta_y
    local hypotenusa = (collider_a.radius + collider_b.radius) * (collider_a.radius + collider_b.radius)

    print("Katet A: " .. katet_a .. " Katet B: " .. katet_b .." hypo: " .. hypotenusa)

    if (katet_a + katet_b) < hypotenusa then
        print("hit")
    end
end

function Physics:destroy()
    for _, collider in ipairs(self.colliders) do
        collider = nil
    end
end