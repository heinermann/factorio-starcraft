-- Equipment grid extensions are to be used for a number of things.
-- 1. Protoss shields.
-- 2. Unit speed upgrades.
-- 3. Spellcaster energy storage +upgrade.
-- 4. Defense matrix shields? (unlikely as it will conflict with protoss shields unless I can guarantee it hits this first)

tempSprite = {
  filename = "__base__/graphics/equipment/fusion-reactor-equipment.png",
  width = 128,
  height = 128,
  priority = "medium",
  hr_version =
  {
    filename = "__base__/graphics/equipment/hr-fusion-reactor-equipment.png",
    width = 256,
    height = 256,
    priority = "medium",
    scale = 0.5
  }
}

function fake_item(name)
  return {
    type = "item",
    name = name,
    icon = "__base__/graphics/icons/fusion-reactor-equipment.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "starcraft-mechanics",
    stack_size = 1,
    flags = {"hidden"}
  }
end

data:extend({
  -------------------------------------
  -- Equipment categories and grid
  -------------------------------------
  {
    type = "equipment-category",
    name = "starcraft"
  },
  {
    type = "equipment-grid",
    name = "starcraft-unit-eg",
    equipment_categories = {"starcraft"},
    width = 10,
    height = 1,
    locked = true
  },
  -------------------------------------
  -- Generator
  -------------------------------------
  {
    type = "generator-equipment",
    name = "starcraft-energy-src",
    categories = {"starcraft"},
    energy_source = {
      type = "electric",
      usage_priority = "primary-output"
    },
    shape = { width = 1, height = 1, type = "full" },
    sprite = tempSprite,
    power = "1kW"
  },
  fake_item("starcraft-energy-src"),
  -------------------------------------
  -- Energy
  -------------------------------------
  {
    type = "battery-equipment",
    name = "starcraft-unit-energy-200",
    categories = {"starcraft"},
    energy_source = {
      type = "electric",
      render_no_power_icon = false,
      render_no_network_icon = false,
      buffer_capacity = "200J",
      usage_priority = "primary-input",
      input_flow_limit = "1W",
      output_flow_limit = "0W"
    },
    shape = { width = 1, height = 1, type = "full" },
    sprite = tempSprite
  },
  fake_item("starcraft-unit-energy-200"),
  -------------------------------------
  -- Upgraded Energy
  -------------------------------------
  {
    type = "battery-equipment",
    name = "starcraft-unit-energy-250",
    categories = {"starcraft"},
    energy_source = {
      type = "electric",
      render_no_power_icon = false,
      render_no_network_icon = false,
      buffer_capacity = "250J",
      usage_priority = "primary-input",
      input_flow_limit = "1W",
      output_flow_limit = "0W"
    },
    shape = { width = 1, height = 1, type = "full" },
    sprite = tempSprite
  },
  fake_item("starcraft-unit-energy-250"),
  -------------------------------------
  -- Shields
  -------------------------------------
  {
    type = "energy-shield-equipment",
    name = "starcraft-shields-80",
    categories = {"starcraft"},
    energy_per_shield = "1J",
    max_shield_value = 80,
    energy_source = {
      type = "electric",
      render_no_power_icon = false,
      render_no_network_icon = false,
      usage_priority = "primary-input",
      input_flow_limit = "1W",
      output_flow_limit = "0W"
    },
    shape = { width = 1, height = 1, type = "full" },
    sprite = tempSprite
  },
  fake_item("starcraft-shields-80")
})
