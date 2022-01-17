local table = require('__stdlib__/stdlib/utils/table')

IS_SCOUT_TYPE = {
    ["starcraft-scout"] = true,
    ["starcraft-artanis"] = true,
    ["starcraft-mojo"] = true
}

IS_BEACON_TYPE = {
    ["starcraft-terran-beacon"] = true,
    ["starcraft-protoss-beacon"] = true,
    ["starcraft-zerg-beacon"] = true,
    ["starcraft-terran-flag-beacon"] = true,
    ["starcraft-protoss-flag-beacon"] = true,
    ["starcraft-zerg-flag-beacon"] = true,
}

IS_ULTRALISK_TYPE = {
    ["starcraft-ultralisk"] = true,
    ["starcraft-torrasque"] = true,
}

IS_CARRIER_TYPE = {
    ["starcraft-carrier"] = true,
    ["starcraft-gantrithor"] = true,
}

IS_REAVER_TYPE = {
    ["starcraft-reaver"] = true,
    ["starcraft-warbringer"] = true,
}

IS_QUEEN_TYPE = {
    ["starcraft-queen"] = true,
    ["starcraft-matriarch"] = true,
}

IS_ARBITER_TYPE = {
    ["starcraft-arbiter"] = true,
    ["starcraft-danimoth"] = true,
}

IS_EGG_TYPE = {
    ["starcraft-egg"] = true,
    ["starcraft-cocoon"] = true,
    ["starcraft-lurker-egg"] = true,
}

IS_GHOST_TYPE = {
    ["starcraft-ghost"] = true,
    ["starcraft-kerrigan"] = true,
    ["starcraft-stukov"] = true,
    ["starcraft-duran"] = true,
    ["starcraft-infested-duran"] = true,
}

IS_MORPHING_BUILDING_TYPE = {
    ["starcraft-lair"] = true,
    ["starcraft-hive"] = true,
    ["starcraft-greater-spire"] = true,
    ["starcraft-spore-colony"] = true,
    ["starcraft-sunken-colony"] = true,
}

IS_HATCHERY_TYPE = {
    ["starcraft-hatchery"] = true,
    ["starcraft-lair"] = true,
    ["starcraft-hive"] = true,
}

IS_FACTORY_TYPE = {
    ["starcraft-command-center"] = true,
    ["starcraft-barracks"] = true,
    ["starcraft-factory"] = true,
    ["starcraft-starport"] = true,
    ["starcraft-infested-command-center"] = true,
    ["starcraft-hatchery"] = true,
    ["starcraft-lair"] = true,
    ["starcraft-hive"] = true,
    ["starcraft-gateway"] = true,
    ["starcraft-stargate"] = true,
    ["starcraft-nexus"] = true,
    ["starcraft-robotics-facility"] = true,
}

IS_REFINERY_TYPE = {
    ["starcraft-refinery"] = true,
    ["starcraft-extractor"] = true,
    ["starcraft-assimilator"] = true,
}

IS_VULTURE_TYPE = {
    ["starcraft-vulture"] = true,
    ["starcraft-raynor-vulture"] = true,
}

IS_FIGHTER_TYPE = {
    ["starcraft-interceptor"] = true,
    ["starcraft-scarab"] = true,
}

IS_TRAP_OR_DOOR_TYPE = {
    ["starcraft-floor-missile-trap"] = true,
    ["starcraft-floor-hatch"] = true,
    ["starcraft-left-upper-door"] = true,
    ["starcraft-right-upper-door"] = true,
    ["starcraft-left-pit-door"] = true,
    ["starcraft-right-pit-door"] = true,
    ["starcraft-floor-gun-trap"] = true,
    ["starcraft-left-wall-missile-trap"] = true,
    ["starcraft-left-wall-flame-trap"] = true,
    ["starcraft-right-wall-missile-trap"] = true,
    ["starcraft-right-wall-flame-trap"] = true,
}

IS_DOOR_TYPE = {
    ["starcraft-left-upper-door"] = true,
    ["starcraft-right-upper-door"] = true,
    ["starcraft-left-pit-door"] = true,
    ["starcraft-right-pit-door"] = true,
}

IS_GOLIATH_TYPE = {
    ["starcraft-goliath"] = true,
    ["starcraft-alan-schezar"] = true,
}

IS_GOLIATH_TURRET_TYPE = {
    ["starcraft-goliath-turret"] = true,
    ["starcraft-alan-schezar-turret"] = true,
}

IS_UNSIEGED_TANK_TYPE = {
    ["starcraft-tank"] = true,
    ["starcraft-duke"] = true,
}

