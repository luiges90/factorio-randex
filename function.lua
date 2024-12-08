function clamp(a, min, max) 
    if a < min then
        return min
    end
    if a > max then
        return max
    end
    return a
end

function mersenne_twister:random_real(a, b)
	return self:random(100 * a, 100 * b) / 100
end

function contains(needle, haystack)
	for i, item in pairs(haystack) do
		if needle == item then
			return true
		end
	end
	return false
end

function dump(x, indent)
    if indent == nil then
        indent = 0
    end
    if type(x) == "table" then
        log(string.rep(" ", indent) .. "table")
        for k, v in pairs(x) do
            log(string.rep(" ", indent) .. k .. ": ")
            dump(v, indent + 2)
        end
    elseif type(x) == "boolean" then
        local s = "false"
        if x then 
            s = "true"
        end
        log(string.rep(" ", indent) .. s)
    else
        log(string.rep(" ", indent) .. x)
    end
end

function ceil_2sf(x)
    if x >= 100000 then
        return math.ceil(x / 10000) * 10000
    elseif x >= 10000 then
        return math.ceil(x / 1000) * 1000
    elseif x >= 1000 then
        return math.ceil(x / 100) * 100
    elseif x >= 100 then
        return math.ceil(x / 10) * 10
    else
        return math.ceil(x)
    end
end

function find_items_placing_entity(entity)
    local found = {}
    for name, recipe in pairs(data.raw.item) do
        if recipe.place_result == entity then
            table.insert(found, name)
        end
    end
    return found
end

function find_recipes_creating(item)
    local found = {}
    for name, recipe in pairs(data.raw.recipe) do
        if recipe.results then
            for _, result in pairs(recipe.results) do
                if result.name == item then
                    table.insert(found, name)
                    break
                end
            end
        end
    end
    return found
end

function find_technologies_providing_recipe(item)
    local found = {}
    for name, recipe in pairs(data.raw.technology) do
        if recipe.effects then
            for _, effect in pairs(recipe.effects) do
                if effect.type == "unlock-recipe" and effect.recipe == item then
                    table.insert(found, name)
                    break
                end
            end
        end
    end
    return found
end

-- These items are not stackable and will crash if we attempt to change their stack size.
stack_blacklist = {}

for _, category in pairs({"armor", "item", "item-with-entity-data", "ammo", "gun", "selection-tool", "spidertron-remote"}) do
    for _, item in pairs(data.raw[category]) do
        if not item.stack_size or item.stack_size == 1 then
            table.insert(stack_blacklist, item.name)
        end
    end
end
table.insert(stack_blacklist, "discharge-defense-remote")
table.insert(stack_blacklist, "artillery-targeting-remote")
table.insert(stack_blacklist, "blueprint")
table.insert(stack_blacklist, "blueprint-book")
table.insert(stack_blacklist, "deconstruction-planner")
table.insert(stack_blacklist, "upgrade-planner")
table.insert(stack_blacklist, "copy-paste-tool")
table.insert(stack_blacklist, "cut-paste-tool")
table.insert(stack_blacklist, "cardboard-box")

