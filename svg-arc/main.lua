local love = require "love"

local font = love.graphics.newFont(14)
love.graphics.setFont(font)

local windowWidth, windowHeight = love.graphics.getDimensions()
local middle = { windowWidth/2, windowHeight/2 }
local radius = 100

local headAngle = 0
local tailAngle = math.pi / 2
local arcHead = { middle[1] + radius, middle[2] };
local arcTail = { middle[1], middle[2] + radius };

local function largeArc()
    local diff = math.abs(tailAngle - headAngle)
    return (diff > math.pi) and 1 or 0
    --return (math.abs(math.fmod(tailAngle, 2 * math.pi) - math.fmod(headAngle, 2 * math.pi)) > math.pi) and 1 or 0
end

local function sweep()
    local positive = tailAngle > headAngle
    local diff = math.abs(tailAngle - headAngle)
    --return (math.fmod(tailAngle, 2 * math.pi) > math.fmod(headAngle, 2 * math.pi)) and 1 or 0
    return positive and 1 or 0
end

local function printArc()
    local moveStr = 'M ' .. arcHead[1] .. ' ' .. arcHead[2]
    local angleInDegrees = (headAngle + tailAngle) / 2 * 180 / math.pi
    local arcStr = 'A ' .. radius .. ' ' .. radius .. ' '.. angleInDegrees .. ' ' .. largeArc() .. ' ' .. sweep() .. ' ' .. arcTail[1] .. ' ' .. arcTail[2]
    local pathStr = moveStr .. ' ' .. arcStr
    return ('  <path d="' .. pathStr .. '" stroke="#FFFFFFFF" fill="#000000"/>')
end

local function printSvg()
    local width = windowWidth
    local height = windowHeight
    local left = middle[1] - (width/2)
    local top = middle[2] - (height/2)
    local viewbox = '' .. left .. ' ' .. top .. ' ' .. width .. ' ' .. height
    local header = ('<svg version="1.1" viewBox="' .. viewbox .. '" width="' .. width .. '" height="' .. height .. '" xmlns="http://www.w3.org/2000/svg">\n'
    )

    local arc = printArc() .. '\n'

    local footer = ('</svg>\n')

    local outputFile = "output.svg"
    local success, err = love.filesystem.write(outputFile, header .. arc .. footer)
    if success then
        print("SVG written to path " .. love.filesystem.getSaveDirectory() .. '/' .. outputFile)
    else
        print("SVG not written " .. err)
    end
end

local function drawDot(x, y)
    if type(x) == 'table' then
        love.graphics.circle("line", x[1], x[2], 3, 20)
    else
        love.graphics.circle("line", x, y, 3, 20)
    end
end

local function circlePoint(angle)
    return { radius * math.cos(angle) + middle[1], radius * math.sin(angle) + middle[2] }
end

local incrementAngle = math.pi / 3
function love.keypressed(key, scancode, isrepeat)
    if key == "escape" then
        love.event.quit()
    end
end

function love.textinput(text)
    if text == 'h' then
        headAngle = headAngle + incrementAngle
    elseif text == 'H' then
        headAngle = headAngle - incrementAngle
    elseif text == 't' then
        tailAngle = tailAngle + incrementAngle
    elseif text == 'T' then
        tailAngle = tailAngle - incrementAngle
    end
    arcHead = circlePoint(headAngle)
    arcTail = circlePoint(tailAngle)
    printSvg()
end


function love.update(dt)
end

local function drawHead()
    drawDot(arcHead)
    love.graphics.print("head", arcHead[1] + 10, arcHead[2] + 10)
end

local function drawTail()
    drawDot(arcTail)
    love.graphics.print("tail", arcTail[1] + 10, arcTail[2] + 10)
end

function love.draw()
    love.graphics.clear()
    love.graphics.circle("line", middle[1], middle[2], radius, 100)

    drawHead()
    drawTail()

    local headStr = "head " .. (headAngle / math.pi) .. "π"
    local tailStr = "tail " .. (tailAngle / math.pi) .. "π"
    love.graphics.print("largeArc " .. largeArc(), 10, windowHeight - 96)
    love.graphics.print("sweep " .. sweep(), 10, windowHeight - 72)
    love.graphics.print(headStr, 10, windowHeight - 48)
    love.graphics.print(tailStr, 10, windowHeight - 24)
end

