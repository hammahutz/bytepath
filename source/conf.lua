game_screen_width = 1920
game_screen_height = 1080
game_screen_resulution_denominator = 4
game_screen_resulution_upscale = 3

function love.conf(t)
    t.window.title ="BYTEPATH"
    t.window.width = game_screen_width / game_screen_resulution_denominator
    t.window.height = game_screen_height / game_screen_resulution_denominator
    t.window.resizable = true
    t.window.fullscreentype = "exclusive"
    t.window.display = 1
end