Wall = Object:extend()

function Wall:new(world, x, y, w, h)
    self.body = love.physics.newBody(world, x, y, 'static')
    self.shape = love.physics.newRectangleShape(w, h)
    self.fixture = love.physics.newFixture(self.body, self.shape)
    self.fixture:setUserData(self)
end

function Wall:draw()
    love.graphics.polygon('line', self.body:getWorldPoints(self.shape:getPoints()))
end
