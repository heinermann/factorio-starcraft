require("prototypes.entity.helpers")

data:extend({
    make_projectile{
        name = "starcraft-sts_sta_photon_cannon",
        acceleration = sc_pixels_per_frame_to_factorio_tiles_per_tick(850/256) / 2.52,
        rotatable = false,
        max_speed = sc_pixels_per_frame_to_factorio_tiles_per_tick(160),
        animation = create_anim{
            filename = "main_524_diffuse.png",
            size = { 96, 77 },
            hr_size = { 193, 155 },
            draw_as_glow = true,
            frame_count = 11,
            animation_speed = 1/2.5 -- 42ms in SC (1 ticks)
        },
        action = {
            type = "direct",
            action_delivery = {
                type = "instant",
                target_effects = {
                    {
                        type = "damage",
                        apply_damage_to_trees = false,
                        damage = {
                            amount = 20,
                            type = "physical"
                        }
                    },
                    {
                        type = "create-trivial-smoke",
                        smoke_name = "starcraft-dragbull_explode",
                        offsets = {
                            { 0, -sc_pixels_to_factorio_tiles(20)/2 }
                        }
                    },
                    {
                        type = "play-sound",
                        sound = {
                            filename = "__starcraft__/sound/misc/explomed.wav",
                            aggregation = {
                              max_count = 4,
                              remove = false,
                              count_already_playing = true
                            }
                        }
                    }
                }
            }
        }
    }
})
