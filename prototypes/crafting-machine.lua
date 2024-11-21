require("randomlua")
require("function")
require("types.energy")
require("types.energy-source")
require("types.fluid-box")
require("types.effect")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 8456)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

function rand_crafting_machine(item)
    item.energy_usage = rand_energy(item.energy_usage, rng, min, max)
    item.crafting_speed = item.crafting_speed * rng:random_real(min, max)
    rand_energy_source(item.energy_source, rng, min, max)
    if item.fluid_boxes then
        for _, box in pairs(item.fluid_boxes) do
            rand_fluid_box(box, rng, min, max)
        end
    end
    if item.module_slots then
        item.module_slots = math.ceil(item.module_slots * rng:random_real(min, max))
    end
    if item.trash_inventory_size then
        item.trash_inventory_size = math.ceil(item.trash_inventory_size * rng:random_real(min, max))
    end
    --if item.effect_receiver then
    --    item.effect_receiver = rand_effect_receiver(item.effect_receiver, rng, min, max)
    --end
end

for _, item in pairs(data.raw["assembling-machine"]) do
    rand_crafting_machine(item)
    if item.ingredient_count then
        item.ingredient_count = math.ceil(item.ingredient_count * rng:random_real(min, max))
    end
end

local supply_size = 0
for _, item in pairs(data.raw["rocket-silo"]) do
    rand_crafting_machine(item)
    item.active_energy_usage = rand_energy(item.active_energy_usage, rng, min, max)
    item.rocket_parts_required = math.ceil(item.rocket_parts_required * rng:random_real(min, max))
    if item.rocket_parts_storage_cap then
        item.rocket_parts_storage_cap = math.ceil(item.rocket_parts_storage_cap * rng:random_real(min, max))
        if item.rocket_parts_storage_cap < item.rocket_parts_required then
            item.rocket_parts_storage_cap = item.rocket_parts_required
        end
    end
    if item.to_be_inserted_to_rocket_inventory_size then
        item.to_be_inserted_to_rocket_inventory_size = math.ceil(item.to_be_inserted_to_rocket_inventory_size * rng:random_real(min, max))
    end
    if item.rocket_supply_inventory_size then
        supply_size = math.max(supply_size, item.rocket_supply_inventory_size)
        item.rocket_supply_inventory_size = math.ceil(item.rocket_supply_inventory_size * rng:random_real(min, max))
    end
    if item.logistic_trash_inventory_size then
        item.logistic_trash_inventory_size = math.ceil(item.logistic_trash_inventory_size * rng:random_real(min, max))
    end
end

for _, item in pairs(data.raw["rocket-silo-rocket"]) do
    item.inventory_size = supply_size
end

for _, item in pairs(data.raw["furnace"]) do
    rand_crafting_machine(item)
end

