require("randomlua")
require("function")
    
function rand_energy(item, rng, min, max)
    energy, energy_unit = string.match(item, "^([%d.]+)(%a+)")
    return (energy * rng:random_real(min, max)) .. energy_unit
end

function multiply_energy(energy_str, factor)
    energy, energy_unit = string.match(energy_str, "^([%d.]+)(%a+)")
    return (energy * factor) .. energy_unit
end

function compare_energy(energy_str1, energy_str2)
    energy1, energy_unit1 = string.match(energy_str1, "^([%d.]+)(%a+)")
    energy2, energy_unit2 = string.match(energy_str2, "^([%d.]+)(%a+)")
    if energy1 == energy2 and energy_unit1 == energy_unit2 then return 0 end

    if energy_unit1 == "J" then
        energy1 = energy1 * 60
    end
    if energy_unit2 == "J" then
        energy2 = energy2 * 60
    end
    if energy_unit1 == "kJ" then 
        energy1 = energy1 * 1000 * 60
    end
    if energy_unit2 == "kJ" then 
        energy2 = energy2 * 1000 * 60
    end
    if energy_unit1 == "kW" then
        energy1 = energy1 * 60
    end
    if energy_unit2 == "kW" then
        energy2 = energy2 * 60
    end
    if energy_unit1 == "MJ" then 
        energy1 = energy1 * 1000000 * 60
    end
    if energy_unit2 == "MJ" then 
        energy2 = energy2 * 1000000 * 60
    end
    if energy_unit1 == "MW" then
        energy1 = energy1 * 1000000
    end
    if energy_unit2 == "MW" then
        energy2 = energy2 * 1000000
    end
    if energy_unit1 == "GJ" then 
        energy1 = energy1 * 1000000000 * 60
    end
    if energy_unit2 == "GJ" then 
        energy2 = energy2 * 1000000000 * 60
    end
    if energy_unit1 == "GW" then
        energy1 = energy1 * 1000000000
    end
    if energy_unit2 == "GW" then
        energy2 = energy2 * 1000000000
    end

    if energy1 == energy2 then return 0 end
    if energy1 > energy2 then return 1 end
    if energy1 < energy2 then return -1 end
end