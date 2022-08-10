-- q - A runtime typechecking library for Lua created from a brain and coffee
-- Author: RealNickk
-- Version: 1.0.0
-- License: MIT

-- Testing
local DEBUG = false

-- Constants
local unpack = table.unpack or unpack
local typeof = typeof or type -- Support for both Roblox Luau/Vanilla Lua
local newproxy, IsProxy, SupportsProxy = newproxy, nil, true
if not newproxy then -- Support for newer versions of Lua
    newproxy = function()
        return setmetatable({}, { __fakeuserdata = true })
    end
    IsProxy = function(x)
        if typeof(x) == "table" then
            local mt = getmetatable(x)
            if type(getmetatable(x)) == "table" then
                return mt.__fakeuserdata == true
            end
        end
        return false
    end
    SupportsProxy = false
else
    IsProxy = function(x)
        return typeof(x) == "userdata"
    end
end

--[=[
    @class q
    A class that allows you to manage runtime types.
    This class provides a way to check if a value is of
    a certain type, a way to handle typechecking errors,
    and a way to define your own custom types for
    general use.
]=]
local q = {}

--[=[
    @type Handler (...: any) -> (success: boolean, err: string?, context: table?)
    @within q
    A handler function for a [QType]. This function takes in any
    number of parameters with any type. The first return argument
    is a boolean indicating whether the typecheck passed or not.
    The second return argument is the error message if the
    typecheck failed. The third return argument is returned for
    extra context on the object.

    :::note
    The `context` argument is only passed when needed. In
    documentation, it will explicitly state if and when it is
    passed, and there will be an interface defined for it.
    :::

    Here is a code snippet of a handler function:
    ```lua
    local function isInstance(obj)
        local typeName = typeof(obj)
        if typeName ~= "Instance" then
            return false,
                string.format("expected an Instance, got %s", typeName),
                { ObjectType = typeName }
        end
        return true
    end
    ```
]=]

--[=[
    Creates a blank `qtype` object. This can be used to create your
    own custom types to be used with the library.

    @param  name    string   -- The name of the qtype
    @param  handler function -- The handler function for the qtype
    @return qtype            -- The blank qtype object
]=]
function q.custom(name, handler)
    local data, qtype = {}, newproxy(true)
    local mt = getmetatable(qtype)
    mt.__type = "qtype"
    mt.__qtypename = name
    mt.__call = function(_, ...)
        return handler(data, ...)
    end
    mt.__index = data
    mt.__newindex = data
    return qtype
end

--[=[
    Returns the typename of the given object.

    @param  obj    any -- The name of the qtype
    @return string     -- Returns the typename of the given object
]=]
function q.typeName(obj)
    if q.qtype(obj) then
        return getmetatable(obj).__qtypename
    end
    return typeof(obj)
end

--[=[
    Errors with 'err' if the typecheck fails.

    @param res boolean -- The result of the typecheck
    @param err string  -- The error message
    @return void
]=]
function q.assert(res, err)
    if not res then error(err, 2); end
end

--[=[
    Creates a function that will create a tuple then
    assert the tuple before calling the callback.

    @param f   (...: any) -> (...: any) -- The callback function
    @param ... qtype -- The qtypes to check arguments against
    @return (...: any) -> (...: any) -- The wrapped function
]=]
function q.wrap(f, ...)
    local tupleCheck = q.tuple(...)
    return function(...)
        q.assert(tupleCheck(...))
        return f(...)
    end
end

--[=[
    @type ProcessorHandler (obj: T) -> any
    @within q
    A function that processes a value. This is used in [q.pwrap].

    ```lua
    q.numberString = q.custom("numberString", function(self, obj)
        return q.string(obj) and (tonumber(obj) ~= nil) or q.number(obj)
    end)

    q.processNumberString = function(obj)
        return tonumber(obj)
    end

    local function _doSomething(value)
        print(type(value))
    end

    local doSomething = q.pwrap(
        _doSomething,
        { q.processNumberString },
        { q.numberString }
    )

    doSomething(1234)   --> number
    doSomething("5678") --> number
    doSomething("Hello, world!") --> invalid argument #1 (expected numberString, got string)
    ```

    This is really ugly, so if anyone has a better way to do this,
    please let me know.
]=]

