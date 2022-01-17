local function make_recipe_raw(data)
  return {
    type = "recipe",
    ingredients = {},
    allow_as_intermediate = false,
    allow_decomposition = false,
    allow_inserter_overload = false,
    allow_intermediates = false,
    always_show_made_in = true,
    always_show_products = false,

    hidden = true,
    hide_from_stats = true,
    hide_from_player_crafting = true,

    show_amount_in_title = false,
    unlock_results = false,

    name = data.name,
    category = data.category,
    energy_required = data.energy_required,
    result = data.result,
    result_count = data.result_count,
  }
end

local function make_item_raw(data)
  return {
    name = data.result,
    type = "item",
    icon = "__base__/graphics/icons/fusion-reactor-equipment.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "starcraft-mechanics",
    stack_size = data.result_count,
    flags = {"hidden", "hide-from-bonus-gui"}
  }
end

local function make_recipe(name, sc_ticks, source, count)
  count = count or 1
  source = source or "none"

  local data = {
    name = "starcraft-make-" .. name,
    category = "starcraft-" .. source,

    -- ticks * 42ms/tick / 1000ms/s = seconds
    energy_required = sc_ticks * 42 / 1000,

    result = "starcraft-processitem-" .. name,
    result_count = count,
  }

  return table.unpack({make_item_raw(data), make_recipe_raw(data)})
end

