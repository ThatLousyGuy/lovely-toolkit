Oscillator = {}

function Oscillator:new(timeline)
    local state = {
        properties = {
            timeline = timeline,
            amplitude = 50,
        }
    }

    return setmetatable(state, { __index = Oscillator })
end

function Oscillator:position()
    local props = self.properties
    local timeline = props.timeline
    local amplitude = props.amplitude

    local t = timeline:time()
    local x = t * 10
    local y = amplitude * math.sin(t)

    return { x, y }
end
