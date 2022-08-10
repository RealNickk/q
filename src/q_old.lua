-- My first attempt at writing this library. It's a bit of a mess, but I figured i'd archive it anyway.

local q = {}
local qtype = {}

function q.getType(...)
	local params = {...}
	for i, v in ipairs(params) do
		local t = typeof(v)
		if t == "userdata" then
			local mt = getmetatable(v)
			if type(mt) == "table" and type(mt.__type) == "string" then
				if mt.__type == "qtype" and type(mt.__typeinfo) == "table" and type(mt.__typeinfo.Name) == "string" then
					params[i] = mt.__typeinfo.Name
					continue;
				end
				params[i] = mt.__type
				continue;
			end
		end
		params[i] = t
	end
	return unpack(params)
end

function q.query(o)
	if typeof(o) == "userdata" then
		local mt = getmetatable(o)
		if type(mt) == "table" and mt.__type == "qtype" and type(mt.__typeinfo) == "table" then
			return true, mt.__typeinfo
		end
	end
	return false, nil
end

function q.blank()
	local qt = newproxy(true)
	local mt = getmetatable(qt)
	mt.__type = "qtype"
	mt.__typeinfo = { Name = nil, Data = nil, Handler = nil }
	mt.__index = qtype
	return qt, mt.__typeinfo
end

function q.is(o, qt)
	local ti = getmetatable(qt).__typeinfo
	if not ti or not ti.Handler then return false; end
	return ti.Handler(qt, ti.Data, o)
end

function q.isBase(o, t)
	local ot = q.getType(o)
	return ot == t
end

function q.check(o, qt, err, ...)
	local isQType, typeInfo = q.query(qt)
	if isQType and typeInfo.Name == "tuple" then -- if tuple
		local func, funcName = debug.info(2, "fn")
		if func == qtype.Check then -- go up another level
			func, funcName = debug.info(3, "fn")
		end

		local is, i = q.is(o, qt)
		if not is then
			if i == 0 then error("a packet set of arguments need to be given"); end
			local expTypeName = q.getType(typeInfo.Data[i])
			if funcName == "" then -- anonymous function
				error(string.format("invalid argument #%s (%s expected)", i, expTypeName))
			else
				error(string.format("invalid argument #%s to '%s' (%s expected)", i, funcName, expTypeName))
			end
		end
	end
	assert(q.is(o, qt), string.format(err, ...))
end

-- tuple type
function q:isTuple(data, obj)
	if not q.is(obj, q.table) then return false, 0; end
	for i, v in ipairs(obj) do
		if not q.is(v, data[i]) then
			return false, i
		end
	end
	return true
end

function q.tuple(...)
	local qt, ti = q.blank()
	ti.Name = "tuple"
	ti.Data = {...}
	ti.Handler = q.isTuple
	return qt
end

-- variant type
function q:isVariant(data, obj)
	for _, v in ipairs(data) do
		if q.is(obj, v) then
			return true
		end
	end
	return false
end

function q.variant(...)
	local qt, ti = q.blank()
	ti.Name = "variant"
	ti.Data = {...}
	ti.Handler = q.isVariant
	return qt
end

-- Native types
local function wrapNative(t)
	local qt, info = q.blank()
	info.Name = t
	info.Data = t
	info.Handler = function(_, data, obj) return type(obj) == data; end
	return qt
end

q.null     = wrapNative("nil")
q.none     = q.null
q.bool     = wrapNative("boolean")
q.boolean  = q.bool
q.number   = wrapNative("number")
q.string   = wrapNative("string")
q.func     = wrapNative("function")
q.closure  = q.func
q.userdata = wrapNative("userdata")
q.thread   = wrapNative("thread")
q.table    = wrapNative("table")

-- template (table) type
function q:isTemplate(data, obj)
	if not q.is(obj, q.table) then return false; end
	for k, v in pairs(data) do
		if not q.is(obj[k], v) then
			return false
		end
	end
	return true
end

function q.template(t)
	local qt, ti = q.blank()
	ti.Name = "template"
	ti.Data = t
	ti.Handler = q.isTemplate
	return qt
end

-- nullable type
function q:isNullable(data, obj)
	return obj == nil or q.is(obj, data)
end

function q.nullable(o)
	local qt, ti = q.blank()
	ti.Name = "nullable"
	ti.Data = o
	ti.Handler = q.isNullable
	return qt
end

-- any type
do
	local qt, ti = q.blank()
	ti.Name = "any"
	ti.Handler = function() return true; end
	q.any = qt
end

-- qtype functions
function qtype:Is(o)
	return q.is(o, self)
end

function qtype:Check(o, err, ...)
	q.check(o, self, err, ...)
end

return q