data:extend({
  -- Terran Units
  make_recipe("scv", 300, "command-center"),

  make_recipe("marine", 360, "barracks"),
  make_recipe("ghost", 750, "barracks"),
  make_recipe("firebat", 360, "barracks"),
  make_recipe("medic", 450, "barracks"),

  make_recipe("vulture", 450, "factory"),
  make_recipe("goliath", 600, "factory"),
  make_recipe("tank", 750, "factory"),

  make_recipe("wraith", 900, "starport"),
  make_recipe("vessel", 1200, "starport"),
  make_recipe("dropship", 750, "starport"),
  make_recipe("bcruiser", 2000, "starport"),
  make_recipe("valkyrie", 750, "starport"),

  make_recipe("nuke", 1500, "nuke-silo"),

  -- Zerg Units
  make_recipe("drone", 300, "larva"),
  make_recipe("zergling", 420, "larva", 2),
  make_recipe("overlord", 600, "larva"),
  make_recipe("hydra", 420, "larva"),
  make_recipe("mutalisk", 600, "larva"),
  make_recipe("queen", 750, "larva"),
  make_recipe("ultralisk", 900, "larva"),
  make_recipe("defiler", 750, "larva"),
  make_recipe("scourge", 450, "larva", 2),

  make_recipe("guardian", 600, "mutalisk"),
  make_recipe("devourer", 600, "mutalisk"),
  make_recipe("lurker", 600, "hydra"),
  make_recipe("infested", 600, "infested-cc"),

  -- Protoss Units
  make_recipe("probe", 300, "nexus"),

  make_recipe("zealot", 600, "gateway"),
  make_recipe("dragoon", 750, "gateway"),
  make_recipe("templar", 750, "gateway"),
  make_recipe("dark-templar", 750, "gateway"),

  make_recipe("shuttle", 900, "robotics-facility"),
  make_recipe("reaver", 1050, "robotics-facility"),
  make_recipe("observer", 600, "robotics-facility"),

  make_recipe("scout", 1200, "stargate"),
  make_recipe("carrier", 2100, "stargate"),
  make_recipe("arbiter", 2400, "stargate"),
  make_recipe("corsair", 600, "stargate"),

  make_recipe("darchon", 300, "dark-templar"),
  make_recipe("archon", 300, "high-templar"),
  make_recipe("interceptor", 300, "carrier"),
  make_recipe("scarab", 105, "reaver"),

  -- Terran Structures
  make_recipe("command-center", 1800),
  make_recipe("depot", 600),
  make_recipe("refinery", 600),
  make_recipe("barracks", 1200),
  make_recipe("academy", 1200),
  make_recipe("factory", 1200),
  make_recipe("starport", 1050),
  make_recipe("science-facility", 900),
  make_recipe("engineering-bay", 900),
  make_recipe("armory", 1200),
  make_recipe("turret", 450),
  make_recipe("bunker", 450),

  make_recipe("comsat", 600, "command-center"),
  make_recipe("nuke-silo", 1200, "command-center"),
  make_recipe("control-tower", 600, "starport"),
  make_recipe("covert-ops", 600, "science-facility"),
  make_recipe("physics-lab", 600, "science-facility"),
  make_recipe("machine-shop", 600, "factory"),

  -- Zerg Structures
  make_recipe("hatchery", 1800),
  make_recipe("lair", 1500, "hatchery"),
  make_recipe("hive", 1800, "lair"),
  make_recipe("nydus", 600, "nydus"),
  make_recipe("hydra-den", 600),
  make_recipe("defiler-mound", 900),
  make_recipe("greater-spire", 1800, "spire"),
  make_recipe("queens-nest", 900),
  make_recipe("evo-chamber", 600),
  make_recipe("ultra-cavern", 1200),
  make_recipe("spire", 1800),
  make_recipe("spawning-pool", 1200),
  make_recipe("creep-colony", 300),
  make_recipe("spore-colony", 300, "creep-colony"),
  make_recipe("sunken-colony", 300, "creep-colony"),
  make_recipe("extractor", 600),

  -- Protoss Structures
  make_recipe("nexus", 1800),
  make_recipe("robotics-facility", 1200),
  make_recipe("pylon", 450),
  make_recipe("assimilator", 600),
  make_recipe("observatory", 450),
  make_recipe("gateway", 900),
  make_recipe("photon", 750),
  make_recipe("citadel", 900),
  make_recipe("cyber-core", 900),
  make_recipe("archives", 900),
  make_recipe("forge", 600),
  make_recipe("stargate", 1050),
  make_recipe("fleet-beacon", 900),
  make_recipe("arbiter-tribunal", 900),
  make_recipe("robotics-support-bay", 450),
  make_recipe("shield-battery", 450),
  make_recipe("pylon", 450),

  -- Terran Upgrades
  make_recipe("infantry-armor", 4000, "engineering-bay"),
  make_recipe("infantry-weapons", 4000, "engineering-bay"),
  make_recipe("vehicle-plating", 4000, "armory"),
  make_recipe("vehicle-weapons", 4000, "armory"),
  make_recipe("ship-plating", 4000, "armory"),
  make_recipe("ship-weapons", 4000, "armory"),

  make_recipe("u238-shells", 1500, "academy"),
  make_recipe("caduceus-reactor", 2500, "academy"),
  make_recipe("ion-thrusters", 1500, "machine-shop"),
  make_recipe("charon-boosters", 2000, "machine-shop"),
  make_recipe("titan-reactor", 2500, "science-facility"),
  make_recipe("ocular-implants", 2500, "covert-ops"),
  make_recipe("moebius-reactor", 2500, "covert-ops"),
  make_recipe("apollo-reactor", 2500, "control-tower"),
  make_recipe("colossus-reactor", 2500, "physics-lab"),

  -- Zerg Upgrades
  make_recipe("carapace", 4000, "evo-chamber"),
  make_recipe("melee-attacks", 4000, "evo-chamber"),
  make_recipe("missile-attacks", 4000, "evo-chamber"),
  make_recipe("flyer-carapace", 4000, "spire-upgrades"),
  make_recipe("flyer-attacks", 4000, "spire-upgrades"),

  make_recipe("ventral-sacs", 2400, "lair-upgrades"),
  make_recipe("antennae", 2000, "lair-upgrades"),
  make_recipe("pneumatized-carapace", 2000, "lair-upgrades"),
  make_recipe("metabolic-boost", 1500, "spawning-pool"),
  make_recipe("adrenal-glands", 1500, "spawning-pool"),
  make_recipe("muscular-augments", 1500, "hydra-den"),
  make_recipe("grooved-spines", 1500, "hydra-den"),
  make_recipe("gamete-meiosis", 2500, "queens-nest"),
  make_recipe("metasynaptic-node", 2500, "defiler-mound"),
  make_recipe("chitinous-plating", 2000, "ultra-cavern"),
  make_recipe("anabolic-synthesis", 2000, "ultra-cavern"),

  -- Protoss Upgrades
  make_recipe("protoss-armor", 4000, "forge"),
  make_recipe("protoss-ground-weapons", 4000, "forge"),
  make_recipe("plasma-shields", 4000, "forge"),
  make_recipe("protoss-plating", 4000, "cyber-core"),
  make_recipe("protoss-air-weapons", 4000, "cyber-core"),

  make_recipe("singularity-charge", 2500, "cyber-core"),
  make_recipe("leg-enhancements", 2000, "citadel"),
  make_recipe("scarab-damage", 2500, "robotics-support-bay"),
  make_recipe("reaver-capacity", 2500, "robotics-support-bay"),
  make_recipe("gravitic-drive", 2500, "robotics-support-bay"),
  make_recipe("sensor-array", 2000, "observatory"),
  make_recipe("gravitic-boosters", 2000, "observatory"),
  make_recipe("khaydarin-amulet", 2500, "archives"),
  make_recipe("argus-talisman", 2500, "archives"),
  make_recipe("apial-sensors", 2500, "fleet-beacon"),
  make_recipe("gravitic-thrusters", 2500, "fleet-beacon"),
  make_recipe("carrier-capacity", 2500, "fleet-beacon"),
  make_recipe("argus-jewel", 2500, "fleet-beacon"),
  make_recipe("khaydarin-core", 2500, "arbiter-tribunal"),

  -- Terran Technologies
  make_recipe("stim-packs", 1200, "academy"),
  make_recipe("restoration", 1200, "academy"),
  make_recipe("optical-flare", 1800, "academy"),
  make_recipe("lockdown", 1500, "covert-ops"),
  make_recipe("emp-shockwave", 1800, "science-facility"),
  make_recipe("irradiate", 1200, "science-facility"),
  make_recipe("spider-mines", 1200, "machine-shop"),
  make_recipe("siege-mode", 1200, "machine-shop"),
  make_recipe("yamato-gun", 1800, "physics-lab"),
  make_recipe("cloaking-field", 1500, "control-tower"),
  make_recipe("personnel-cloaking", 1200, "covert-ops"),

  -- Zerg Technologies
  make_recipe("burrowing", 1200, "hatchery-upgrades"),
  make_recipe("spawn-broodlings", 1200, "queens-nest"),
  make_recipe("ensnare", 1200, "queens-nest"),
  make_recipe("plague", 1500, "defiler-mound"),
  make_recipe("consume", 1500, "defiler-mound"),
  make_recipe("lurker-aspect", 1800, "hydra-den"),

  -- Protoss Technologies
  make_recipe("psionic-storm", 1800, "archives"),
  make_recipe("hallucination", 1200, "archives"),
  make_recipe("mind-control", 1800, "archives"),
  make_recipe("maelstrom", 1500, "archives"),
  make_recipe("recall", 1800, "arbiter-tribunal"),
  make_recipe("stasis", 1500, "arbiter-tribunal"),
  make_recipe("disruption-web", 1200, "fleet-beacon"),
})