IS_SIEGED_TANK_TYPE = {
    ["starcraft-sieged-tank"] = true,
    ["starcraft-duke-sieged"] = true,
}

IS_TANK_TYPE = {
    ["starcraft-tank"] = true,
    ["starcraft-duke"] = true,
    ["starcraft-sieged-tank"] = true,
    ["starcraft-duke-sieged"] = true,
}

IS_DEFILER_TYPE = {
    ["starcraft-defiler"] = true,
    ["starcraft-unclean-one"] = true,
}

IS_MARINE_TYPE = {
    ["starcraft-marine"] = true,
    ["starcraft-raynor-marine"] = true,
}

IS_FIREBAT_TYPE = {
    ["starcraft-firebat"] = true,
    ["starcraft-gui-montag"] = true,
}

IS_WRAITH_TYPE = {
    ["starcraft-wraith"] = true,
    ["starcraft-tom-kazansky"] = true,
}

IS_CRITTER_TYPE = {
    ["starcraft-rhynadon"] = true,
    ["starcraft-bengalaas"] = true,
    ["starcraft-ragnasaur"] = true,
    ["starcraft-scantid"] = true,
    ["starcraft-kakaru"] = true,
    ["starcraft-ursadon"] = true,
}

IS_ZERGLING_TYPE = {
    ["starcraft-zergling"] = true,
    ["starcraft-devouring-one"] = true,
}

IS_SCIENCE_VESSEL_TYPE = {
    ["starcraft-science-vessel"] = true,
    ["starcraft-magellan"] = true,
}

IS_BATTLECRUISER_TYPE = {
    ["starcraft-battle-cruiser"] = true,
    ["starcraft-mengsk"] = true,
    ["starcraft-hyperion"] = true,
    ["starcraft-norad2"] = true,
    ["starcraft-dugalle"] = true,
}

IS_BURROWABLE_TYPE = {
    ["starcraft-lurker"] = true,
    ["starcraft-drone"] = true,
    ["starcraft-infested-terran"] = true,
    ["starcraft-defiler"] = true,
    ["starcraft-zergling"] = true,
    ["starcraft-hydralisk"] = true,
    ["starcraft-unclean-one"] = true,
    ["starcraft-devouring-one"] = true,
    ["starcraft-hunter-killer"] = true,
}

IS_CORSAIR_TYPE = {
    ["starcraft-corsair"] = true,
    ["starcraft-raszagal"] = true,
}

IS_TOWER_TYPE = {
    ["starcraft-missile-turret"] = true,
    ["starcraft-cannon"] = true,
    ["starcraft-spore-colony"] = true,
    ["starcraft-sunken-colony"] = true,
}

IS_WORKER_TYPE = {
    ["starcraft-scv"] = true,
    ["starcraft-drone"] = true,
    ["starcraft-probe"] = true,
}

IS_RESOURCE_TYPE = {
    ["starcraft-mineral-field"] = true,
    ["starcraft-vespene-geyser"] = true,
    ["starcraft-refinery"] = true,
    ["starcraft-extractor"] = true,
    ["starcraft-assimilator"] = true,
}

IS_FLYING_BUILDING = {
    ["starcraft-command-center-lifted"] = true,
    ["starcraft-command-center"] = true,
    ["starcraft-infested-command-center-lifted"] = true,
    ["starcraft-infested-command-center"] = true,
    ["starcraft-barracks-lifted"] = true,
    ["starcraft-barracks"] = true,
    ["starcraft-factory-lifted"] = true,
    ["starcraft-factory"] = true,
    ["starcraft-starport-lifted"] = true,
    ["starcraft-starport"] = true,
    ["starcraft-science-facility-lifted"] = true,
    ["starcraft-science-facility"] = true,
}

CLOAK_ENERGY_COST = {
    ["starcraft-ghost"] = 10 / 256,
    ["starcraft-kerrigan"] = 10 / 256,
    ["starcraft-stukov"] = 10 / 256,
    ["starcraft-duran"] = 10 / 256,
    ["starcraft-infested-duran"] = 10 / 256,
    ["starcraft-infested-kerrigan"] = 10 / 256,
    ["starcraft-wraith"] = 13 / 256,
    ["starcraft-tom-kazansky"] = 13 / 256,
}

FLINGY_FULL = 0
FLINGY_PARTIAL = 1
FLINGY_ISCRIPT = 2

