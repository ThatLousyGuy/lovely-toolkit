Oscillator = {}

function Oscillator:new(timeline)
    local state = {
        properties = {
            timeline = timeline,
        }
    }

    return setmetatable(state, { __index = Oscillator })
end

function Oscillator:positionFunction(variables)
    local vars = variables or {}
    local amplitude = vars.amplitude or 1
    local frequency = vars.frequency or 1
    local xScale = vars.xScale or 1
    local shift = vars.shift or 0
    return function ()
        local props = self.properties
        local timeline = props.timeline

        local t = timeline:time()
        local x = t * xScale
        local y = amplitude * math.sin(
            math.pi * 2 * frequency * t + shift)

        return { x, y }
    end
end

