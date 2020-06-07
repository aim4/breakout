Ball = Object:extend()

function Ball:new(world)
    if not world then
        return
    end

    self.body = love.physics.newBody(world, 200, 200, 'dynamic')
    self.body:setMass(32)
    self.body:setLinearVelocity(300, 300)
    self.shape = love.physics.newCircleShape(0, 0, 10)
    self.fixture = love.physics.newFixture(self.body, self.shape)
    self.fixture:setRestitution(1)
    self.fixture:setUserData(self)
end