FLINGY_DATA = {
    ["starcraft-scourge"] = {
        flingy_type = FLINGY_FULL,
        top_speed = 1707,
        acceleration = 107,
        halt_distance = 13616,
        turn_radius = 40,
    },
    ["starcraft-broodling"] = {
        flingy_type = FLINGY_ISCRIPT,
        top_speed = 6 * 256,
        turn_radius = 40,
    },
    ["starcraft-infested-terran"] = {
        flingy_type = FLINGY_ISCRIPT,
        top_speed = 5.82 * 256,
        turn_radius = 40,
    },
    ["starcraft-defiler"] = {
        flingy_type = FLINGY_ISCRIPT,
        top_speed = 4 * 256,
        turn_radius = 27,
    },
    ["starcraft-drone"] = {
        flingy_type = FLINGY_FULL,
        top_speed = 1280,
        acceleration = 67,
        halt_distance = 12227,
        turn_radius = 40,
    },
    ["starcraft-guardian"] = {
        flingy_type = FLINGY_FULL,
        top_speed = 640,
        acceleration = 27,
        halt_distance = 7585,
        turn_radius = 20,
    },
    ["starcraft-hydralisk"] = {
        flingy_type = FLINGY_ISCRIPT,
        top_speed = 3.66 * 256,
        turn_radius = 27,
    },
    ["starcraft-larva"] = {
        flingy_type = FLINGY_ISCRIPT,
        top_speed = 2 * 256,
        turn_radius = 20,
    },
    ["starcraft-mutalisk"] = {
        flingy_type = FLINGY_FULL,
        top_speed = 1707,
        acceleration = 67,
        halt_distance = 21745,
        turn_radius = 40,
    },
    ["starcraft-overlord"] = {
        flingy_type = FLINGY_FULL,
        top_speed = 213,
        acceleration = 27,
        halt_distance = 840,
        turn_radius = 20,
    },
    ["starcraft-queen"] = {
        flingy_type = FLINGY_FULL,
        top_speed = 1707,
        acceleration = 67,
        halt_distance = 21745,
        turn_radius = 40,
    },
    ["starcraft-ultralisk"] = {
        flingy_type = FLINGY_ISCRIPT,
        top_speed = 5.12 * 256,
        turn_radius = 40,
    },
    ["starcraft-zergling"] = {
        flingy_type = FLINGY_ISCRIPT,
        top_speed = 5.49 * 256,
        turn_radius = 27,
    },
    ["starcraft-arbiter"] = {
        flingy_type = FLINGY_FULL,
        top_speed = 1280,
        acceleration = 33,
        halt_distance = 24824,
        turn_radius = 40,
    },
    ["starcraft-archon"] = {
        flingy_type = FLINGY_FULL,
        top_speed = 1280,
        acceleration = 160,
        halt_distance = 5120,
        turn_radius = 40,
    },
    ["starcraft-carrier"] = {
        flingy_type = FLINGY_FULL,
        top_speed = 853,
        acceleration = 27,
        halt_distance = 13474,
        turn_radius = 20,
    },
    ["starcraft-dragoon"] = {
        flingy_type = FLINGY_ISCRIPT,
        top_speed = 5 * 256,
        turn_radius = 40,
    },
    ["starcraft-interceptor"] = {
        flingy_type = FLINGY_FULL,
        top_speed = 3413,
        acceleration = 427,
        halt_distance = 13640,
        turn_radius = 40,
    },
    ["starcraft-probe"] = {
        flingy_type = FLINGY_FULL,
        top_speed = 1280,
        acceleration = 67,
        halt_distance = 12227,
        turn_radius = 40,
    },
    ["starcraft-scout"] = {
        flingy_type = FLINGY_FULL,
        top_speed = 1280,
        acceleration = 48,
        halt_distance = 17067,
        turn_radius = 30,
    },
    ["starcraft-shuttle"] = {
        flingy_type = FLINGY_FULL,
        top_speed = 1133,
        acceleration = 17,
        halt_distance = 37756,
        turn_radius = 20,
    },
    ["starcraft-high-templar"] = {
        flingy_type = FLINGY_PARTIAL,
        top_speed = 853,
        acceleration = 27,
        halt_distance = 13474,
        turn_radius = 40,
    },
    ["starcraft-reaver"] = {
        flingy_type = FLINGY_ISCRIPT,
        top_speed = 1.78 * 256,
        turn_radius = 20,
    },
    ["starcraft-scarab"] = {
        flingy_type = FLINGY_ISCRIPT,
        top_speed = 16 * 256,
        turn_radius = 27,
    },
    ["starcraft-zealot"] = {
        flingy_type = FLINGY_ISCRIPT,
        top_speed = 4 * 256,
        turn_radius = 40,
    },
    ["starcraft-observer"] = {
        flingy_type = FLINGY_FULL,
        top_speed = 853,
        acceleration = 27,
        halt_distance = 13474,
        turn_radius = 20,
    },
    ["starcraft-battlecruiser"] = {
        flingy_type = FLINGY_FULL,
        top_speed = 640,
        acceleration = 27,
        halt_distance = 7585,
        turn_radius = 20,
    },
    ["starcraft-civilian"] = {
        flingy_type = FLINGY_ISCRIPT,
        top_speed = 4 * 256,
        turn_radius = 40,
    },
    ["starcraft-dropship"] = {
        flingy_type = FLINGY_FULL,
        top_speed = 1400,
        acceleration = 17,
        halt_distance = 37756,
        turn_radius = 20,
    },
    ["starcraft-goliath"] = {
        flingy_type = FLINGY_ISCRIPT,
        top_speed = 4.57 * 256,
        turn_radius = 17,
    },
    ["starcraft-goliath-turret"] = {
        flingy_type = FLINGY_ISCRIPT,
        top_speed = 1,
        turn_radius = 17,
    },
    ["starcraft-wraith"] = {
        flingy_type = FLINGY_FULL,
        top_speed = 1707,
        acceleration = 67,
        halt_distance = 21745,
        turn_radius = 40,
    },
    ["starcraft-scv"] = {
        flingy_type = FLINGY_FULL,
        top_speed = 1280,
        acceleration = 67,
        halt_distance = 12227,
        turn_radius = 40,
    },
    ["starcraft-tank"] = {
        flingy_type = FLINGY_ISCRIPT,
        top_speed = 4 * 256,
        turn_radius = 13,
    },
    ["starcraft-tank-turret"] = {
        flingy_type = FLINGY_ISCRIPT,
        top_speed = 1,
        turn_radius = 13,
    },
    ["starcraft-sieged-tank"] = {
        flingy_type = FLINGY_ISCRIPT,
        top_speed = 1,
        turn_radius = 40,
    },
    ["starcraft-sieged-turret"] = {
        flingy_type = FLINGY_ISCRIPT,
        top_speed = 1,
        turn_radius = 13,
    },
    ["starcraft-vessel"] = {
        flingy_type = FLINGY_FULL,
        top_speed = 1280,
        acceleration = 50,
        halt_distance = 5120,
        turn_radius = 40,
    },
    ["starcraft-vessel-turret"] = {
        flingy_type = FLINGY_FULL,
        top_speed = 1,
        acceleration = 1,
        halt_distance = 1,
        turn_radius = 20,
    },
    ["starcraft-vulture"] = {
        flingy_type = FLINGY_FULL,
        top_speed = 1707,
        acceleration = 100,
        halt_distance = 14569,
        turn_radius = 40,
    },
    ["starcraft-spider-mine"] = {
        flingy_type = FLINGY_ISCRIPT,
        top_speed = 1,
        turn_radius = 127,
    },
    ["starcraft-nuke"] = {
        flingy_type = FLINGY_PARTIAL,
        top_speed = 8533,
        acceleration = 33,
        halt_distance = 1103213,
        turn_radius = 127,
    },
    ["starcraft-ragnasaur"] = {
        flingy_type = FLINGY_ISCRIPT,
        top_speed = 4 * 256,
        turn_radius = 27,
    },
    ["starcraft-devourer"] = {
        flingy_type = FLINGY_FULL,
        top_speed = 1280,
        acceleration = 48,
        halt_distance = 17067,
        turn_radius = 30,
    },
    ["starcraft-lurker"] = {
        flingy_type = FLINGY_ISCRIPT,
        top_speed = 5.82 * 256,
        turn_radius = 40,
    },
    ["starcraft-dark-templar"] = {
        flingy_type = FLINGY_ISCRIPT,
        top_speed = 4.92 * 256,
        turn_radius = 40,
    },
    ["starcraft-valkyrie"] = {
        flingy_type = FLINGY_FULL,
        top_speed = 1690,
        acceleration = 65,
        halt_distance = 21901,
        turn_radius = 30,
    },
    ["starcraft-corsair"] = {
        flingy_type = FLINGY_FULL,
        top_speed = 1707,
        acceleration = 67,
        halt_distance = 17067,
        turn_radius = 30,
    },
    ["starcraft-kakaru"] = {
        flingy_type = FLINGY_FULL,
        top_speed = 1280,
        acceleration = 16,
        halt_distance = 51200,
        turn_radius = 14,
    },
    ["starcraft-lifted-terran-structure"] = {
        flingy_type = FLINGY_PARTIAL,
        top_speed = 427,
        acceleration = 33,
        halt_distance = 2763,
        turn_radius = 27,
    },
}

