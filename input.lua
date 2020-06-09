local state = require("state")

local input = {}
local press_functions = {}
local release_functions = {}

function initializeInput()
    input.press = function(pressed_key)
        if press_functions[pressed_key] then
            press_functions[pressed_key]()
        end
    end
    input.release = function(released_key)
        if release_functions[released_key] then
            release_functions[released_key]()
        end
    end
    input.toggle_focus = function(focused)
        if not focused then
            input.paused = true
        end
    end

    setPressFunctions()
    setReleaseFunctions()
end

function setPressFunctions()
    press_functions.left = function()
        state.button_left = true
    end
    press_functions.right = function()
        state.button_right = true
    end
    press_functions.escape = function()
        love.event.quit()
    end
    press_functions.space = function()
        if state.game_over or state.stage_cleared then
            return
        end
        state.paused = not state.paused
    end
end

function setReleaseFunctions()
    release_functions.left = function()
        state.button_left = false 
    end
    release_functions.right = function()
        state.button_right = false 
    end
end

return input

