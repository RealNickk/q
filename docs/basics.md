---
sidebar_position: 4
---

# The Basics of q
If you have not read the [Is q Something I want to Use](IsQSomethingIWantToUse)
page, I highly recommend you do so before continuing. It will give you a better
understanding of what q is and what it can do. I'd hate to waste your time if
you don't want to use q.

In this article, I will be going over the basics of q. I will be going over the
syntax and how to use it. I will also be going over some of the features of q
that you may not know about, such as custom types and interfaces.

## Syntax
q is a typechecking library, but it's built to run without having to rewrite the
compiler. It's built to run on top of vanilla Lua, which means that it's
compatible with a couple of versions of Lua, namely 5.1, 5.2, 5.3, and LuaJIT.

q is built to be as simple as possible, so it's syntax is very simple. It's
syntax isn't similar to Luau's syntax, but it's easy to learn and easy to use.
Here's an example of q's syntax:
```lua
local q = require(game:GetService("ReplicatedStorage").q)
print(q.string("Hello, world!")) --> true
```

The first line is the same as any other require statement. The second line is
where the magic happens. The property you choose is the type you want to check
against. If the value is the type you specified, it will return true. If it's
not, it will return false with argument 2 as the error message, and a possible
third argument as the context which can be read about in the API reference.

## Everyday Use
q is built to be used in everyday Lua code. Whether it's a Roblox game or a
seperate base, q is built to be used in any situation. Here's an example of
q being used in a Roblox game:
```lua
if q.string("Hello, world!") then
    print("This is a string!")
else
    warn("This is not a string!")
end
```

In this example, we're checking if the value is a string. If it is, we print
"This is a string!". If it's not, we follow the else statement and warn the
player that it's not a string. This is useful for checking if a value is the
type you want it to be. It's also useful for checking if a value is a certain
type before doing something with it.

q supports all of the vanilla Lua types, as well as some custom types. Some of
the custom types will be explained next.

## Nullables
q supports nullables. This means that you can check if a value is a certain
type, or nil. Here's an example:
```lua
local nullOrString = q.nullable(q.string)
print(nullOrString("Hello, world!")) --> true
print(nullOrString(nil)) --> true
print(nullOrString(1)) --> false
```

In this example, we're checking if the value is a string or nil. If it is, it
will return true. If it's not, it will return false. I would recommend using
this over variants, as it's easier to use and easier to read.

## Variants
Variants are a type that can be multiple types. They are useful for functions
that can take multiple types at once. Here's an example of a variant:
```lua
local variant = q.variant(q.string, q.number)
print(variant("Hello, world!")) --> true
print(variant(2007)) --> true
print(variant(true)) --> false
```

In this example, we're creating a new variant type. We're telling q that the
variant can be a string or a number. We then check if the value is a string,
which it is, so it returns true. After that, we checkif the value is a number,
which it is, so it returns true. Lastly, we check if the value is a boolean,
which it isn't, so it returns false.

## Tuples
Tuples are a list of values. They are useful for functions that take multiple
arguments. Here's an example of a tuple:
```lua
local tuple = q.tuple(q.string, q.number)
print(tuple("Hello, world!", 2007)) --> true
print(tuple("Hello, world!", true)) --> false
```

In this example, we're creating a new tuple type. We're telling q that the
tuple is a list: [string, number]. We then check if the values are a string
and a number, which they are, so it returns true. Afterwards, we check if the
values are a string and a boolean, which they aren't, so it returns false.

## Interfaces
Interfaces are a way to check if a table has certain properties. They can be
used to check if a table has a certain method, or if it has a certain property.
Here's an example of an interface:
```lua
local person = q.interface({
    Name = q.string,
    Age = q.number
})
print(person({ Name = "Nicholas", Age = 15 })) --> true
print(person({ Name = "Nicholas", Age = 15, Extra = true })) --> true
print(person({ Name = "Nicholas", Age = false })) --> false
```

In this example, we're creating a new interface type. We're telling q that the
interface is a table with the properties Name and Age. We then check if the
first table matches the interface, which it does, so it returns true. After
that, we check if the second table matches the interface, which it does, so it
returns true. Lastly, we check if the third table matches the interface, which
it doesn't, so it returns false.

## Strict Interfaces
Strict interfaces are pretty much 100% the same as interfaces, but they're
strict. They're strict in the sense that they don't allow extra properties.
Here's an example of a strict interface:
```lua
local person = q.strictInterface({
    Name = q.string,
    Age = q.number
})
print(person({ Name = "Nicholas", Age = 15 })) --> true
print(person({ Name = "Nicholas", Age = 15, Extra = true })) --> false
print(person({ Name = "Nicholas", Age = false })) --> false
```

In this example, you can see that the table with the extra property returns
false. This is because strict interfaces don't allow extra properties. The
first table returns true because it doesn't have any extra properties.

## User-Defined Types
The nice thing about having q is that it's flexible. You can use it in any
situation, and you can create your own types to make up for other types that
q doesn't have. Here's an example of using a custom type, where variants are
not the best option:
```lua
q.numberString = q.custom("numberString", function(self, obj)
    return q.string(obj) and (tonumber(obj) ~= nil) or q.number(obj)
end)

local doSomething = q.wrap(function(value)
    value = tonumber(value)
    print(type(value))
end, q.numberString)

doSomething(1234)   --> number
doSomething("5678") --> number
doSomething("Hello, world!") --> invalid argument #1 (expected numberString, got string)
```

In this example, we're creating a new type called "numberString". A numberString
is a type that can be either a number or a string that can be converted to a
number. We then create a function that takes a numberString as an argument. We
then call the function with a number, a string that can be converted to a
number, and a string that can't be converted to a number. The first two calls
work, but the third one doesn't. This is because the third call is a string that
can't be converted to a number, and q.numberString only allows strings that can
be converted to numbers.

## Processors
Do you see a problem in the last snippet? There is an issue with that code. The
issue is that you have to still input boilerplate code to convert the string to
a number. This is where processors come in. A processor is a function that runs
after the function is called. It's useful for converting values to the type you
want them to be. The problem with processors is that it makes it a lot harder to
understand the code, and you're probably better off not using processors unless
you really need them. Here's an example of using a processor:
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

local doSomething = q.pwrap( -- note that it's pwrap (wrap and process), not wrap
    _doSomething,
    { q.processNumberString },
    { q.numberString }
)

doSomething(1234)   --> number
doSomething("5678") --> number
doSomething("Hello, world!") --> invalid argument #1 (expected numberString, got string)
```

Processors call regardless of whether or not the value is the type you want it
to be. It acts as the type but also converts the value to what you want.
However, this is really ugly. You have to create a new function, and you have to
create a new table for both the processors and arguments. I was unable to find a
way to make this better, so if you have any suggestions, please let me know and
I'll see what I can do.

## Conclusion
I went over the basics of q, including types, variants, tuples, interfaces,
strict interfaces, user-defined types, and processors. I hope you learned
something new. If you have any questions, feel free to ask me through the
contact methods listed on my GitHub. If you're interested in contributing to
q, feel free to make a pull request on GitHub. If you like my work, feel free
to star the repository on GitHub. If you are interested in any other projects
I've made, feel free to check out my GitHub profile.

Thanks for reading!