FLINGY_DATA["starcraft-kerrigan"] = FLINGY_DATA["starcraft-civilian"]
FLINGY_DATA["starcraft-marine"] = FLINGY_DATA["starcraft-civilian"]
FLINGY_DATA["starcraft-medic"] = FLINGY_DATA["starcraft-civilian"]
FLINGY_DATA["starcraft-firebat"] = FLINGY_DATA["starcraft-civilian"]
FLINGY_DATA["starcraft-ghost"] = FLINGY_DATA["starcraft-civilian"]
FLINGY_DATA["starcraft-duran"] = FLINGY_DATA["starcraft-civilian"]
FLINGY_DATA["starcraft-stukov"] = FLINGY_DATA["starcraft-civilian"]
FLINGY_DATA["starcraft-gui-montag"] = FLINGY_DATA["starcraft-firebat"]
FLINGY_DATA["starcraft-alan-schezar"] = FLINGY_DATA["starcraft-goliath"]
FLINGY_DATA["starcraft-alan-schezar-turret"] = FLINGY_DATA["starcraft-goliath-turret"]
FLINGY_DATA["starcraft-raynor-vulture"] = FLINGY_DATA["starcraft-vulture"]
FLINGY_DATA["starcraft-raynor-marine"] = FLINGY_DATA["starcraft-marine"]
FLINGY_DATA["starcraft-tom-kazansky"] = FLINGY_DATA["starcraft-wraith"]
FLINGY_DATA["starcraft-magellan"] = FLINGY_DATA["starcraft-science-vessel"]
FLINGY_DATA["starcraft-duke"] = FLINGY_DATA["starcraft-tank"]
FLINGY_DATA["starcraft-duke-turret"] = FLINGY_DATA["starcraft-tank-turret"]
FLINGY_DATA["starcraft-duke-sieged"] = FLINGY_DATA["starcraft-sieged-tank"]
FLINGY_DATA["starcraft-duke-sieged-turret"] = FLINGY_DATA["starcraft-sieged-turret"]
FLINGY_DATA["starcraft-mengsk"] = FLINGY_DATA["starcraft-battlecruiser"]
FLINGY_DATA["starcraft-hyperion"] = FLINGY_DATA["starcraft-battlecruiser"]
FLINGY_DATA["starcraft-norad2"] = FLINGY_DATA["starcraft-battlecruiser"]
FLINGY_DATA["starcraft-dugalle"] = FLINGY_DATA["starcraft-battlecruiser"]

