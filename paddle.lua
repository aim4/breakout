Paddle = Object:extend()

function Paddle:new(world)
    if not world then
        return
    end

    self.body = love.physics.newBody(world, 200, 560, 'static')
    self.shape = love.physics.newRectangleShape(180, 20)
    self.fixture = love.physics.newFixture(self.body, self.shape)
    self.fixture:setUserData(self)
end

function Paddle:draw()
    love.graphics.polygon('line', paddle.body:getWorldPoints(paddle.shape:getPoints()))
end

