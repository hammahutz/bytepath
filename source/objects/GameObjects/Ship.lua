Ship = Object:extend()

function Ship:new(name, parent)
    self.name = name or "Fighter"
    self.parent = parent
    self.polygons = {}
    self.u = self.parent.width --Coordinate unit

    self:get_ship_visual()
end

function Ship:draw()
    pushRotate(self.parent.x, self.parent.y, self.parent.direction)
    love.graphics.setColor(default_color)
    for _, polygon in ipairs(self.polygons) do
        local points = fn.map(polygon, function(v, k)
        	if k % 2 == 1 then 
          		return self.parent.x + v + random(-1, 1)
        	else 
          		return self.parent.y + v + random(-1, 1)
        	end 
      	end)
        love.graphics.polygon('line', points)
    end
    love.graphics.pop()
end

function Ship:destroy()
    self.polygons = nil
    self = nil
end

function Ship:get_ship_visual()

    if self.name == "Crusader" then
        self.parent.gun_pos = self.u * 1.2
        self.parent.timer:every(0.01,
        function () 
           self.parent:add_trail(2.5*self.u_scale, 0)
       end)

       self.u_scale = 1/2
       self.u = self.u * self.u_scale

        self.polygons[1] = {
            self.u*2, 0,
            self.u, self.u,
            -self.u, self.u,
            -self.u*1.5, self.u*0.5,
            -self.u*1.5, 0,
            -self.u*1.5, -self.u*0.5,
            -self.u, -self.u,
            self.u, -self.u
        }
        
         self.polygons[2] = {
            self.u, self.u,
            self.u, self.u*2,
            -self.u*1.5,self.u*2,
            -self.u*2.5,self.u,
            -self.u*2.5,0,
            -self.u*1.5,0,
            -self.u*1.5,self.u*0.5,
            -self.u,self.u
         }
        
         self.polygons[3] = {
            self.u, -self.u,
            self.u, -self.u*2,
            -self.u*1.5,-self.u*2,
            -self.u*2.5,-self.u,
            -self.u*2.5,0,
            -self.u*1.5,0,
            -self.u*1.5,-self.u*0.5,
            -self.u,-self.u
         }

    elseif self.name == "Bit Hunter" then
        self.parent.gun_pos = self.u * 1.2
        self.parent.timer:every(0.01,
        function () 
           self.parent:add_trail(2.5*self.u_scale, 0)
       end)

       self.u_scale = 2/3
       self.u = self.u * self.u_scale

        self.polygons[1] = {
            self.u*3, 0,
            self.u*2, self.u,
            -self.u*3, self.u,
            -self.u*2, 0,
            -self.u*3, -self.u,
            self.u*2, -self.u
        }

    elseif self.name == "Rogue" then
        self.parent.gun_pos = self.u * 1.2
        self.parent.timer:every(0.01,
        function () 
           self.parent:add_trail(2*self.u_scale, 0.5)
           self.parent:add_trail(2*self.u_scale, -0.5)
       end)

       self.u_scale = 2/3
       self.u = self.u * self.u_scale

        self.polygons[1] = {
            self.u*2, 0,
            0, self.u,
            -self.u*3,0,
            0,-self.u
        }
        self.polygons[2] = {
            self.u, self.u*0.5,
            self.u*0.5, self.u*1.5,
            -self.u*4, self.u*4,
            -self.u*1.5, self.u*0.5,
            0, self.u
        }
        self.polygons[3] = {
            self.u, -self.u*0.5,
            self.u*0.5, -self.u*1.5,
            -self.u*4, -self.u*4,
            -self.u*1.5, -self.u*0.5,
            0, -self.u
        }

    elseif self.name == "Wisp" then
        self.parent.gun_pos = self.u * 1.2
        self.parent.timer:every(0.01,
        function () 
           self.parent:add_trail(2.0*self.u_scale, 0)
           self.parent:add_trail(0, 2.0*self.u_scale)
           self.parent:add_trail(0, -2.0*self.u_scale)
       end)

       self.u_scale = 2/3
       self.u = self.u * self.u_scale

        self.polygons[1] = {
            self.u*2, 0,
            self.u*2, self.u*0.5,
            self.u*0.5, self.u*2,
            -self.u*0.5, self.u*2,
            -self.u*2, self.u*0.5,
            -self.u*2, -self.u*0.5,
            -self.u*0.5, -self.u*2,
            self.u*0.5, -self.u*2,
            self.u*2, -self.u*0.5,
        }

    elseif self.name == "Sentinel" then
        self.parent.gun_pos = self.u * 1.5
        self.parent.timer:every(0.01,
        function () 
           self.parent:add_trail(1.8, 0)
       end)

       self.u_scale = 1/15
       self.u = self.u * self.u_scale

        self.polygons[1] = {
            self.u*20, 0,
            0, self.u*20,
            -self.u*20, self.u*15,
            -self.u*25, 0,
            -self.u*20, -self.u*15,
            0, -self.u*20 
        }

    elseif self.name == "Nuclear" then
        self.parent.gun_pos = self.u * 1.5
        self.parent.timer:every(0.01,
        function () 
           self.parent:add_trail(1.8, 0)
       end)

       self.u_scale = 1/15
       self.u = self.u * self.u_scale

        self.polygons[1] = {
            self.u*25, self.u*5,
            self.u*20, self.u*10,
            -self.u*20, self.u*10,
            -self.u*25, self.u*5,
            -self.u*25, -self.u*5,
            -self.u*20, -self.u*10,
            self.u*20, -self.u*10,
            self.u*25, -self.u*5,
        }

    elseif self.name == "Cycler" then
        self.parent.gun_pos = self.u * 1.5
        self.parent.timer:every(0.01,
        function () 
           self.parent:add_trail(1.3, 0)
       end)

       self.u_scale = 1/15
       self.u = self.u * self.u_scale

        self.polygons[1] = {
            self.u*20,0,
            0,self.u*20,
            -self.u*20,0,
            0,-self.u*20
        }

    elseif self.name == "Striker" then
        self.parent.gun_pos = self.u * 1.5
        self.parent.timer:every(0.01,
        function () 
           self.parent:add_trail(1, 2)
           self.parent:add_trail(1, 2)
       end)

       self.u_scale = 1/15
       self.u = self.u * self.u_scale

        self.polygons[1] = {
            self.u*20, 0,
            self.u*10, self.u*10,
            -self.u*10, self.u*10,
            -self.u*20, 0,
            -self.u*10, -self.u*10,
            self.u*10, -self.u*10
        }
        self.polygons[2] = {
            -self.u*5, self.u*10,
            -self.u*10, self.u*20,
            -self.u*5, self.u*30,
            self.u*10, self.u*35,
            self.u*35, self.u*25,
            self.u*5, self.u*45,
            -self.u*15, self.u*30,
            -self.u*20, 0,
            -self.u*10, self.u*10
        }
        self.polygons[3] = {
            -self.u*5, -self.u*10,
            -self.u*10, -self.u*20,
            -self.u*5, -self.u*30,
            self.u*10, -self.u*35,
            self.u*35, -self.u*25,
            self.u*5, -self.u*45,
            -self.u*15, -self.u*30,
            -self.u*20, 0,
            -self.u*10, -self.u*10
        }
    elseif self.name == "Fighter" or true then
        self.parent.gun_pos = self.u * 1.2
        self.parent.timer:every(0.01,
        function () 
           self.parent:add_trail(0.9, 0.2)
           self.parent:add_trail(0.9, -0.2)
       end)

        self.polygons[1] = {
            self.u, 0, -- 1
            self.u/2, -self.u/2, -- 2
            -self.u/2, -self.u/2, -- 3
             -self.u, 0, -- 4
             -self.u/2, self.u/2, -- 5
             self.u/2, self.u/2, -- 6
        }
        
         self.polygons[2] = {
            self.u/2, -self.u/2, -- 7
             0, -self.u, -- 8
             -self.u - self.u/2, -self.u, -- 9
             -3*self.u/4, -self.u/4, -- 10
             -self.u/2, -self.u/2, -- 11
         }
        
         self.polygons[3] = {
            self.u/2, self.u/2, -- 12
             -self.u/2, self.u/2, -- 13
             -3*self.u/4, self.u/4, -- 14
             -self.u - self.u/2, self.u, -- 15
             0, self.u, -- 16
         }
    end
end