FLINGY_DATA["starcraft-infested-kerrigan"] = FLINGY_DATA["starcraft-civilian"]
FLINGY_DATA["starcraft-infested-duran"] = FLINGY_DATA["starcraft-civilian"]
FLINGY_DATA["starcraft-torrasque"] = FLINGY_DATA["starcraft-ultralisk"]
FLINGY_DATA["starcraft-matriarch"] = FLINGY_DATA["starcraft-queen"]
FLINGY_DATA["starcraft-unclean-one"] = FLINGY_DATA["starcraft-defiler"]
FLINGY_DATA["starcraft-hunter-killer"] = FLINGY_DATA["starcraft-hydralisk"]
FLINGY_DATA["starcraft-devouring-one"] = FLINGY_DATA["starcraft-zergling"]
FLINGY_DATA["starcraft-kukulza-mutalisk"] = FLINGY_DATA["starcraft-mutalisk"]
FLINGY_DATA["starcraft-kukulza-guardian"] = FLINGY_DATA["starcraft-guardian"]
FLINGY_DATA["starcraft-yggdrasill"] = FLINGY_DATA["starcraft-overlord"]

FLINGY_DATA["starcraft-dark-templar-hero"] = FLINGY_DATA["starcraft-dark-templar"]
FLINGY_DATA["starcraft-zeratul"] = FLINGY_DATA["starcraft-dark-templar"]
FLINGY_DATA["starcraft-tassadar-zeratul"] = FLINGY_DATA["starcraft-archon"]
FLINGY_DATA["starcraft-dark-archon"] = FLINGY_DATA["starcraft-archon"]
FLINGY_DATA["starcraft-fenix-zealot"] = FLINGY_DATA["starcraft-zealot"]
FLINGY_DATA["starcraft-fenix-dragoon"] = FLINGY_DATA["starcraft-dragoon"]
FLINGY_DATA["starcraft-tassadar"] = FLINGY_DATA["starcraft-high-templar"]
FLINGY_DATA["starcraft-aldaris"] = FLINGY_DATA["starcraft-high-templar"]
FLINGY_DATA["starcraft-mojo"] = FLINGY_DATA["starcraft-scout"]
FLINGY_DATA["starcraft-artanis"] = FLINGY_DATA["starcraft-scout"]
FLINGY_DATA["starcraft-warbringer"] = FLINGY_DATA["starcraft-reaver"]
FLINGY_DATA["starcraft-gantrithor"] = FLINGY_DATA["starcraft-carrier"]
FLINGY_DATA["starcraft-danimoth"] = FLINGY_DATA["starcraft-arbiter"]
FLINGY_DATA["starcraft-raszagal"] = FLINGY_DATA["starcraft-corsair"]

