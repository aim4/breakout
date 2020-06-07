World = Object:extend()

function World:new()
    self.world = love.physics.newWorld(0, 100)
end

function World:update(dt)
    self.world:update(dt)
end
