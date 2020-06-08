Brick = Object:extend()

function Brick:new(world, x, y)
    self.health = 2

    self.body = love.physics.newBody(world, x, y, 'static')
    self.shape = love.physics.newRectangleShape(50, 20)
    self.fixture = love.physics.newFixture(self.body, self.shape)
    self.fixture:setUserData(self)
end

function Brick:draw()
    love.graphics.polygon('fill', self.body:getWorldPoints(self.shape:getPoints()))
end

function Brick:end_contact()
    self.health = self.health - 1
end
