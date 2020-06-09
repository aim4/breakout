function love.conf(t)
    t.console = true
    t.window.width = 800
    t.window.height = 600
end

function love.load()
    Object = require "classic"
    require "world"
    require "paddle"
    require "ball"
    require "wall"
    require "brick"
    state = require "state"
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

    if state.paused then
        drawPauseText()
    elseif state.game_over then
        drawGameOverText()
    elseif state.stage_cleared then
        drawStateClearedText()
    end
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
    if state.game_over or state.stage_cleared or state.paused then
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

    if #bricks == 0 then
        state.stage_cleared = true
    end
    
    for i = #bricks, 1, -1 do
        brick = bricks[i]
        if brick.health == 0 then
            table.remove(bricks, i)
            brick.fixture:destroy()
        end
    end

    world:update(dt)
end

function generateGameObjects()
    world = love.physics.newWorld(0, 0)
    world:setCallbacks(nil, worldEndContactCallback, nil, nil)
    paddle = Paddle(world)
    ball = Ball(world)
    walls = {
        Wall(world, 400, -6, 800, 10), -- top
        Wall(world, 400, 606, 800, 10), -- bottom
        Wall(world, -6, 300, 10, 600), -- left
        Wall(world, 806, 300, 10, 600) -- right
    }

    -- game over if the bottom wall is touched
    walls[2].end_contact = function(self)
        state.game_over = true 
    end

    bricks = {}

    local spacing = 10
    local row_width = love.graphics.getDimensions() - 2 * spacing
    local brick_width = 50
    local brick_height = 20
    for i = 0,38 do
        local x = ((i * (brick_width + spacing)) % row_width) + (brick_width - spacing)
        local y = (math.floor((i * (brick_width + spacing) / row_width)) * (brick_width - spacing)) + 80
        bricks[i + 1] = Brick(world, x, y, brick_width, brick_height)
   end

    entities = {
        paddle,
        ball,
        walls,
        bricks
    }
end

function drawPauseText()
    local text = "Paused"
    love.graphics.setColor(state.palette[3])
    local f = love.graphics.setNewFont(18)
    local w = f:getWidth(text)
    sw, sh = love.graphics.getDimensions()

    love.graphics.printf(text, sw/2 - w/2, sh/2, w, "center")
    love.graphics.reset()
end

function drawGameOverText()
    local text = "Game Over"
    love.graphics.setColor(state.palette[5])
    local f = love.graphics.setNewFont(18)
    local w = f:getWidth(text)
    sw, sh = love.graphics.getDimensions()
    
    love.graphics.printf(text, sw/2 - w/2, sh/2, w, "center")
    love.graphics.reset()
end

function drawStateClearedText()
    local text = "Stage Cleared"
    love.graphics.setColor(state.palette[4])
    local f = love.graphics.setNewFont(18)
    local w = f:getWidth(text)
    sw, sh = love.graphics.getDimensions()
    
    love.graphics.printf(text, sw/2 - w/2, sh/2, w, "center")
    love.graphics.reset()
end
