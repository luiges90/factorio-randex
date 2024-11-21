require("randomlua")
require("function")
require("types.trigger")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 1452)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

for _, item in pairs(data.raw["chain-active-trigger"]) do
    if item.action then
        for k, t in pairs(item.action) do
            if type(k) == "number" then
                rand_trigger(t, rng, min, max)
            else
                rand_trigger(item.action, rng, min, max)
                break
            end
        end
    end
    if item.max_jumps then
        item.max_jumps = math.ceil(item.max_jumps * rng:random_real(min, max))
    end
    if item.max_range_per_jump then
        item.max_range_per_jump = item.max_range_per_jump * rng:random_real(min, max)
    end
    if item.max_range then
        item.max_range = item.max_range * rng:random_real(min, max)
    end
    if item.jump_delay_ticks then
        item.jump_delay_ticks = math.ceil(item.jump_delay_ticks * rng:random_real(min, max))
    end
    if item.fork_chance then
        item.fork_chance = clamp(item.fork_chance * rng:random_real(min, max), 0, 1)
    end
    if item.fork_chancce_increase_per_quality_level then
        item.fork_chancce_increase_per_quality_level = clamp(item.fork_chancce_increase_per_quality_level * rng:random_real(min, max), 0, 1)
    end
    if item.max_forks_per_jump then
        item.max_forks_per_jump = math.ceil(item.max_forks_per_jump * rng:random_real(min, max))
    end
    if item.max_forks then
        item.max_forks = math.ceil(item.max_forks * rng:random_real(min, max))
    end
end

for _, item in pairs(data.raw["delayed-active-trigger"]) do
    if item.action then
        for k, t in pairs(item.action) do
            if type(k) == "number" then
                rand_trigger(t, rng, min, max)
            else
                rand_trigger(item.action, rng, min, max)
                break
            end
        end
    end
    if item.delay then
        item.delay = math.ceil(item.delay * rng:random_real(min, max))
    end
    if item.repeat_count then
        item.repeat_count = math.ceil(item.repeat_count * rng:random_real(min, max))
    end
    if item.repeat_delay then
        item.repeat_delay = math.ceil(item.repeat_delay * rng:random_real(min, max))
    end
end