require("randomlua")
require("function")
require("types.energy")
require("types.energy-source")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 63854)

local alt_min = settings.startup["pw-rand-min-alternate-entities"].value
local alt_max = settings.startup["pw-rand-max-alternate-entities"].value

local prototype_types = {
    "accumulator", "agricultural-tower", "ammo", "armor", "artillery-turret", "asteroid-collector", "beacon", "boiler", "burner-generator", "capsule", "cargo", 
    "container", "linked-container", "logistic-container", "crafting-machine", "assembling-machine", "rocket-silo", "furnance", "electric-pole", 
    --"equipment", "active-defense-equipment", "battery-equipment", "belt-immunity-equipment", "energy-shield-equipment", "generator-equipment", "inventory-bonus-equipment",
    --"movement-bonus-equipment", "night-vision-equipment", "roboport-equipment", "solar-panel-equipment",
    "flying-robot", "capture-robot", "combat-robot", "construction-robot", "logistic-robot", 
    "fusion-generator", "fusion-reactor", "gate", "generator", "gun", "heat-pipe", "inserter", "lab",
    "lamp", "land-mine", "lightning-attractor", "mining-drill", "module", "offshore-pump", "pipe", "pipe-to-ground", "pump", "radar", "reactor",
    "repair-tool", "roboport", "solar-panel", "space-platform-hub", "spider-unit", "storage-tank", "thruster", 
    "transport-belt", "underground-belt", "splitter", "loader", "loader-1x1", "lane-splitter", "linked-belt",
    "turret", "ammo-turret", "electric-turret", "fluid-turret", "vehicle", "wall"
}

local result = {}
for _, prototype_type in ipairs(prototype_types) do
    local old_entities = data.raw[prototype_type]
    local alt_cnt = rng:random(alt_min, alt_max)
    log("Creating " .. alt_cnt .. " alternate entities for " .. prototype_type)

    if old_entities then
        for _, old_entity in pairs(old_entities) do
            for i = 1, alt_cnt do
                log("Creating alternate entity " .. i .. " of " .. alt_cnt .. " for " .. old_entity.name)
                local old_recipe_names = find_recipes_creating(old_entity.name)

                local alt = table.deepcopy(old_entity)
                alt.name = alt.name .. "-" .. i .. "a"
                alt.localised_name = {"", {"entity-name." ..  old_entity.name}, " Alternate ", tostring(i)}
                alt.localised_description = {"entity-description." ..  old_entity.name}
                
                local items = find_items_placing_entity(old_entity.name)
                local item = nil
                if #items > 0 then
                    item = data.raw["item"][items[1]]
                else
                    log("No items found for entity " .. old_entity.name)
                    break
                end

                log("Creating alternate item for " .. item.name .. " placing " .. alt.name)
                local new_item = table.deepcopy(item)
                new_item.name = item.name .. "--" .. alt.name .. "-" .. i .. "a"
                new_item.localised_name = {"", {"?", {"item-name." .. item.name}, {"entity-name." .. old_entity.name}}, " Alternate ", tostring(i)}
                new_item.localised_description = {"item-description." .. item.name}
                new_item.place_result = alt.name
                if old_entity.minable then
                    alt.minable = {mining_time = old_entity.minable.mining_time, result = new_item.name}
                end
                if not new_item.weight then
                    new_item.weight = 10000
                end
                table.insert(result, alt)
                log("Created alternate entity " .. alt.name)
                table.insert(result, new_item)
                log("Created alternate item " .. new_item.name)

                local k = 0
                for _, recipe in pairs(old_recipe_names) do
                    local recipe = data.raw["recipe"][recipe]
                    k = k + 1
                    
                    if recipe.category == "recycling" then
                        log("Skipping recycling recipe " .. recipe.name)
                    else
                        log("Creating alternate recipe for " .. recipe.name .. " resulting in " .. new_item.name)
                        local new_recipe = table.deepcopy(recipe)
                        new_recipe.name = recipe.name .. "--" .. new_item.name .. "-" .. k .. "a"
                        new_recipe.localised_name = {"", {"?", {"recipe-name." .. recipe.name}, {"item-name." .. item.name}, {"entity-name." .. old_entity.name}}, " Alternate ", tostring(i)}
                        new_recipe.localised_description = {"recipe-description." .. recipe.name}

                        local new_results = {}
                        for _, result in pairs(new_recipe.results) do
                            if result.name == old_name then
                                table.insert(new_results, {name = new_item.name, type = result.type, amount = result.amount})
                            else
                                table.insert(new_results, result)
                            end
                        end
                        new_recipe.results = new_results

                        table.insert(result, new_recipe)
                        log("Created alternate recipe " .. new_recipe.name)

                        local old_technology_names = find_technologies_providing_recipe(recipe.name)

                        local l = 0
                        for _, technology in pairs(old_technology_names) do
                            local technology = data.raw["technology"][technology]
                            l = l + 1
                            
                            log("Creating technology for " .. technology.name .. " providing " .. new_recipe.name)
                            local new_technology = table.deepcopy(technology)
                            new_technology.name = technology.name .. "--" .. new_recipe.name .. "-" .. l .. "a"
                            new_technology.localised_name = {"", {"?", {"recipe-name." .. recipe.name}, {"item-name." .. item.name}, {"entity-name." .. old_entity.name}}, " Alternate ", tostring(i)}
                            new_technology.effects = {
                                {
                                    type = "unlock-recipe",
                                    recipe = new_recipe.name
                                }
                            }
                            table.insert(result, new_technology)
                            log("Created alternate technology " .. new_technology.name)
                        end
                    end
                end
            end
        end
    end
end

for _, item in pairs(result) do
    data:extend{item}
end
