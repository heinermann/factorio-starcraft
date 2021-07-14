

unitSizeTypes = {
  independent = {
    { type = "physical", percent = 99 },
    { type = "impact", percent = 99 },
    { type = "explosion", percent = 99 },
    { type = "fire", percent = 99 },
    { type = "laser", percent = 99 },
    { type = "acid", percent = 99 },
    { type = "electric", percent = 99 },
    { type = "psionic", percent = 99 }
  },
  small = {
    { type = "physical", percent = 0 },
    { type = "impact", percent = 0 },
    { type = "explosion", percent = 50 },
    { type = "fire", percent = 0 },
    { type = "laser", percent = 0 },
    { type = "acid", percent = 50 },
    { type = "electric", percent = 0 },
    { type = "psionic", percent = 0 }
  },
  medium = {
    { type = "physical", percent = 0 },
    { type = "impact", percent = 50 },
    { type = "explosion", percent = 25 },
    { type = "fire", percent = 50 },
    { type = "laser", percent = 0 },
    { type = "acid", percent = 25 },
    { type = "electric", percent = 0 },
    { type = "psionic", percent = 0 }
  },
  large = {
    { type = "physical", percent = 0 },
    { type = "impact", percent = 75 },
    { type = "explosion", percent = 0 },
    { type = "fire", percent = 75 },
    { type = "laser", percent = 0 },
    { type = "acid", percent = 0 },
    { type = "electric", percent = 0 },
    { type = "psionic", percent = 0 }
  }
}

function create_ground_unit(data)
  
end

function make_structure(data)
  return {
    type = "simple-entity-with-force",
    icon = "__base__/graphics/icons/info.png",
    icon_size = 64,

    flags = {
      "not-rotatable",
      "not-blueprintable",
      "not-deconstructable",
      "hidden",
      "not-flammable",
      "no-automated-item-removal",
      "no-automated-item-insertion",
      "no-copy-paste",
      "not-upgradable"
    },

    allow_copy_paste = false,
    remove_decoratives = true,
    resistances = unitSizeTypes.large,

    hide_resistances = false,
    create_ghost_on_death = false,

    random_variation_on_create = false,

    --animations
    --tile_width = 8,
    --tile_height = 6,
    --max-health
    --healing_per_tick
    --repair_speed_modifier
    --dying_explosion
    --damaged_trigger_effect
    --dying_trigger_effect
    --attack_reaction

    table.unpack(data)
  }
end

function make_zerg_structure(data)
  local result = make_structure(data)

  result.healing_per_tick = 0.0062
  result.flags = {
    table.unpack(result.flags),
    "not-repairable"
  }
  result.damaged_trigger_effect = {
    type = "script",
    effect_id = "zerg_bldg_dmg" -- Used to update overlays
  }

  return result
end

function make_protoss_structure(data)
  local result = make_structure(data)

  result.flags = {
    table.unpack(result.flags),
    "not-repairable"
  }
  result.damaged_trigger_effect = {
    type = "script",
    effect_id = "protoss_bldg_dmg" -- Used to update overlays
  }

  return result
end

function make_terran_structure(data)
  local result = make_structure(data)
  -- TODO: repair_speed_modifier

  result.damaged_trigger_effect = {
    type = "script",
    effect_id = "terran_bldg_dmg" -- Used to update overlays
  }

  return result
end
