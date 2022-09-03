local love = require "love"
require "input_sink"

function love.keypressed(key, scancode, isrepeat)
    if key == "escape" then
        love.event.quit()
    end
end

local font = love.graphics.newFont(14)
love.graphics.setFont(font)

local inputSink = InputSink:new()
local windowWidth = 800
local windowHeight = 600
function love.load()
    windowWidth, windowHeight = love.graphics.getDimensions()
end

function love.resize(w, h)
    windowWidth, windowHeight = w, h
end

function love.keypressed(key, scancode, isrepeat)
    if inputSink then
        inputSink:keypress(key, scancode, isrepeat)
        return
    end

    if key == "escape" then
        love.window.close()
    end

end

function love.textinput(text)
    inputSink:input(text)
end

function love.draw()
    love.graphics.clear()
    love.graphics.print(inputSink:text(), 100, 100)
end
