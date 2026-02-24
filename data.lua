local asteroid_util = require("__space-age__.prototypes.planet.asteroid-spawn-definitions")
data:extend({
	{
		type = "space-location",
		name = "half-way-to-shattered-planet",
		icon = "__space-age__/graphics/icons/solar-system-edge.png",
		order = "f[solbar-system-edge]",
		subgroup = "planets",
		gravity_pull = -10,
		draw_orbit = false,
		auto_save_on_first_trip = false,
		distance = 65,
		orientation = 0.25,
		magnitude = 1.0,
		label_orientation = 0.15,
		asteroid_spawn_influence = 1,
		asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.shattered_planet_trip, 0.8),
	},
	{
		type = "space-connection",
		name = "solar-system-edge-half-way-to-shattered-planet",
		icon = "__space-age__/graphics/icons/solar-system-edge.png",
		subgroup = "planet-connections",
		from = "solar-system-edge",
		to = "half-way-to-shattered-planet",
		order = "i",
		length = 2000000,
		asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.shattered_planet_trip),
	},
	{
		type = "space-connection",
		name = "solar-system-edge-shattered-planet",
		subgroup = "planet-connections",
		from = "half-way-to-shattered-planet",
		to = "shattered-planet",
		order = "i",
		length = 2000000,
		asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.shattered_planet_trip),
	},
	{
		type = "technology",
		name = "shattered-planet",
		icon = "__space-age__/graphics/icons/starmap-shattered-planet.png",
		icon_size = 512,
		effects = {
			{
				type = "unlock-space-location",
				space_location = "shattered-planet",
			},
		},
		prerequisites = { "promethium-science-pack" },
		unit = {
			count = 10000,
			ingredients = {
				{ "promethium-science-pack", 1 },
			},
			time = 120,
		},
	},
})

local tech = data.raw.technology["promethium-science-pack"]

if tech and tech.effects then
	for i = #tech.effects, 1, -1 do
		local effect = tech.effects[i]
		if effect.type == "unlock-space-location" and effect.space_location == "shattered-planet" then
			table.remove(tech.effects, i)
		end
	end
end
table.insert(data.raw["technology"]["promethium-science-pack"].effects, {
	type = "unlock-space-location",
	space_location = "half-way-to-shattered-planet",
})
