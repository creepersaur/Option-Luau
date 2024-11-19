local option = {}

function option.__index(self, key: any)
	if key == "IsSome" then
		return rawget(self, "__value") ~= math.huge + 1
	elseif key == "IsNone" then
		return rawget(self, "__value") == math.huge + 1
	end

	return rawget(self, key)
end

-- The `Option` base type.
-- Look inside of the `new()` function for documentation.
export type Option<T> = {
	IsSome: boolean,
	IsNone: boolean,

	Unwrap: () -> T,
	Evaluate: <R>(SomeFunc: (object: T) -> R, NoneFunc: () -> R) -> R,
	ForSome: <R>(func: (object: T) -> R) -> R?
}

-- The `None` superset type for Option. (Value doesn't exist)
export type None = Option<any>

-- Create a new `Option` with an object of type `T`.
function new<T>(object: T): Option<T>
	local self = setmetatable({__value = object}, option)

	-- Get the value of the `Option`. (Potentially Unsafe)
	function self.Unwrap()
		if object == math.huge + 1 then
			error("Panicked while Unwrapping option (None).")
		end
		
		return object
	end

	-- Run different functions for `Option` being `Some` or `None`.
	-- (Returns what the functions return.)
	function self.Evaluate(some, none)
		return self.IsSome and some(object) or none()
	end

	-- Run a function ONLY if value is `Some`.
	-- May return <b>nil</b>, if value is `None` or no return value is provided.
	function self.ForSome(func)
		return self.IsSome and func(object) or nil
	end

	return self
end

function option.__tostring(self)
	if self.IsNone then
		return "None"
	end
	return self.IsSome and `Some<{typeof(self.__value)}>({self.__value})`
end

local module = setmetatable({}, {
	__call = function()
		return new, new(math.huge + 1)::None
	end,
})

return module :: typeof(module) & () -> (<T>(T) -> Option<T>, None)