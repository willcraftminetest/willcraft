--WillCraft own items and commands.

--Spawn Command.

spawn_command = {}
spawn_command.pos = {x=0, y=3, z=0}

if minetest.setting_get_pos("static_spawnpoint") then
    spawn_command.pos = minetest.setting_get_pos("static_spawnpoint")
end

function teleport_to_spawn(name)
    local player = minetest.get_player_by_name(name)
    if player == nil then
        -- just a check to prevent the server crashing
        return false
    end
    local pos = player:getpos()
    if _G['cursed_world'] ~= nil and    --check global table for cursed_world mod
        cursed_world.location_y and cursed_world.dimension_y and
        pos.y < (cursed_world.location_y + cursed_world.dimension_y) and    --if player is in cursed world, stay in cursed world
        pos.y > (cursed_world.location_y - cursed_world.dimension_y)
    then   --check global table for cursed_world mod
        --minetest.chat_send_player(name, "T"..(cursed_world.location_y + cursed_world.dimension_y).." "..(cursed_world.location_y - cursed_world.dimension_y))
        local spawn_pos = vector.round(spawn_command.pos);
        spawn_pos.y = spawn_pos.y + cursed_world.location_y;
        player:setpos(spawn_pos)
        minetest.chat_send_player(name, "Teleported to spawn!")
    else
        player:setpos(spawn_command.pos)
        minetest.chat_send_player(name, "Teleported to spawn!")
    end
end

minetest.register_chatcommand("spawn", {
    description = "Teleport you to spawn point.",
    privs = {home = true},
    func = teleport_to_spawn,
})

--Items!

minetest.register_craftitem("willcraft:superapple", {
    description = "Adamante Super Apple",
    inventory_image = "adamante_superapple.png",
    on_use = minetest.item_eat(30),
})

minetest.register_craft({
    type = "shaped",
    output = "willcraft:superapple 9",
    recipe = {
        {"default:diamondblock", "",                         ""},
        {"default:diamondblock", "default:diamondblock",  ""},
        {"default:diamondblock", "default:apple",  ""}
    }
})

minetest.register_node("willcraft:lgbt", {
    description = "LGBT Block",
    tiles = {"adamante_lgbt.png"},
    is_ground_content = true,
    groups = {cracky=3, stone=1}
})