local chat = minetest.chat_send_all
local vdiff = vector.subtract
local gmo = minetest.get_mapgen_object



local after = minetest.after
local settime = minetest.set_timeofday
local rep = function(f)
	after(5, f)
end
local function midnight()
	settime(0)
	rep(midnight)
end



local black = "#000000"

-- global setting used to control the default fog colour when a player joins.
-- note that nothing stops this from being overriden later...
if not minetest.global_exists("yetdarker_fog_colour") then
	-- intentional global assignment
	yetdarker_fog_colour = black
end

minetest.register_on_joinplayer(function(player)
	player:set_sky(yetdarker_fog_colour, "plain", nil, false)
end)



local dark = {day=0,night=0}
minetest.register_on_generated(function(minp, maxp, seed)
	-- looks to be 5x5x5 chunks generated at a time.
	-- so 80x80x80 blocks for a total of 512K blocks.
	-- local diff = vdiff(maxp, minp)
	-- chat("minp, maxp, diff: "
	--	.. fmt(minp) .. ", " .. fmt(maxp) .. ", " .. fmt(diff))
	local vm, emin, emax = gmo("voxelmanip")
	local data = vm:get_light_data()

	-- note, unique to mapgen - must not have been calculated yet.
	vm:set_lighting(dark)
	vm:write_to_map(false)
end)

