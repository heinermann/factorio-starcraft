local function setup_vespene_geyser(entity, iscript)
    iscript.register_entity(entity)

    local gas_box = entity.bounding_box
    local minerals_filter = {
        name = "starcraft-mineral-field",
        type = "resource",
        force = "neutral"
    }

    -- Define bounds to search from this geyser
    local left_bounds = {{gas_box.left_top.x - 32, gas_box.left_top.y - 32}, {gas_box.left_top.x, gas_box.right_bottom.y + 32}}
    local top_bounds = {{gas_box.left_top.x - 32, gas_box.left_top.y - 32}, {gas_box.right_bottom.x + 32, gas_box.left_top.y}}
    local right_bounds = {{gas_box.right_bottom.x, gas_box.left_top.y - 32}, {gas_box.right_bottom.x + 32, gas_box.right_bottom.y + 32}}
    local bottom_bounds = {{gas_box.left_top.x - 32, gas_box.right_bottom.y}, {gas_box.right_bottom.x + 32, gas_box.right_bottom.y + 32}}
    local all_bounds = {left_bounds, top_bounds, right_bounds, bottom_bounds}

    -- Find the side of the geyser with the least minerals
    local best_count = math.huge
    local best_bounds = left_bounds
    for _, area in pairs(all_bounds) do
        minerals_filter.area = area
        local count = entity.surface.count_entities_filtered(minerals_filter)
        if count < best_count then
        best_count = count
        best_bounds = area
        end
    end

    -- remove minerals from the side of the geyser that has the least
    minerals_filter.area = best_bounds
    for _, entity in pairs(entity.surface.find_entities_filtered(minerals_filter)) do
        entity.deplete()
    end
end

function setup_resource(entity, iscript)
    if not entity.valid then
        return
    end

    entity.surface.destroy_decoratives{area = entity.selection_box}

    if entity.name == "starcraft-vespene-geyser" then
        setup_vespene_geyser(entity, iscript)
    end
end
