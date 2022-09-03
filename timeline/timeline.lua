Timeline = {}

function Timeline:new(startTime)
    local normalizedStartTime = startTime or 0
    local normalizedEndTime = normalizedStartTime

    local state = {
        properties = {
            startTime = startTime or 0,
            endTime = normalizedEndTime,
            current = normalizedEndTime,
        }
    }

    return setmetatable(state, { __index = Timeline })
end

function Timeline:time()
    return self.properties.current
end

function Timeline:startTime()
    return self.properties.startTime
end

function Timeline:endTime()
    return self.properties.endTime
end

function Timeline:forward(dt)
    local props = self.properties

    local newEndTime = props.endTime + dt
    local newCurrent = props.current
    if props.current == props.endTime then
        newCurrent = newEndTime
    end

    props.endTime = newEndTime
    props.current = newCurrent
end

function Timeline:seek(time)
    local props = self.properties

    if time >= props.endTime then
        props.current = props.endTime
    elseif time <= props.startTime then
        props.current = props.startTime
    else
        props.current = time
    end
end
