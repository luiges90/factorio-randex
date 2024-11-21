require("randomlua")
require("function")
    
function rand_energy(item, rng, min, max)
    energy, energy_unit = string.match(item, "^([%d.]+)(%a+)")
    return (energy * rng:random_real(min, max)) .. energy_unit
end
