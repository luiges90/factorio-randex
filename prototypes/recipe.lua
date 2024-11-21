require("randomlua")
require("function")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 832)

local prescale = settings.startup["pw-rand-recipe-prescale"].value
local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value
local diff = settings.startup["pw-rand-recipe-difficulty"].value

for name, recipe in pairs(data.raw.recipe) do
	if not string.find(recipe.name, "barrel") then
		if recipe.ingredients then
			for _, ingredient in pairs(recipe.ingredients) do
				if not contains(ingredient.name, stack_blacklist) then
					if ingredient.ignored_by_stats then
						ingredient.amount = ceil_2sf((ingredient.amount - ingredient.ignored_by_stats) * prescale * rng:random_real(min, max) * diff + ingredient.ignored_by_stats)
					else
						ingredient.amount = ceil_2sf(ingredient.amount * prescale * rng:random_real(min, max) * diff)
					end
				end
			end
		end

		if recipe.results then
			for _, result in pairs(recipe.results) do
				if not contains(result.name, stack_blacklist) then
					if result.amount then
						if result.ignored_by_productivity then
							result.amount = ceil_2sf((result.amount - result.ignored_by_productivity) * prescale * rng:random_real(min, max) + result.ignored_by_productivity)
						elseif result.ignored_by_stats then
							result.amount = ceil_2sf((result.amount - result.ignored_by_stats) * prescale * rng:random_real(min, max) + result.ignored_by_stats)
						else
							result.amount = ceil_2sf(result.amount * prescale * rng:random_real(min, max))
						end
					end
					if result.type == "item" or result.type == "fluid" then
						if result.amount_min then
							if result.ignored_by_productivity then
								result.amount_min = ceil_2sf((result.amount_min - result.ignored_by_productivity) * prescale * rng:random_real(min, max) + result.ignored_by_productivity)
							elseif result.ignored_by_stats then
								result.amount_min = ceil_2sf((result.amount_min - result.ignored_by_stats) * prescale * rng:random_real(min, max) + result.ignored_by_stats)
							else
								result.amount_min = ceil_2sf(result.amount_min * prescale * rng:random_real(min, max))
							end
						end
						if result.amount_max then
							if result.ignored_by_productivity then
								result.amount_max = ceil_2sf((result.amount_max - result.ignored_by_productivity) * prescale * rng:random_real(min, max) + result.ignored_by_productivity)
							elseif result.ignored_by_stats then
								result.amount_max = ceil_2sf((result.amount_max - result.ignored_by_stats) * prescale * rng:random_real(min, max) + result.ignored_by_stats)
							else
								result.amount_max = ceil_2sf(result.amount_max * prescale * rng:random_real(min, max))
							end
						end
						if result.probability then
							result.probability = clamp(ceil_2sf(result.probability * prescale * rng:random_real(min, max) * 10000) / 10000, 0, 1)
						end
					end
				end
			end
		end

		if not recipe.energy_required then
			recipe.energy_required = 0.5
		end
		recipe.energy_required = ceil_2sf(math.ceil(recipe.energy_required * prescale * rng:random_real(min, max) * 2) / 2)
	end
end
