Paddle = Object:extend()

function Paddle:new(world)
    if not world then
        return
    end

    self.body = love.physics.newBody(world, 200, 560, 'static')
    self.shape = love.physics.newRectangleShape(180, 20)
    self.fixture = love.physics.newFixture(self.body, self.shape)
    self.fixture:setUserData(self)
    self.speed = 400
end

function Paddle:draw()
    love.graphics.polygon('line', paddle.body:getWorldPoints(paddle.shape:getPoints()))
end

function Paddle:update(dt)
    if input.left and input.right then
        return
    end

    local x, y = self.body:getPosition()
    if input.left then
        new_x = math.max(x - self.speed * dt, 108)
        self.body:setPosition(new_x, y)
    elseif input.right then
        new_x = math.min(x + self.speed * dt, 700)
        self.body:setPosition(new_x, y)
    end
end
