Brick = Object:extend()

function Brick:new(world, x, y, w, h)
    self.health = 3

    self.body = love.physics.newBody(world, x, y, 'static')
    self.shape = love.physics.newRectangleShape(w, h)
    self.fixture = love.physics.newFixture(self.body, self.shape)
    self.fixture:setUserData(self)
end

function Brick:draw()
    love.graphics.setColor(state.palette[self.health] or state.palette[5])
    love.graphics.polygon('fill', self.body:getWorldPoints(self.shape:getPoints()))
    love.graphics.reset()
end

function Brick:end_contact()
    self.health = self.health - 1
end
