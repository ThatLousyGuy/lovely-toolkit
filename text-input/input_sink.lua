InputSink = {}

function InputSink:new()
    local state = {
        props = {
            text = "",
            unregistrar = {}

        }
    }

    return setmetatable(state, { __index = InputSink });
end

function InputSink:register(unregisterfunc)
    if unregisterfunc then
        table.insert(self.props.unregistrar, unregisterfunc)
    end
end

function InputSink:unregister()
    for _, func in ipairs(self.props.unregistrar) do
        func(self)
    end
end

function InputSink:keypress(key, scancode, isrepeat)
    if key == "escape" then
        self:unregister()
    elseif key == "backspace" then
        local length = string.len(self.props.text)
        if length <= 1 then
            self.props.text = ""
        else
            self.props.text = string.sub(self.props.text, 1, length - 1)
        end
    end
end

function InputSink:input(text)
    self.props.text = self.props.text .. text
end

function InputSink:text()
    return self.props.text
end
