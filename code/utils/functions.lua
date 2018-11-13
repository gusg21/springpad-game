function math.sign(v)
	if v > 0 then
		return 1
	elseif v < 0 then
		return -1
	else
		return 0
	end
end
function math.round(v, bracket)
	bracket = bracket or 1
	return math.floor(v / bracket + math.sign(v) * 0.5) * bracket
end
function btoi(x)
	return x and 1 or 0
end
love.keyboard.keysPressed = {}
love.keyboard.keysReleased = {}
-- returns if specified key was pressed since the last update
function love.keyboard.wasPressed(key)
	if (love.keyboard.keysPressed[key]) then
		return true
	else
		return false
	end
end
-- returns if specified key was released since last update
function love.keyboard.wasReleased(key)
	if (love.keyboard.keysReleased[key]) then
		return true
	else
		return false
	end
end
-- concatenate this to existing love.keypressed callback, if any
function love.keypressed(key, unicode)
	love.keyboard.keysPressed[key] = true
end
-- concatenate this to existing love.keyreleased callback, if any
function love.keyreleased(key)
	love.keyboard.keysReleased[key] = true
end
-- call in end of each love.update to reset lists of pressed\released keys
function love.keyboard.updateKeys()
	love.keyboard.keysPressed = {}
	love.keyboard.keysReleased = {}
end
function table.copy(orig)
	local orig_type = type(orig)
	local copy
	if orig_type == "table" then
		copy = {}
		for orig_key, orig_value in next, orig, nil do
			copy[table.copy(orig_key)] = table.copy(orig_value)
		end
		setmetatable(copy, table.copy(getmetatable(orig)))
	else -- number, string, boolean, etc
		copy = orig
	end
	return copy
end
function valueInRange(value, min, max)
	return value >= min and value <= max
end
function rectanglesOverlap(x1, y1, w1, h1, x2, y2, w2, h2)
	local xOverlap = valueInRange(x1, x2, x2 + w2) or valueInRange(x2, x1, x1 + w1)
	local yOverlap = valueInRange(y1, y2, y2 + h2) or valueInRange(y2, y1, y1 + h1)

	return xOverlap and yOverlap
end
function isOnScreen(pos, width, height)
	width = width or 8
	height = height or width
	return valueInRange(pos.x, -width, love.graphics.getWidth() / _zoom) and
		valueInRange(pos.y, -height, love.graphics.getHeight() / _zoom)
end
function math.clamp(val, min, max)
	return math.max(min, math.min(val, max))
end