--[=[
    Creates a function that will create a tuple then
    assert the tuple before calling the callback. This
    function will also process the arguments before
    calling the callback.

    This is really ugly, so if anyone has a better way to do this,
    please let me know.

    @param f (...: any) -> (...: any) -- The callback function
    @param processors {ProcessorHandler<T>} -- A list of processor functions
    @param qtypes {QType} -- The types to check against
    @return (...: any) -> (...: any) -- The wrapped function
]=]
function q.pwrap(f, processors, qtypes)
    local tupleCheck = q.tuple(unpack(qtypes))
    return function(...)
        q.assert(tupleCheck(...))
        local args = {...}
        for i, v in ipairs(processors) do
            if type(v) == "function" then
                args[i] = v(args[i])
            end
        end
        return f(unpack(args))
    end
end

--[=[
    @type QType userdata | table
    @within q
    A custom type defined by the user. These can be called like
    a function with parameters to typecheck them. Refer to [Handler]
    for more information on how to call these user-defined types.

    You can get the typename of a QType by using [q.typeName].
    :::warning
    QTypes are not meant to be used with `type` or `typeof`. You must use
    `q.typeName` to get the name of a QType. `q.typeName` will fallback
    to the `typeof` function for ease of use.
    :::

    QTypes can be accessed and written to like a table for use
    in the handler function.
    :::caution
    In some versions of Lua, QTypes are userdatas. In newer versions of Lua,
    QTypes are tables. This is due to the fact that `newproxy` was removed
    in newer versions of Lua. This library will automatically detect if your
    version of Lua can create userdatas from code. However, this means that
    you should __NEVER__ use `q.userdata` or `q.table` to check if an object
    is a QType. Instead, use [q.qtype] to check if an object is a QType.

    You can still access and write to the QType like a table, but you must
    use `q.isQType` to check if an object is a QType.
    :::

    QTypes are created using [q.custom]. Here is an example of adding
    support for an `Instance` type:
    ```lua
    local q = require(path.to.q)
    q.instance = q.custom("Instance", function(obj)
        local typeName = typeof(obj)
        if typeName ~= "Instance" then
            return false,
                string.format("expected an Instance, got %s", typeName),
                { ObjectType = typeName }
        end
        return true
    end)
    q.instance(game)    -- true
    q.instance("hello") -- false
    ```
]=]

function q:isQType(obj)
    if IsProxy(obj) then
        local meta = getmetatable(obj)
        if type(meta) == "table" and meta.__type == "qtype" then
            return true
        end
    end
    return false, "not a qtype"
end

--[=[
    @prop qtype QType
    @within q
    @tag built-in
    A qtype that checks if an object is a qtype:
    ```lua
    local q = require(path.to.q)
    q.qtype(q.string) -- true
    q.qtype("string") -- false
    ```
]=]

q.qtype = q.custom("qtype", q.isQType)

-- Native types
function q:isNative(obj)
    local typeName = typeof(obj)
    if typeName ~= self.TypeName then
        return false,
            string.format("expected %s, got %s", self.TypeName, typeName)
    end
    return true
end

-- Internal function to create a new native type
local function wrapNative(typeName)
	local qtype = q.custom(typeName, q.isNative)
	qtype.TypeName = typeName
	return qtype
end

--[=[
    @prop null QType
    @within q
    @tag built-in
    A type that represents `nil`:
    ```lua
    q.null()    -- true
    q.null(nil) -- true
    q.null(1)   -- false
    ```
]=]

q.null     = wrapNative("nil")
q.none     = q.null

--[=[
    @prop bool QType
    @within q
    @tag built-in
    A type that represents a `boolean` (true or false):
    ```lua
    q.bool(true)  -- true
    q.bool(false) -- true
    q.bool(1)     -- false
    ```
]=]

q.bool     = wrapNative("boolean")
q.boolean  = q.bool

--[=[
    @prop number QType
    @within q
    @tag built-in
    A type that represents a `number`:
    ```lua
    q.number(1)   -- true
    q.number(1.1) -- true
    q.number("1") -- false
    ```
]=]

q.number   = wrapNative("number")

