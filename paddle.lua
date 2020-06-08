Paddle = Object:extend()

function Paddle:new(world)
    if not world then
        return
    end

    -- Dimensions
    local window_width = love.graphics.getDimensions()
    local padding = 2
    self.width = 120
    self.height = 20
    self.left_bound = self.width / 2 + padding
    self.right_bound = window_width - (self.width / 2) - padding
    

    -- Physics
    self.body = love.physics.newBody(world, 200, 560, 'kinematic')
    self.shape = love.physics.newRectangleShape(self.width, self.height)
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
    if input.left and x > self.left_bound then
        self.body:setLinearVelocity(-self.speed, 0)
        -- new_x = math.max(x - self.speed * dt, 108)
        -- self.body:setPosition(new_x, y)
    elseif input.right then
        self.body:setLinearVelocity(self.speed, 0)
        -- new_x = math.min(x + self.speed * dt, 700)
        -- self.body:setPosition(new_x, y)
    else
        self.body:setLinearVelocity(0, 0)
    end
end
