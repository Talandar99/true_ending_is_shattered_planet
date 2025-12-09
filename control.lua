local target_location = "shattered-planet"
local finished = {}

local function disable_original_victory()
	if remote.interfaces["space_finish_script"] then
		remote.call("space_finish_script", "set_no_victory", true)
	end
end

script.on_init(function()
	disable_original_victory()
end)

script.on_configuration_changed(function()
	disable_original_victory()
end)

local function on_platform_changed(event)
	local platform = event.platform
	if not (platform and platform.valid) then
		return
	end

	local loc = platform.last_visited_space_location
	if not loc then
		return
	end
	if loc.name ~= target_location then
		return
	end

	local force = platform.force
	if finished[force.name] then
		return
	end
	finished[force.name] = true

	game.reset_game_state()
	game.enable_galaxy_of_fame_button = true
	game.set_game_state({
		game_finished = true,
		player_won = true,
		can_continue = true,
		victorious_force = force,
	})
end

script.on_event(defines.events.on_space_platform_changed_state, on_platform_changed)
