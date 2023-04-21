local Observable = {}
Observable.__index = Observable

function Observable:new()
    local o = {}
    setmetatable(o, Observable)
    o.listeners = {}
    return o
end

function Observable:subscribe(event, listener)
    if not self.listeners[event] then
        self.listeners[event] = {}
    end
    table.insert(self.listeners[event], listener)
end

function Observable:unsubscribe(event, listener)
    if self.listeners[event] then
        for i, registered_listener in ipairs(self.listeners[event]) do
            if registered_listener == listener then
                table.remove(self.listeners[event], i)
                break
            end
        end
    end
end

function Observable:notify(event, ...)
    if self.listeners[event] then
        for _, listener in ipairs(self.listeners[event]) do
            listener(...)
        end
    end
end


return Observable
