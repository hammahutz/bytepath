Area = Object:extend()

function Area:new(room)
    self.room = room
    self.game_objects = {}
end

function Area:update(dt)
    self:updatePhysics(dt)
    self:updateGameObjects(dt)
end

function Area:draw()
    if self.world then self.world:draw() end
    for _, game_object in ipairs(self.game_objects) do game_object:draw() end
end

function Area:updatePhysics(dt)
    if self.world then self.world:update(dt) end
end

function Area:updateGameObjects(dt)
    for i = #self.game_objects, 1, -1 do
        local game_object = self.game_objects[i]
        game_object:update(dt)
        if game_object.dead then 
            game_object:destroy()
            table.remove(self.game_objects, i)
        end
    end
end

function Area:addGameObject(game_object_type, x, y, options)
    local options = options or {}
    local game_object = _G[game_object_type](self, x or 0, y or 0, options)
    table.insert(self.game_objects, game_object)
    
    if debug then print("Name: " .. game_object.name .. " ID: " .. game_object.id) end
    
    return game_object
end

function Area:addPhysicsWorld()
    self.world = Physics:new(self, 0, 0)
end

function Area:destroy()
    for i = #self.game_objects, 1, -1 do
        local game_object = self.game_objects[i]
        game_object:destroy()
        table.remove(self.game_objects, i)
    end
    self.game_objects = {}

    if self.world then
        self.world:destroy()
        self.world = nil
    end
end