require('timeline')
require('actors/oscillator')
local love = require "love"

local fontHeight = 14
local font = love.graphics.newFont(fontHeight)
love.graphics.setFont(font)

local timeline = Timeline:new()
local oscillator = Oscillator:new(timeline)

function love.keypressed(key, _, _)
    if key == "escape" then
        love.event.quit()
    end
end

function love.update(dt)
    timeline:forward(dt)
end

function love.draw()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.clear()
    love.graphics.print(timeline:time(), 10, 10)

    local pos = oscillator:position()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.circle("fill", pos[1] + 100, pos[2] + 100, 5)
end
