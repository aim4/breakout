Ball = Object:extend()

function Ball:new(world)
    if not world then
        return
    end

    self.max_speed = 800
    self.body = love.physics.newBody(world, 200, 200, 'dynamic')
    self.body:setMass(32)
    self.body:setLinearVelocity(300, 300)
    self.shape = love.physics.newCircleShape(0, 0, 10)
    
    self.fixture = love.physics.newFixture(self.body, self.shape)
    self.fixture:setRestitution(1)
    self.fixture:setFriction(0)
    self.fixture:setUserData(self)
end

function Ball:draw()
    local ball_x, ball_y = ball.body:getWorldCenter()
    love.graphics.circle('fill', ball_x, ball_y, ball.shape:getRadius())
end

function Ball:update()
    local vx, vy = self.body:getLinearVelocity()
    local speed = math.abs(vx) + math.abs(vy)

    local vx_is_critical = math.abs(vx) > self.max_speed * 2
    local vy_is_critical = math.abs(vy) > self.max_speed * 2

    -- Ball is too fast
    if vx_is_critical or vy_is_critical then
        self.body:setLinearVelocity(vx * 0.75, vy * 0.75)
    end
    if speed > self.max_speed then
        self.body:setLinearDamping(0.1)
    else
        self.body:setLinearDamping(0)
    end
end
