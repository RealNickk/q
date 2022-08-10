---
sidebar_position: 3
---

# Installation
q is a Lua module meant to be used in Roblox Luau and vanilla Lua. Because of
that, you can install q in a couple of ways.

## From the Repository
You can clone the repository and get the Lua files needed to use q. This is not
auto-updating, but there are no drawbacks other than that. You need `git`
installed to clone repositories. Provided that you have it installed, we can
continue.

:::tip
If you don't feel like cloning the repository, you can go to `src/q.lua`
in the online Github repository and copy the code there.
:::

You can clone the repository with this command:
```bash
git clone https://github.com/RealNickk/q.git
```

Once it finishes cloning, you can open it and inside `src`, there are the source
files that you can use for your own purpose.

### Roblox Environments
You can create a ModuleScript in ReplicatedStorage and paste the contents of
`q.lua` into it. You can then require it:
```lua
local q = require(path.to.q)
```

### Vanilla Environments
You can put `q.lua` in your Lua includes directory to require it, or you can put
it in a directory relative to your script and load it with a relative path.
```lua
local q = require("q") -- as include or in same directory
local q = require("some/relative/path/to/q") -- as relative path
```

### Exploit Environments
Open the root directory of your exploit and find the `workspace` directory.
Paste `q.lua` into the workspace directory. You can load q by doing:
```lua
local q = loadstring(readfile("q.lua"))()
```

:::caution
Your exploit may support filesystem functions but not have a
`readfile` function, instead it might have their own name for it. You will have
to look at your exploit's documentation to see if they support filesystem
functions. The functions used here are using the Unified Naming Convention,
which most mainstream exploits follow.

Not all exploits support filesystem functions. If yours does not, you will have
to load q using a different method.
:::

## Using Loadstring
This is referring to Roblox exploit clients or Roblox servers, but if you have
any class that can do web requests (vanilla Lua), it'll work fine. I'm only
going to explain two ways to do it, both being through Roblox. This method is
auto-updating but will have an extremely small delay since you have to make a
web request.

### Exploit Environments
Scripts in exploit environments are different from how Roblox
scripts work. You cannot just insert a ModuleScript into the game and set the
source to the contents of `q.lua`, as Roblox compiles the script into bytecode
and stores it in an offset in the C++ structure of the script. Since most
exploits do not have the ability to write bytecode to a Lua source container,
you will have to loadstring the contents of `q.lua` every time you want to use
q, which has the drawback of environment sharing, since there is no sandboxing,
but it's not a big deal unless you're doing some funky stuff.
```lua
local q = loadstring(game:HttpGet("https://github.com/RealNickk/raw/main/q/src/q.lua"))()
```

### Roblox Server Environments
:::info
This method only works if the ModuleScript is required by the server.
`ServerScriptService.LoadstringEnabled` must be set to `true` to use q with this
method.
:::

You can create a ModuleScript in ServerStorage and set the source to this:
```lua
local HttpService = game:GetService("HttpService")
local q = loadstring(HttpService:GetAsync("https://github.com/RealNickk/raw/main/q/src/q.lua"))()
return q
```

You can then require it **from the server** by doing:
```lua
local q = require(path.to.q)
```

:::danger
Using this method can open up your server to serverside arbitrary code
execution vulnerabilities if you do not write good code. This means that people
may be able to execute backdoors on your game's server end, giving exploiters
full access to your game. I would recommend to not enable it unless you are
testing in a volatile environment. It's always better to be safe than sorry.
:::

# Next Step?
You can view the [API Reference](/api/q) page to learn how to use q.