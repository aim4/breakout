Brick = Object:extend()

function Brick:new(world, x, y)
    self.body = love.physics.newBody(world, x, y, 'static')
    self.shape = love.physics.newRectangleShape(50, 20)
    self.fixture = love.physics.newFixture(self.body, self.shape)
    self.fixture:setUserData(entity)
end

function Brick:draw()
    love.graphics.polygon('fill', self.body:getWorldPoints(self.shape:getPoints()))
end
