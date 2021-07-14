-- Equipment grid extensions are to be used for a number of things.
-- 1. Protoss shields.
-- 2. Unit speed upgrades.
-- 3. Spellcaster energy storage +upgrade.
-- 4. Defense matrix shields? (unlikely as it will conflict with protoss shields unless I can guarantee it hits this first)

local tempSprite = {
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

local function fake_item(name)
  return {
    type = "item",
    name = name,
    icon = "__base__/graphics/icons/fusion-reactor-equipment.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "starcraft-mechanics",
    stack_size = 1,
    flags = {"hidden", "not-stackable", "hide-from-bonus-gui"}
  }
end

local function make_energy(amount)
  local item_name = "starcraft-unit-energy-" .. tostring(amount)
  return fake_item(item_name), {
    type = "battery-equipment",
    name = item_name,
    categories = {"starcraft"},
    energy_source = {
      type = "electric",
      render_no_power_icon = false,
      render_no_network_icon = false,
      buffer_capacity = tostring(amount) .. "J",
      usage_priority = "primary-input",
      input_flow_limit = "1W",
      output_flow_limit = "0W"
    },
    shape = { width = 1, height = 1, type = "full" },
    sprite = tempSprite
  }
end

local function make_shields(amount)
  local item_name = "starcraft-shields-" .. tostring(amount)
  return fake_item(item_name), {
    type = "energy-shield-equipment",
    name = item_name,
    categories = {"starcraft"},
    energy_per_shield = "1J",
    max_shield_value = amount,
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
  make_energy(200),
  -------------------------------------
  -- Upgraded Energy
  -------------------------------------
  make_energy(250),
  -------------------------------------
  -- Shields
  -------------------------------------
  make_shields(20),   -- Probe), Observer
  make_shields(40),   -- DT), Templar), Interceptor
  make_shields(60),   -- Zealot), Shuttle
  make_shields(80),   -- Corsair), Goon), Hero DT), Reaver
  make_shields(100),  -- Scout), Cannon
  make_shields(150),  -- Arbiter), Carrier
  make_shields(200),  -- Dark Archon), Shield Battery
  make_shields(240),  -- Fenix
  make_shields(250),  -- Artanis), Observatory
  make_shields(300),  -- Tassadar), Aldaris), Pylon
  make_shields(350),  -- Archon
  make_shields(400),  -- Zeratul), Mojo), Warbringer
  make_shields(450),  -- Assimilator), Citadel), Robotics Bay
  make_shields(500),  -- Gantrithor), Danimoth), Robotics), Gateway), Cybernetics), Archive), Fleet Beacon), Tribunal
  make_shields(550),  -- Forge
  make_shields(600),  -- Stargate
  make_shields(750),  -- Nexus
  make_shields(800)   -- Archon Hero
})
