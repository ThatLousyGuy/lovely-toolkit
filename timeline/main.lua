require('timeline')
require('actors/oscillator')
require('actors/dot')
local love = require "love"

local fontHeight = 14
local font = love.graphics.newFont(fontHeight)
love.graphics.setFont(font)

local timeline = Timeline:new()
local oscillator = Oscillator:new(timeline)

local actors = { }
local function createActors()
    for i = 0, 2 do
        local dot = Dot:new()
        dot:position(
            oscillator:positionFunction({
                frequency = math.pow(2, i),
                amplitude = 25,
                xScale = 50
            }))
        table.insert(actors, dot)
    end
end
createActors()

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
    love.graphics.print(string.format("%.3f", timeline:time()), 10, 10)

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.push()
    love.graphics.translate(100, 100)
    for i, actor in ipairs(actors) do
        love.graphics.push()
        love.graphics.translate(0, i * 110)
        actor:draw()
        love.graphics.pop()
    end
    love.graphics.pop()
end
