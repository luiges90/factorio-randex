local prototypes = {
    "accumulator",
    "active-trigger",
    "agricultural-tower",
    "ammo",
    "armor",
    "artillery-turret",
    "asteroid-collector",
    "asteroid",
    "beacon",
    "boiler",
    "burner-generator",
    "capsule",
    "cargo",
    "character",
    "combinator",
    "container",
    "crafting-machine",
    "electric-pole",
    "entity",
    "equipment-grid",
    "equipment",
    --"fire",
    "fluid",
    "flying-robot",
    "fusion-generator",
    "fusion-reactor",
    "gate",
    "generator",
    "gun",
    "heat-pipe",
    "inserter",
    "item",
    "lab",
    "lamp",
    "land-mine",
    "lightning-attractor",
    "lightning",
    "mining-drill",
    "module",
    "offshore-pump",
    "pipe",
    "planet",
    "plant",
    "projectile",
    "pump",
    "quality",
    "radar",
    "reactor",
    "recipe",
    "repair-tool",
    "resource-entity",
    "roboport",
    "segmented-unit",
    "solar-panel",
    "space-connection",
    "space-platform-hub",
    "spider-unit",
    "sticker",
    "storage-tank",
    "surface",
    "technology",
    "thruster",
    "tile",
    "transport-belt",
    "turret",
    "unit",
    "unit-spawner",
    "vehicle"
}

for _, file in ipairs(prototypes) do
    require("prototypes." .. file)
end

-- Currently player has little recourse if spitters outrange the gun turret.
if data.raw["ammo-turret"]["gun-turret"].attack_parameters.range < data.raw["unit"]["small-spitter"].attack_parameters.range + 1 then
    data.raw["ammo-turret"]["gun-turret"].attack_parameters.range = data.raw["unit"]["small-spitter"].attack_parameters.range + 1
end
if data.raw["ammo-turret"]["gun-turret"].attack_parameters.range < data.raw["unit"]["medium-spitter"].attack_parameters.range + 1 then
    data.raw["ammo-turret"]["gun-turret"].attack_parameters.range = data.raw["unit"]["medium-spitter"].attack_parameters.range + 1
end
-- large / behemoth are exempt since we expect player has better tech by then

-- electric mining drill enforce a minimum mining size to be same as vanilla because otherwise mining out a patch is very cumbersome. Vulcanus is too far away.
if data.raw["mining-drill"]["electric-mining-drill"].resource_searching_radius < 2.49 then
    data.raw["mining-drill"]["electric-mining-drill"].resource_searching_radius = 2.49
end
