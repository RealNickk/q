---
sidebar_position: 2
---

# Is q Something I Want to Use
This is a quick introduction to why q was made and what it can be used for. For
more information, please look at the [API Reference](/api/q). There you will
find examples of how to use q, as well as explanations of what each function,
property, and type can do, as well as warnings and other information.

The main thing I will be explaining here is problems, solutions, what q can do,
and what q was not designed to do. I will also go over alternative routes you
may want to take if you disagree with how q works, because there are many ways
to solve problems, and q is not the only way to do it. I won't force you to use
q if it doesn't fit your needs. I'd rather you have something that works for you
than something that doesn't.

## The problem
Say we have this code to add cash to a player's leaderboard status:
```lua
function addCash(playerName, amount)
    PlayerList[playerName].leaderboard.Cash.Value += amount
end

addCash("builderman", 10)
```

I wrote this off the top of my head, and reading it makes me sick. This code is
repulsive. There's no error handling, and it's not flexible. If you wanted to
add more leaderboard stats, you would have to add more functions like this. This
is not good practice and in the long run is not worth it. I didn't include that
you have to keep refreshing the players list, but you get the point. That is,
however, an entirely different topic that has nothing to do with typechecking
which you can read about on your own time. We're going to use this code as an
example regardless of how bad it is.

Back to the main problem: What if I fed a string to `addCash` as the second
argument without thinking about it? Even though the code might work, I could not
verify whether or not it was sanitized, so if I had a stray character in there,
my code would error. The error could be small, but what if it was big? What if
it ran in a loop for all players (I have no clue who would do that, but bear
with me)? There's lots of undefined behavior that can be hit if you make a
mistake in your code, and you could miss it the first time.

## The Solution
There is no wrong answer here per se, but I'll go over a couple of solutions
that I've seen and why they're not ideal, then I'll go over the solution that
I've come up with.

:::tip
Whichever method you like best, you can use. There is no right or wrong
answer here. These are all adequate solutions, and maybe q isn't fit for you if
you don't like how it solves this issue. It all boils down to how YOU like the
problem to be solved. I'm just going over the different methods that I've seen
and why I don't like them.
:::

### Luau Typechecking
You might say that Luau has typechecking, and that's true. I have nothing
against Luau typechecking, but it's not enough. Luau typechecking is only for
static types, and it's not enough to catch all errors. For example, if I were to
have a function that takes a function as an argument, I could pass a string to
it and it would not error. Luau typechecking would not catch this error, because
it's not a static type. It's a dynamic type. You can't check for dynamic types
with Luau's typechecking.

The second reason I'm not a fan of Luau typechecking is that it makes the code
look slightly more complicated. I like my code to be as simple as possible, and
I don't like having to write `local x: number = 5` every time I want to make a
variable. I like to be able to just write `local x = 5` then check later on if
it's a number and be done with it. Your preference may vary, but that's just my
opinion.

Regardless on whether or not I like Luau typechecking, here is an example of how
you can solve the problem using it:
```lua
function addCash(playerName: string, amount: number)
    PlayerList[playerName].leaderboard.Cash.Value += amount
end

addCash("builderman", 10)
addCash("builderman", "10") -- not allowed
```

Luau typechecking, even though it has its flaws, is still a good solution to the
problem. It's fast, it's easy to use, and it's built into Roblox. It's a good
solution, but it's not the solution I like.

You may be using vanilla Lua, and you may not have Luau typechecking. If you're
using vanilla Lua, you can use q to solve the problem. I'll go over that later
on in the document, after I go over the next solution, which is using inline
typechecking to solve the problem.

### Inline Typechecking
So, another solution I could do is to use `type` to check if the argument is a
string or a number, but that's not very readable.
```lua
function addCash(playerName, amount)
    assert(type(playerName) == "string", "bad argument #1 (expected string)")
    assert(type(amount) == "number", "bad argument #2 (expected number)")
    PlayerList[playerName].leaderboard.Cash.Value += amount
end

addCash("builderman", 10)
addCash("builderman", "10") --> Script:3: bad argument #2 (expected number)
```

The issue with this code is that you need to write a lot of boilerplate code
that can be easily done with a library. You also have to hardcode the argument
number, which is not the best practice because if you were to insert an argument
in the middle, you would have to change the argument number of every argument
after it. This is tedious and not fun to do. Also, depending on how much
arguments you have, you could be calling "assert" and "type" a lot, which is not
very efficient.

Here's the second drawback: With q, you can create your own custom types and
typenames, and you can use them to check if the argument is the right fit for
the function. This makes the code more readable, and most of all more flexible.
Using inline typechecking, you can't do that. You can't create your own types
and typenames, so if I only wanted to take, let's say an integer, not a decimal
number, I would have to write a lot of boilerplate code to check if the number
is an integer, where with q, I can just create a custom type called "integer"
and use that to check if the argument is an integer.

### Tuples
A tuple is an ordered list of elements. This is a great example of arguments
that are passed to a function. You can use the `q.tuple` function to create a
tuple that you can then feed arguments for it to check.
```lua
function addCash(playerName, amount)
    q.assert(q.tuple(q.string, q.number))
    PlayerList[playerName].leaderboard.Cash.Value += amount
end

addCash("builderman", 10)
addCash("builderman", "10") --> Script:7: invalid argument #2 (expected number, got string)
```
This is quite cleaner, don't you think? You also get more information about the
problem in return such as the line number. Best part is you don't have to
hardcode anything. Although this is easy, I think it could get easier to write.

There are still drawbacks to this method. You have to write
`q.assert(q.tuple(q.string, q.number))` every time you want to check arguments.
This too, is tedious.

Also, since this is a runtime check, it's not as efficient as Luau typechecking.
It's not a big deal, but it's still something to consider. If you are planning
to write code that runs ten million times a second, you might want to consider
using Luau typechecking instead.

### Wrappers
You could write a wrapper function that does the typechecking for you. This is
similar to the last example, but it's a lot cleaner (in my opinion), and that's
what I chose to do.
```lua
local addCash = q.wrap(function(playerName, amount)
    PlayerList[playerName].leaderboard.Cash.Value += amount
end, q.string, q.number)

addCash("builderman", 10)
addCash("builderman", "10") --> Script:6: invalid argument #2 (expected number, got string)
```
In my eyes, this is the best solution for general code. It's easy to write and
easy to read. The code is still a piece of garbage, but that's not the point.
The point is that you can verify the types of your arguments without running
into the drawbacks that I went over in the last few examples. This still has an
efficiency drawback, but it has the best readability and flexibility out of all
the solutions I've gone over.

## Conclusion
As you saw, q is a great library to use for runtime typechecking. It's easy to
use and easy to read, and it's efficient enough to use in most cases. I went
over the fact that Luau typechecking may be enough for you, and that's fine. I
just wanted to show you that there are other options out there that you can use
if you don't like Luau typechecking or if you want to tackle a problem that Luau
typechecking can't solve.

If you think using q is the way to go for you, then you can continue reading the
rest of the documentation to learn more about q and how to get started. If you
don't think q is for you, then that's fine too. You can use Luau typechecking or
you can use inline typechecking. It's all up to you.