FLINGY_DATA["starcraft-rhynadon"] = FLINGY_DATA["starcraft-ragnasaur"]
FLINGY_DATA["starcraft-bengalaas"] = FLINGY_DATA["starcraft-ragnasaur"]
FLINGY_DATA["starcraft-scantid"] = FLINGY_DATA["starcraft-ragnasaur"]
FLINGY_DATA["starcraft-ursadon"] = FLINGY_DATA["starcraft-ragnasaur"]

FLINGY_DATA["starcraft-command-center-lifted"] = FLINGY_DATA["starcraft-lifted-terran-structure"]
FLINGY_DATA["starcraft-infested-command-center-lifted"] = FLINGY_DATA["starcraft-lifted-terran-structure"]
FLINGY_DATA["starcraft-barracks-lifted"] = FLINGY_DATA["starcraft-lifted-terran-structure"]
FLINGY_DATA["starcraft-factory-lifted"] = FLINGY_DATA["starcraft-lifted-terran-structure"]
FLINGY_DATA["starcraft-starport-lifted"] = FLINGY_DATA["starcraft-lifted-terran-structure"]
FLINGY_DATA["starcraft-science-facility-lifted"] = FLINGY_DATA["starcraft-lifted-terran-structure"]

-- Use a default elevation level of 4
-- Scanner = 18
-- DWeb and Swarm = 19
-- This should also determine render layer for factorio
UNIT_ELEVATION_LEVEL = {
    ["starcraft-wraith"] = 18,
    ["starcraft-tom-kazansky"] = 18,
    ["starcraft-science-vessel"] = 16,
    ["starcraft-magellan"] = 16,
    ["starcraft-dropship"] = 16,
    ["starcraft-battlecruiser"] = 16,
    ["starcraft-mengsk"] = 16,
    ["starcraft-hyperion"] = 16,
    ["starcraft-norad2"] = 16,
    ["starcraft-dugalle"] = 16,
    ["starcraft-nuke"] = 18,
    ["starcraft-larva"] = 2,
    ["starcraft-overlord"] = 16,
    ["starcraft-yggdrasill"] = 16,
    ["starcraft-mutalisk"] = 18,
    ["starcraft-kukulza-mutalisk"] = 18,
    ["starcraft-guardian"] = 18,
    ["starcraft-kukulza-guardian"] = 18,
    ["starcraft-queen"] = 18,
    ["starcraft-matriarch"] = 18,
    ["starcraft-scourge"] = 18,
    ["starcraft-valkyrie"] = 16,
    ["starcraft-cocoon"] = 18,
    ["starcraft-corsair"] = 18,
    ["starcraft-raszagal"] = 18,
    ["starcraft-devourer"] = 18,
    ["starcraft-shuttle"] = 18,
    ["starcraft-scout"] = 18,
    ["starcraft-mojo"] = 18,
    ["starcraft-artanis"] = 18,
    ["starcraft-arbiter"] = 16,
    ["starcraft-danimoth"] = 16,
    ["starcraft-carrier"] = 16,
    ["starcraft-gantrithor"] = 16,
    ["starcraft-interceptor"] = 18,
    ["starcraft-observer"] = 18,
    ["starcraft-kakaru"] = 18,

    ["starcraft-bunker"] = 3,
    ["starcraft-spawning-pool"] = 2,
    ["starcraft-zerg-beacon"] = 0,
    ["starcraft-terran-beacon"] = 0,
    ["starcraft-protoss-beacon"] = 0,
    ["starcraft-flag-zerg-beacon"] = 0,
    ["starcraft-flag-terran-beacon"] = 0,
    ["starcraft-flag-protoss-beacon"] = 0,
    ["starcraft-floor-hatch"] = 1,
}

