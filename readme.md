# Option

Option is a simple type/object that represents either a value of a specific type ("Some") or the absence of a value ("None").
It is inspired by Rust's 🦀 `Option` enum, and offers a very similar experience.

## Installation

Just download/copy the `option.luau` file from the repo and put it into your luau project.
(Might be added into wally)

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
local Value = Some(10)
local NoneValue = None
```

## Checking if something is Some/None

You can use `is_some` or `is_none` to check wether