--[=[
    @prop string QType
    @within q
    @tag built-in
    A type that represents a `string`:
    ```lua
    q.string("1") -- true
    q.string(1)   -- false
    ```
]=]

q.string   = wrapNative("string")

--[=[
    @prop func QType
    @within q
    @tag built-in
    A type that represents a `function`:
    ```lua
    q.func(function() end) -- true
    q.func(1)              -- false
    ```
]=]

q.func     = wrapNative("function")
q.closure  = q.func
q.callback = q.func

--[=[
    @prop userdata QType
    @within q
    @tag built-in
    A type that represents a `userdata`:
    ```lua
    q.userdata(newproxy()) -- true
    q.userdata(1)          -- false
    ```
]=]

q.userdata = wrapNative("userdata")

--[=[
    @prop thread QType
    @within q
    @tag built-in
    A type that represents a `thread` (coroutine):
    ```lua
    q.thread(coroutine.create(function() end)) -- true
    q.thread(1)                                -- false
    ```
]=]

q.thread   = wrapNative("thread")

--[=[
    @prop table QType
    @within q
    @tag built-in
    A type that represents a `table`:
    ```lua
    q.table({}) -- true
    q.table(1)  -- false
    ```
]=]

q.table    = wrapNative("table")

--[=[
    @interface TupleContext
    @within q
    .TypeName string
    .Index number

    A context object that is passed to the handler function of a tuple.
    It contains the typename of the object being checked and the index
    of the object in the tuple.
]=]

--[=[
    @type Tuple QType
    @within q
    A type that represents arguments or parameters to
    a function. Tuples can also be used to typeheck
    numbered tables (lists).

    Tuples are created using [q.tuple]. Here is an example
    of a tuple that checks for a `string` and a `number`:
    ```lua
    local tuple = q.tuple(q.string, q.number)
    tuple("1", 1) -- true
    tuple(1, "1") -- false
    ```
]=]

function q:isTuple(...)
    local args = {...}
    for i = 1, #self.Guide do
        local success = self.Guide[i](args[i])
        if not success then
            local expTypeName, typeName =
                q.typeName(self.Guide[i]),
                q.typeName(args[i])
            return false,
                string.format("invalid argument #%d (expected %s, got %s)", i, expTypeName, typeName),
                { TypeName = expTypeName, Index = i }
        end
    end

    return true
end

--[=[
    Creates a tuple type. Accepts any number of qtypes as arguments.
    The handler will return a [TupleContext] object as the `context`
    argument if the check fails.

    @param  ... QType -- The types to check against
    @return Tuple<T>  -- The tuple type
]=]
function q.tuple(...)
    local tuple = q.custom("tuple", q.isTuple)
    tuple.Guide = {...}
    return tuple
end

--[=[
    @interface VariantContext
    @within q
    .TypeName string

    A context object that is passed to the handler function of a variant.
    It contains the typename of the object being checked.
]=]

--[=[
    @type Variant QType
    @within q
    A type that can represent many types. This can be compared
    with unions in C.

    Variants are created using [q.variant]. Here is an example
    of a variant that checks for a `string` or a `number`:
    ```lua
    local variant = q.variant(q.string, q.number)
    variant("1")  -- true
    variant(1)    -- true
    variant(true) -- false
    ```

    :::tip
    I would recommend using [q.nullable] over [q.variant] for optional arguments.
    :::
]=]

function q:isVariant(obj)
    local success, err;
    for _, v in ipairs(self.Guide) do
        success, err = v(obj)
        if success then
            return true,
                nil,
                { TypeName = q.typeName(obj) }
        end
    end

    return false, err
end

--[=[
    Creates a variant type, which can stand for any given type in the
    arguments. The handler will return a [VariantContext] object as
    the `context` argument if the check succeeds.

    @param  ... QType      -- The types to check against
    @return     Variant<T> -- The variant type
]=]
function q.variant(...)
    local variant = q.custom("variant", q.isVariant)
    variant.Guide = {...}
    return variant
end

--[=[
    @interface InterfaceContext
    @within q
    .TypeName string
    .InvalidKey boolean
    .Key string

    A context object that is passed to the handler function of an
    interface. It contains the typename of the object being checked,
    whether or not the key is invalid (see [StrictInterface]), and
    the key of the object in the table.
]=]

