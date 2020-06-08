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
    input = require "input"

    initializeInput()
    generateGameObjects()
    paused = false
end

function love.draw()
    ball:draw()
    paddle:draw()
    for i, b in ipairs(bricks) do
        b:draw()
    end

    drawPauseText()
end

function love.focus(focused)
    input.toggle_focus(focused)
end

function love.keypressed(key)
    input.press(key)
end

function love.keyreleased(key)
    input.release(key)
end

function love.update(dt)
    if input.paused then
        return
    end

    for _, entity in ipairs(entities) do
        if entity.update then entity:update(dt) end
        if type(entity) == "table" then
            for _, childEntity in ipairs(entity) do
                if childEntity.update then childEntity:update(dt) end
            end
        end
    end

    world:update(dt)
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

    entities = {
        paddle,
        ball,
        walls,
        bricks
    }
end

function drawPauseText()
    local text = "Paused"
    local f = love.graphics.setNewFont(18)
    local w = f:getWidth(text)
    sw, sh = love.graphics.getDimensions()
    if input.paused then
        love.graphics.printf(text, sw/2 - w/2, sh/2, w, "center")
    end
end

