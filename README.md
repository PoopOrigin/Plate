# Plate
Simple lua/luau utility module for tables

Usage
```lua
--Require the module
local Plate = require(path.to.Plate)
```

## DeepCopy

```lua
local a = {x = 1, nested = {y = 2}}
local b = Plate.DeepCopy(a)

b.nested.y = 99
print(a.nested.y) --> 2
--If you were to use a shallow copy like table.clone(), it would print 99 here
```

## RemoveByValue

```lua
local t = {"a", "b", "c"}
Plate.RemoveByValue(t, "b")

print(table.concat(t, ", ")) --> a, c
```

## At

```lua
local t = {"apple", "banana", "orange"}
print(Plate.At(t, 2)) --> banana
print(Plate.At(t, 4)) --> "Index out of bounds"
print(Plate.At(t, 1.1)) --> "Index is not an integer"
```

## Count

```lua
local t = {10, 20, Name = "Plate"}
print(Plate.Count(t)) --> 3
```

## Reverse

```lua
local t = {1, 2, 3}
local r = Plate.Reverse(t)

print(table.concat(r, ", ")) --> 3, 2, 1
```

## Slice

```lua
local t = {"a", "b", "c", "d"}
local s = Plate.Slice(t, 2, 3)

print(table.concat(s, ", ")) --> b, c
```

## Append

```lua
local a = {1, 2}
local b = {3, 4}

Plate.Append(a, b)
print(table.concat(a, ", ")) --> 1, 2, 3, 4
```

## Merge

```lua
local a = {x = 1, y = 2}
local b = {y = 99, z = 3}

Plate.Merge(a, b)
print(a.x, a.y, a.z) --> 1 99 3
```

## Union

```lua
local a = {1, 3, 5}
local b = {2, 3, 4}

local u = Plate.Union(a, b)
print(table.concat(u, ", ")) --> 1, 2, 3, 4, 5
```

## Intersect

```lua
local a = {1, 2, 3, 4}
local b = {2, 4, 6}

local i = Plate.Intersect(a, b)
print(table.concat(i, ", ")) --> 2, 4
```

## Difference

```lua
local a = {1, 2, 3, 4}
local b = {2, 4}

local d = Plate.Difference(a, b)
print(table.concat(d, ", ")) --> 1, 3
```
