Brick = Object:extend()

function Brick:new(world, x, y, w, h)
    self.health = 2

    self.body = love.physics.newBody(world, x, y, 'static')
    self.shape = love.physics.newRectangleShape(w, h)
    self.fixture = love.physics.newFixture(self.body, self.shape)
    self.fixture:setUserData(self)
end

function Brick:draw()
    if self.health == 1 then
        love.graphics.setColor(1, 1, 0)
    end
    love.graphics.polygon('fill', self.body:getWorldPoints(self.shape:getPoints()))
    love.graphics.reset()
end

function Brick:end_contact()
    self.health = self.health - 1
end