--[=[
    @type Interface QType
    @within q
    A type that serves as a guide for a table. It can be used to
    check if a table has the correct typed values.

    :::tip
    You can use this for sanitizing tables sent to `RemoteEvents`
    and `RemoteFunctions` to ensure that the data is valid. This
    guarantees that the thread doesn't error on behalf of the user
    (such as an exploiter) and possibly cause the server to hang
    or crash.
    :::

    Interfaces are created using [q.interface]. Here is an example
    of an interface that checks for a `string` and a `number`:
    ```lua
    local interface = q.interface({
        Name = q.string,
        Age  = q.number,
    })
    interface({ Name = "Nicholas", Age = 15 })   -- true
    interface({ Name = "Nicholas", Age = "15" }) -- false
    ```
]=]

function q:isInterface(obj)
    if type(obj) ~= "table" then
        return false, "object is not a table"
    end

    for k, v in pairs(self.Base) do
        local success, err = v(obj[k])
        if not success then
            return false,
                string.format("value at '%s' doesn't match: %s", tostring(k), err),
                { TypeName = q.typeName(obj), InvalidKey = false, Key = k }
        end
    end

    return true
end

--[=[
    Creates an interface type. Accepts a table of keys to qtype values.
    The handler will return an [InterfaceContext] object as the `context`
    argument if the check fails.

    @param  base table   -- The base table
    @return Interface<T> -- The interface type
]=]
function q.interface(base)
    local interface = q.custom("interface", q.isInterface)
    interface.Base = base
    return interface
end

--[=[
    @type StrictInterface QType
    @within q
    A type that serves as a guide for a table. It can be used to
    check if a table has the correct typed values. Unlike `Interface`,
    `StrictInterface` will not allow extra keys in the table.

    Strict interfaces are created using [q.strictInterface]. Here is an example
    of a strict interface that checks for a `string` and a `number`:
    ```lua
    local interface = q.strictInterface({
        Name = q.string,
        Age  = q.number,
    })
    interface({ Name = "Nicholas", Age = 15 })   -- true
    interface({ Name = "Nicholas", Age = "15" }) -- false
    interface({ Name = "Nicholas", Age = 15, Extra = true }) -- false
    ```
]=]

function q:isStrictInterface(obj)
    if type(obj) ~= "table" then
        return false, "object is not a table"
    end

    for k, v in pairs(obj) do
        if not self.Base[k] then
            return false,
                string.format("value at '%s' does not exist in interface", tostring(k)),
                { TypeName = q.typeName(obj), InvalidKey = true, Key = k }
        end

        local success, err =  self.Base[k](v)
        if not success then
            return false,
                string.format("value at '%s' does not match: %s", tostring(k), err),
                { TypeName = q.typeName(obj), InvalidKey = false, Key = k }
        end
    end

    return true
end

--[=[
    Creates a strict interface type. Since it's strict, new keys cannot exist
    in the table when checking. Accepts a table of keys to qtype values. The
    handler will return an [InterfaceContext] object as the `context` argument
    if the check fails.

    @param  base table -- The base table
    @return StrictInterface<T>  -- The interface type
]=]
function q.strictInterface(base)
    local interface = q.custom("strictInterface", q.isStrictInterface)
    interface.Base = base
    return interface
end

--[=[
    @type Nullable QType
    @within q
    A type that serves as `null` or another type. Another way of saying
    `q.variant(null, type)`. This is useful for optional arguments.

    Nullables are created using [q.nullable]. Here is an example
    of a nullable that checks for a `string` or `null`:
    ```lua
    local nullable = q.nullable(q.string)
    nullable("1")  -- true
    nullable(nil)  -- true
    nullable(1)    -- false
    ```

    Another way of doing this is by using [q.variant]:
    ```lua
    local variant = q.variant(q.string, q.null)
    variant("1")  -- true
    variant(nil)  -- true
    variant(1)    -- false
    ```
]=]

function q:isNullable(obj)
    if self.Type(obj) == true or obj == nil then
        return true
    else
        return false, string.format("expected %s or nothing, got %s", q.typeName(self.Type), q.typeName(obj))
    end
