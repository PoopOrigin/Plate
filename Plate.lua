local Plate = {}

function Plate.DeepCopy(t) --Recursively copies a table.
	if type(t) ~= "table" then
		error("Argument is not a table")
	end

	local out = {}

	for k, v in pairs(t) do
		if type(v) == "table" then
			out[k] = Plate.DeepCopy(v)
		else
			out[k] = v
		end
	end

	return out
end

function Plate.RemoveByValue(t, value) --removes the first matching value from a table.
	if type(t) ~= "table" then
		error("First argument is not a table")
	end

	for i = 1, #t do
		if t[i] == value then
			return table.remove(t, i)
		end
	end

	return nil
end

function Plate.At(t, idx) --Returns the value at a given index like t[i] but it has bounds checking.
	if type(t) ~= "table" then
		error("First argument is not a table")
	end
	if type(idx) ~= "number" or idx % 1 ~= 0 then
		error("Index is not an integer")
	end

	if idx < 1 or idx > #t then
		error("Index out of bounds")
	end
	return t[idx]
end

function Plate.Count(t) --Counts how many key value pairs exist in a table
	if type(t) ~= "table" then
		error("Argument is not a table")
	end

	local count = 0
	for i, v in pairs(t) do
		count = count + 1
	end
	return count
end

function Plate.Reverse(t) --Returns an array containing the elements of t in reverse order.
	if type(t) ~= "table" then
		error("Argument is not a table")
	end

	local out = {}

	for i = #t, 1, -1 do
		out[#out + 1] = t[i]
	end

	return out
end

function Plate.Slice(t, StartIdx, EndIdx) --Returns an array containing elements from StartIdx to EndIdx
	if type(t) ~= "table" then
		error("First argument is not a table")
	end
	if type(StartIdx) ~= "number" or StartIdx % 1 ~= 0 then
		error("Start index is not an integer")
	end
	if type(EndIdx) ~= "number" or EndIdx % 1 ~= 0 then
		error("End index is not an integer")
	end
	if StartIdx < 1 or StartIdx > #t then
		error("Start index out of bounds")
	end
	if EndIdx < 1 or EndIdx > #t then
		error("End index out of bounds")
	end
	if StartIdx > EndIdx then
		warn("Start index greater than end index")
	end

	local out = {}

	for i = StartIdx, EndIdx do
		out[#out + 1] = t[i]
	end

	return out
end

function Plate.Append(t1, t2) --Appends all array elements from t2 onto the end of t1.
	if type(t1) ~= "table" then
		error("First argument is not a table")
	end
	if type(t2) ~= "table" then
		error("Second argument is not a table")
	end

	for i, v in ipairs(t2) do
		t1[#t1 + 1] = v
	end
end

function Plate.Merge(t1, t2) --Copies every key value pair from t2 into t1.
	if type(t1) ~= "table" then
		error("First argument is not a table")
	end
	if type(t2) ~= "table" then
		error("Second argument is not a table")
	end

	for i, v in pairs(t2) do
		t1[i] = v
	end

	return t1
end

-- Set like table stuff
-- Both t1 and t2 are expected to already be sorted.
-- Values must be comparable.
-- Duplicate values are not removed automatically.

function Plate.Union(t1, t2) --Returns the union of two sorted tables.
	if type(t1) ~= "table" then
		error("First argument is not a table")
	end
	if type(t2) ~= "table" then
		error("Second argument is not a table")
	end

	local out = {}
	local i1 = 1
	local i2 = 1

	while i1 <= #t1 and i2 <= #t2 do
		if t1[i1] < t2[i2] then
			out[#out + 1] = t1[i1]
			i1 = i1 + 1
		elseif t1[i1] > t2[i2] then
			out[#out + 1] = t2[i2]
			i2 = i2 + 1
		else
			out[#out + 1] = t1[i1]
			i1 = i1 + 1
			i2 = i2 + 1
		end
	end

	while i1 <= #t1 do
		out[#out + 1] = t1[i1]
		i1 = i1 + 1
	end

	while i2 <= #t2 do
		out[#out + 1] = t2[i2]
		i2 = i2 + 1
	end

	return out
end

function Plate.Intersect(t1, t2) --Returns the intersection of two sorted tables.
	if type(t1) ~= "table" then
		error("First argument is not a table")
	end
	if type(t2) ~= "table" then
		error("Second argument is not a table")
	end

	local out = {}
	local i1 = 1
	local i2 = 1

	while i1 <= #t1 and i2 <= #t2 do
		if t1[i1] < t2[i2] then
			i1 = i1 + 1
		elseif t1[i1] > t2[i2] then
			i2 = i2 + 1
		else
			out[#out + 1] = t1[i1]
			i1 = i1 + 1
			i2 = i2 + 1
		end
	end

	return out
end

function Plate.Difference(t1, t2) --Returns the set difference of two sorted tables, values that are in t1 but not in t2.
	if type(t1) ~= "table" then
		error("First argument is not a table")
	end
	if type(t2) ~= "table" then
		error("Second argument is not a table")
	end

	local out = {}
	local i1 = 1
	local i2 = 1
	while i1 <= #t1 and i2 <= #t2 do
		if t1[i1] < t2[i2] then
			out[#out + 1] = t1[i1]
			i1 = i1 + 1
		elseif t1[i1] > t2[i2] then
			i2 = i2 + 1
		else
			i1 = i1 + 1
			i2 = i2 + 1
		end
	end

	while i1 <= #t1 do
		out[#out + 1] = t1[i1]
		i1 = i1 + 1
	end

	return out
end

return Plate
