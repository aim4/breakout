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
    require "brick"

    generateGameObjects()
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
    ball:draw()
    paddle:draw()
    for i, b in ipairs(bricks) do
        b:draw()
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

function generateGameObjects()
    world = love.physics.newWorld(0, 0)
    paddle = Paddle(world)
    ball = Ball(world)
    walls = {
        Wall(world, 400, -6, 800, 10), -- top
        Wall(world, 400, 606, 800, 10), -- bottom
        Wall(world, -6, 300, 10, 600), -- left
        Wall(world, 806, 300, 10, 600) -- right
    }

    bricks = {
        Brick(world, 100, 100),
        Brick(world, 200, 100),
        Brick(world, 300, 100),
    }
end


