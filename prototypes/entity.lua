require("randomlua")
require("function")
require("types.energy")
require("types.resistance")
require("types.trigger")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 1360)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value
local enemy_hp = settings.startup["pw-rand-enemy-health"].value

function rand_item(item, hp_multiplier)
    if item.max_health then
        item.max_health = item.max_health * rng:random_real(min, max) * hp_multiplier
    end

    if item.healing_per_tick then
        item.healing_per_tick = item.healing_per_tick * rng:random_real(min, max) * hp_multiplier
    end

    if item.repair_speed_modifier then
        item.repair_speed_modifier = item.repair_speed_modifier * rng:random_real(min, max)
    end

    if item.resistances then
        rand_resistance(item.resistances, rng, min, max)
    end

    if item.dying_trigger_effect then
        rand_trigger_effect(item.dying_trigger_effect, rng, min, max)
    end

    if item.damaged_trigger_effect then
        rand_trigger_effect(item.damaged_trigger_effect, rng, min, max)
    end

    if item.created_effect then
        rand_trigger(item.created_effect, rng, min, max)
    end

    if item.emissions_per_second then
        for i, v in pairs(item.emissions_per_second) do
            item.emissions_per_second[i] = v * rng:random_real(min, max)
        end
    end

    if item.heating_energy then
        item.heating_energy = rand_energy(item.heating_energy, rng, min, max)
    end
end

local entity_categories = {
    'accumulator', 'agricultural-tower', 'artillery-turret', 'asteroid-collector', 'beacon', 'boiler', 'burner-generator', 'cargo-bay', 'cargo-landing-pad',
    'arithmetic-combinator', 'decider-combinator', 'selector-combinator', 'constant-combinator',
    'container', 'logistic-container', 'assembling-machine', 'rocket-silo', 'furnace', 'display-panel', 'electric-pole',
    'fusion-generator', 'fusion-reactor', 'generator', 'heat-pipe', 'inserter', 'lab', 'lamp', 'lightning-attractor', 'mining-drill',
    'offshore-pump', 'pipe', 'pipe-to-ground', 'power-switch', 'programmable-speaker', 'pump', 'radar', 
    'curved-rail-a', 'elevated-curved-rail-a', 'curved-rail-b', 'elevated-curved-rail-b', 'half-diagonal-rail', 'elevated-half-diagonal-rail', 'rail-ramp', 'straight-rail', 'elevated-straight-rail',
    'rail-chain-signal', 'rail-signal', 'rail-support', 'reactor', 'roboport', 'solar-panel', 'storage-tank', 'thruster', 'train-stop',
    'lane-splitter', 'loader-1x1', 'loader', 'splitter', 'transport-belt', 'underground-belt',

    'character', 'cargo-pod', 'capture-robot', 'combat-robot', 'construction-robot', 'logistic-robot', 'gate', 'space-platform-hub',
    'turret', 'ammo-turret', 'electric-turret', 'fluid-turret', 'car', 'artillery-wagon', 'cargo-wagon', 'fluid-wagon', 'locomotive', 'spider-vehicle', 'wall'
}

for _, category in pairs(entity_categories) do
    for _, item in pairs(data.raw[category]) do
        rand_item(item, 1)
    end
end

local enemy_categories = {
    'asteroid', 'unit-spawner', 'segment', 'segmented-unit', 'spider-unit', 'unit', 'tree', 'plant'
}

for _, category in pairs(enemy_categories) do
    for _, item in pairs(data.raw[category]) do
        rand_item(item, enemy_hp)
    end
end
