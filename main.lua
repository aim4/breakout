function love.conf(t)
    t.console = true
    t.window.width = 800
    t.window.height = 600
end

function love.load()
    Object = require "classic"
    -- require "world"
    require "paddle"
    require "ball"
    require "wall"

    -- Game objects
    world = love.physics.newWorld(0, 0)
    paddle = Paddle(world)
    ball = Ball(world)
    walls = {
        Wall(world, 400, 10, 800, 10), -- top
        Wall(world, 400, 595, 800, 10), -- bottom
        Wall(world, 5, 300, 10, 600), -- left
        Wall(world, 795, 300, 10, 600) -- right
    }

    paused = false
    key_map = {
        escape = function()
            love.event.quit()
        end,
        space= function()
            paused = not paused
        end
    }

end

function love.draw()
    local ball_x, ball_y = ball.body:getWorldCenter()
    love.graphics.circle('fill', ball_x, ball_y, ball.shape:getRadius())
    love.graphics.polygon('line', paddle.body:getWorldPoints(paddle.shape:getPoints())
    )

    for i, w in ipairs(walls) do
        w:draw()
    end
end

function love.focus(focused)
    if not focused then
        paused = true
    end
end

function love.keypressed(key)
    if key_map[key] then
        key_map[key]()
    end
end

function love.update(dt)
    if not paused then
        world:update(dt)
    end
end