IS_BUILDING = {
    ["starcraft-command-center"] = true,
    ["starcraft-comsat-station"] = true,
    ["starcraft-nuke-silo"] = true,
    ["starcraft-supply-depot"] = true,
    ["starcraft-refinery"] = true,
    ["starcraft-barracks"] = true,
    ["starcraft-academy"] = true,
    ["starcraft-factory"] = true,
    ["starcraft-starport"] = true,
    ["starcraft-control-tower"] = true,
    ["starcraft-science-facility"] = true,
    ["starcraft-covert-ops"] = true,
    ["starcraft-physics-lab"] = true,
    ["starcraft-machine-shop"] = true,
    ["starcraft-engineering-bay"] = true,
    ["starcraft-armory"] = true,
    ["starcraft-missile-turret"] = true,
    ["starcraft-bunker"] = true,
    ["starcraft-crashed-norad2"] = true,
    ["starcraft-ion-cannon"] = true,
    ["starcraft-infested-command-center"] = true,
    ["starcraft-hatchery"] = true,
    ["starcraft-lair"] = true,
    ["starcraft-hive"] = true,
    ["starcraft-nydus-canal"] = true,
    ["starcraft-hydra-den"] = true,
    ["starcraft-defiler-mound"] = true,
    ["starcraft-greater-spire"] = true,
    ["starcraft-queens-nest"] = true,
    ["starcraft-evo-chamber"] = true,
    ["starcraft-ultra-cavern"] = true,
    ["starcraft-spire"] = true,
    ["starcraft-spawning-pool"] = true,
    ["starcraft-creep-colony"] = true,
    ["starcraft-spore-colony"] = true,
    ["starcraft-sunken-colony"] = true,
    ["starcraft-overmind-2"] = true,
    ["starcraft-overmind"] = true,
    ["starcraft-extractor"] = true,
    ["starcraft-mature-chrysalis"] = true,
    ["starcraft-cerebrate"] = true,
    ["starcraft-daggoth"] = true,
    ["starcraft-nexus"] = true,
    ["starcraft-robotics-facility"] = true,
    ["starcraft-pylon"] = true,
    ["starcraft-assimilator"] = true,
    ["starcraft-observatory"] = true,
    ["starcraft-gateway"] = true,
    ["starcraft-cannon"] = true,
    ["starcraft-citadel"] = true,
    ["starcraft-cyber-core"] = true,
    ["starcraft-archives"] = true,
    ["starcraft-forge"] = true,
    ["starcraft-stargate"] = true,
    ["starcraft-stasis-cell"] = true,
    ["starcraft-fleet-beacon"] = true,
    ["starcraft-tribunal"] = true,
    ["starcraft-robotics-support-bay"] = true,
    ["starcraft-shield-battery"] = true,
    ["starcraft-khaydarin-crystal-formation"] = true,
    ["starcraft-khaydarin-crystal-formation"] = true,
    ["starcraft-protoss-temple"] = true,
    ["starcraft-xel-naga-temple"] = true,
    ["starcraft-warp-gate"] = true,
    ["starcraft-psi-disruptor"] = true,
}

IS_FLYER = {
    ["starcraft-wraith"] = true,
    ["starcraft-tom-kazansky"] = true,
    ["starcraft-science-vessel"] = true,
    ["starcraft-magellan"] = true,
    ["starcraft-dropship"] = true,
    ["starcraft-battlecruiser"] = true,
    ["starcraft-mengsk"] = true,
    ["starcraft-hyperion"] = true,
    ["starcraft-norad2"] = true,
    ["starcraft-dugalle"] = true,
    ["starcraft-nuke"] = true,
    ["starcraft-overlord"] = true,
    ["starcraft-yggdrasill"] = true,
    ["starcraft-mutalisk"] = true,
    ["starcraft-kukulza-mutalisk"] = true,
    ["starcraft-guardian"] = true,
    ["starcraft-kukulza-guardian"] = true,
    ["starcraft-queen"] = true,
    ["starcraft-matriarch"] = true,
    ["starcraft-scourge"] = true,
    ["starcraft-valkyrie"] = true,
    ["starcraft-cocoon"] = true,
    ["starcraft-corsair"] = true,
    ["starcraft-raszagal"] = true,
    ["starcraft-devourer"] = true,
    ["starcraft-shuttle"] = true,
    ["starcraft-scout"] = true,
    ["starcraft-mojo"] = true,
    ["starcraft-artanis"] = true,
    ["starcraft-arbiter"] = true,
    ["starcraft-danimoth"] = true,
    ["starcraft-carrier"] = true,
    ["starcraft-gantrithor"] = true,
    ["starcraft-interceptor"] = true,
    ["starcraft-observer"] = true,
    ["starcraft-kakaru"] = true,
}

