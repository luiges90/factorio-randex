require("randomlua")
require("function")

function rand_asteroid_spawn_point(item, rng, min, max)
    item.probability = item.probability * rng:random_real(min, max)
    item.speed = item.speed * rng:random_real(min, max)
    if item.angle_when_stopped then
        item.angle_when_stopped = clamp(item.angle_when_stopped * rng:random_real(min, max), 0, 1)
    end
end