end

--[=[
    Creates a nullable type. Accepts a qtype as an argument.

    @param  t QType -- The type to make nullable
    @return Nullable<T> -- The nullable type
]=]
function q.nullable(t)
    local nullable = q.custom("nullable", q.isNullable)
    nullable.Type = t
    return nullable
end

--[=[
    @prop any QType
    @within q
    A type that serves as any type. This is useful for when you don't
    know the type of a value.

    :::warning
    The point of this library is to reduce type errors. Using
    this type when not needed can cause unexpected behavior.
    It's recommended to use [q.variant] when applicable.

    If you have no clue what you're doing or if you plan to use
    only the `any` type, then you're better off not using this
    library at all, and sticking without type checking.
    :::

    The `any` type is created using [q.any]. Here is an example
    of doing that:
    ```lua
    local any = q.any()
    any("1")  -- true
    any(1)    -- true
    any(nil)  -- true
    ```
]=]

-- Any type
function q:isAny(_)
    return true
end

-- A type that represents any type.
q.any = q.custom("any", q.isAny)

if not DEBUG then
    return q
else
    -- Testing code
    local overallFail = false
    local function test(name, qtype, ...)
        local success, err, context = qtype(...)
        local fail = false

        if not success then
            fail = true
        end

        if not fail or (fail and string.sub(name, 1, 1) == "!") then
            print(name.." passed: "..tostring(err))
        else
            overallFail = true
            print(name.." failed")
        end
    end

    function testfunc(name, f, ...)
        local success, err = pcall(f, ...)
        if success then
            overallFail = true
            print(name.." failed: "..tostring(err))
        else
            print(name.." passed: "..tostring(err))
        end
    end

    test("null",      q.null,     nil)
    test("!null",     q.null,     true)

    test("bool",      q.bool,     true)
    test("!bool",     q.bool,     nil)

    test("number",    q.number,   1)
    test("!number",   q.number,   nil)

    test("string",    q.string,   "hello")
    test("!string",   q.string,   nil)

    test("func",      q.func,     function() end)
    test("!func",     q.func,     nil)

    if SupportsProxy then
        test("userdata",  q.userdata, newproxy(true))
        test("!userdata", q.userdata, nil)
    end

    test("thread",    q.thread,   coroutine.create(function() end))
    test("!thread",   q.thread,   nil)

    test("table",     q.table,    {})
    test("!table",    q.table,    nil)

    test("qtype",     q.qtype,    q.null)
    test("!qtype",    q.qtype,    nil)

    test("tuple",     q.tuple(q.number, q.string), 1, "hello")
    test("!tuple",    q.tuple(q.number, q.string), nil, nil)

    local function tupleFuncTest(...)
        test("tuplefn",     q.tuple(q.number, q.string), ...)
        test("!tuplefn",    q.tuple(q.number, q.string), nil, nil)
    end
    tupleFuncTest(1, "hello")

    test("variant",   q.variant(q.number, q.string), 1)
    test("variant",   q.variant(q.number, q.string), "hello")
    test("!variant",  q.variant(q.number, q.string), nil)

    local int = q.interface({ a = q.number, b = q.string })
    test("interface",  int, { a = 1, b = "hello" })
    test("!interface", int, { a = nil, b = nil })

    local sint = q.strictInterface({ a = q.number, b = q.string })
    test("sinterface",  sint, { a = 1, b = "hello" })
    test("!sinterface", sint, { a = nil, b = nil })
    test("!sinterface", sint, { a = 1, b = "hello", c = 2 })

    test("nullable",  q.nullable(q.number), 1)
    test("nullable",  q.nullable(q.number), nil)
    test("!nullable", q.nullable(q.number), "hello")

    test("any",       q.any, 1)
    test("any",       q.any, "hello")
    test("any",       q.any, nil)

    testfunc("strictbasic", function()
        q.assert(q.string(1))
    end)

    testfunc("strictTupleWrap", q.wrap(function()
        print("shouldnt run")
    end, q.number, q.bool), 1, "hello")

    print()
    print("Lua version: ".._VERSION)
    print("Test result: "..(overallFail and "failed" or "passed"))
end