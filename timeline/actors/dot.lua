local love = require("love")

Dot = {}

function Dot:new(radius)
    local state = {
        properties = {
            radius = radius or 2,
            position = { 0, 0 }
        }
    }
    return setmetatable(state, { __index = Dot })
end

function Dot:position(pos)
    if (pos ~= nil) then
        self.properties.position = pos
    end
    return self.properties.position
end

function Dot:draw()
    local props = self.properties
    local pos = props.position
    if type(props.position) == "function" then
        pos = (props.position)()
    end

    love.graphics.circle("fill", pos[1], pos[2], props.radius)
end