CAN_MOVE = {
    ["starcraft-marine"] = true,
    ["starcraft-raynor-marine"] = true,
    ["starcraft-ghost"] = true,
    ["starcraft-kerrigan"] = true,
    ["starcraft-stukov"] = true,
    ["starcraft-duran"] = true,
    ["starcraft-infested-duran"] = true,
    ["starcraft-vulture"] = true,
    ["starcraft-raynor-vulture"] = true,
    ["starcraft-goliath"] = true,
    ["starcraft-alan-schezar"] = true,
    ["starcraft-tank"] = true,
    ["starcraft-duke"] = true,
    ["starcraft-scv"] = true,
    ["starcraft-wraith"] = true,
    ["starcraft-tom-kazansky"] = true,
    ["starcraft-firebat"] = true,
    ["starcraft-gui-montag"] = true,
    ["starcraft-science-vessel"] = true,
    ["starcraft-magellan"] = true,
    ["starcraft-dropship"] = true,
    ["starcraft-battlecruiser"] = true,
    ["starcraft-mengsk"] = true,
    ["starcraft-hyperion"] = true,
    ["starcraft-norad2"] = true,
    ["starcraft-dugalle"] = true,
    ["starcraft-spider-mine"] = true,
    ["starcraft-nuke"] = true,
    ["starcraft-civilian"] = true,
    ["starcraft-medic"] = true,
    ["starcraft-larva"] = true,
    ["starcraft-zergling"] = true,
    ["starcraft-devouring-one"] = true,
    ["starcraft-hydralisk"] = true,
    ["starcraft-hunter-killer"] = true,
    ["starcraft-ultralisk"] = true,
    ["starcraft-torrasque"] = true,
    ["starcraft-broodling"] = true,
    ["starcraft-drone"] = true,
    ["starcraft-defiler"] = true,
    ["starcraft-unclean-one"] = true,
    ["starcraft-overlord"] = true,
    ["starcraft-yggdrasill"] = true,
    ["starcraft-mutalisk"] = true,
    ["starcraft-kukulza-mutalisk"] = true,
    ["starcraft-guardian"] = true,
    ["starcraft-kukulza-guardian"] = true,
    ["starcraft-queen"] = true,
    ["starcraft-matriarch"] = true,
    ["starcraft-scourge"] = true,
    ["starcraft-valkyrie"] = true,
    ["starcraft-corsair"] = true,
    ["starcraft-raszagal"] = true,
    ["starcraft-dark-templar"] = true,
    ["starcraft-dark-templar-hero"] = true,
    ["starcraft-zeratul"] = true,
    ["starcraft-dark-dark-archon"] = true,
    ["starcraft-devourer"] = true,
    ["starcraft-probe"] = true,
    ["starcraft-zealot"] = true,
    ["starcraft-fenix-zealot"] = true,
    ["starcraft-dragoon"] = true,
    ["starcraft-fenix-dragoon"] = true,
    ["starcraft-high-templar"] = true,
    ["starcraft-tassadar"] = true,
    ["starcraft-aldaris"] = true,
    ["starcraft-archon"] = true,
    ["starcraft-tassadar-zeratul"] = true,
    ["starcraft-shuttle"] = true,
    ["starcraft-scout"] = true,
    ["starcraft-mojo"] = true,
    ["starcraft-artanis"] = true,
    ["starcraft-arbiter"] = true,
    ["starcraft-danimoth"] = true,
    ["starcraft-carrier"] = true,
    ["starcraft-gantrithor"] = true,
    ["starcraft-interceptor"] = true,
    ["starcraft-observer"] = true,
    ["starcraft-reaver"] = true,
    ["starcraft-warbringer"] = true,
    ["starcraft-scarab"] = true,
    ["starcraft-rhynadon"] = true,
    ["starcraft-bengalaas"] = true,
    ["starcraft-scantid"] = true,
    ["starcraft-kakaru"] = true,
    ["starcraft-ragnasaur"] = true,
    ["starcraft-ursadon"] = true,
    ["starcraft-lurker"] = true,
}

CAN_TURN = table.dictionary_merge(CAN_MOVE, {
    ["starcraft-goliath-turret"] = true,
    ["starcraft-alan-schezar-turret"] = true,
    ["starcraft-tank-turret"] = true,
    ["starcraft-sieged-turret"] = true,
    ["starcraft-duke-turret"] = true,
    ["starcraft-duke-sieged-turret"] = true,
    ["starcraft-missile-turret"] = true,
    ["starcraft-cannon"] = true,
    ["starcraft-spore-colony"] = true,
    ["starcraft-sunken-colony"] = true,
    ["starcraft-floor-missile-trap"] = true,
    ["starcraft-floor-gun-trap"] = true,
})

IS_SUBUNIT_TYPE = {
    ["starcraft-goliath-turret"] = true,
    ["starcraft-alan-schezar-turret"] = true,
    ["starcraft-tank-turret"] = true,
    ["starcraft-sieged-turret"] = true,
    ["starcraft-duke-turret"] = true,
    ["starcraft-duke-sieged-turret"] = true,
}
