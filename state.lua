state = {}
state.button_left = false
state.button_right = false
state.game_over = false
state.palette = {
    {1.0, 0.0, 0.0, 1.0}, -- red
    {0.0, 1.0, 0.0, 1.0}, -- green
    {0.4, 0.4, 1.0, 1.0}, -- blue
    {0.9, 1.0, 0.2, 1.0}, -- yellow
    {1.0 ,1.0, 1.0, 1.0} -- white
}
state.paused = false
state.stage_cleared = false
return state
