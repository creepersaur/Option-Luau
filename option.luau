local option = {}

function option.__index(self, key: any)
	if key == "is_some" then
		return rawget(self, "__value") ~= math.huge + 1
	elseif key == "is_none" then
		return rawget(self, "__value") == math.huge + 1
	end

	print(self)
	return rawget(self, key)
end

export type Option<T> = {
	is_some: boolean,
	is_none: boolean,

	unwrap: <T>() -> T,
	evaluate: <R>(Some: (object: T) -> R, None: () -> R) -> R,
	forSome: <R>(func: (object: T) -> R) -> R?
}

export type None = Option<any>

function new<T>(object: T): Option<T>
	local self = setmetatable({__value = object}, option)

	function self.unwrap()
		if object == math.huge + 1 then
			error("Panicked while unwrapping option (None).")
		end
		
		return object
	end

	function self.evaluate(some, none)
		return self.is_some and some(object) or none()
	end

	function self.forSome(func)
		return self.is_some and func(object) or nil
	end

	return self
end

function option.__tostring(self)
	if self.is_none then
		return "None"
	end
	return self.is_some and "Some<" .. typeof(self.__value) .. ">(" .. self.__value .. ")"
end

local module = setmetatable({}, {
	__call = function()
		return new, new(math.huge + 1)::None
	end,
})

return module :: typeof(module) & () -> (<T>(T) -> Option<T>, None)