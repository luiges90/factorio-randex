require("randomlua")
require("function")
require("types.energy")
require("types.energy-source")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 63854)

local alt_min = settings.startup["pw-rand-min-alternate-entities"].value
local alt_max = settings.startup["pw-rand-max-alternate-entities"].value

local item_types = {"item", "item-with-entity-data", "gun", "ammo", "armor", "capsule", "module"}
local prototype_types = {
    "accumulator", "agricultural-tower", "artillery-turret", "asteroid-collector", "beacon", "boiler", "burner-generator", "cargo", 
    "container", "linked-container", "logistic-container", "crafting-machine", "assembling-machine", "rocket-silo", "furnace", "electric-pole", 
    "active-defense-equipment", "battery-equipment", "belt-immunity-equipment", "energy-shield-equipment", "generator-equipment", "inventory-bonus-equipment",
    "movement-bonus-equipment", "night-vision-equipment", "roboport-equipment", "solar-panel-equipment",
    "flying-robot", "capture-robot", "combat-robot", "construction-robot", "logistic-robot", 
    "fusion-generator", "fusion-reactor", "gate", "generator", "heat-pipe", "inserter", "lab",
    "lamp", "land-mine", "lightning-attractor", "mining-drill", "offshore-pump", "pipe", "pipe-to-ground", "pump", "radar", "reactor",
    "repair-tool", "roboport", "solar-panel", "space-platform-hub", "spider-unit", "storage-tank", "thruster", 
    "transport-belt", "underground-belt", "splitter", "loader", "loader-1x1", "lane-splitter", "linked-belt",
    "turret", "ammo-turret", "electric-turret", "fluid-turret", 
    "vehicle", "car", "artillery-wagon", "cargo-wagon", "fluid-wagon", "locomotive", "spider-vehicle", "wall"
}

local result = {}

function find_entity_by_name(entity_name)
    for _, prototype_type in pairs(prototype_types) do
        local entities = data.raw[prototype_type]
        if entities and entities[entity_name] then
            return entities[entity_name]
        end
    end
    return nil
end

