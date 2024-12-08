require("randomlua")
require("function")
require("types.energy")
require("types.energy-source")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 63854)

local alt_min = settings.startup["pw-rand-min-alternate-entities"].value
local alt_max = settings.startup["pw-rand-max-alternate-entities"].value
local alt_cnt = rng:random(alt_min, alt_max)

local old_entities = data.raw["solar-panel"]
log("Creating " .. alt_cnt .. " alternate entities for solar panels")

local result = {}
for _, old_entity in pairs(old_entities) do
    for i = 1, alt_cnt do
        log("Creating alternate entity " .. i .. " of " .. alt_cnt .. " for " .. old_entity.name)
        local old_name = old_entity.name
        local old_recipe_names = find_recipes_creating(old_name)

        local alt = table.deepcopy(old_entity)
        alt.name = alt.name .. "-a" .. i
        table.insert(result, alt)
        log("Created alternate entity " .. alt.name)

        local item = find_items_placing_entity(old_name)
        local j = 0
        for _, item in pairs(item) do
            j = j + 1
            log("Creating alternate item for " .. item .. " placing " .. alt.name)
            local new_item = table.deepcopy(data.raw["item"][item])
            new_item.name = item .. "--" .. alt.name .. "-" .. j
            new_item.place_result = alt.name
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
                    new_recipe.name = recipe.name .. "--" .. new_item.name .. "-" .. k
                    for _, result in pairs(new_recipe.results) do
                        if result.name == old_name then
                            result.name = new_item.name
                        end
                    end
                    table.insert(result, new_recipe)
                    log("Created alternate recipe " .. new_recipe.name)

                    local old_technology_names = find_technologies_providing_recipe(recipe.name)

                    local l = 0
                    for _, technology in pairs(old_technology_names) do
                        local technology = data.raw["technology"][technology]
                        l = l + 1
                        
                        log("Creating alternate technology for " .. technology.name .. " providing " .. new_recipe.name)
                        local new_technology = table.deepcopy(technology)
                        new_technology.name = technology.name .. "--" .. new_recipe.name .. "-" .. l
                        for _, effect in pairs(new_technology.effects) do
                            if effect.recipe == recipe.name then
                                effect.recipe = new_recipe.name
                            end
                        end
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
