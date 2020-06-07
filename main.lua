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

    -- Game objects
    world = love.physics.newWorld(0, 100)
    paddle = Paddle(world)
    ball = Ball(world)

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