for _, item_type in pairs(item_types) do
    for _, old_item in pairs(data.raw[item_type]) do
        local alt_cnt = rng:random(alt_min, alt_max)
        log("Creating " .. alt_cnt .. " alternate items for " .. old_item.name)
        for i = 1, alt_cnt do
            local new_item = table.deepcopy(old_item)
            new_item.name = old_item.name .. "-" .. i .. "a"
            new_item.localised_name = {"", {"item-name." .. old_item.name}, " Alt. ", tostring(i)}
            new_item.localised_description = {"item-description." .. old_item.name}
            if not new_item.weight then
                new_item.weight = 10000
            end

            local old_entity_name = old_item.place_result
            local old_equipment_name = old_item.place_as_equipment_result
            if old_item.place_result then
                local old_entity = find_entity_by_name(old_entity_name)
                if old_entity then
                    local new_entity = table.deepcopy(old_entity)
                    new_entity.name = old_entity.name .. "-" .. i .. "a"
                    new_entity.localised_name = {"", {"?", {"entity-name." ..  old_entity.name}, {"item-name." .. old_item.name}}, " Alt. ", tostring(i)}
                    new_entity.localised_description = {"entity-description." ..  old_entity.name}

                    new_item.localised_name = {"", {"?", {"entity-name." .. old_entity.name}, {"item-name." .. old_item.name}}, " Alt. ", tostring(i)}
                    new_item.place_result = new_entity.name
                    if old_entity.minable then
                        new_entity.minable = {mining_time = old_entity.minable.mining_time, result = new_item.name}
                    end

                    table.insert(result, new_item)
                    log("Created alternate entity " .. new_item.name)

                    table.insert(result, new_entity)
                    log("Created alternate item " .. new_entity.name)
                else
                    log("Could not find entity " .. old_entity_name)
                    break
                end
            elseif old_item.place_as_equipment_result then
                local old_equipment = find_entity_by_name(old_equipment_name)
                if old_equipment then
                    local new_equipment = table.deepcopy(old_equipment)
                    new_equipment.name = old_equipment.name .. "-" .. i .. "a"
                    new_equipment.localised_name = {"", {"?", {"equipment-name." ..  old_equipment.name}, {"item-name." .. old_item.name}}, " Alt. ", tostring(i)}
                    new_equipment.localised_description = {"entity-description." ..  old_equipment.name}

                    new_item.localised_name = {"", {"?", {"equipment-name." ..  old_equipment.name}, {"item-name." .. old_item.name}}, " Alt. ", tostring(i)}
                    new_item.place_as_equipment_result = new_equipment.name

                    table.insert(result, new_item)
                    log("Created alternate equipment " .. new_item.name)

                    table.insert(result, new_equipment)
                    log("Created alternate item " .. new_equipment.name)
                else
                    log("Could not find equipment " .. old_equipment_name)
                    break
                end
            elseif item_type == "item" then
                log("Skipping item " .. old_item.name .. " without place_result")
                break
            else
                table.insert(result, new_item)
                log("Created alternate item " .. new_item.name)
            end

            local old_recipe_names = find_recipes_creating(old_item.name)

            local k = 0
            for _, old_recipe_name in pairs(old_recipe_names) do
                local old_recipe = data.raw["recipe"][old_recipe_name]
                k = k + 1
                
                if old_recipe.category == "recycling" then
                    log("Skipping recycling recipe " .. old_recipe.name)
                else
                    local new_recipe = table.deepcopy(old_recipe)
                    if k == 1 then
                        new_recipe.name = old_recipe.name .. "-" .. i .. "a"
                    else 
                        new_recipe.name = old_recipe.name .. "-" .. i .. '-' .. k .. "a"
                    end

                    local l10n = {"?", {"recipe-name." .. old_recipe.name}}
                    if old_entity_name then
                        table.insert(l10n, {"entity-name." .. old_entity_name})
                    end
                    if old_equipment_name then
                        table.insert(l10n, {"equipment-name." .. old_equipment_name})
                    end
                    table.insert(l10n, {"item-name." .. old_item.name})
                    new_recipe.localised_name = {"", l10n, " Alt. ", tostring(i)}

                    local new_results = {}
                    for _, recipe_result in pairs(old_recipe.results) do
                        if result.name == old_name then
                            table.insert(new_results, {name = new_item.name, type = recipe_result.type, amount = recipe_result.amount})
                        else
                            table.insert(new_results, recipe_result)
                        end
                    end
                    new_recipe.results = new_results

                    table.insert(result, new_recipe)
                    log("Created alternate recipe " .. new_recipe.name)

                    local old_technology_names = find_technologies_providing_recipe(old_recipe.name)

                    local l = 0
                    for _, old_technology_name in pairs(old_technology_names) do
                        local old_technology = data.raw["technology"][old_technology_name]
                        l = l + 1
                        
                        local new_technology = table.deepcopy(old_technology)
                        new_technology.name = new_recipe.name .. "-" .. l .. "a"

                        local l10n = {"?", {"recipe-name." .. old_recipe.name}}
                        if old_entity_name then
                            table.insert(l10n, {"entity-name." .. old_entity_name})
                        end
                        if old_equipment_name then
                            table.insert(l10n, {"equipment-name." .. old_equipment_name})
                        end
                        table.insert(l10n, {"item-name." .. old_item.name})
                        new_technology.localised_name = {"", l10n, " Alt. ", tostring(i)}

                        new_technology.effects = {
                            {
                                type = "unlock-recipe",
                                recipe = new_recipe.name
                            }
                        }
                        new_technology.prerequisites = {old_technology.name}
                        table.insert(result, new_technology)
                        log("Created alternate technology " .. new_technology.name)
                    end
                end
            end
        end
    end
end

for _, item in pairs(result) do
    data:extend{item}
end
