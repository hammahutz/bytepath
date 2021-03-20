Physics = GameObject:extend()



local function checkIgnores(collider_a, collider_b)
    if (type(collider_a.collider_class.ignores) == "table") then
        for _, ignore in ipairs(collider_a.collider_class.ignores) do
            if ignore == collider_b.collider_class.name then
                do return end
            end
        end
    elseif (type(collider_a.collider_class.ignores) ~= "nil") then
        if collider_a.collider_class.ignores == collider_b.collider_class.name then
            do return end
        end
    end
end



function Physics:new(area, x, y, options)
    Physics.super.new(self, area, x, y, options)
    self.colliders = {}
    self.classes = {}
    return self
end

function Physics:update(dt)
    for i = #self.colliders, 1, -1 do
        local collider_a = self.colliders[i]

        collider_a:update(dt)

        for _, collider_b in ipairs(self.colliders) do
            if collider_a.id ~= collider_b.id then
                Physics:checkCollision(collider_a, collider_b)
            end
        end

        if collider_a.dead then 
            table.remove(self.colliders, i)
        end

    end
end

function Physics:draw()
    if self.colliders  then
      love.graphics.setColor(1, 1, 0)
        for _, collider in ipairs(self.colliders) do
            collider:draw(z)
        end
      love.graphics.setColor(default_color)
    end
end

function Physics:newCircleCollider(area, x, y, radius)
    local collider = Collider(self.area, x, y, {collider_type = "Circle", radius = radius})
    table.insert(self.colliders, collider)
    return collider
end

function Physics:checkCollision(collider_a, collider_b)
    checkIgnores(collider_a, collider_b)
    

    local delta_x, delta_y

    delta_x = math.abs(collider_a.x - collider_b.x)
    delta_y = math.abs(collider_a.y - collider_b.y)

    --Om hypotenusa är minder än cirklarnas radier så är det kollision
    local katet_a =  delta_x * delta_x
    local katet_b = delta_y * delta_y
    local hypotenusa = (collider_a.radius + collider_b.radius) * (collider_a.radius + collider_b.radius)


    if (katet_a + katet_b) < hypotenusa then
        print(collider_a.collider_class.name .. " " .. collider_b.collider_class.name)
    end
end

function Physics:destroy()
    for _, collider in ipairs(self.colliders) do
        collider = nil
    end
end


---Adds a addCollisionClass
---@param class_name string Name of the class
---@param ignores table Claseses to be ignore
function Physics:addCollisionClass(class_name, ignores)
    table.insert(self.classes, {class = class_name, ignores = ignores})
end