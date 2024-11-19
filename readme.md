<div align="center">

# Option

Option is a simple type/object that represents either a value of a specific type *("Some")* or the absence of a value *("None")*.
It is inspired by [Rust's 🦀`Option` enum](https://doc.rust-lang.org/std/option/enum.Option.html), and offers a very similar experience.

</div>

## Installation

Just download/copy the `option.luau` file from the repo and put it into your luau project.
(Might be added into wally if people ask for it.)

## Usage

Let's start by defining a few variables and importing the module.

```lua
local OptionModule = require(path_to_module)

type Option<any> = OptionModule.Option<any>
local Some, None = OptionModule()
```

The module uses an enum-like approach where `Option` can have any type.

Options with values can be defined using `Some(object)`. Those without values can just be `None`. (**Note**: `None` is not a function.)

```lua
local Thing = Some(10)
local Nothing = None
```

## Checking if something is Some/None

You can use `IsSome` or `IsNone` to check whether the Option has some value or is none.

```lua
-- We don't know the value of 'Thing'
local Thing: Option<number>

if Thing.IsSome then
	print("Thing has a value")
elseif Thing.IsNone then
	print("Thing does NOT have a value")
end
```

## Value of an Option (Unsafe)

To get the value of an Option, you can call the `Unwrap` method on it. Keep in mind that `Unwrap()` will error if the value is `None`.

```lua
local Thing = Some(10)
local Value = Thing.unwrap() -- returns 10
```

```lua
local Nothing = None -- None
local Value = Thing.unwrap() -- THIS WILL ERROR
```

## Value of an Option (Safe)

You can get the value of an option in a safer way by using the `ForSome()` or `Evaluate()` methods. You don't need to use them if the value will never be `None`. (**Note**: It's still fine to use `Unwrap()` but your code might break if you're not careful.)

### `ForSome<R>(func: (Value: <T>) -> R) -> R?`

```lua
local Thing = Some(10)
local After = Thing.ForSome(function(Value)
	-- This only runs if `Thing` is Some.
	-- If it's none, then After will be nil.
	return Value
end)
```

### `Evaluate: <R>(SomeFunc: (object: T) -> R, NoneFunc: () -> R) -> R`

```lua
local Thing = Some(10)
local After = Thing.Evaluate(function(Value)
	-- Some value exists (Some)
	return true

end, function()
	-- No value exists (None)
	return false
end)

-- After will be true/false depending on if `Thing` is Some/None.
```

## Conclusion

That's all I have for now. There's probably no need to do any of this. But it's useful for safety. And I just wanted to remake the `Option` enum from rust. It also helps in team projects, maybe.

<div align="center">

# 😎
