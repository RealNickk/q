-- q - A runtime typechecking library for Lua created from a brain and coffee
-- Author: RealNickk
-- Version: 2.0.0
-- License: MIT

local q = {}

function q.new()
    local data, qtype = {}, newproxy(true)
    local mt = getmetatable(qtype)
    mt.__type = "qtype"
    mt.__call = function(_, ...)
        return handler(data, ...)
    end
    return qtype
end

function q.as()
    
end