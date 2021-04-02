-- TODO: repair_speed_modifier? Rate should be 0.9 * max_health / BuildTime instead of flat repair
-- TODO: dying_trigger_effect
-- TODO: damaged_trigger_effect

-- For shields, consider LuaEquipmentGrid with some fake equipment. Then EMP shockwave can be used against most non-Starcraft entities and use Factorio's builtin shield handling.
-- Problem is that shield handling may not correctly simulate starcraft damage mechanics where shields take full damage. Some mods also use different mechanisms for shields which are
-- inconsistent (such as Shield Generators and Turret Shields).

-- UnitSizeTypes and DamageTypes relationships are modeled as resistances. 
-- Armor is also modeled in resistances

unitsdat = {   -- Terran Marine
  {
    Flingy = 78,                      -- Marine
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 0,
    max_health = 40,
    resistances = {  -- Small Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 0 },
      { type = "explosion", percent = 50 },
      { type = "fire", percent = 0 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 50 },
      { type = "electric", percent = 0 }
    },
    Armor = 0,
    ArmorUpgrade = 0,                -- Terran Infantry Armor 
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 2,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 10,           -- Attack Unit (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 0,
    SightRange = 7,
    RightClickAction = 1,
    GroundWeapon = 0,                -- Gauss Rifle (Normal)
    GroundWeaponHits = 1,
    AirWeapon = 0,                   -- Gauss Rifle (Normal)
    AirWeaponHits = 1,
    FlagOrganic = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    UnitDimensions = {8, 9, 8, 10},
    MineralCost = 50,
    GasCost = 0,
    BuildTime = 360,                 -- 24.00 sec on Normal, 15.00 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 2,                  -- 1 supply in game
    CargoSize = 1,
    CargoSpace = 0
  }, -- Terran Ghost
  {
    Flingy = 74,                      -- Ghost
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 0,
    max_health = 45,
    resistances = {  -- Small Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 0 },
      { type = "explosion", percent = 50 },
      { type = "fire", percent = 0 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 50 },
      { type = "electric", percent = 0 }
    },
    Armor = 0,
    ArmorUpgrade = 0,                -- Terran Infantry Armor 
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 5,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 10,           -- Attack Unit (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 0,
    SightRange = 9,
    RightClickAction = 1,
    GroundWeapon = 2,                -- C-10 Concussion Rifle (Normal)
    GroundWeaponHits = 1,
    AirWeapon = 2,                   -- C-10 Concussion Rifle (Normal)
    AirWeaponHits = 1,
    FlagCloakable = true,
    FlagOrganic = true,
    FlagSpellcaster = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    UnitDimensions = {7, 10, 7, 11},
    MineralCost = 25,
    GasCost = 75,
    BuildTime = 750,                 -- 50.00 sec on Normal, 31.25 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 2,                  -- 1 supply in game
    CargoSize = 1,
    CargoSpace = 0
  }, -- Terran Vulture
  {
    Flingy = 88,                      -- Vulture
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 0,
    max_health = 80,
    resistances = {  -- Medium Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 50 },
      { type = "explosion", percent = 25 },
      { type = "fire", percent = 50 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 25 },
      { type = "electric", percent = 0 }
    },
    Armor = 0,
    ArmorUpgrade = 1,                -- Terran Vehicle Plating 
    ElevationLevel = 4,
    has_belt_immunity = true,
    Rank = 6,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 10,           -- Attack Unit (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 0,
    SightRange = 8,
    RightClickAction = 1,
    GroundWeapon = 4,                -- Fragmentation Grenade (Normal)
    GroundWeaponHits = 1,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    FlagMechanical = true,
    UnitDimensions = {16, 16, 15, 15},
    MineralCost = 75,
    GasCost = 0,
    BuildTime = 450,                 -- 30.00 sec on Normal, 18.75 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 4,                  -- 2 supply in game
    CargoSize = 2,
    CargoSpace = 0
  }, -- Terran Goliath
  {
    Flingy = 75,                      -- Goliath Base
    SubUnit = 4,                    -- Goliath Turret
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 0,
    max_health = 125,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 1,                -- Terran Vehicle Plating 
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 7,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 21,           -- Stay In Range
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 5,
    SightRange = 8,
    RightClickAction = 1,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    FlagMechanical = true,
    UnitDimensions = {16, 16, 15, 15},
    MineralCost = 100,
    GasCost = 50,
    BuildTime = 600,                 -- 40.00 sec on Normal, 25.00 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 4,                  -- 2 supply in game
    CargoSize = 2,
    CargoSpace = 0
  }, -- Goliath Turret
  {
    Flingy = 76,                      -- Goliath Turret
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 0,
    max_health = 0,
    resistances = {  -- Independent Size Type
      { type = "physical", percent = 99 },
      { type = "impact", percent = 99 },
      { type = "poison", percent = 99 },
      { type = "explosion", percent = 99 },
      { type = "fire", percent = 99 },
      { type = "laser", percent = 99 },
      { type = "acid", percent = 99 },
      { type = "electric", percent = 99 }
    },
    Armor = 0,
    ArmorUpgrade = 1,                -- Terran Vehicle Plating 
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 4,           -- Guard (Subunit)
    HumanAIIdleOrder = 4,          -- Guard (Subunit)
    ReturnToIdleOrder = 4,            -- Guard (Subunit)
    AttackUnitOrder = 22,           -- Attack (Subunit)
    AttackMoveOrder = 4,            -- Guard (Subunit)
    SeekRange = 0,
    SightRange = 8,
    RightClickAction = 1,
    GroundWeapon = 7,                -- Twin Autocannons (Normal)
    GroundWeaponHits = 1,
    AirWeapon = 8,                   -- Hellfire Missile Pack (Normal)
    AirWeaponHits = 1,
    FlagIsSubunit = true,
    FlagCanAttack = true,
    FlagInvincible = true,
    UnitDimensions = {1, 1, 1, 1},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Terran Siege Tank (Tank Mode)
  {
    Flingy = 82,                      -- Siege Tank (Tank) Base
    SubUnit = 6,                    -- Siege Tank Turret (Tank Mode)
    ConstructionAnimation = 0,
    SpawnDirection = 12,
    MaxShields = 0,
    max_health = 150,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 1,                -- Terran Vehicle Plating 
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 8,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 21,           -- Stay In Range
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 8,
    SightRange = 10,
    RightClickAction = 1,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagMediumOverlay = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    FlagMechanical = true,
    UnitDimensions = {16, 16, 15, 15},
    MineralCost = 150,
    GasCost = 100,
    BuildTime = 750,                 -- 50.00 sec on Normal, 31.25 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 4,                  -- 2 supply in game
    CargoSize = 4,
    CargoSpace = 0
  }, -- Siege Tank Turret (Tank Mode)
  {
    Flingy = 83,                      -- Siege Tank (Tank) Turret
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 12,
    MaxShields = 0,
    max_health = 0,
    resistances = {  -- Independent Size Type
      { type = "physical", percent = 99 },
      { type = "impact", percent = 99 },
      { type = "poison", percent = 99 },
      { type = "explosion", percent = 99 },
      { type = "fire", percent = 99 },
      { type = "laser", percent = 99 },
      { type = "acid", percent = 99 },
      { type = "electric", percent = 99 }
    },
    Armor = 0,
    ArmorUpgrade = 1,                -- Terran Vehicle Plating 
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 4,           -- Guard (Subunit)
    HumanAIIdleOrder = 4,          -- Guard (Subunit)
    ReturnToIdleOrder = 4,            -- Guard (Subunit)
    AttackUnitOrder = 22,           -- Attack (Subunit)
    AttackMoveOrder = 4,            -- Guard (Subunit)
    SeekRange = 8,
    SightRange = 10,
    RightClickAction = 1,
    GroundWeapon = 11,               -- Arclite Cannon (Normal)
    GroundWeaponHits = 1,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsSubunit = true,
    FlagCanAttack = true,
    FlagInvincible = true,
    UnitDimensions = {1, 1, 1, 1},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Terran SCV
  {
    Flingy = 81,                      -- SCV
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 0,
    max_health = 60,
    resistances = {  -- Small Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 0 },
      { type = "explosion", percent = 50 },
      { type = "fire", percent = 0 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 50 },
      { type = "electric", percent = 0 }
    },
    Armor = 0,
    ArmorUpgrade = 0,                -- Terran Infantry Armor 
    ElevationLevel = 4,
    has_belt_immunity = true,
    Rank = 1,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 10,           -- Attack Unit (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 1,
    SightRange = 7,
    RightClickAction = 5,
    GroundWeapon = 13,               -- Fusion Cutter
    GroundWeaponHits = 1,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsWorker = true,
    FlagOrganic = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    FlagMechanical = true,
    UnitDimensions = {11, 11, 11, 11},
    MineralCost = 50,
    GasCost = 0,
    BuildTime = 300,                 -- 20.00 sec on Normal, 12.50 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 2,                  -- 1 supply in game
    CargoSize = 1,
    CargoSpace = 0
  }, -- Terran Wraith
  {
    Flingy = 80,                      -- Wraith
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 0,
    max_health = 120,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 0,
    ArmorUpgrade = 2,                -- Terran Ship Plating 
    ElevationLevel = 18,
    has_belt_immunity = true,
    Rank = 10,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 10,           -- Attack Unit (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 0,
    SightRange = 7,
    RightClickAction = 1,
    GroundWeapon = 16,               -- Burst Lasers (Normal)
    GroundWeaponHits = 1,
    AirWeapon = 15,                  -- Gemini Missiles (Normal)
    AirWeaponHits = 1,
    FlagIsFlyer = true,
    FlagCloakable = true,
    FlagSpellcaster = true,
    FlagMediumOverlay = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    FlagMechanical = true,
    UnitDimensions = {19, 15, 18, 14},
    MineralCost = 150,
    GasCost = 100,
    BuildTime = 900,                 -- 60.00 sec on Normal, 37.50 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 4,                  -- 2 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Terran Science Vessel
  {
    Flingy = 86,                      -- Science Vessel (Base)
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 0,
    max_health = 200,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 2,                -- Terran Ship Plating 
    ElevationLevel = 16,
    has_belt_immunity = true,
    Rank = 11,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 10,           -- Attack Unit (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 0,
    SightRange = 10,
    RightClickAction = 2,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsFlyer = true,
    FlagAnimatedIdle = true,
    FlagDetector = true,
    FlagSpellcaster = true,
    FlagMediumOverlay = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    FlagMechanical = true,
    UnitDimensions = {32, 33, 32, 16},
    MineralCost = 100,
    GasCost = 225,
    BuildTime = 1200,                -- 80.00 sec on Normal, 50.00 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 4,                  -- 2 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Gui Montag (Firebat)
  {
    Flingy = 73,                      -- Firebat
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 0,
    max_health = 160,
    resistances = {  -- Small Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 0 },
      { type = "explosion", percent = 50 },
      { type = "fire", percent = 0 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 50 },
      { type = "electric", percent = 0 }
    },
    Armor = 3,
    ArmorUpgrade = 0,                -- Terran Infantry Armor 
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 12,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 10,           -- Attack Unit (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 3,
    SightRange = 7,
    RightClickAction = 1,
    GroundWeapon = 26,               -- Flame Thrower (Gui Montag)
    GroundWeaponHits = 3,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsHero = true,
    FlagOrganic = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    UnitDimensions = {11, 13, 11, 14},
    MineralCost = 100,
    GasCost = 50,
    BuildTime = 720,                 -- 48.00 sec on Normal, 30.00 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 1,
    CargoSpace = 0
  }, -- Terran Dropship
  {
    Flingy = 72,                      -- Dropship
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 0,
    max_health = 150,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 2,                -- Terran Ship Plating 
    ElevationLevel = 16,
    has_belt_immunity = true,
    Rank = 9,
    CompAIIdleOrder = 93,          -- Idle (Transport)
    HumanAIIdleOrder = 93,         -- Idle (Transport)
    ReturnToIdleOrder = 93,           -- Idle (Transport)
    AttackUnitOrder = 21,           -- Stay In Range
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 0,
    SightRange = 8,
    RightClickAction = 2,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsFlyer = true,
    FlagMediumOverlay = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    FlagMechanical = true,
    UnitDimensions = {24, 16, 24, 20},
    MineralCost = 100,
    GasCost = 100,
    BuildTime = 750,                 -- 50.00 sec on Normal, 31.25 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 4,                  -- 2 supply in game
    CargoSize = 255,
    CargoSpace = 8
  }, -- Terran Battlecruiser
  {
    Flingy = 70,                      -- Battlecruiser
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 0,
    max_health = 500,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 3,
    ArmorUpgrade = 2,                -- Terran Ship Plating 
    ElevationLevel = 16,
    has_belt_immunity = true,
    Rank = 15,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 10,           -- Attack Unit (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 0,
    SightRange = 11,
    RightClickAction = 1,
    GroundWeapon = 19,               -- ATS Laser Battery (Normal)
    GroundWeaponHits = 1,
    AirWeapon = 20,                  -- ATA Laser Battery (Normal)
    AirWeaponHits = 1,
    FlagIsFlyer = true,
    FlagSpellcaster = true,
    FlagLargeOverlay = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    FlagMechanical = true,
    UnitDimensions = {37, 29, 37, 29},
    MineralCost = 400,
    GasCost = 300,
    BuildTime = 2000,                -- 133.33 sec on Normal, 83.33 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 12,                 -- 6 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Spider Mine
  {
    Flingy = 89,                      -- Spider Mine
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 0,
    max_health = 20,
    resistances = {  -- Small Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 0 },
      { type = "explosion", percent = 50 },
      { type = "fire", percent = 0 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 50 },
      { type = "electric", percent = 0 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = true,
    Rank = 0,
    CompAIIdleOrder = 20,          -- Script (Spider Mine)
    HumanAIIdleOrder = 20,         -- Script (Spider Mine)
    ReturnToIdleOrder = 20,           -- Script (Spider Mine)
    AttackUnitOrder = 20,           -- Script (Spider Mine)
    AttackMoveOrder = 188,          -- Fatal
    SeekRange = 3,
    SightRange = 3,
    RightClickAction = 0,
    GroundWeapon = 6,                -- Spider Mines
    GroundWeaponHits = 1,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    UnitDimensions = {7, 7, 7, 7},
    MineralCost = 1,
    GasCost = 0,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Nuclear Missile
  {
    Flingy = 109,                     -- Nuclear Missile
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 0,
    max_health = 100,
    resistances = {  -- Independent Size Type
      { type = "physical", percent = 99 },
      { type = "impact", percent = 99 },
      { type = "poison", percent = 99 },
      { type = "explosion", percent = 99 },
      { type = "fire", percent = 99 },
      { type = "laser", percent = 99 },
      { type = "acid", percent = 99 },
      { type = "electric", percent = 99 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 18,
    has_belt_immunity = true,
    Rank = 0,
    CompAIIdleOrder = 23,          -- Nothing 2 (Normal)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 188,          -- Fatal
    AttackUnitOrder = 188,          -- Fatal
    AttackMoveOrder = 188,          -- Fatal
    SeekRange = 0,
    SightRange = 3,
    RightClickAction = 1,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsFlyer = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    FlagInvincible = true,
    UnitDimensions = {7, 14, 7, 14},
    MineralCost = 200,
    GasCost = 200,
    BuildTime = 1500,                -- 100.00 sec on Normal, 62.50 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 16,                 -- 8 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Terran Civilian
  {
    Flingy = 71,                      -- Civilian
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 0,
    max_health = 40,
    resistances = {  -- Small Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 0 },
      { type = "explosion", percent = 50 },
      { type = "fire", percent = 0 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 50 },
      { type = "electric", percent = 0 }
    },
    Armor = 0,
    ArmorUpgrade = 0,                -- Terran Infantry Armor 
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 21,           -- Stay In Range
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 0,
    SightRange = 7,
    RightClickAction = 2,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagOrganic = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    UnitDimensions = {8, 9, 8, 10},
    MineralCost = 0,
    GasCost = 0,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 1,
    CargoSpace = 0
  }, -- Sarah Kerrigan (Ghost)
  {
    Flingy = 77,                      -- Sarah Kerrigan
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 0,
    max_health = 250,
    resistances = {  -- Small Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 0 },
      { type = "explosion", percent = 50 },
      { type = "fire", percent = 0 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 50 },
      { type = "electric", percent = 0 }
    },
    Armor = 3,
    ArmorUpgrade = 0,                -- Terran Infantry Armor 
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 18,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 10,           -- Attack Unit (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 0,
    SightRange = 11,
    RightClickAction = 1,
    GroundWeapon = 3,                -- C-10 Concussion Rifle (Sarah Kerrigan)
    GroundWeaponHits = 1,
    AirWeapon = 3,                   -- C-10 Concussion Rifle (Sarah Kerrigan)
    AirWeaponHits = 1,
    FlagIsHero = true,
    FlagCloakable = true,
    FlagOrganic = true,
    FlagSpellcaster = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    UnitDimensions = {7, 10, 7, 11},
    MineralCost = 50,
    GasCost = 150,
    BuildTime = 1500,                -- 100.00 sec on Normal, 62.50 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 1,
    CargoSpace = 0
  }, -- Alan Schezar (Goliath)
  {
    Flingy = 75,                      -- Goliath Base
    SubUnit = 18,                   -- Alan Schezar Turret
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 0,
    max_health = 300,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 3,
    ArmorUpgrade = 1,                -- Terran Vehicle Plating 
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 13,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 21,           -- Stay In Range
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 5,
    SightRange = 8,
    RightClickAction = 1,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsHero = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    FlagMechanical = true,
    UnitDimensions = {16, 16, 15, 15},
    MineralCost = 200,
    GasCost = 100,
    BuildTime = 1200,                -- 80.00 sec on Normal, 50.00 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 2,
    CargoSpace = 0
  }, -- Alan Schezar Turret
  {
    Flingy = 76,                      -- Goliath Turret
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 0,
    max_health = 0,
    resistances = {  -- Independent Size Type
      { type = "physical", percent = 99 },
      { type = "impact", percent = 99 },
      { type = "poison", percent = 99 },
      { type = "explosion", percent = 99 },
      { type = "fire", percent = 99 },
      { type = "laser", percent = 99 },
      { type = "acid", percent = 99 },
      { type = "electric", percent = 99 }
    },
    Armor = 0,
    ArmorUpgrade = 1,                -- Terran Vehicle Plating 
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 4,           -- Guard (Subunit)
    HumanAIIdleOrder = 4,          -- Guard (Subunit)
    ReturnToIdleOrder = 4,            -- Guard (Subunit)
    AttackUnitOrder = 22,           -- Attack (Subunit)
    AttackMoveOrder = 4,            -- Guard (Subunit)
    SeekRange = 0,
    SightRange = 8,
    RightClickAction = 1,
    GroundWeapon = 9,                -- Twin Autocannons (Alan Schezar)
    GroundWeaponHits = 1,
    AirWeapon = 10,                  -- Hellfire Missile Pack (Alan Schezar)
    AirWeaponHits = 1,
    FlagIsSubunit = true,
    FlagCanAttack = true,
    FlagInvincible = true,
    UnitDimensions = {1, 1, 1, 1},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Jim Raynor (Vulture)
  {
    Flingy = 88,                      -- Vulture
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 0,
    max_health = 300,
    resistances = {  -- Medium Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 50 },
      { type = "explosion", percent = 25 },
      { type = "fire", percent = 50 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 25 },
      { type = "electric", percent = 0 }
    },
    Armor = 3,
    ArmorUpgrade = 1,                -- Terran Vehicle Plating 
    ElevationLevel = 4,
    has_belt_immunity = true,
    Rank = 17,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 10,           -- Attack Unit (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 0,
    SightRange = 8,
    RightClickAction = 1,
    GroundWeapon = 5,                -- Fragmentation Grenade (Jim Raynor-Vulture)
    GroundWeaponHits = 1,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsHero = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    FlagMechanical = true,
    UnitDimensions = {16, 16, 15, 15},
    MineralCost = 150,
    GasCost = 0,
    BuildTime = 900,                 -- 60.00 sec on Normal, 37.50 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 2,
    CargoSpace = 0
  }, -- Jim Raynor (Marine)
  {
    Flingy = 78,                      -- Marine
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 0,
    max_health = 200,
    resistances = {  -- Small Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 0 },
      { type = "explosion", percent = 50 },
      { type = "fire", percent = 0 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 50 },
      { type = "electric", percent = 0 }
    },
    Armor = 3,
    ArmorUpgrade = 0,                -- Terran Infantry Armor 
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 17,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 10,           -- Attack Unit (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 0,
    SightRange = 7,
    RightClickAction = 1,
    GroundWeapon = 1,                -- Gauss Rifle (Jim Raynor-Marine)
    GroundWeaponHits = 1,
    AirWeapon = 1,                   -- Gauss Rifle (Jim Raynor-Marine)
    AirWeaponHits = 1,
    FlagIsHero = true,
    FlagOrganic = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    UnitDimensions = {8, 9, 8, 10},
    MineralCost = 50,
    GasCost = 0,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 1,
    CargoSpace = 0
  }, -- Tom Kazansky (Wraith)
  {
    Flingy = 80,                      -- Wraith
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 0,
    max_health = 500,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 4,
    ArmorUpgrade = 2,                -- Terran Ship Plating 
    ElevationLevel = 18,
    has_belt_immunity = true,
    Rank = 14,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 10,           -- Attack Unit (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 0,
    SightRange = 7,
    RightClickAction = 1,
    GroundWeapon = 18,               -- Burst Lasers (Tom Kazansky)
    GroundWeaponHits = 1,
    AirWeapon = 17,                  -- Gemini Missiles (Tom Kazansky)
    AirWeaponHits = 1,
    FlagIsFlyer = true,
    FlagIsHero = true,
    FlagCloakable = true,
    FlagSpellcaster = true,
    FlagMediumOverlay = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    FlagMechanical = true,
    UnitDimensions = {19, 15, 18, 14},
    MineralCost = 400,
    GasCost = 200,
    BuildTime = 1800,                -- 120.00 sec on Normal, 75.00 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Magellan (Science Vessel)
  {
    Flingy = 86,                      -- Science Vessel (Base)
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 0,
    max_health = 800,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 4,
    ArmorUpgrade = 2,                -- Terran Ship Plating 
    ElevationLevel = 16,
    has_belt_immunity = true,
    Rank = 15,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 10,           -- Attack Unit (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 0,
    SightRange = 10,
    RightClickAction = 2,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsFlyer = true,
    FlagIsHero = true,
    FlagAnimatedIdle = true,
    FlagDetector = true,
    FlagSpellcaster = true,
    FlagMediumOverlay = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    FlagMechanical = true,
    UnitDimensions = {32, 33, 32, 16},
    MineralCost = 50,
    GasCost = 600,
    BuildTime = 2400,                -- 160.00 sec on Normal, 100.00 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Edmund Duke (Tank Mode)
  {
    Flingy = 82,                      -- Siege Tank (Tank) Base
    SubUnit = 24,                   -- Edmund Duke Turret (Tank Mode)
    ConstructionAnimation = 0,
    SpawnDirection = 12,
    MaxShields = 0,
    max_health = 400,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 3,
    ArmorUpgrade = 1,                -- Terran Vehicle Plating 
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 19,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 21,           -- Stay In Range
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 8,
    SightRange = 10,
    RightClickAction = 1,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsHero = true,
    FlagMediumOverlay = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    FlagMechanical = true,
    UnitDimensions = {16, 16, 15, 15},
    MineralCost = 300,
    GasCost = 200,
    BuildTime = 1500,                -- 100.00 sec on Normal, 62.50 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 4,
    CargoSpace = 0
  }, -- Edmund Duke Turret (Tank Mode)
  {
    Flingy = 83,                      -- Siege Tank (Tank) Turret
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 12,
    MaxShields = 0,
    max_health = 0,
    resistances = {  -- Independent Size Type
      { type = "physical", percent = 99 },
      { type = "impact", percent = 99 },
      { type = "poison", percent = 99 },
      { type = "explosion", percent = 99 },
      { type = "fire", percent = 99 },
      { type = "laser", percent = 99 },
      { type = "acid", percent = 99 },
      { type = "electric", percent = 99 }
    },
    Armor = 0,
    ArmorUpgrade = 1,                -- Terran Vehicle Plating 
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 4,           -- Guard (Subunit)
    HumanAIIdleOrder = 4,          -- Guard (Subunit)
    ReturnToIdleOrder = 4,            -- Guard (Subunit)
    AttackUnitOrder = 22,           -- Attack (Subunit)
    AttackMoveOrder = 4,            -- Guard (Subunit)
    SeekRange = 0,
    SightRange = 10,
    RightClickAction = 1,
    GroundWeapon = 12,               -- Arclite Cannon (Edmund Duke)
    GroundWeaponHits = 1,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsSubunit = true,
    FlagCanAttack = true,
    FlagInvincible = true,
    UnitDimensions = {1, 1, 1, 1},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Edmund Duke (Siege Mode)
  {
    Flingy = 84,                      -- Siege Tank (Siege) Base
    SubUnit = 26,                   -- Edmund Duke Turret (Siege Mode)
    ConstructionAnimation = 0,
    SpawnDirection = 12,
    MaxShields = 0,
    max_health = 400,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 3,
    ArmorUpgrade = 1,                -- Terran Vehicle Plating 
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 19,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 100,          -- Watch Target
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 0,
    SightRange = 10,
    RightClickAction = 3,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsHero = true,
    FlagMediumOverlay = true,
    FlagMechanical = true,
    UnitDimensions = {16, 16, 15, 15},
    MineralCost = 300,
    GasCost = 200,
    BuildTime = 1500,                -- 100.00 sec on Normal, 62.50 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Edmund Duke Turret (Siege Mode)
  {
    Flingy = 85,                      -- Siege Tank (Siege) Turret
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 28,
    MaxShields = 0,
    max_health = 0,
    resistances = {  -- Independent Size Type
      { type = "physical", percent = 99 },
      { type = "impact", percent = 99 },
      { type = "poison", percent = 99 },
      { type = "explosion", percent = 99 },
      { type = "fire", percent = 99 },
      { type = "laser", percent = 99 },
      { type = "acid", percent = 99 },
      { type = "electric", percent = 99 }
    },
    Armor = 0,
    ArmorUpgrade = 1,                -- Terran Vehicle Plating 
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 4,           -- Guard (Subunit)
    HumanAIIdleOrder = 4,          -- Guard (Subunit)
    ReturnToIdleOrder = 4,            -- Guard (Subunit)
    AttackUnitOrder = 22,           -- Attack (Subunit)
    AttackMoveOrder = 4,            -- Guard (Subunit)
    SeekRange = 12,
    SightRange = 10,
    RightClickAction = 1,
    GroundWeapon = 28,               -- Arclite Shock Cannon (Edmund Duke)
    GroundWeaponHits = 1,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsSubunit = true,
    FlagCanAttack = true,
    FlagInvincible = true,
    UnitDimensions = {1, 1, 1, 1},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Arcturus Mengsk (Battlecruiser)
  {
    Flingy = 70,                      -- Battlecruiser
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 0,
    max_health = 1000,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 4,
    ArmorUpgrade = 2,                -- Terran Ship Plating 
    ElevationLevel = 16,
    has_belt_immunity = true,
    Rank = 21,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 10,           -- Attack Unit (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 0,
    SightRange = 8,
    RightClickAction = 1,
    GroundWeapon = 21,               -- ATS Laser Battery (Norad II+Mengsk+DuGalle)
    GroundWeaponHits = 1,
    AirWeapon = 22,                  -- ATA Laser Battery (Norad II+Mengsk+DuGalle)
    AirWeaponHits = 1,
    FlagIsFlyer = true,
    FlagIsHero = true,
    FlagSpellcaster = true,
    FlagLargeOverlay = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    FlagMechanical = true,
    UnitDimensions = {37, 29, 37, 29},
    MineralCost = 800,
    GasCost = 600,
    BuildTime = 4800,                -- 320.00 sec on Normal, 200.00 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Hyperion (Battlecruiser)
  {
    Flingy = 70,                      -- Battlecruiser
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 0,
    max_health = 850,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 4,
    ArmorUpgrade = 2,                -- Terran Ship Plating 
    ElevationLevel = 16,
    has_belt_immunity = true,
    Rank = 20,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 10,           -- Attack Unit (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 0,
    SightRange = 11,
    RightClickAction = 1,
    GroundWeapon = 23,               -- ATS Laser Battery (Hyperion)
    GroundWeaponHits = 1,
    AirWeapon = 24,                  -- ATA Laser Battery (Hyperion)
    AirWeaponHits = 1,
    FlagIsFlyer = true,
    FlagIsHero = true,
    FlagSpellcaster = true,
    FlagLargeOverlay = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    FlagMechanical = true,
    UnitDimensions = {37, 29, 37, 29},
    MineralCost = 800,
    GasCost = 600,
    BuildTime = 2400,                -- 160.00 sec on Normal, 100.00 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Norad II (Battlecruiser)
  {
    Flingy = 70,                      -- Battlecruiser
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 0,
    max_health = 700,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 4,
    ArmorUpgrade = 2,                -- Terran Ship Plating 
    ElevationLevel = 16,
    has_belt_immunity = true,
    Rank = 21,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 10,           -- Attack Unit (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 0,
    SightRange = 11,
    RightClickAction = 1,
    GroundWeapon = 21,               -- ATS Laser Battery (Norad II+Mengsk+DuGalle)
    GroundWeaponHits = 1,
    AirWeapon = 22,                  -- ATA Laser Battery (Norad II+Mengsk+DuGalle)
    AirWeaponHits = 1,
    FlagIsFlyer = true,
    FlagIsHero = true,
    FlagSpellcaster = true,
    FlagLargeOverlay = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    FlagMechanical = true,
    UnitDimensions = {37, 29, 37, 29},
    MineralCost = 800,
    GasCost = 600,
    BuildTime = 4800,                -- 320.00 sec on Normal, 200.00 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Terran Siege Tank (Siege Mode)
  {
    Flingy = 84,                      -- Siege Tank (Siege) Base
    SubUnit = 31,                   -- Siege Tank Turret (Siege Mode)
    ConstructionAnimation = 0,
    SpawnDirection = 12,
    MaxShields = 0,
    max_health = 150,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 1,                -- Terran Vehicle Plating 
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 8,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 100,          -- Watch Target
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 0,
    SightRange = 10,
    RightClickAction = 3,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagMediumOverlay = true,
    FlagMechanical = true,
    UnitDimensions = {16, 16, 15, 15},
    MineralCost = 150,
    GasCost = 100,
    BuildTime = 750,                 -- 50.00 sec on Normal, 31.25 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 4,                  -- 2 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Siege Tank Turret (Siege Mode)
  {
    Flingy = 85,                      -- Siege Tank (Siege) Turret
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 28,
    MaxShields = 0,
    max_health = 0,
    resistances = {  -- Independent Size Type
      { type = "physical", percent = 99 },
      { type = "impact", percent = 99 },
      { type = "poison", percent = 99 },
      { type = "explosion", percent = 99 },
      { type = "fire", percent = 99 },
      { type = "laser", percent = 99 },
      { type = "acid", percent = 99 },
      { type = "electric", percent = 99 }
    },
    Armor = 0,
    ArmorUpgrade = 1,                -- Terran Vehicle Plating 
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 4,           -- Guard (Subunit)
    HumanAIIdleOrder = 4,          -- Guard (Subunit)
    ReturnToIdleOrder = 4,            -- Guard (Subunit)
    AttackUnitOrder = 22,           -- Attack (Subunit)
    AttackMoveOrder = 4,            -- Guard (Subunit)
    SeekRange = 12,
    SightRange = 10,
    RightClickAction = 1,
    GroundWeapon = 27,               -- Arclite Shock Cannon (Normal)
    GroundWeaponHits = 1,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsSubunit = true,
    FlagCanAttack = true,
    FlagInvincible = true,
    UnitDimensions = {1, 1, 1, 1},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Terran Firebat
  {
    Flingy = 73,                      -- Firebat
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 0,
    max_health = 50,
    resistances = {  -- Small Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 0 },
      { type = "explosion", percent = 50 },
      { type = "fire", percent = 0 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 50 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 0,                -- Terran Infantry Armor 
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 4,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 10,           -- Attack Unit (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 3,
    SightRange = 7,
    RightClickAction = 1,
    GroundWeapon = 25,               -- Flame Thrower (Normal)
    GroundWeaponHits = 3,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagOrganic = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    UnitDimensions = {11, 7, 11, 14},
    MineralCost = 50,
    GasCost = 25,
    BuildTime = 360,                 -- 24.00 sec on Normal, 15.00 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 2,                  -- 1 supply in game
    CargoSize = 1,
    CargoSpace = 0
  }, -- Scanner Sweep
  {
    Flingy = 79,                      -- Scanner Sweep
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 0,
    max_health = 0,
    resistances = {  -- Independent Size Type
      { type = "physical", percent = 99 },
      { type = "impact", percent = 99 },
      { type = "poison", percent = 99 },
      { type = "explosion", percent = 99 },
      { type = "fire", percent = 99 },
      { type = "laser", percent = 99 },
      { type = "acid", percent = 99 },
      { type = "electric", percent = 99 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 18,
    has_belt_immunity = true,
    Rank = 0,
    CompAIIdleOrder = 140,         -- Idle (Scanner Sweep)
    HumanAIIdleOrder = 140,        -- Idle (Scanner Sweep)
    ReturnToIdleOrder = 140,          -- Idle (Scanner Sweep)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 10,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsFlyer = true,
    FlagDetector = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    UnitDimensions = {13, 13, 13, 17},
    MineralCost = 0,
    GasCost = 0,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Terran Medic
  {
    Flingy = 189,                     -- Medic
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 0,
    max_health = 60,
    resistances = {  -- Small Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 0 },
      { type = "explosion", percent = 50 },
      { type = "fire", percent = 0 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 50 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 0,                -- Terran Infantry Armor 
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 3,
    CompAIIdleOrder = 175,         -- Idle (Medic)
    HumanAIIdleOrder = 175,        -- Idle (Medic)
    ReturnToIdleOrder = 175,          -- Idle (Medic)
    AttackUnitOrder = 175,          -- Idle (Medic)
    AttackMoveOrder = 175,          -- Idle (Medic)
    SeekRange = 9,
    SightRange = 9,
    RightClickAction = 2,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagOrganic = true,
    FlagSpellcaster = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    UnitDimensions = {8, 9, 8, 10},
    MineralCost = 50,
    GasCost = 25,
    BuildTime = 450,                 -- 30.00 sec on Normal, 18.75 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 2,                  -- 1 supply in game
    CargoSize = 1,
    CargoSpace = 0
  }, -- Zerg Larva
  {
    Flingy = 10,                      -- Larva
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 0,
    max_health = 25,
    resistances = {  -- Small Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 0 },
      { type = "explosion", percent = 50 },
      { type = "fire", percent = 0 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 50 },
      { type = "electric", percent = 0 }
    },
    Armor = 10,
    ArmorUpgrade = 3,                -- Zerg Carapace 
    ElevationLevel = 2,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 77,         -- Idle (Larva)
    ReturnToIdleOrder = 77,           -- Idle (Larva)
    AttackUnitOrder = 188,          -- Fatal
    AttackMoveOrder = 188,          -- Fatal
    SeekRange = 0,
    SightRange = 4,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    healing_per_tick = 0.0062,   -- Zerg Health Regen
    FlagOrganic = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    UnitDimensions = {8, 8, 7, 7},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 0, -- Zerg
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Zerg Egg
  {
    Flingy = 6,                       -- Egg
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 0,
    max_health = 200,
    resistances = {  -- Medium Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 50 },
      { type = "explosion", percent = 25 },
      { type = "fire", percent = 50 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 25 },
      { type = "electric", percent = 0 }
    },
    Armor = 10,
    ArmorUpgrade = 3,                -- Zerg Carapace 
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 1,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 2,            -- Guard (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 0,
    SightRange = 4,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagOrganic = true,
    UnitDimensions = {16, 16, 15, 15},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 0, -- Zerg
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Zerg Zergling
  {
    Flingy = 15,                      -- Zergling
    SubUnit = 228,                  -- None
    ConstructionAnimation = 56,
    SpawnDirection = 10,
    MaxShields = 0,
    max_health = 35,
    resistances = {  -- Small Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 0 },
      { type = "explosion", percent = 50 },
      { type = "fire", percent = 0 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 50 },
      { type = "electric", percent = 0 }
    },
    Armor = 0,
    ArmorUpgrade = 3,                -- Zerg Carapace 
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 5,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 10,           -- Attack Unit (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 3,
    SightRange = 5,
    RightClickAction = 1,
    GroundWeapon = 35,               -- Claws (Normal)
    GroundWeaponHits = 1,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    healing_per_tick = 0.0062,   -- Zerg Health Regen
    FlagTwoUnitsIn1Egg = true,
    FlagOrganic = true,
    FlagBurrowable = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    UnitDimensions = {8, 4, 7, 11},
    MineralCost = 50,
    GasCost = 0,
    BuildTime = 420,                 -- 28.00 sec on Normal, 17.50 sec on Fastest
    Race = 0, -- Zerg
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 1,                  -- 0.5 supply in game
    CargoSize = 1,
    CargoSpace = 0
  }, -- Zerg Hydralisk
  {
    Flingy = 8,                       -- Hydralisk
    SubUnit = 228,                  -- None
    ConstructionAnimation = 31,
    SpawnDirection = 12,
    MaxShields = 0,
    max_health = 80,
    resistances = {  -- Medium Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 50 },
      { type = "explosion", percent = 25 },
      { type = "fire", percent = 50 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 25 },
      { type = "electric", percent = 0 }
    },
    Armor = 0,
    ArmorUpgrade = 3,                -- Zerg Carapace 
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 9,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 10,           -- Attack Unit (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 0,
    SightRange = 6,
    RightClickAction = 1,
    GroundWeapon = 38,               -- Needle Spines (Normal)
    GroundWeaponHits = 1,
    AirWeapon = 38,                  -- Needle Spines (Normal)
    AirWeaponHits = 1,
    healing_per_tick = 0.0062,   -- Zerg Health Regen
    FlagOrganic = true,
    FlagBurrowable = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    UnitDimensions = {10, 10, 10, 12},
    MineralCost = 75,
    GasCost = 25,
    BuildTime = 420,                 -- 28.00 sec on Normal, 17.50 sec on Fastest
    Race = 0, -- Zerg
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 2,                  -- 1 supply in game
    CargoSize = 2,
    CargoSpace = 0
  }, -- Zerg Ultralisk
  {
    Flingy = 14,                      -- Ultralisk
    SubUnit = 228,                  -- None
    ConstructionAnimation = 52,
    SpawnDirection = 14,
    MaxShields = 0,
    max_health = 400,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 3,                -- Zerg Carapace 
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 14,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 10,           -- Attack Unit (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 3,
    SightRange = 7,
    RightClickAction = 1,
    GroundWeapon = 40,               -- Kaiser Blades (Normal)
    GroundWeaponHits = 1,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    healing_per_tick = 0.0062,   -- Zerg Health Regen
    FlagOrganic = true,
    FlagLargeOverlay = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    UnitDimensions = {19, 16, 18, 15},
    MineralCost = 200,
    GasCost = 200,
    BuildTime = 900,                 -- 60.00 sec on Normal, 37.50 sec on Fastest
    Race = 0, -- Zerg
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 8,                  -- 4 supply in game
    CargoSize = 4,
    CargoSpace = 0
  }, -- Zerg Broodling
  {
    Flingy = 1,                       -- Broodling
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 0,
    max_health = 30,
    resistances = {  -- Small Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 0 },
      { type = "explosion", percent = 50 },
      { type = "fire", percent = 0 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 50 },
      { type = "electric", percent = 0 }
    },
    Armor = 0,
    ArmorUpgrade = 3,                -- Zerg Carapace 
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 3,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 10,           -- Attack Unit (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 3,
    SightRange = 5,
    RightClickAction = 1,
    GroundWeapon = 42,               -- Toxic Spores (Broodling)
    GroundWeaponHits = 1,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    healing_per_tick = 0.0062,   -- Zerg Health Regen
    FlagOrganic = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    UnitDimensions = {9, 9, 9, 9},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 0, -- Zerg
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 1,
    CargoSpace = 0
  }, -- Zerg Drone
  {
    Flingy = 5,                       -- Drone
    SubUnit = 228,                  -- None
    ConstructionAnimation = 19,
    SpawnDirection = 13,
    MaxShields = 0,
    max_health = 40,
    resistances = {  -- Small Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 0 },
      { type = "explosion", percent = 50 },
      { type = "fire", percent = 0 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 50 },
      { type = "electric", percent = 0 }
    },
    Armor = 0,
    ArmorUpgrade = 3,                -- Zerg Carapace 
    ElevationLevel = 4,
    has_belt_immunity = true,
    Rank = 4,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 10,           -- Attack Unit (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 0,
    SightRange = 7,
    RightClickAction = 4,
    GroundWeapon = 43,               -- Spines
    GroundWeaponHits = 1,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsWorker = true,
    healing_per_tick = 0.0062,   -- Zerg Health Regen
    FlagOrganic = true,
    FlagBurrowable = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    UnitDimensions = {11, 11, 11, 11},
    MineralCost = 50,
    GasCost = 0,
    BuildTime = 300,                 -- 20.00 sec on Normal, 12.50 sec on Fastest
    Race = 0, -- Zerg
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 2,                  -- 1 supply in game
    CargoSize = 1,
    CargoSpace = 0
  }, -- Zerg Overlord
  {
    Flingy = 12,                      -- Overlord
    SubUnit = 228,                  -- None
    ConstructionAnimation = 44,
    SpawnDirection = 13,
    MaxShields = 0,
    max_health = 200,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 0,
    ArmorUpgrade = 4,                -- Zerg Flyer Caparace 
    ElevationLevel = 16,
    has_belt_immunity = true,
    Rank = 8,
    CompAIIdleOrder = 159,         -- Patrol (Computer)
    HumanAIIdleOrder = 93,         -- Idle (Transport)
    ReturnToIdleOrder = 93,           -- Idle (Transport)
    AttackUnitOrder = 21,           -- Stay In Range
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 0,
    SightRange = 9,
    RightClickAction = 2,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsFlyer = true,
    healing_per_tick = 0.0062,   -- Zerg Health Regen
    FlagDetector = true,
    FlagOrganic = true,
    FlagMediumOverlay = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    UnitDimensions = {25, 25, 24, 24},
    MineralCost = 100,
    GasCost = 0,
    BuildTime = 600,                 -- 40.00 sec on Normal, 25.00 sec on Fastest
    Race = 0, -- Zerg
    SupplyProvided = 16,             -- 8 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 8
  }, -- Zerg Mutalisk
  {
    Flingy = 11,                      -- Mutalisk
    SubUnit = 228,                  -- None
    ConstructionAnimation = 40,
    SpawnDirection = 15,
    MaxShields = 0,
    max_health = 120,
    resistances = {  -- Small Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 0 },
      { type = "explosion", percent = 50 },
      { type = "fire", percent = 0 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 50 },
      { type = "electric", percent = 0 }
    },
    Armor = 0,
    ArmorUpgrade = 4,                -- Zerg Flyer Caparace 
    ElevationLevel = 18,
    has_belt_immunity = true,
    Rank = 10,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 10,           -- Attack Unit (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 3,
    SightRange = 7,
    RightClickAction = 1,
    GroundWeapon = 48,               -- Glave Wurm (Normal)
    GroundWeaponHits = 1,
    AirWeapon = 48,                  -- Glave Wurm (Normal)
    AirWeaponHits = 1,
    FlagIsFlyer = true,
    healing_per_tick = 0.0062,   -- Zerg Health Regen
    FlagOrganic = true,
    FlagMediumOverlay = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    UnitDimensions = {22, 22, 21, 21},
    MineralCost = 100,
    GasCost = 100,
    BuildTime = 600,                 -- 40.00 sec on Normal, 25.00 sec on Fastest
    Race = 0, -- Zerg
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 4,                  -- 2 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Zerg Guardian
  {
    Flingy = 7,                       -- Guardian
    SubUnit = 228,                  -- None
    ConstructionAnimation = 27,
    SpawnDirection = 14,
    MaxShields = 0,
    max_health = 150,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 2,
    ArmorUpgrade = 4,                -- Zerg Flyer Caparace 
    ElevationLevel = 18,
    has_belt_immunity = true,
    Rank = 11,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 10,           -- Attack Unit (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 0,
    SightRange = 11,
    RightClickAction = 1,
    GroundWeapon = 46,               -- Acid Spore (Normal)
    GroundWeaponHits = 1,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsFlyer = true,
    healing_per_tick = 0.0062,   -- Zerg Health Regen
    FlagOrganic = true,
    FlagMorphFromOtherUnit = true,
    FlagLargeOverlay = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    UnitDimensions = {22, 22, 21, 21},
    MineralCost = 50,
    GasCost = 100,
    BuildTime = 600,                 -- 40.00 sec on Normal, 25.00 sec on Fastest
    Race = 0, -- Zerg
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 4,                  -- 2 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Zerg Queen
  {
    Flingy = 13,                      -- Queen
    SubUnit = 228,                  -- None
    ConstructionAnimation = 49,
    SpawnDirection = 15,
    MaxShields = 0,
    max_health = 120,
    resistances = {  -- Medium Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 50 },
      { type = "explosion", percent = 25 },
      { type = "fire", percent = 50 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 25 },
      { type = "electric", percent = 0 }
    },
    Armor = 0,
    ArmorUpgrade = 4,                -- Zerg Flyer Caparace 
    ElevationLevel = 18,
    has_belt_immunity = true,
    Rank = 13,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 27,           -- Use Ability (Infest 1)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 8,
    SightRange = 10,
    RightClickAction = 2,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsFlyer = true,
    healing_per_tick = 0.0062,   -- Zerg Health Regen
    FlagOrganic = true,
    FlagSpellcaster = true,
    FlagMediumOverlay = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    UnitDimensions = {24, 24, 23, 23},
    MineralCost = 100,
    GasCost = 100,
    BuildTime = 750,                 -- 50.00 sec on Normal, 31.25 sec on Fastest
    Race = 0, -- Zerg
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 4,                  -- 2 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Zerg Defiler
  {
    Flingy = 4,                       -- Defiler
    SubUnit = 228,                  -- None
    ConstructionAnimation = 15,
    SpawnDirection = 13,
    MaxShields = 0,
    max_health = 80,
    resistances = {  -- Medium Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 50 },
      { type = "explosion", percent = 25 },
      { type = "fire", percent = 50 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 25 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 3,                -- Zerg Carapace 
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 12,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 10,           -- Attack Unit (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 0,
    SightRange = 10,
    RightClickAction = 2,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    healing_per_tick = 0.0062,   -- Zerg Health Regen
    FlagOrganic = true,
    FlagBurrowable = true,
    FlagSpellcaster = true,
    FlagMediumOverlay = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    UnitDimensions = {13, 12, 13, 12},
    MineralCost = 50,
    GasCost = 150,
    BuildTime = 750,                 -- 50.00 sec on Normal, 31.25 sec on Fastest
    Race = 0, -- Zerg
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 4,                  -- 2 supply in game
    CargoSize = 2,
    CargoSpace = 0
  }, -- Zerg Scourge
  {
    Flingy = 0,                       -- Scourge
    SubUnit = 228,                  -- None
    ConstructionAnimation = 2,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 25,
    resistances = {  -- Small Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 0 },
      { type = "explosion", percent = 50 },
      { type = "fire", percent = 0 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 50 },
      { type = "electric", percent = 0 }
    },
    Armor = 0,
    ArmorUpgrade = 4,                -- Zerg Flyer Caparace 
    ElevationLevel = 18,
    has_belt_immunity = true,
    Rank = 6,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 10,           -- Attack Unit (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 3,
    SightRange = 5,
    RightClickAction = 1,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 55,                  -- Suicide (Scourge)
    AirWeaponHits = 1,
    FlagIsFlyer = true,
    healing_per_tick = 0.0062,   -- Zerg Health Regen
    FlagTwoUnitsIn1Egg = true,
    FlagOrganic = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    UnitDimensions = {12, 12, 11, 11},
    MineralCost = 25,
    GasCost = 75,
    BuildTime = 450,                 -- 30.00 sec on Normal, 18.75 sec on Fastest
    Race = 0, -- Zerg
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 1,                  -- 0.5 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Torrasque (Ultralisk)
  {
    Flingy = 14,                      -- Ultralisk
    SubUnit = 228,                  -- None
    ConstructionAnimation = 52,
    SpawnDirection = 14,
    MaxShields = 0,
    max_health = 800,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 4,
    ArmorUpgrade = 3,                -- Zerg Carapace 
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 15,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 10,           -- Attack Unit (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 3,
    SightRange = 7,
    RightClickAction = 1,
    GroundWeapon = 41,               -- Kaiser Blades (Torrasque)
    GroundWeaponHits = 1,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsHero = true,
    healing_per_tick = 0.0062,   -- Zerg Health Regen
    FlagOrganic = true,
    FlagLargeOverlay = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    UnitDimensions = {19, 16, 18, 15},
    MineralCost = 400,
    GasCost = 400,
    BuildTime = 1800,                -- 120.00 sec on Normal, 75.00 sec on Fastest
    Race = 0, -- Zerg
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 4,
    CargoSpace = 0
  }, -- Matriarch (Queen)
  {
    Flingy = 13,                      -- Queen
    SubUnit = 228,                  -- None
    ConstructionAnimation = 49,
    SpawnDirection = 15,
    MaxShields = 0,
    max_health = 300,
    resistances = {  -- Medium Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 50 },
      { type = "explosion", percent = 25 },
      { type = "fire", percent = 50 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 25 },
      { type = "electric", percent = 0 }
    },
    Armor = 3,
    ArmorUpgrade = 4,                -- Zerg Flyer Caparace 
    ElevationLevel = 18,
    has_belt_immunity = true,
    Rank = 15,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 27,           -- Use Ability (Infest 1)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 8,
    SightRange = 10,
    RightClickAction = 2,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsFlyer = true,
    FlagIsHero = true,
    healing_per_tick = 0.0062,   -- Zerg Health Regen
    FlagOrganic = true,
    FlagSpellcaster = true,
    FlagMediumOverlay = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    UnitDimensions = {24, 24, 23, 23},
    MineralCost = 200,
    GasCost = 300,
    BuildTime = 1500,                -- 100.00 sec on Normal, 62.50 sec on Fastest
    Race = 0, -- Zerg
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Infested Terran
  {
    Flingy = 2,                       -- Infested Terran
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 0,
    max_health = 60,
    resistances = {  -- Small Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 0 },
      { type = "explosion", percent = 50 },
      { type = "fire", percent = 0 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 50 },
      { type = "electric", percent = 0 }
    },
    Armor = 0,
    ArmorUpgrade = 3,                -- Zerg Carapace 
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 7,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 134,          -- Attack Unit (Infested Terran)
    AttackMoveOrder = 135,          -- Attack Ground (Infested Terran)
    SeekRange = 3,
    SightRange = 5,
    RightClickAction = 1,
    GroundWeapon = 54,               -- Suicide (Infested Terran)
    GroundWeaponHits = 1,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    healing_per_tick = 0.0062,   -- Zerg Health Regen
    FlagOrganic = true,
    FlagBurrowable = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    UnitDimensions = {8, 9, 8, 10},
    MineralCost = 100,
    GasCost = 50,
    BuildTime = 600,                 -- 40.00 sec on Normal, 25.00 sec on Fastest
    Race = 0, -- Zerg
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 2,                  -- 1 supply in game
    CargoSize = 1,
    CargoSpace = 0
  }, -- Infested Kerrigan (Infested Terran)
  {
    Flingy = 9,                       -- Infested Kerrigan
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 0,
    max_health = 400,
    resistances = {  -- Small Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 0 },
      { type = "explosion", percent = 50 },
      { type = "fire", percent = 0 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 50 },
      { type = "electric", percent = 0 }
    },
    Armor = 2,
    ArmorUpgrade = 3,                -- Zerg Carapace 
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 16,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 10,           -- Attack Unit (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 3,
    SightRange = 9,
    RightClickAction = 1,
    GroundWeapon = 37,               -- Claws (Infested Kerrigan)
    GroundWeaponHits = 1,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsHero = true,
    healing_per_tick = 0.0062,   -- Zerg Health Regen
    FlagCloakable = true,
    FlagOrganic = true,
    FlagSpellcaster = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    UnitDimensions = {7, 10, 7, 11},
    MineralCost = 200,
    GasCost = 300,
    BuildTime = 1500,                -- 100.00 sec on Normal, 62.50 sec on Fastest
    Race = 0, -- Zerg
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 1,
    CargoSpace = 0
  }, -- Unclean One (Defiler)
  {
    Flingy = 4,                       -- Defiler
    SubUnit = 228,                  -- None
    ConstructionAnimation = 15,
    SpawnDirection = 13,
    MaxShields = 0,
    max_health = 250,
    resistances = {  -- Medium Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 50 },
      { type = "explosion", percent = 25 },
      { type = "fire", percent = 50 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 25 },
      { type = "electric", percent = 0 }
    },
    Armor = 3,
    ArmorUpgrade = 3,                -- Zerg Carapace 
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 15,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 10,           -- Attack Unit (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 0,
    SightRange = 10,
    RightClickAction = 2,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsHero = true,
    healing_per_tick = 0.0062,   -- Zerg Health Regen
    FlagOrganic = true,
    FlagBurrowable = true,
    FlagSpellcaster = true,
    FlagMediumOverlay = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    UnitDimensions = {14, 14, 14, 14},
    MineralCost = 50,
    GasCost = 200,
    BuildTime = 1500,                -- 100.00 sec on Normal, 62.50 sec on Fastest
    Race = 0, -- Zerg
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 2,
    CargoSpace = 0
  }, -- Hunter Killer (Hydralisk)
  {
    Flingy = 8,                       -- Hydralisk
    SubUnit = 228,                  -- None
    ConstructionAnimation = 31,
    SpawnDirection = 12,
    MaxShields = 0,
    max_health = 160,
    resistances = {  -- Medium Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 50 },
      { type = "explosion", percent = 25 },
      { type = "fire", percent = 50 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 25 },
      { type = "electric", percent = 0 }
    },
    Armor = 2,
    ArmorUpgrade = 3,                -- Zerg Carapace 
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 15,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 10,           -- Attack Unit (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 0,
    SightRange = 8,
    RightClickAction = 1,
    GroundWeapon = 39,               -- Needle Spines (Hunter Killer)
    GroundWeaponHits = 1,
    AirWeapon = 39,                  -- Needle Spines (Hunter Killer)
    AirWeaponHits = 1,
    FlagIsHero = true,
    healing_per_tick = 0.0062,   -- Zerg Health Regen
    FlagOrganic = true,
    FlagBurrowable = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    UnitDimensions = {10, 10, 10, 12},
    MineralCost = 150,
    GasCost = 50,
    BuildTime = 780,                 -- 52.00 sec on Normal, 32.50 sec on Fastest
    Race = 0, -- Zerg
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 2,
    CargoSpace = 0
  }, -- Devouring One (Zergling)
  {
    Flingy = 15,                      -- Zergling
    SubUnit = 228,                  -- None
    ConstructionAnimation = 56,
    SpawnDirection = 10,
    MaxShields = 0,
    max_health = 120,
    resistances = {  -- Small Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 0 },
      { type = "explosion", percent = 50 },
      { type = "fire", percent = 0 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 50 },
      { type = "electric", percent = 0 }
    },
    Armor = 3,
    ArmorUpgrade = 3,                -- Zerg Carapace 
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 15,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 10,           -- Attack Unit (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 3,
    SightRange = 5,
    RightClickAction = 1,
    GroundWeapon = 36,               -- Claws (Devouring One)
    GroundWeaponHits = 1,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsHero = true,
    healing_per_tick = 0.0062,   -- Zerg Health Regen
    FlagTwoUnitsIn1Egg = true,
    FlagOrganic = true,
    FlagBurrowable = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    UnitDimensions = {8, 4, 7, 11},
    MineralCost = 100,
    GasCost = 0,
    BuildTime = 840,                 -- 56.00 sec on Normal, 35.00 sec on Fastest
    Race = 0, -- Zerg
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 1,
    CargoSpace = 0
  }, -- Kukulza (Mutalisk)
  {
    Flingy = 11,                      -- Mutalisk
    SubUnit = 228,                  -- None
    ConstructionAnimation = 40,
    SpawnDirection = 15,
    MaxShields = 0,
    max_health = 300,
    resistances = {  -- Small Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 0 },
      { type = "explosion", percent = 50 },
      { type = "fire", percent = 0 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 50 },
      { type = "electric", percent = 0 }
    },
    Armor = 3,
    ArmorUpgrade = 4,                -- Zerg Flyer Caparace 
    ElevationLevel = 18,
    has_belt_immunity = true,
    Rank = 15,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 10,           -- Attack Unit (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 3,
    SightRange = 7,
    RightClickAction = 1,
    GroundWeapon = 49,               -- Glave Wurm (Kukulza-Mutalisk)
    GroundWeaponHits = 1,
    AirWeapon = 49,                  -- Glave Wurm (Kukulza-Mutalisk)
    AirWeaponHits = 1,
    FlagIsFlyer = true,
    FlagIsHero = true,
    healing_per_tick = 0.0062,   -- Zerg Health Regen
    FlagOrganic = true,
    FlagMediumOverlay = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    UnitDimensions = {22, 22, 21, 21},
    MineralCost = 200,
    GasCost = 200,
    BuildTime = 1200,                -- 80.00 sec on Normal, 50.00 sec on Fastest
    Race = 0, -- Zerg
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Kukulza (Guardian)
  {
    Flingy = 7,                       -- Guardian
    SubUnit = 228,                  -- None
    ConstructionAnimation = 27,
    SpawnDirection = 14,
    MaxShields = 0,
    max_health = 400,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 4,
    ArmorUpgrade = 4,                -- Zerg Flyer Caparace 
    ElevationLevel = 18,
    has_belt_immunity = true,
    Rank = 15,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 10,           -- Attack Unit (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 0,
    SightRange = 11,
    RightClickAction = 1,
    GroundWeapon = 47,               -- Acid Spore (Kukulza-Guardian)
    GroundWeaponHits = 1,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsFlyer = true,
    FlagIsHero = true,
    healing_per_tick = 0.0062,   -- Zerg Health Regen
    FlagOrganic = true,
    FlagMorphFromOtherUnit = true,
    FlagLargeOverlay = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    UnitDimensions = {22, 22, 21, 21},
    MineralCost = 100,
    GasCost = 200,
    BuildTime = 1200,                -- 80.00 sec on Normal, 50.00 sec on Fastest
    Race = 0, -- Zerg
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Yggdrasill (Overlord)
  {
    Flingy = 12,                      -- Overlord
    SubUnit = 228,                  -- None
    ConstructionAnimation = 44,
    SpawnDirection = 13,
    MaxShields = 0,
    max_health = 1000,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 4,
    ArmorUpgrade = 4,                -- Zerg Flyer Caparace 
    ElevationLevel = 16,
    has_belt_immunity = true,
    Rank = 15,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 93,         -- Idle (Transport)
    ReturnToIdleOrder = 93,           -- Idle (Transport)
    AttackUnitOrder = 21,           -- Stay In Range
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 0,
    SightRange = 11,
    RightClickAction = 2,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsFlyer = true,
    FlagIsHero = true,
    healing_per_tick = 0.0062,   -- Zerg Health Regen
    FlagDetector = true,
    FlagOrganic = true,
    FlagMediumOverlay = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    UnitDimensions = {25, 25, 24, 24},
    MineralCost = 200,
    GasCost = 0,
    BuildTime = 1200,                -- 80.00 sec on Normal, 50.00 sec on Fastest
    Race = 0, -- Zerg
    SupplyProvided = 60,             -- 30 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 8
  }, -- Terran Valkyrie
  {
    Flingy = 190,                     -- Valkyrie
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 0,
    max_health = 200,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 2,
    ArmorUpgrade = 2,                -- Terran Ship Plating 
    ElevationLevel = 16,
    has_belt_immunity = true,
    Rank = 16,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 10,           -- Attack Unit (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 0,
    SightRange = 8,
    RightClickAction = 1,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 103,                 -- Halo Rockets
    AirWeaponHits = 4,
    FlagIsFlyer = true,
    FlagMediumOverlay = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    FlagMechanical = true,
    UnitDimensions = {24, 16, 24, 20},
    MineralCost = 250,
    GasCost = 125,
    BuildTime = 750,                 -- 50.00 sec on Normal, 31.25 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 6,                  -- 3 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Mutalisk Cocoon
  {
    Flingy = 3,                       -- Guardian Cocoon
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 200,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 0,
    ArmorUpgrade = 3,                -- Zerg Carapace 
    ElevationLevel = 18,
    has_belt_immunity = true,
    Rank = 2,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 2,            -- Guard (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 0,
    SightRange = 4,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsFlyer = true,
    FlagOrganic = true,
    UnitDimensions = {16, 16, 15, 15},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 0, -- Zerg
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Protoss Corsair
  {
    Flingy = 191,                     -- Corsair
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 80,
    max_health = 100,
    resistances = {  -- Medium Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 50 },
      { type = "explosion", percent = 25 },
      { type = "fire", percent = 50 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 25 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 6,                -- Protoss Plating 
    ElevationLevel = 18,
    has_belt_immunity = true,
    Rank = 8,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 10,           -- Attack Unit (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 9,
    SightRange = 9,
    RightClickAction = 1,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 100,                 -- Neutron Flare
    AirWeaponHits = 1,
    FlagIsFlyer = true,
    FlagSpellcaster = true,
    FlagMediumOverlay = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    FlagMechanical = true,
    UnitDimensions = {18, 16, 17, 15},
    MineralCost = 150,
    GasCost = 100,
    BuildTime = 600,                 -- 40.00 sec on Normal, 25.00 sec on Fastest
    Race = 2, -- Protoss
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 4,                  -- 2 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Protoss Dark Templar (Unit)
  {
    Flingy = 188,                     -- Dark Templar (Unit)
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 40,
    max_health = 80,
    resistances = {  -- Small Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 0 },
      { type = "explosion", percent = 50 },
      { type = "fire", percent = 0 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 50 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 5,                -- Protoss Armor 
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 12,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 10,           -- Attack Unit (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 3,
    SightRange = 7,
    RightClickAction = 1,
    GroundWeapon = 111,              -- Warp Blades (Normal)
    GroundWeaponHits = 1,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagOrganic = true,
    FlagPermanentCloak = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    UnitDimensions = {12, 6, 11, 19},
    MineralCost = 125,
    GasCost = 100,
    BuildTime = 750,                 -- 50.00 sec on Normal, 31.25 sec on Fastest
    Race = 2, -- Protoss
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 4,                  -- 2 supply in game
    CargoSize = 2,
    CargoSpace = 0
  }, -- Zerg Devourer
  {
    Flingy = 185,                     -- Devourer
    SubUnit = 228,                  -- None
    ConstructionAnimation = 917,
    SpawnDirection = 12,
    MaxShields = 0,
    max_health = 250,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 2,
    ArmorUpgrade = 4,                -- Zerg Flyer Caparace 
    ElevationLevel = 18,
    has_belt_immunity = true,
    Rank = 12,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 10,           -- Attack Unit (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 7,
    SightRange = 10,
    RightClickAction = 1,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 104,                 -- Corrosive Acid
    AirWeaponHits = 1,
    FlagIsFlyer = true,
    healing_per_tick = 0.0062,   -- Zerg Health Regen
    FlagOrganic = true,
    FlagMorphFromOtherUnit = true,
    FlagLargeOverlay = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    UnitDimensions = {22, 22, 21, 21},
    MineralCost = 150,
    GasCost = 50,
    BuildTime = 600,                 -- 40.00 sec on Normal, 25.00 sec on Fastest
    Race = 0, -- Zerg
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 4,                  -- 2 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Protoss Dark Archon
  {
    Flingy = 187,                     -- Dark Archon Energy
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 200,
    max_health = 25,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 5,                -- Protoss Armor 
    ElevationLevel = 4,
    has_belt_immunity = true,
    Rank = 9,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 21,           -- Stay In Range
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 7,
    SightRange = 10,
    RightClickAction = 2,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagAnimatedIdle = true,
    FlagSpellcaster = true,
    FlagLargeOverlay = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    UnitDimensions = {16, 16, 15, 15},
    MineralCost = 0,
    GasCost = 0,
    BuildTime = 300,                 -- 20.00 sec on Normal, 12.50 sec on Fastest
    Race = 2, -- Protoss
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 8,                  -- 4 supply in game
    CargoSize = 4,
    CargoSpace = 0
  }, -- Protoss Probe
  {
    Flingy = 42,                      -- Probe
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 20,
    max_health = 20,
    resistances = {  -- Small Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 0 },
      { type = "explosion", percent = 50 },
      { type = "fire", percent = 0 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 50 },
      { type = "electric", percent = 0 }
    },
    Armor = 0,
    ArmorUpgrade = 5,                -- Protoss Armor 
    ElevationLevel = 4,
    has_belt_immunity = true,
    Rank = 0,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 10,           -- Attack Unit (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 0,
    SightRange = 8,
    RightClickAction = 4,
    GroundWeapon = 62,               -- Particle Beam
    GroundWeaponHits = 1,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsWorker = true,
    FlagRoboticUnit = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    FlagMechanical = true,
    UnitDimensions = {11, 11, 11, 11},
    MineralCost = 50,
    GasCost = 0,
    BuildTime = 300,                 -- 20.00 sec on Normal, 12.50 sec on Fastest
    Race = 2, -- Protoss
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 2,                  -- 1 supply in game
    CargoSize = 1,
    CargoSpace = 0
  }, -- Protoss Zealot
  {
    Flingy = 49,                      -- Zealot
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 60,
    max_health = 100,
    resistances = {  -- Small Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 0 },
      { type = "explosion", percent = 50 },
      { type = "fire", percent = 0 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 50 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 5,                -- Protoss Armor 
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 3,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 10,           -- Attack Unit (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 3,
    SightRange = 7,
    RightClickAction = 1,
    GroundWeapon = 64,               -- Psi Blades (Normal)
    GroundWeaponHits = 2,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagOrganic = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    UnitDimensions = {11, 5, 11, 13},
    MineralCost = 100,
    GasCost = 0,
    BuildTime = 600,                 -- 40.00 sec on Normal, 25.00 sec on Fastest
    Race = 2, -- Protoss
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 4,                  -- 2 supply in game
    CargoSize = 2,
    CargoSpace = 0
  }, -- Protoss Dragoon
  {
    Flingy = 40,                      -- Dragoon
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 80,
    max_health = 100,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 5,                -- Protoss Armor 
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 4,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 10,           -- Attack Unit (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 0,
    SightRange = 8,
    RightClickAction = 1,
    GroundWeapon = 66,               -- Phase Disruptor (Normal)
    GroundWeaponHits = 1,
    AirWeapon = 66,                  -- Phase Disruptor (Normal)
    AirWeaponHits = 1,
    FlagMediumOverlay = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    FlagMechanical = true,
    UnitDimensions = {15, 15, 16, 16},
    MineralCost = 125,
    GasCost = 50,
    BuildTime = 750,                 -- 50.00 sec on Normal, 31.25 sec on Fastest
    Race = 2, -- Protoss
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 4,                  -- 2 supply in game
    CargoSize = 4,
    CargoSpace = 0
  }, -- Protoss High Templar
  {
    Flingy = 45,                      -- High Templar
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 40,
    max_health = 40,
    resistances = {  -- Small Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 0 },
      { type = "explosion", percent = 50 },
      { type = "fire", percent = 0 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 50 },
      { type = "electric", percent = 0 }
    },
    Armor = 0,
    ArmorUpgrade = 5,                -- Protoss Armor 
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 6,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 10,           -- Attack Unit (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 3,
    SightRange = 7,
    RightClickAction = 2,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagOrganic = true,
    FlagSpellcaster = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    UnitDimensions = {12, 10, 11, 13},
    MineralCost = 50,
    GasCost = 150,
    BuildTime = 750,                 -- 50.00 sec on Normal, 31.25 sec on Fastest
    Race = 2, -- Protoss
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 4,                  -- 2 supply in game
    CargoSize = 2,
    CargoSpace = 0
  }, -- Protoss Archon
  {
    Flingy = 38,                      -- Archon Energy
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 350,
    max_health = 10,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 0,
    ArmorUpgrade = 5,                -- Protoss Armor 
    ElevationLevel = 4,
    has_belt_immunity = true,
    Rank = 9,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 10,           -- Attack Unit (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 3,
    SightRange = 8,
    RightClickAction = 1,
    GroundWeapon = 70,               -- Psionic Shockwave (Normal)
    GroundWeaponHits = 1,
    AirWeapon = 70,                  -- Psionic Shockwave (Normal)
    AirWeaponHits = 1,
    FlagAnimatedIdle = true,
    FlagLargeOverlay = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    UnitDimensions = {16, 16, 15, 15},
    MineralCost = 0,
    GasCost = 0,
    BuildTime = 300,                 -- 20.00 sec on Normal, 12.50 sec on Fastest
    Race = 2, -- Protoss
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 8,                  -- 4 supply in game
    CargoSize = 4,
    CargoSpace = 0
  }, -- Protoss Shuttle
  {
    Flingy = 44,                      -- Shuttle
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 60,
    max_health = 80,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 6,                -- Protoss Plating 
    ElevationLevel = 18,
    has_belt_immunity = true,
    Rank = 7,
    CompAIIdleOrder = 93,          -- Idle (Transport)
    HumanAIIdleOrder = 93,         -- Idle (Transport)
    ReturnToIdleOrder = 93,           -- Idle (Transport)
    AttackUnitOrder = 21,           -- Stay In Range
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 0,
    SightRange = 8,
    RightClickAction = 2,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsFlyer = true,
    FlagRoboticUnit = true,
    FlagMediumOverlay = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    FlagMechanical = true,
    UnitDimensions = {20, 16, 19, 15},
    MineralCost = 200,
    GasCost = 0,
    BuildTime = 900,                 -- 60.00 sec on Normal, 37.50 sec on Fastest
    Race = 2, -- Protoss
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 4,                  -- 2 supply in game
    CargoSize = 255,
    CargoSpace = 8
  }, -- Protoss Scout
  {
    Flingy = 43,                      -- Scout
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 100,
    max_health = 150,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 0,
    ArmorUpgrade = 6,                -- Protoss Plating 
    ElevationLevel = 18,
    has_belt_immunity = true,
    Rank = 8,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 10,           -- Attack Unit (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 0,
    SightRange = 8,
    RightClickAction = 1,
    GroundWeapon = 73,               -- Dual Photon Blasters (Normal)
    GroundWeaponHits = 1,
    AirWeapon = 74,                  -- Anti-matter Missiles (Normal)
    AirWeaponHits = 1,
    FlagIsFlyer = true,
    FlagMediumOverlay = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    FlagMechanical = true,
    UnitDimensions = {18, 16, 17, 15},
    MineralCost = 275,
    GasCost = 125,
    BuildTime = 1200,                -- 80.00 sec on Normal, 50.00 sec on Fastest
    Race = 2, -- Protoss
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 6,                  -- 3 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Protoss Arbiter
  {
    Flingy = 37,                      -- Arbiter
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 150,
    max_health = 200,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 6,                -- Protoss Plating 
    ElevationLevel = 16,
    has_belt_immunity = true,
    Rank = 10,
    CompAIIdleOrder = 130,         -- Script (Cloak Nearby Units)
    HumanAIIdleOrder = 130,        -- Script (Cloak Nearby Units)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 10,           -- Attack Unit (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 0,
    SightRange = 9,
    RightClickAction = 1,
    GroundWeapon = 77,               -- Phase Disruptor Cannon (Normal)
    GroundWeaponHits = 1,
    AirWeapon = 77,                  -- Phase Disruptor Cannon (Normal)
    AirWeaponHits = 1,
    FlagIsFlyer = true,
    FlagSpellcaster = true,
    FlagMediumOverlay = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    FlagMechanical = true,
    UnitDimensions = {22, 22, 21, 21},
    MineralCost = 100,
    GasCost = 350,
    BuildTime = 2400,                -- 160.00 sec on Normal, 100.00 sec on Fastest
    Race = 2, -- Protoss
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 8,                  -- 4 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Protoss Carrier
  {
    Flingy = 39,                      -- Carrier
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 150,
    max_health = 300,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 4,
    ArmorUpgrade = 6,                -- Protoss Plating 
    ElevationLevel = 16,
    has_belt_immunity = true,
    Rank = 11,
    CompAIIdleOrder = 50,          -- Idle (Carrier)
    HumanAIIdleOrder = 50,         -- Idle (Carrier)
    ReturnToIdleOrder = 50,           -- Idle (Carrier)
    AttackUnitOrder = 53,           -- Attack (Carrier)
    AttackMoveOrder = 50,           -- Idle (Carrier)
    SeekRange = 8,
    SightRange = 11,
    RightClickAction = 1,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsFlyer = true,
    FlagLargeOverlay = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    FlagMechanical = true,
    UnitDimensions = {32, 32, 31, 31},
    MineralCost = 350,
    GasCost = 250,
    BuildTime = 2100,                -- 140.00 sec on Normal, 87.50 sec on Fastest
    Race = 2, -- Protoss
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 12,                 -- 6 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Protoss Interceptor
  {
    Flingy = 41,                      -- Interceptor
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 40,
    max_health = 40,
    resistances = {  -- Small Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 0 },
      { type = "explosion", percent = 50 },
      { type = "fire", percent = 0 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 50 },
      { type = "electric", percent = 0 }
    },
    Armor = 0,
    ArmorUpgrade = 6,                -- Protoss Plating 
    ElevationLevel = 18,
    has_belt_immunity = true,
    Rank = 1,
    CompAIIdleOrder = 23,          -- Nothing 2 (Normal)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 64,           -- Move&Attack (Interceptor)
    AttackUnitOrder = 64,           -- Move&Attack (Interceptor)
    AttackMoveOrder = 188,          -- Fatal
    SeekRange = 0,
    SightRange = 6,
    RightClickAction = 0,
    GroundWeapon = 79,               -- Pulse Cannon
    GroundWeaponHits = 1,
    AirWeapon = 79,                  -- Pulse Cannon
    AirWeaponHits = 1,
    FlagIsFlyer = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    FlagMechanical = true,
    UnitDimensions = {8, 8, 7, 7},
    MineralCost = 25,
    GasCost = 0,
    BuildTime = 300,                 -- 20.00 sec on Normal, 12.50 sec on Fastest
    Race = 2, -- Protoss
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Protoss Dark Templar (Hero)
  {
    Flingy = 46,                      -- Dark Templar (Hero)
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 80,
    max_health = 40,
    resistances = {  -- Small Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 0 },
      { type = "explosion", percent = 50 },
      { type = "fire", percent = 0 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 50 },
      { type = "electric", percent = 0 }
    },
    Armor = 0,
    ArmorUpgrade = 5,                -- Protoss Armor 
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 12,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 10,           -- Attack Unit (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 3,
    SightRange = 7,
    RightClickAction = 1,
    GroundWeapon = 86,               -- Warp Blades (Dark Templar Hero)
    GroundWeaponHits = 1,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagOrganic = true,
    FlagPermanentCloak = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    UnitDimensions = {12, 6, 11, 19},
    MineralCost = 150,
    GasCost = 150,
    BuildTime = 750,                 -- 50.00 sec on Normal, 31.25 sec on Fastest
    Race = 2, -- Protoss
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 2,                  -- 1 supply in game
    CargoSize = 2,
    CargoSpace = 0
  }, -- Zeratul (Dark Templar)
  {
    Flingy = 46,                      -- Dark Templar (Hero)
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 400,
    max_health = 60,
    resistances = {  -- Small Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 0 },
      { type = "explosion", percent = 50 },
      { type = "fire", percent = 0 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 50 },
      { type = "electric", percent = 0 }
    },
    Armor = 0,
    ArmorUpgrade = 5,                -- Protoss Armor 
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 15,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 10,           -- Attack Unit (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 3,
    SightRange = 7,
    RightClickAction = 1,
    GroundWeapon = 85,               -- Warp Blades (Zeratul)
    GroundWeaponHits = 1,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsHero = true,
    FlagOrganic = true,
    FlagPermanentCloak = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    UnitDimensions = {12, 6, 11, 19},
    MineralCost = 100,
    GasCost = 300,
    BuildTime = 1500,                -- 100.00 sec on Normal, 62.50 sec on Fastest
    Race = 2, -- Protoss
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 2,
    CargoSpace = 0
  }, -- Tassadar/Zeratul (Archon)
  {
    Flingy = 38,                      -- Archon Energy
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 800,
    max_health = 100,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 3,
    ArmorUpgrade = 5,                -- Protoss Armor 
    ElevationLevel = 4,
    has_belt_immunity = true,
    Rank = 17,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 10,           -- Attack Unit (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 3,
    SightRange = 8,
    RightClickAction = 1,
    GroundWeapon = 71,               -- Psionic Shockwave (Tassadar/Zeratul Archon)
    GroundWeaponHits = 1,
    AirWeapon = 71,                  -- Psionic Shockwave (Tassadar/Zeratul Archon)
    AirWeaponHits = 1,
    FlagIsHero = true,
    FlagAnimatedIdle = true,
    FlagLargeOverlay = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    UnitDimensions = {16, 16, 15, 15},
    MineralCost = 0,
    GasCost = 0,
    BuildTime = 600,                 -- 40.00 sec on Normal, 25.00 sec on Fastest
    Race = 2, -- Protoss
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 4,
    CargoSpace = 0
  }, -- Fenix (Zealot)
  {
    Flingy = 49,                      -- Zealot
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 240,
    max_health = 240,
    resistances = {  -- Small Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 0 },
      { type = "explosion", percent = 50 },
      { type = "fire", percent = 0 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 50 },
      { type = "electric", percent = 0 }
    },
    Armor = 2,
    ArmorUpgrade = 5,                -- Protoss Armor 
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 13,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 10,           -- Attack Unit (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 3,
    SightRange = 7,
    RightClickAction = 1,
    GroundWeapon = 65,               -- Psi Blades (Fenix-Zealot)
    GroundWeaponHits = 2,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsHero = true,
    FlagOrganic = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    UnitDimensions = {11, 5, 11, 13},
    MineralCost = 200,
    GasCost = 0,
    BuildTime = 1200,                -- 80.00 sec on Normal, 50.00 sec on Fastest
    Race = 2, -- Protoss
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 2,
    CargoSpace = 0
  }, -- Fenix (Dragoon)
  {
    Flingy = 40,                      -- Dragoon
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 240,
    max_health = 240,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 3,
    ArmorUpgrade = 5,                -- Protoss Armor 
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 14,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 10,           -- Attack Unit (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 0,
    SightRange = 8,
    RightClickAction = 1,
    GroundWeapon = 67,               -- Phase Disruptor (Fenix-Dragoon)
    GroundWeaponHits = 1,
    AirWeapon = 67,                  -- Phase Disruptor (Fenix-Dragoon)
    AirWeaponHits = 1,
    FlagIsHero = true,
    FlagMediumOverlay = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    FlagMechanical = true,
    UnitDimensions = {15, 15, 16, 16},
    MineralCost = 300,
    GasCost = 100,
    BuildTime = 1500,                -- 100.00 sec on Normal, 62.50 sec on Fastest
    Race = 2, -- Protoss
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 4,
    CargoSpace = 0
  }, -- Tassadar (Templar)
  {
    Flingy = 45,                      -- High Templar
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 300,
    max_health = 80,
    resistances = {  -- Small Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 0 },
      { type = "explosion", percent = 50 },
      { type = "fire", percent = 0 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 50 },
      { type = "electric", percent = 0 }
    },
    Armor = 2,
    ArmorUpgrade = 5,                -- Protoss Armor 
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 16,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 10,           -- Attack Unit (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 3,
    SightRange = 7,
    RightClickAction = 1,
    GroundWeapon = 69,               -- Psi Assault (Tassadar+Aldaris)
    GroundWeaponHits = 1,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsHero = true,
    FlagOrganic = true,
    FlagSpellcaster = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    UnitDimensions = {12, 10, 11, 13},
    MineralCost = 100,
    GasCost = 300,
    BuildTime = 1500,                -- 100.00 sec on Normal, 62.50 sec on Fastest
    Race = 2, -- Protoss
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 2,
    CargoSpace = 0
  }, -- Mojo (Scout)
  {
    Flingy = 43,                      -- Scout
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 400,
    max_health = 400,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 3,
    ArmorUpgrade = 6,                -- Protoss Plating 
    ElevationLevel = 18,
    has_belt_immunity = true,
    Rank = 12,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 10,           -- Attack Unit (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 0,
    SightRange = 10,
    RightClickAction = 1,
    GroundWeapon = 75,               -- Dual Photon Blasters (Mojo)
    GroundWeaponHits = 1,
    AirWeapon = 76,                  -- Anti-matter Missiles (Mojo)
    AirWeaponHits = 1,
    FlagIsFlyer = true,
    FlagIsHero = true,
    FlagMediumOverlay = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    FlagMechanical = true,
    UnitDimensions = {18, 16, 17, 15},
    MineralCost = 600,
    GasCost = 300,
    BuildTime = 2400,                -- 160.00 sec on Normal, 100.00 sec on Fastest
    Race = 2, -- Protoss
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Warbringer (Reaver)
  {
    Flingy = 47,                      -- Reaver
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 400,
    max_health = 200,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 3,
    ArmorUpgrade = 5,                -- Protoss Armor 
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 12,
    CompAIIdleOrder = 58,          -- Idle (Reaver)
    HumanAIIdleOrder = 58,         -- Idle (Reaver)
    ReturnToIdleOrder = 58,           -- Idle (Reaver)
    AttackUnitOrder = 59,           -- Attack (Reaver)
    AttackMoveOrder = 58,           -- Idle (Reaver)
    SeekRange = 8,
    SightRange = 10,
    RightClickAction = 1,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsHero = true,
    FlagRoboticUnit = true,
    FlagLargeOverlay = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    FlagMechanical = true,
    UnitDimensions = {16, 16, 15, 15},
    MineralCost = 400,
    GasCost = 200,
    BuildTime = 1800,                -- 120.00 sec on Normal, 75.00 sec on Fastest
    Race = 2, -- Protoss
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 4,
    CargoSpace = 0
  }, -- Gantrithor (Carrier)
  {
    Flingy = 39,                      -- Carrier
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 500,
    max_health = 800,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 4,
    ArmorUpgrade = 6,                -- Protoss Plating 
    ElevationLevel = 16,
    has_belt_immunity = true,
    Rank = 17,
    CompAIIdleOrder = 50,          -- Idle (Carrier)
    HumanAIIdleOrder = 50,         -- Idle (Carrier)
    ReturnToIdleOrder = 50,           -- Idle (Carrier)
    AttackUnitOrder = 53,           -- Attack (Carrier)
    AttackMoveOrder = 50,           -- Idle (Carrier)
    SeekRange = 8,
    SightRange = 9,
    RightClickAction = 1,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsFlyer = true,
    FlagIsHero = true,
    FlagLargeOverlay = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    FlagMechanical = true,
    UnitDimensions = {32, 32, 31, 31},
    MineralCost = 700,
    GasCost = 600,
    BuildTime = 4200,                -- 280.00 sec on Normal, 175.00 sec on Fastest
    Race = 2, -- Protoss
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Protoss Reaver
  {
    Flingy = 47,                      -- Reaver
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 80,
    max_health = 100,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 0,
    ArmorUpgrade = 5,                -- Protoss Armor 
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 5,
    CompAIIdleOrder = 58,          -- Idle (Reaver)
    HumanAIIdleOrder = 58,         -- Idle (Reaver)
    ReturnToIdleOrder = 58,           -- Idle (Reaver)
    AttackUnitOrder = 59,           -- Attack (Reaver)
    AttackMoveOrder = 58,           -- Idle (Reaver)
    SeekRange = 8,
    SightRange = 10,
    RightClickAction = 1,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagRoboticUnit = true,
    FlagLargeOverlay = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    FlagMechanical = true,
    UnitDimensions = {16, 16, 15, 15},
    MineralCost = 200,
    GasCost = 100,
    BuildTime = 1050,                -- 70.00 sec on Normal, 43.75 sec on Fastest
    Race = 2, -- Protoss
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 8,                  -- 4 supply in game
    CargoSize = 4,
    CargoSpace = 0
  }, -- Protoss Observer
  {
    Flingy = 50,                      -- Observer
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 20,
    max_health = 40,
    resistances = {  -- Small Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 0 },
      { type = "explosion", percent = 50 },
      { type = "fire", percent = 0 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 50 },
      { type = "electric", percent = 0 }
    },
    Armor = 0,
    ArmorUpgrade = 6,                -- Protoss Plating 
    ElevationLevel = 18,
    has_belt_immunity = true,
    Rank = 2,
    CompAIIdleOrder = 159,         -- Patrol (Computer)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 10,           -- Attack Unit (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 0,
    SightRange = 9,
    RightClickAction = 2,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsFlyer = true,
    FlagRoboticUnit = true,
    FlagDetector = true,
    FlagPermanentCloak = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    FlagMechanical = true,
    UnitDimensions = {16, 16, 15, 15},
    MineralCost = 25,
    GasCost = 75,
    BuildTime = 600,                 -- 40.00 sec on Normal, 25.00 sec on Fastest
    Race = 2, -- Protoss
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 2,                  -- 1 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Protoss Scarab
  {
    Flingy = 48,                      -- Scarab
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 10,
    max_health = 20,
    resistances = {  -- Small Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 0 },
      { type = "explosion", percent = 50 },
      { type = "fire", percent = 0 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 50 },
      { type = "electric", percent = 0 }
    },
    Armor = 0,
    ArmorUpgrade = 5,                -- Protoss Armor 
    ElevationLevel = 4,
    has_belt_immunity = true,
    Rank = 0,
    CompAIIdleOrder = 23,          -- Nothing 2 (Normal)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 65,           -- Move&Attack (Scarab)
    AttackUnitOrder = 65,           -- Move&Attack (Scarab)
    AttackMoveOrder = 188,          -- Fatal
    SeekRange = 3,
    SightRange = 5,
    RightClickAction = 0,
    GroundWeapon = 82,               -- Scarab
    GroundWeaponHits = 1,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    FlagInvincible = true,
    FlagMechanical = true,
    UnitDimensions = {2, 2, 2, 2},
    MineralCost = 15,
    GasCost = 0,
    BuildTime = 105,                 -- 7.00 sec on Normal, 4.38 sec on Fastest
    Race = 2, -- Protoss
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Danimoth (Arbiter)
  {
    Flingy = 37,                      -- Arbiter
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 500,
    max_health = 600,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 3,
    ArmorUpgrade = 6,                -- Protoss Plating 
    ElevationLevel = 16,
    has_belt_immunity = true,
    Rank = 12,
    CompAIIdleOrder = 130,         -- Script (Cloak Nearby Units)
    HumanAIIdleOrder = 130,        -- Script (Cloak Nearby Units)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 10,           -- Attack Unit (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 0,
    SightRange = 9,
    RightClickAction = 1,
    GroundWeapon = 78,               -- Phase Disruptor Cannon (Danimoth)
    GroundWeaponHits = 1,
    AirWeapon = 78,                  -- Phase Disruptor Cannon (Danimoth)
    AirWeaponHits = 1,
    FlagIsFlyer = true,
    FlagIsHero = true,
    FlagSpellcaster = true,
    FlagMediumOverlay = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    FlagMechanical = true,
    UnitDimensions = {22, 22, 21, 21},
    MineralCost = 50,
    GasCost = 1000,
    BuildTime = 4800,                -- 320.00 sec on Normal, 200.00 sec on Fastest
    Race = 2, -- Protoss
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Aldaris (Templar)
  {
    Flingy = 45,                      -- High Templar
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 300,
    max_health = 80,
    resistances = {  -- Small Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 0 },
      { type = "explosion", percent = 50 },
      { type = "fire", percent = 0 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 50 },
      { type = "electric", percent = 0 }
    },
    Armor = 2,
    ArmorUpgrade = 5,                -- Protoss Armor 
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 16,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 10,           -- Attack Unit (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 3,
    SightRange = 7,
    RightClickAction = 1,
    GroundWeapon = 69,               -- Psi Assault (Tassadar+Aldaris)
    GroundWeaponHits = 1,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsHero = true,
    FlagOrganic = true,
    FlagSpellcaster = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    UnitDimensions = {12, 14, 11, 13},
    MineralCost = 100,
    GasCost = 300,
    BuildTime = 1500,                -- 100.00 sec on Normal, 62.50 sec on Fastest
    Race = 2, -- Protoss
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 2,
    CargoSpace = 0
  }, -- Artanis (Scout)
  {
    Flingy = 43,                      -- Scout
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 250,
    max_health = 250,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 3,
    ArmorUpgrade = 6,                -- Protoss Plating 
    ElevationLevel = 18,
    has_belt_immunity = true,
    Rank = 12,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 10,           -- Attack Unit (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 0,
    SightRange = 10,
    RightClickAction = 1,
    GroundWeapon = 114,              -- Dual Photon Blasters (Artanis)
    GroundWeaponHits = 1,
    AirWeapon = 115,                 -- Anti-matter Missiles (Artanis)
    AirWeaponHits = 1,
    FlagIsFlyer = true,
    FlagIsHero = true,
    FlagMediumOverlay = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    FlagMechanical = true,
    UnitDimensions = {18, 16, 17, 15},
    MineralCost = 600,
    GasCost = 300,
    BuildTime = 2400,                -- 160.00 sec on Normal, 100.00 sec on Fastest
    Race = 2, -- Protoss
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Rhynadon (Badlands Critter)
  {
    Flingy = 115,                     -- Rhynadon (Badlands)
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 0,
    max_health = 60,
    resistances = {  -- Small Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 0 },
      { type = "explosion", percent = 50 },
      { type = "fire", percent = 0 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 50 },
      { type = "electric", percent = 0 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 166,        -- Idle (Critter)
    ReturnToIdleOrder = 166,          -- Idle (Critter)
    AttackUnitOrder = 188,          -- Fatal
    AttackMoveOrder = 188,          -- Fatal
    SeekRange = 0,
    SightRange = 7,
    RightClickAction = 2,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagOrganic = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    UnitDimensions = {16, 16, 15, 15},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 4, -- Neutral
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Bengalaas (Jungle Critter)
  {
    Flingy = 116,                     -- Bengalaas (Jungle)
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 0,
    max_health = 60,
    resistances = {  -- Small Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 0 },
      { type = "explosion", percent = 50 },
      { type = "fire", percent = 0 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 50 },
      { type = "electric", percent = 0 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 166,        -- Idle (Critter)
    ReturnToIdleOrder = 166,          -- Idle (Critter)
    AttackUnitOrder = 188,          -- Fatal
    AttackMoveOrder = 188,          -- Fatal
    SeekRange = 0,
    SightRange = 7,
    RightClickAction = 2,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagOrganic = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    UnitDimensions = {16, 16, 15, 15},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 4, -- Neutral
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Cargo Ship (Unused)
  {
    Flingy = 43,                      -- Scout
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 0,
    max_health = 125,
    resistances = {  -- Medium Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 50 },
      { type = "explosion", percent = 25 },
      { type = "fire", percent = 50 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 25 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 18,
    has_belt_immunity = true,
    Rank = 0,
    CompAIIdleOrder = 23,          -- Nothing 2 (Normal)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 8,
    SightRange = 8,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    UnitDimensions = {15, 15, 16, 16},
    MineralCost = 100,
    GasCost = 100,
    BuildTime = 600,                 -- 40.00 sec on Normal, 25.00 sec on Fastest
    Race = 0, -- Zerg
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Mercenary Gunship (Unused)
  {
    Flingy = 43,                      -- Scout
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 0,
    max_health = 125,
    resistances = {  -- Medium Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 50 },
      { type = "explosion", percent = 25 },
      { type = "fire", percent = 50 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 25 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 18,
    has_belt_immunity = true,
    Rank = 0,
    CompAIIdleOrder = 23,          -- Nothing 2 (Normal)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 4,
    SightRange = 7,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    UnitDimensions = {15, 15, 16, 16},
    MineralCost = 100,
    GasCost = 100,
    BuildTime = 600,                 -- 40.00 sec on Normal, 25.00 sec on Fastest
    Race = 0, -- Zerg
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Scantid (Desert Critter)
  {
    Flingy = 198,                     -- Scantid (Desert)
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 0,
    max_health = 60,
    resistances = {  -- Small Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 0 },
      { type = "explosion", percent = 50 },
      { type = "fire", percent = 0 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 50 },
      { type = "electric", percent = 0 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 166,        -- Idle (Critter)
    ReturnToIdleOrder = 166,          -- Idle (Critter)
    AttackUnitOrder = 188,          -- Fatal
    AttackMoveOrder = 188,          -- Fatal
    SeekRange = 0,
    SightRange = 7,
    RightClickAction = 2,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagOrganic = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    UnitDimensions = {16, 16, 15, 15},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 4, -- Neutral
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Kakaru (Twilight Critter)
  {
    Flingy = 199,                     -- Kakaru (Twilight)
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 0,
    max_health = 60,
    resistances = {  -- Small Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 0 },
      { type = "explosion", percent = 50 },
      { type = "fire", percent = 0 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 50 },
      { type = "electric", percent = 0 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 18,
    has_belt_immunity = true,
    Rank = 0,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 166,        -- Idle (Critter)
    ReturnToIdleOrder = 166,          -- Idle (Critter)
    AttackUnitOrder = 188,          -- Fatal
    AttackMoveOrder = 188,          -- Fatal
    SeekRange = 0,
    SightRange = 7,
    RightClickAction = 2,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsFlyer = true,
    FlagOrganic = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    UnitDimensions = {16, 16, 15, 15},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 4, -- Neutral
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Ragnasaur (Ashworld Critter)
  {
    Flingy = 114,                     -- Ragnasaur (Ashworld)
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 0,
    max_health = 60,
    resistances = {  -- Small Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 0 },
      { type = "explosion", percent = 50 },
      { type = "fire", percent = 0 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 50 },
      { type = "electric", percent = 0 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 166,        -- Idle (Critter)
    ReturnToIdleOrder = 166,          -- Idle (Critter)
    AttackUnitOrder = 188,          -- Fatal
    AttackMoveOrder = 188,          -- Fatal
    SeekRange = 0,
    SightRange = 7,
    RightClickAction = 2,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagOrganic = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    UnitDimensions = {16, 16, 15, 15},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 4, -- Neutral
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Ursadon (Ice World Critter)
  {
    Flingy = 200,                     -- Ursadon (Ice)
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 0,
    max_health = 60,
    resistances = {  -- Small Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 0 },
      { type = "explosion", percent = 50 },
      { type = "fire", percent = 0 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 50 },
      { type = "electric", percent = 0 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 166,        -- Idle (Critter)
    ReturnToIdleOrder = 166,          -- Idle (Critter)
    AttackUnitOrder = 188,          -- Fatal
    AttackMoveOrder = 188,          -- Fatal
    SeekRange = 0,
    SightRange = 7,
    RightClickAction = 2,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagOrganic = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    UnitDimensions = {16, 16, 15, 15},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 4, -- Neutral
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Lurker Egg
  {
    Flingy = 184,                     -- Lurker Egg
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 0,
    max_health = 200,
    resistances = {  -- Medium Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 50 },
      { type = "explosion", percent = 25 },
      { type = "fire", percent = 50 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 25 },
      { type = "electric", percent = 0 }
    },
    Armor = 10,
    ArmorUpgrade = 3,                -- Zerg Carapace 
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 1,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 2,            -- Guard (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 0,
    SightRange = 4,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagOrganic = true,
    UnitDimensions = {16, 16, 15, 15},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 0, -- Zerg
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Raszagal (Corsair)
  {
    Flingy = 191,                     -- Corsair
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 60,
    max_health = 100,
    resistances = {  -- Medium Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 50 },
      { type = "explosion", percent = 25 },
      { type = "fire", percent = 50 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 25 },
      { type = "electric", percent = 0 }
    },
    Armor = 0,
    ArmorUpgrade = 6,                -- Protoss Plating 
    ElevationLevel = 18,
    has_belt_immunity = true,
    Rank = 8,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 10,           -- Attack Unit (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 9,
    SightRange = 9,
    RightClickAction = 1,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 100,                 -- Neutron Flare
    AirWeaponHits = 1,
    FlagIsFlyer = true,
    FlagIsHero = true,
    FlagSpellcaster = true,
    FlagMediumOverlay = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    FlagMechanical = true,
    UnitDimensions = {24, 16, 24, 20},
    MineralCost = 150,
    GasCost = 100,
    BuildTime = 750,                 -- 50.00 sec on Normal, 31.25 sec on Fastest
    Race = 2, -- Protoss
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Samir Duran (Ghost)
  {
    Flingy = 74,                      -- Ghost
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 0,
    max_health = 200,
    resistances = {  -- Small Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 0 },
      { type = "explosion", percent = 50 },
      { type = "fire", percent = 0 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 50 },
      { type = "electric", percent = 0 }
    },
    Armor = 2,
    ArmorUpgrade = 0,                -- Terran Infantry Armor 
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 18,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 10,           -- Attack Unit (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 0,
    SightRange = 10,
    RightClickAction = 1,
    GroundWeapon = 112,              -- C-10 Concussion Rifle (Samir Duran)
    GroundWeaponHits = 1,
    AirWeapon = 112,                 -- C-10 Concussion Rifle (Samir Duran)
    AirWeaponHits = 1,
    FlagIsHero = true,
    FlagCloakable = true,
    FlagOrganic = true,
    FlagSpellcaster = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    UnitDimensions = {7, 10, 7, 11},
    MineralCost = 200,
    GasCost = 75,
    BuildTime = 1500,                -- 100.00 sec on Normal, 62.50 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 1,
    CargoSpace = 0
  }, -- Alexei Stukov (Ghost)
  {
    Flingy = 74,                      -- Ghost
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 0,
    max_health = 250,
    resistances = {  -- Small Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 0 },
      { type = "explosion", percent = 50 },
      { type = "fire", percent = 0 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 50 },
      { type = "electric", percent = 0 }
    },
    Armor = 3,
    ArmorUpgrade = 0,                -- Terran Infantry Armor 
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 22,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 10,           -- Attack Unit (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 0,
    SightRange = 11,
    RightClickAction = 1,
    GroundWeapon = 116,              -- C-10 Concussion Rifle (Alexei Stukov)
    GroundWeaponHits = 1,
    AirWeapon = 116,                 -- C-10 Concussion Rifle (Alexei Stukov)
    AirWeaponHits = 1,
    FlagIsHero = true,
    FlagCloakable = true,
    FlagOrganic = true,
    FlagSpellcaster = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    UnitDimensions = {7, 10, 7, 11},
    MineralCost = 200,
    GasCost = 75,
    BuildTime = 1500,                -- 100.00 sec on Normal, 62.50 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 1,
    CargoSpace = 0
  }, -- Map Revealer
  {
    Flingy = 139,                     -- Map Revealer
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 0,
    max_health = 1,
    resistances = {  -- Independent Size Type
      { type = "physical", percent = 99 },
      { type = "impact", percent = 99 },
      { type = "poison", percent = 99 },
      { type = "explosion", percent = 99 },
      { type = "fire", percent = 99 },
      { type = "laser", percent = 99 },
      { type = "acid", percent = 99 },
      { type = "electric", percent = 99 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 18,
    has_belt_immunity = true,
    Rank = 0,
    CompAIIdleOrder = 23,          -- Nothing 2 (Normal)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 10,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsFlyer = true,
    UnitDimensions = {13, 13, 13, 17},
    MineralCost = 0,
    GasCost = 0,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 4, -- Neutral
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Gerard DuGalle (BattleCruiser)
  {
    Flingy = 70,                      -- Battlecruiser
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 0,
    max_health = 700,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 4,
    ArmorUpgrade = 2,                -- Terran Ship Plating 
    ElevationLevel = 16,
    has_belt_immunity = true,
    Rank = 0,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 10,           -- Attack Unit (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 0,
    SightRange = 11,
    RightClickAction = 1,
    GroundWeapon = 21,               -- ATS Laser Battery (Norad II+Mengsk+DuGalle)
    GroundWeaponHits = 1,
    AirWeapon = 22,                  -- ATA Laser Battery (Norad II+Mengsk+DuGalle)
    AirWeaponHits = 1,
    FlagIsFlyer = true,
    FlagIsHero = true,
    FlagSpellcaster = true,
    FlagLargeOverlay = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    FlagMechanical = true,
    UnitDimensions = {37, 29, 37, 29},
    MineralCost = 800,
    GasCost = 600,
    BuildTime = 4800,                -- 320.00 sec on Normal, 200.00 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Zerg Lurker
  {
    Flingy = 186,                     -- Lurker
    SubUnit = 228,                  -- None
    ConstructionAnimation = 919,
    SpawnDirection = 12,
    MaxShields = 0,
    max_health = 125,
    resistances = {  -- Medium Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 50 },
      { type = "explosion", percent = 25 },
      { type = "fire", percent = 50 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 25 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 3,                -- Zerg Carapace 
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 10,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 11,           -- Attack In Range
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 6,
    SightRange = 8,
    RightClickAction = 2,
    GroundWeapon = 109,              -- Subterranean Spines
    GroundWeaponHits = 1,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    healing_per_tick = 0.0062,   -- Zerg Health Regen
    FlagOrganic = true,
    FlagBurrowable = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    UnitDimensions = {15, 15, 16, 16},
    MineralCost = 50,
    GasCost = 100,
    BuildTime = 600,                 -- 40.00 sec on Normal, 25.00 sec on Fastest
    Race = 0, -- Zerg
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 4,                  -- 2 supply in game
    CargoSize = 4,
    CargoSpace = 0
  }, -- Infested Duran (Infested Terran)
  {
    Flingy = 74,                      -- Ghost
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 32,
    MaxShields = 0,
    max_health = 300,
    resistances = {  -- Small Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 0 },
      { type = "explosion", percent = 50 },
      { type = "fire", percent = 0 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 50 },
      { type = "electric", percent = 0 }
    },
    Armor = 3,
    ArmorUpgrade = 3,                -- Zerg Carapace 
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 15,
    CompAIIdleOrder = 2,           -- Guard (Normal)
    HumanAIIdleOrder = 2,          -- Guard (Normal)
    ReturnToIdleOrder = 2,            -- Guard (Normal)
    AttackUnitOrder = 10,           -- Attack Unit (Normal)
    AttackMoveOrder = 2,            -- Guard (Normal)
    SeekRange = 0,
    SightRange = 11,
    RightClickAction = 1,
    GroundWeapon = 113,              -- C-10 Concussion Rifle (Infested Duran)
    GroundWeaponHits = 1,
    AirWeapon = 113,                 -- C-10 Concussion Rifle (Infested Duran)
    AirWeaponHits = 1,
    FlagIsHero = true,
    healing_per_tick = 0.0062,   -- Zerg Health Regen
    FlagCloakable = true,
    FlagOrganic = true,
    FlagSpellcaster = true,
    FlagAutoAttackAndMove = true,
    FlagCanAttack = true,
    UnitDimensions = {7, 10, 7, 11},
    MineralCost = 200,
    GasCost = 75,
    BuildTime = 1500,                -- 100.00 sec on Normal, 62.50 sec on Fastest
    Race = 0, -- Zerg
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 1,
    CargoSpace = 0
  }, -- Disruption Web
  {
    Flingy = 192,                     -- Disruption Web
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 800,
    resistances = {  -- Independent Size Type
      { type = "physical", percent = 99 },
      { type = "impact", percent = 99 },
      { type = "poison", percent = 99 },
      { type = "explosion", percent = 99 },
      { type = "fire", percent = 99 },
      { type = "laser", percent = 99 },
      { type = "acid", percent = 99 },
      { type = "electric", percent = 99 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 19,
    has_belt_immunity = true,
    Rank = 0,
    CompAIIdleOrder = 23,          -- Nothing 2 (Normal)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 8,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagInvincible = true,
    UnitDimensions = {60, 40, 59, 39},
    MineralCost = 250,
    GasCost = 250,
    BuildTime = 2400,                -- 160.00 sec on Normal, 100.00 sec on Fastest
    Race = 4, -- Neutral
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Terran Command Center
  {
    Flingy = 94,                      -- Command Center
    SubUnit = 228,                  -- None
    ConstructionAnimation = 325,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 1500,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = true,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 10,
    RightClickAction = 2,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagIsFlyingBuilding = true,
    FlagResourceDepot = true,
    FlagLargeOverlay = true,
    FlagMechanical = true,
    FlagProducesUnits = true,
    UnitDimensions = {58, 41, 58, 41},
    MineralCost = 400,
    GasCost = 0,
    BuildTime = 1800,                -- 120.00 sec on Normal, 75.00 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 20,             -- 10 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Terran Comsat Station
  {
    Flingy = 93,                      -- Comsat Station
    SubUnit = 228,                  -- None
    ConstructionAnimation = 330,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 500,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 10,
    RightClickAction = 6,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagIsAddon = true,
    FlagSpellcaster = true,
    FlagLargeOverlay = true,
    FlagMechanical = true,
    UnitDimensions = {37, 16, 31, 25},
    MineralCost = 50,
    GasCost = 50,
    BuildTime = 600,                 -- 40.00 sec on Normal, 25.00 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Terran Nuclear Silo
  {
    Flingy = 108,                     -- Nuke Silo
    SubUnit = 228,                  -- None
    ConstructionAnimation = 330,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 600,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 124,        -- Idle (Nuclear Silo)
    ReturnToIdleOrder = 124,          -- Idle (Nuclear Silo)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 8,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagIsAddon = true,
    FlagLargeOverlay = true,
    FlagMechanical = true,
    UnitDimensions = {37, 16, 31, 25},
    MineralCost = 100,
    GasCost = 100,
    BuildTime = 1200,                -- 80.00 sec on Normal, 50.00 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Terran Supply Depot
  {
    Flingy = 95,                      -- Supply Depot
    SubUnit = 228,                  -- None
    ConstructionAnimation = 330,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 500,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 8,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagLargeOverlay = true,
    FlagMechanical = true,
    UnitDimensions = {38, 22, 38, 26},
    MineralCost = 100,
    GasCost = 0,
    BuildTime = 600,                 -- 40.00 sec on Normal, 25.00 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 16,             -- 8 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Terran Refinery
  {
    Flingy = 105,                     -- Refinery
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 750,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 8,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagResourceContainer = true,
    FlagLargeOverlay = true,
    FlagMechanical = true,
    UnitDimensions = {56, 32, 56, 31},
    MineralCost = 100,
    GasCost = 0,
    BuildTime = 600,                 -- 40.00 sec on Normal, 25.00 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Terran Barracks
  {
    Flingy = 91,                      -- Barracks
    SubUnit = 228,                  -- None
    ConstructionAnimation = 325,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 1000,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = true,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 8,
    RightClickAction = 2,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagIsFlyingBuilding = true,
    FlagLargeOverlay = true,
    FlagMechanical = true,
    FlagProducesUnits = true,
    UnitDimensions = {48, 40, 56, 32},
    MineralCost = 150,
    GasCost = 0,
    BuildTime = 1200,                -- 80.00 sec on Normal, 50.00 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Terran Academy
  {
    Flingy = 90,                      -- Academy
    SubUnit = 228,                  -- None
    ConstructionAnimation = 327,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 600,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 8,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagLargeOverlay = true,
    FlagMechanical = true,
    UnitDimensions = {40, 32, 44, 24},
    MineralCost = 150,
    GasCost = 0,
    BuildTime = 1200,                -- 80.00 sec on Normal, 50.00 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Terran Factory
  {
    Flingy = 97,                      -- Factory
    SubUnit = 228,                  -- None
    ConstructionAnimation = 327,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 1250,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = true,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 8,
    RightClickAction = 2,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagIsFlyingBuilding = true,
    FlagLargeOverlay = true,
    FlagMechanical = true,
    FlagProducesUnits = true,
    UnitDimensions = {56, 40, 56, 40},
    MineralCost = 200,
    GasCost = 100,
    BuildTime = 1200,                -- 80.00 sec on Normal, 50.00 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Terran Starport
  {
    Flingy = 110,                     -- Starport
    SubUnit = 228,                  -- None
    ConstructionAnimation = 325,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 1300,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = true,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 10,
    RightClickAction = 2,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagIsFlyingBuilding = true,
    FlagLargeOverlay = true,
    FlagMechanical = true,
    UnitDimensions = {48, 40, 48, 38},
    MineralCost = 150,
    GasCost = 100,
    BuildTime = 1050,                -- 70.00 sec on Normal, 43.75 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Terran Control Tower
  {
    Flingy = 96,                      -- Control Tower
    SubUnit = 228,                  -- None
    ConstructionAnimation = 327,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 500,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 8,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagIsAddon = true,
    FlagLargeOverlay = true,
    FlagMechanical = true,
    UnitDimensions = {47, 24, 28, 22},
    MineralCost = 50,
    GasCost = 50,
    BuildTime = 600,                 -- 40.00 sec on Normal, 25.00 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Terran Science Facility
  {
    Flingy = 107,                     -- Science Facility
    SubUnit = 228,                  -- None
    ConstructionAnimation = 327,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 850,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = true,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 10,
    RightClickAction = 2,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagIsFlyingBuilding = true,
    FlagLargeOverlay = true,
    FlagMechanical = true,
    UnitDimensions = {48, 38, 48, 38},
    MineralCost = 100,
    GasCost = 150,
    BuildTime = 900,                 -- 60.00 sec on Normal, 37.50 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Terran Covert Ops
  {
    Flingy = 98,                      -- Covert Ops
    SubUnit = 228,                  -- None
    ConstructionAnimation = 330,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 750,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 8,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagIsAddon = true,
    FlagLargeOverlay = true,
    FlagMechanical = true,
    UnitDimensions = {47, 24, 28, 22},
    MineralCost = 50,
    GasCost = 50,
    BuildTime = 600,                 -- 40.00 sec on Normal, 25.00 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Terran Physics Lab
  {
    Flingy = 103,                     -- Physics Lab
    SubUnit = 228,                  -- None
    ConstructionAnimation = 330,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 600,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 8,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagIsAddon = true,
    FlagLargeOverlay = true,
    FlagMechanical = true,
    UnitDimensions = {47, 24, 28, 22},
    MineralCost = 50,
    GasCost = 50,
    BuildTime = 600,                 -- 40.00 sec on Normal, 25.00 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Starbase (Unused)
  {
    Flingy = 43,                      -- Scout
    SubUnit = 228,                  -- None
    ConstructionAnimation = 325,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 0,
    resistances = {  -- Independent Size Type
      { type = "physical", percent = 99 },
      { type = "impact", percent = 99 },
      { type = "poison", percent = 99 },
      { type = "explosion", percent = 99 },
      { type = "fire", percent = 99 },
      { type = "laser", percent = 99 },
      { type = "acid", percent = 99 },
      { type = "electric", percent = 99 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 8,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagLargeOverlay = true,
    UnitDimensions = {48, 32, 47, 31},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Terran Machine Shop
  {
    Flingy = 100,                     -- Machine Shop
    SubUnit = 228,                  -- None
    ConstructionAnimation = 327,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 750,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 8,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagIsAddon = true,
    FlagLargeOverlay = true,
    FlagMechanical = true,
    UnitDimensions = {39, 24, 31, 24},
    MineralCost = 50,
    GasCost = 50,
    BuildTime = 600,                 -- 40.00 sec on Normal, 25.00 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Repair Bay (Unused)
  {
    Flingy = 43,                      -- Scout
    SubUnit = 228,                  -- None
    ConstructionAnimation = 325,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 0,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 8,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagIsAddon = true,
    FlagLargeOverlay = true,
    FlagMechanical = true,
    UnitDimensions = {48, 48, 47, 47},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Terran Engineering Bay
  {
    Flingy = 111,                     -- Engineering Bay
    SubUnit = 228,                  -- None
    ConstructionAnimation = 327,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 850,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = true,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 8,
    RightClickAction = 2,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagIsFlyingBuilding = true,
    FlagLargeOverlay = true,
    FlagMechanical = true,
    UnitDimensions = {48, 32, 48, 28},
    MineralCost = 125,
    GasCost = 0,
    BuildTime = 900,                 -- 60.00 sec on Normal, 37.50 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Terran Armory
  {
    Flingy = 92,                      -- Armory
    SubUnit = 228,                  -- None
    ConstructionAnimation = 327,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 750,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 8,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagLargeOverlay = true,
    FlagMechanical = true,
    UnitDimensions = {48, 32, 47, 22},
    MineralCost = 100,
    GasCost = 50,
    BuildTime = 1200,                -- 80.00 sec on Normal, 50.00 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Terran Missile Turret
  {
    Flingy = 101,                     -- Missile Turret (Base)
    SubUnit = 228,                  -- None
    ConstructionAnimation = 329,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 200,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 18,          -- Guard (Building)
    HumanAIIdleOrder = 18,         -- Guard (Building)
    ReturnToIdleOrder = 18,           -- Guard (Building)
    AttackUnitOrder = 19,           -- Attack (Building)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 11,
    RightClickAction = 3,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 29,                  -- Longbolt Missiles
    AirWeaponHits = 1,
    FlagIsBuilding = true,
    FlagAnimatedIdle = true,
    FlagDetector = true,
    FlagLargeOverlay = true,
    FlagCanAttack = true,
    FlagMechanical = true,
    UnitDimensions = {16, 32, 16, 16},
    MineralCost = 75,
    GasCost = 0,
    BuildTime = 450,                 -- 30.00 sec on Normal, 18.75 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Terran Bunker
  {
    Flingy = 104,                     -- Bunker
    SubUnit = 228,                  -- None
    ConstructionAnimation = 330,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 350,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 3,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 10,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagLargeOverlay = true,
    FlagMechanical = true,
    FlagProducesUnits = true,
    UnitDimensions = {32, 24, 32, 16},
    MineralCost = 100,
    GasCost = 0,
    BuildTime = 450,                 -- 30.00 sec on Normal, 18.75 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 4
  }, -- Norad II (Crashed)
  {
    Flingy = 102,                     -- Crashed Battlecruiser
    SubUnit = 228,                  -- None
    ConstructionAnimation = 325,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 700,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 10,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagLargeOverlay = true,
    FlagMechanical = true,
    UnitDimensions = {48, 32, 47, 31},
    MineralCost = 800,
    GasCost = 600,
    BuildTime = 4800,                -- 320.00 sec on Normal, 200.00 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Ion Cannon
  {
    Flingy = 99,                      -- Ion Cannon
    SubUnit = 228,                  -- None
    ConstructionAnimation = 104,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 2000,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 8,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagLargeOverlay = true,
    FlagMechanical = true,
    UnitDimensions = {48, 32, 47, 31},
    MineralCost = 200,
    GasCost = 0,
    BuildTime = 900,                 -- 60.00 sec on Normal, 37.50 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Uraj Crystal
  {
    Flingy = 207,                     -- Uraj
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 10000,
    resistances = {  -- Independent Size Type
      { type = "physical", percent = 99 },
      { type = "impact", percent = 99 },
      { type = "poison", percent = 99 },
      { type = "explosion", percent = 99 },
      { type = "fire", percent = 99 },
      { type = "laser", percent = 99 },
      { type = "acid", percent = 99 },
      { type = "electric", percent = 99 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = true,
    Rank = 0,
    CompAIIdleOrder = 97,          -- Idle (Power-Up)
    HumanAIIdleOrder = 97,         -- Idle (Power-Up)
    ReturnToIdleOrder = 97,           -- Idle (Power-Up)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 5,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagSingleEntity = true,
    FlagInvincible = true,
    UnitDimensions = {16, 16, 15, 15},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 4, -- Neutral
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Khalis Crystal
  {
    Flingy = 208,                     -- Khalis
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 10000,
    resistances = {  -- Independent Size Type
      { type = "physical", percent = 99 },
      { type = "impact", percent = 99 },
      { type = "poison", percent = 99 },
      { type = "explosion", percent = 99 },
      { type = "fire", percent = 99 },
      { type = "laser", percent = 99 },
      { type = "acid", percent = 99 },
      { type = "electric", percent = 99 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = true,
    Rank = 0,
    CompAIIdleOrder = 97,          -- Idle (Power-Up)
    HumanAIIdleOrder = 97,         -- Idle (Power-Up)
    ReturnToIdleOrder = 97,           -- Idle (Power-Up)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 5,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagSingleEntity = true,
    FlagInvincible = true,
    UnitDimensions = {16, 16, 15, 15},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 4, -- Neutral
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Infested Command Center
  {
    Flingy = 17,                      -- Infested Command Center
    SubUnit = 228,                  -- None
    ConstructionAnimation = 101,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 1500,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = true,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 10,
    RightClickAction = 2,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagIsFlyingBuilding = true,
    healing_per_tick = 0.0062,   -- Zerg Health Regen
    FlagOrganic = true,
    FlagLargeOverlay = true,
    UnitDimensions = {58, 41, 58, 41},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1800,                -- 120.00 sec on Normal, 75.00 sec on Fastest
    Race = 0, -- Zerg
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Zerg Hatchery
  {
    Flingy = 22,                      -- Hatchery
    SubUnit = 228,                  -- None
    ConstructionAnimation = 104,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 1250,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 101,         -- Script (Starting Creep Growth)
    HumanAIIdleOrder = 101,        -- Script (Starting Creep Growth)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 9,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    healing_per_tick = 0.0062,   -- Zerg Health Regen
    FlagResourceDepot = true,
    FlagOrganic = true,
    FlagMorphFromOtherUnit = true,
    FlagLargeOverlay = true,
    FlagProducesUnits = true,
    UnitDimensions = {49, 32, 49, 32},
    MineralCost = 300,
    GasCost = 0,
    BuildTime = 1800,                -- 120.00 sec on Normal, 75.00 sec on Fastest
    Race = 0, -- Zerg
    SupplyProvided = 2,              -- 1 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Zerg Lair
  {
    Flingy = 24,                      -- Lair
    SubUnit = 228,                  -- None
    ConstructionAnimation = 103,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 1800,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 101,         -- Script (Starting Creep Growth)
    HumanAIIdleOrder = 101,        -- Script (Starting Creep Growth)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 10,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    healing_per_tick = 0.0062,   -- Zerg Health Regen
    FlagResourceDepot = true,
    FlagOrganic = true,
    FlagMorphFromOtherUnit = true,
    FlagLargeOverlay = true,
    FlagProducesUnits = true,
    UnitDimensions = {49, 32, 49, 32},
    MineralCost = 150,
    GasCost = 100,
    BuildTime = 1500,                -- 100.00 sec on Normal, 62.50 sec on Fastest
    Race = 0, -- Zerg
    SupplyProvided = 2,              -- 1 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Zerg Hive
  {
    Flingy = 23,                      -- Hive
    SubUnit = 228,                  -- None
    ConstructionAnimation = 103,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 2500,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 101,         -- Script (Starting Creep Growth)
    HumanAIIdleOrder = 101,        -- Script (Starting Creep Growth)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 11,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    healing_per_tick = 0.0062,   -- Zerg Health Regen
    FlagResourceDepot = true,
    FlagOrganic = true,
    FlagMorphFromOtherUnit = true,
    FlagLargeOverlay = true,
    FlagProducesUnits = true,
    UnitDimensions = {49, 32, 49, 32},
    MineralCost = 200,
    GasCost = 150,
    BuildTime = 1800,                -- 120.00 sec on Normal, 75.00 sec on Fastest
    Race = 0, -- Zerg
    SupplyProvided = 2,              -- 1 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Zerg Nydus Canal
  {
    Flingy = 29,                      -- Nydus Canal
    SubUnit = 228,                  -- None
    ConstructionAnimation = 104,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 250,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 8,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    healing_per_tick = 0.0062,   -- Zerg Health Regen
    FlagOrganic = true,
    FlagRequiresCreep = true,
    FlagMorphFromOtherUnit = true,
    FlagLargeOverlay = true,
    UnitDimensions = {32, 32, 31, 31},
    MineralCost = 150,
    GasCost = 0,
    BuildTime = 600,                 -- 40.00 sec on Normal, 25.00 sec on Fastest
    Race = 0, -- Zerg
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Zerg Hydralisk Den
  {
    Flingy = 34,                      -- Hydralisk Den
    SubUnit = 228,                  -- None
    ConstructionAnimation = 104,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 850,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 8,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    healing_per_tick = 0.0062,   -- Zerg Health Regen
    FlagOrganic = true,
    FlagRequiresCreep = true,
    FlagMorphFromOtherUnit = true,
    FlagLargeOverlay = true,
    UnitDimensions = {40, 32, 40, 24},
    MineralCost = 100,
    GasCost = 50,
    BuildTime = 600,                 -- 40.00 sec on Normal, 25.00 sec on Fastest
    Race = 0, -- Zerg
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Zerg Defiler Mound
  {
    Flingy = 27,                      -- Defiler Mound
    SubUnit = 228,                  -- None
    ConstructionAnimation = 104,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 850,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 8,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    healing_per_tick = 0.0062,   -- Zerg Health Regen
    FlagOrganic = true,
    FlagRequiresCreep = true,
    FlagMorphFromOtherUnit = true,
    FlagLargeOverlay = true,
    UnitDimensions = {48, 32, 48, 4},
    MineralCost = 100,
    GasCost = 100,
    BuildTime = 900,                 -- 60.00 sec on Normal, 37.50 sec on Fastest
    Race = 0, -- Zerg
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Zerg Greater Spire
  {
    Flingy = 26,                      -- Greater Spire
    SubUnit = 228,                  -- None
    ConstructionAnimation = 104,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 1000,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 8,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    healing_per_tick = 0.0062,   -- Zerg Health Regen
    FlagOrganic = true,
    FlagRequiresCreep = true,
    FlagMorphFromOtherUnit = true,
    FlagLargeOverlay = true,
    UnitDimensions = {28, 32, 28, 24},
    MineralCost = 100,
    GasCost = 150,
    BuildTime = 1800,                -- 120.00 sec on Normal, 75.00 sec on Fastest
    Race = 0, -- Zerg
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Zerg Queen's Nest
  {
    Flingy = 28,                      -- Queen's Nest
    SubUnit = 228,                  -- None
    ConstructionAnimation = 104,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 850,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 8,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    healing_per_tick = 0.0062,   -- Zerg Health Regen
    FlagOrganic = true,
    FlagRequiresCreep = true,
    FlagMorphFromOtherUnit = true,
    FlagLargeOverlay = true,
    UnitDimensions = {38, 28, 32, 28},
    MineralCost = 150,
    GasCost = 100,
    BuildTime = 900,                 -- 60.00 sec on Normal, 37.50 sec on Fastest
    Race = 0, -- Zerg
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Zerg Evolution Chamber
  {
    Flingy = 20,                      -- Evolution Chamber
    SubUnit = 228,                  -- None
    ConstructionAnimation = 104,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 750,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 8,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    healing_per_tick = 0.0062,   -- Zerg Health Regen
    FlagOrganic = true,
    FlagRequiresCreep = true,
    FlagMorphFromOtherUnit = true,
    FlagLargeOverlay = true,
    UnitDimensions = {44, 32, 32, 20},
    MineralCost = 75,
    GasCost = 0,
    BuildTime = 600,                 -- 40.00 sec on Normal, 25.00 sec on Fastest
    Race = 0, -- Zerg
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Zerg Ultralisk Cavern
  {
    Flingy = 32,                      -- Ultralisk Cavern
    SubUnit = 228,                  -- None
    ConstructionAnimation = 104,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 600,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 8,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    healing_per_tick = 0.0062,   -- Zerg Health Regen
    FlagOrganic = true,
    FlagRequiresCreep = true,
    FlagMorphFromOtherUnit = true,
    FlagLargeOverlay = true,
    UnitDimensions = {40, 32, 32, 31},
    MineralCost = 150,
    GasCost = 200,
    BuildTime = 1200,                -- 80.00 sec on Normal, 50.00 sec on Fastest
    Race = 0, -- Zerg
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Zerg Spire
  {
    Flingy = 35,                      -- Spire
    SubUnit = 228,                  -- None
    ConstructionAnimation = 104,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 600,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 8,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    healing_per_tick = 0.0062,   -- Zerg Health Regen
    FlagOrganic = true,
    FlagRequiresCreep = true,
    FlagMorphFromOtherUnit = true,
    FlagLargeOverlay = true,
    UnitDimensions = {28, 32, 28, 24},
    MineralCost = 200,
    GasCost = 150,
    BuildTime = 1800,                -- 120.00 sec on Normal, 75.00 sec on Fastest
    Race = 0, -- Zerg
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Zerg Spawning Pool
  {
    Flingy = 18,                      -- Spawning Pool
    SubUnit = 228,                  -- None
    ConstructionAnimation = 104,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 750,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 2,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 8,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    healing_per_tick = 0.0062,   -- Zerg Health Regen
    FlagOrganic = true,
    FlagRequiresCreep = true,
    FlagMorphFromOtherUnit = true,
    FlagLargeOverlay = true,
    UnitDimensions = {36, 28, 40, 18},
    MineralCost = 200,
    GasCost = 0,
    BuildTime = 1200,                -- 80.00 sec on Normal, 50.00 sec on Fastest
    Race = 0, -- Zerg
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Zerg Creep Colony
  {
    Flingy = 21,                      -- Creep Colony
    SubUnit = 228,                  -- None
    ConstructionAnimation = 105,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 400,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 101,         -- Script (Starting Creep Growth)
    HumanAIIdleOrder = 101,        -- Script (Starting Creep Growth)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 10,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    healing_per_tick = 0.0062,   -- Zerg Health Regen
    FlagOrganic = true,
    FlagRequiresCreep = true,
    FlagMorphFromOtherUnit = true,
    FlagLargeOverlay = true,
    UnitDimensions = {24, 24, 23, 23},
    MineralCost = 75,
    GasCost = 0,
    BuildTime = 300,                 -- 20.00 sec on Normal, 12.50 sec on Fastest
    Race = 0, -- Zerg
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Zerg Spore Colony
  {
    Flingy = 36,                      -- Spore Colony
    SubUnit = 228,                  -- None
    ConstructionAnimation = 105,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 400,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 101,         -- Script (Starting Creep Growth)
    HumanAIIdleOrder = 101,        -- Script (Starting Creep Growth)
    ReturnToIdleOrder = 18,           -- Guard (Building)
    AttackUnitOrder = 19,           -- Attack (Building)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 10,
    RightClickAction = 3,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 52,                  -- Seeker Spores
    AirWeaponHits = 1,
    FlagIsBuilding = true,
    healing_per_tick = 0.0062,   -- Zerg Health Regen
    FlagDetector = true,
    FlagOrganic = true,
    FlagRequiresCreep = true,
    FlagMorphFromOtherUnit = true,
    FlagLargeOverlay = true,
    FlagCanAttack = true,
    UnitDimensions = {24, 24, 23, 23},
    MineralCost = 50,
    GasCost = 0,
    BuildTime = 300,                 -- 20.00 sec on Normal, 12.50 sec on Fastest
    Race = 0, -- Zerg
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Unused Zerg Building1
  {
    Flingy = 43,                      -- Scout
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 0,
    resistances = {  -- Independent Size Type
      { type = "physical", percent = 99 },
      { type = "impact", percent = 99 },
      { type = "poison", percent = 99 },
      { type = "explosion", percent = 99 },
      { type = "fire", percent = 99 },
      { type = "laser", percent = 99 },
      { type = "acid", percent = 99 },
      { type = "electric", percent = 99 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 7,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    healing_per_tick = 0.0062,   -- Zerg Health Regen
    FlagResourceContainer = true,
    FlagMorphFromOtherUnit = true,
    FlagLargeOverlay = true,
    UnitDimensions = {48, 48, 47, 47},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 0, -- Zerg
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Zerg Sunken Colony
  {
    Flingy = 25,                      -- Sunken Colony
    SubUnit = 228,                  -- None
    ConstructionAnimation = 105,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 300,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 2,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 101,         -- Script (Starting Creep Growth)
    HumanAIIdleOrder = 101,        -- Script (Starting Creep Growth)
    ReturnToIdleOrder = 18,           -- Guard (Building)
    AttackUnitOrder = 19,           -- Attack (Building)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 10,
    RightClickAction = 3,
    GroundWeapon = 53,               -- Subterranean Tentacle
    GroundWeaponHits = 1,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    healing_per_tick = 0.0062,   -- Zerg Health Regen
    FlagOrganic = true,
    FlagRequiresCreep = true,
    FlagMorphFromOtherUnit = true,
    FlagLargeOverlay = true,
    FlagCanAttack = true,
    UnitDimensions = {24, 24, 23, 23},
    MineralCost = 50,
    GasCost = 0,
    BuildTime = 300,                 -- 20.00 sec on Normal, 12.50 sec on Fastest
    Race = 0, -- Zerg
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Zerg Overmind (With Shell)
  {
    Flingy = 30,                      -- Overmind With Shell
    SubUnit = 228,                  -- None
    ConstructionAnimation = 103,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 5000,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 8,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    healing_per_tick = 0.0062,   -- Zerg Health Regen
    FlagDetector = true,
    FlagOrganic = true,
    FlagRequiresCreep = true,
    FlagMorphFromOtherUnit = true,
    FlagLargeOverlay = true,
    UnitDimensions = {80, 32, 79, 40},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 0, -- Zerg
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Zerg Overmind
  {
    Flingy = 31,                      -- Overmind Without Shell
    SubUnit = 228,                  -- None
    ConstructionAnimation = 103,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 2500,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 8,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    healing_per_tick = 0.0062,   -- Zerg Health Regen
    FlagDetector = true,
    FlagOrganic = true,
    FlagRequiresCreep = true,
    FlagMorphFromOtherUnit = true,
    FlagLargeOverlay = true,
    UnitDimensions = {80, 32, 79, 40},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 0, -- Zerg
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Zerg Extractor
  {
    Flingy = 33,                      -- Extractor
    SubUnit = 228,                  -- None
    ConstructionAnimation = 102,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 750,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 7,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    healing_per_tick = 0.0062,   -- Zerg Health Regen
    FlagResourceContainer = true,
    FlagOrganic = true,
    FlagMorphFromOtherUnit = true,
    FlagLargeOverlay = true,
    UnitDimensions = {64, 32, 63, 31},
    MineralCost = 50,
    GasCost = 0,
    BuildTime = 600,                 -- 40.00 sec on Normal, 25.00 sec on Fastest
    Race = 0, -- Zerg
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Mature Chrysalis
  {
    Flingy = 19,                      -- Mature Chrysalis
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 250,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 8,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    healing_per_tick = 0.0062,   -- Zerg Health Regen
    FlagOrganic = true,
    FlagRequiresCreep = true,
    FlagMorphFromOtherUnit = true,
    FlagLargeOverlay = true,
    UnitDimensions = {32, 32, 31, 31},
    MineralCost = 0,
    GasCost = 0,
    BuildTime = 0,                   -- 0.00 sec on Normal, 0.00 sec on Fastest
    Race = 0, -- Zerg
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Zerg Cerebrate
  {
    Flingy = 16,                      -- Cerebrate
    SubUnit = 228,                  -- None
    ConstructionAnimation = 104,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 1500,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 8,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    healing_per_tick = 0.0062,   -- Zerg Health Regen
    FlagDetector = true,
    FlagOrganic = true,
    FlagRequiresCreep = true,
    FlagMorphFromOtherUnit = true,
    FlagLargeOverlay = true,
    UnitDimensions = {40, 32, 32, 31},
    MineralCost = 0,
    GasCost = 0,
    BuildTime = 0,                   -- 0.00 sec on Normal, 0.00 sec on Fastest
    Race = 0, -- Zerg
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Zerg Cerebrate Daggoth
  {
    Flingy = 16,                      -- Cerebrate
    SubUnit = 228,                  -- None
    ConstructionAnimation = 104,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 1500,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 8,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    healing_per_tick = 0.0062,   -- Zerg Health Regen
    FlagDetector = true,
    FlagOrganic = true,
    FlagRequiresCreep = true,
    FlagMorphFromOtherUnit = true,
    FlagLargeOverlay = true,
    UnitDimensions = {40, 32, 32, 31},
    MineralCost = 0,
    GasCost = 0,
    BuildTime = 0,                   -- 0.00 sec on Normal, 0.00 sec on Fastest
    Race = 0, -- Zerg
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Unused Zerg Building2
  {
    Flingy = 43,                      -- Scout
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 0,
    resistances = {  -- Independent Size Type
      { type = "physical", percent = 99 },
      { type = "impact", percent = 99 },
      { type = "poison", percent = 99 },
      { type = "explosion", percent = 99 },
      { type = "fire", percent = 99 },
      { type = "laser", percent = 99 },
      { type = "acid", percent = 99 },
      { type = "electric", percent = 99 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 7,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    healing_per_tick = 0.0062,   -- Zerg Health Regen
    FlagMorphFromOtherUnit = true,
    FlagLargeOverlay = true,
    UnitDimensions = {16, 16, 15, 15},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 0, -- Zerg
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Protoss Nexus
  {
    Flingy = 59,                      -- Nexus
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 750,
    max_health = 750,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 11,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagResourceDepot = true,
    FlagLargeOverlay = true,
    FlagMechanical = true,
    FlagProducesUnits = true,
    UnitDimensions = {56, 39, 56, 39},
    MineralCost = 400,
    GasCost = 0,
    BuildTime = 1800,                -- 120.00 sec on Normal, 75.00 sec on Fastest
    Race = 2, -- Protoss
    SupplyProvided = 18,             -- 9 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Protoss Robotics Facility
  {
    Flingy = 63,                      -- Robotics Facility
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 500,
    max_health = 500,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 10,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagRequiredPsi = true,
    FlagLargeOverlay = true,
    FlagMechanical = true,
    FlagProducesUnits = true,
    UnitDimensions = {36, 16, 40, 20},
    MineralCost = 200,
    GasCost = 200,
    BuildTime = 1200,                -- 80.00 sec on Normal, 50.00 sec on Fastest
    Race = 2, -- Protoss
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Protoss Pylon
  {
    Flingy = 62,                      -- Pylon
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 300,
    max_health = 300,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 164,         -- Script (PSI Provider)
    HumanAIIdleOrder = 164,        -- Script (PSI Provider)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 8,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagLargeOverlay = true,
    FlagMechanical = true,
    UnitDimensions = {16, 12, 16, 20},
    MineralCost = 100,
    GasCost = 0,
    BuildTime = 450,                 -- 30.00 sec on Normal, 18.75 sec on Fastest
    Race = 2, -- Protoss
    SupplyProvided = 16,             -- 8 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Protoss Assimilator
  {
    Flingy = 52,                      -- Assimilator
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 450,
    max_health = 450,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 10,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagResourceContainer = true,
    FlagLargeOverlay = true,
    FlagMechanical = true,
    UnitDimensions = {48, 32, 48, 24},
    MineralCost = 100,
    GasCost = 0,
    BuildTime = 600,                 -- 40.00 sec on Normal, 25.00 sec on Fastest
    Race = 2, -- Protoss
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Unused Protoss Building1
  {
    Flingy = 43,                      -- Scout
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 300,
    max_health = 300,
    resistances = {  -- Independent Size Type
      { type = "physical", percent = 99 },
      { type = "impact", percent = 99 },
      { type = "poison", percent = 99 },
      { type = "explosion", percent = 99 },
      { type = "fire", percent = 99 },
      { type = "laser", percent = 99 },
      { type = "acid", percent = 99 },
      { type = "electric", percent = 99 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 7,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagRequiredPsi = true,
    FlagLargeOverlay = true,
    FlagMechanical = true,
    UnitDimensions = {64, 48, 63, 47},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 2, -- Protoss
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Protoss Observatory
  {
    Flingy = 53,                      -- Observatory
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 250,
    max_health = 250,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 10,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagRequiredPsi = true,
    FlagLargeOverlay = true,
    FlagMechanical = true,
    UnitDimensions = {44, 16, 44, 28},
    MineralCost = 50,
    GasCost = 100,
    BuildTime = 450,                 -- 30.00 sec on Normal, 18.75 sec on Fastest
    Race = 2, -- Protoss
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Protoss Gateway
  {
    Flingy = 56,                      -- Gateway
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 500,
    max_health = 500,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 10,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagRequiredPsi = true,
    FlagLargeOverlay = true,
    FlagMechanical = true,
    FlagProducesUnits = true,
    UnitDimensions = {48, 32, 48, 40},
    MineralCost = 150,
    GasCost = 0,
    BuildTime = 900,                 -- 60.00 sec on Normal, 37.50 sec on Fastest
    Race = 2, -- Protoss
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Unused Protoss Building2
  {
    Flingy = 43,                      -- Scout
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 1,
    max_health = 0,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 10,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagRequiredPsi = true,
    FlagLargeOverlay = true,
    FlagMechanical = true,
    UnitDimensions = {48, 48, 47, 47},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 2, -- Protoss
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Protoss Photon Cannon
  {
    Flingy = 60,                      -- Photon Cannon
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 100,
    max_health = 100,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 18,          -- Guard (Building)
    HumanAIIdleOrder = 18,         -- Guard (Building)
    ReturnToIdleOrder = 18,           -- Guard (Building)
    AttackUnitOrder = 19,           -- Attack (Building)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 11,
    RightClickAction = 3,
    GroundWeapon = 80,               -- STS Photon Cannon
    GroundWeaponHits = 1,
    AirWeapon = 81,                  -- STA Photon Cannon
    AirWeaponHits = 1,
    FlagIsBuilding = true,
    FlagDetector = true,
    FlagRequiredPsi = true,
    FlagLargeOverlay = true,
    FlagCanAttack = true,
    FlagMechanical = true,
    UnitDimensions = {20, 16, 20, 16},
    MineralCost = 150,
    GasCost = 0,
    BuildTime = 750,                 -- 50.00 sec on Normal, 31.25 sec on Fastest
    Race = 2, -- Protoss
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Protoss Citadel of Adun
  {
    Flingy = 54,                      -- Citadel of Adun
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 450,
    max_health = 450,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 10,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagRequiredPsi = true,
    FlagLargeOverlay = true,
    FlagMechanical = true,
    UnitDimensions = {24, 24, 40, 24},
    MineralCost = 150,
    GasCost = 100,
    BuildTime = 900,                 -- 60.00 sec on Normal, 37.50 sec on Fastest
    Race = 2, -- Protoss
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Protoss Cybernetics Core
  {
    Flingy = 57,                      -- Cybernetics Core
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 500,
    max_health = 500,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 10,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagRequiredPsi = true,
    FlagLargeOverlay = true,
    FlagMechanical = true,
    UnitDimensions = {40, 24, 40, 24},
    MineralCost = 200,
    GasCost = 0,
    BuildTime = 900,                 -- 60.00 sec on Normal, 37.50 sec on Fastest
    Race = 2, -- Protoss
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Protoss Templar Archives
  {
    Flingy = 51,                      -- Templar Archives
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 500,
    max_health = 500,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 10,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagRequiredPsi = true,
    FlagLargeOverlay = true,
    FlagMechanical = true,
    UnitDimensions = {32, 24, 32, 24},
    MineralCost = 150,
    GasCost = 200,
    BuildTime = 900,                 -- 60.00 sec on Normal, 37.50 sec on Fastest
    Race = 2, -- Protoss
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Protoss Forge
  {
    Flingy = 55,                      -- Forge
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 550,
    max_health = 550,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 10,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagRequiredPsi = true,
    FlagLargeOverlay = true,
    FlagMechanical = true,
    UnitDimensions = {36, 24, 36, 20},
    MineralCost = 150,
    GasCost = 0,
    BuildTime = 600,                 -- 40.00 sec on Normal, 25.00 sec on Fastest
    Race = 2, -- Protoss
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Protoss Stargate
  {
    Flingy = 65,                      -- Stargate
    SubUnit = 228,                  -- None
    ConstructionAnimation = 200,
    SpawnDirection = 0,
    MaxShields = 600,
    max_health = 600,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 10,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagRequiredPsi = true,
    FlagLargeOverlay = true,
    FlagMechanical = true,
    UnitDimensions = {48, 40, 48, 32},
    MineralCost = 150,
    GasCost = 150,
    BuildTime = 1050,                -- 70.00 sec on Normal, 43.75 sec on Fastest
    Race = 2, -- Protoss
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Stasis Cell/Prison
  {
    Flingy = 66,                      -- Stasis Cell/Prison
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 2000,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 8,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagLargeOverlay = true,
    FlagMechanical = true,
    UnitDimensions = {64, 48, 63, 47},
    MineralCost = 150,
    GasCost = 0,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 2, -- Protoss
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Protoss Fleet Beacon
  {
    Flingy = 69,                      -- Fleet Beacon
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 500,
    max_health = 500,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 10,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagRequiredPsi = true,
    FlagLargeOverlay = true,
    FlagMechanical = true,
    UnitDimensions = {40, 32, 47, 24},
    MineralCost = 300,
    GasCost = 200,
    BuildTime = 900,                 -- 60.00 sec on Normal, 37.50 sec on Fastest
    Race = 2, -- Protoss
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Protoss Arbiter Tribunal
  {
    Flingy = 61,                      -- Arbiter Tribunal
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 500,
    max_health = 500,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 10,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagRequiredPsi = true,
    FlagLargeOverlay = true,
    FlagMechanical = true,
    UnitDimensions = {44, 28, 44, 28},
    MineralCost = 200,
    GasCost = 150,
    BuildTime = 900,                 -- 60.00 sec on Normal, 37.50 sec on Fastest
    Race = 2, -- Protoss
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Protoss Robotics Support Bay
  {
    Flingy = 67,                      -- Robotics Support Bay
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 450,
    max_health = 450,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 10,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagRequiredPsi = true,
    FlagLargeOverlay = true,
    FlagMechanical = true,
    UnitDimensions = {32, 32, 32, 20},
    MineralCost = 150,
    GasCost = 100,
    BuildTime = 450,                 -- 30.00 sec on Normal, 18.75 sec on Fastest
    Race = 2, -- Protoss
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Protoss Shield Battery
  {
    Flingy = 64,                      -- Shield Battery
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 200,
    max_health = 200,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 10,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagRequiredPsi = true,
    FlagSpellcaster = true,
    FlagLargeOverlay = true,
    FlagMechanical = true,
    UnitDimensions = {32, 16, 32, 16},
    MineralCost = 100,
    GasCost = 0,
    BuildTime = 450,                 -- 30.00 sec on Normal, 18.75 sec on Fastest
    Race = 2, -- Protoss
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Khaydarin Crystal Formation
  {
    Flingy = 58,                      -- Khaydarin Crystal Formation
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 100000,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 10,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagLargeOverlay = true,
    FlagInvincible = true,
    UnitDimensions = {64, 48, 63, 47},
    MineralCost = 250,
    GasCost = 0,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 2, -- Protoss
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Protoss Temple
  {
    Flingy = 68,                      -- Protoss Temple
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 1500,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 10,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagLargeOverlay = true,
    UnitDimensions = {112, 48, 111, 47},
    MineralCost = 250,
    GasCost = 0,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 2, -- Protoss
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Xel'Naga Temple
  {
    Flingy = 197,                     -- Xel'Naga Temple
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 5000,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 10,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagLargeOverlay = true,
    UnitDimensions = {80, 34, 79, 63},
    MineralCost = 1500,
    GasCost = 500,
    BuildTime = 4800,                -- 320.00 sec on Normal, 200.00 sec on Fastest
    Race = 2, -- Protoss
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Mineral Field (Type 1)
  {
    Flingy = 118,                     -- Mineral Field Type1
    SubUnit = 228,                  -- None
    ConstructionAnimation = 325,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 100000,
    resistances = {  -- Independent Size Type
      { type = "physical", percent = 99 },
      { type = "impact", percent = 99 },
      { type = "poison", percent = 99 },
      { type = "explosion", percent = 99 },
      { type = "fire", percent = 99 },
      { type = "laser", percent = 99 },
      { type = "acid", percent = 99 },
      { type = "electric", percent = 99 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 23,          -- Nothing 2 (Normal)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 9,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagResourceContainer = true,
    FlagLargeOverlay = true,
    FlagInvincible = true,
    UnitDimensions = {32, 16, 31, 15},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 4, -- Neutral
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Mineral Field (Type 2)
  {
    Flingy = 119,                     -- Mineral Field Type2
    SubUnit = 228,                  -- None
    ConstructionAnimation = 325,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 100000,
    resistances = {  -- Independent Size Type
      { type = "physical", percent = 99 },
      { type = "impact", percent = 99 },
      { type = "poison", percent = 99 },
      { type = "explosion", percent = 99 },
      { type = "fire", percent = 99 },
      { type = "laser", percent = 99 },
      { type = "acid", percent = 99 },
      { type = "electric", percent = 99 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 23,          -- Nothing 2 (Normal)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 9,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagResourceContainer = true,
    FlagLargeOverlay = true,
    FlagInvincible = true,
    UnitDimensions = {32, 16, 31, 15},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 4, -- Neutral
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Mineral Field (Type 3)
  {
    Flingy = 120,                     -- Mineral Field Type3
    SubUnit = 228,                  -- None
    ConstructionAnimation = 325,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 100000,
    resistances = {  -- Independent Size Type
      { type = "physical", percent = 99 },
      { type = "impact", percent = 99 },
      { type = "poison", percent = 99 },
      { type = "explosion", percent = 99 },
      { type = "fire", percent = 99 },
      { type = "laser", percent = 99 },
      { type = "acid", percent = 99 },
      { type = "electric", percent = 99 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 23,          -- Nothing 2 (Normal)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 9,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagResourceContainer = true,
    FlagLargeOverlay = true,
    FlagInvincible = true,
    UnitDimensions = {32, 16, 31, 15},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 4, -- Neutral
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Cave (Unused)
  {
    Flingy = 43,                      -- Scout
    SubUnit = 228,                  -- None
    ConstructionAnimation = 325,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 800,
    resistances = {  -- Independent Size Type
      { type = "physical", percent = 99 },
      { type = "impact", percent = 99 },
      { type = "poison", percent = 99 },
      { type = "explosion", percent = 99 },
      { type = "fire", percent = 99 },
      { type = "laser", percent = 99 },
      { type = "acid", percent = 99 },
      { type = "electric", percent = 99 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 23,          -- Nothing 2 (Normal)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 9,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagResourceContainer = true,
    FlagLargeOverlay = true,
    FlagInvincible = true,
    UnitDimensions = {32, 32, 31, 31},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 4, -- Neutral
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Cave-in (Unused)
  {
    Flingy = 43,                      -- Scout
    SubUnit = 228,                  -- None
    ConstructionAnimation = 325,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 800,
    resistances = {  -- Independent Size Type
      { type = "physical", percent = 99 },
      { type = "impact", percent = 99 },
      { type = "poison", percent = 99 },
      { type = "explosion", percent = 99 },
      { type = "fire", percent = 99 },
      { type = "laser", percent = 99 },
      { type = "acid", percent = 99 },
      { type = "electric", percent = 99 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 23,          -- Nothing 2 (Normal)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 9,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagResourceContainer = true,
    FlagLargeOverlay = true,
    FlagInvincible = true,
    UnitDimensions = {32, 32, 31, 31},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 4, -- Neutral
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Cantina (Unused)
  {
    Flingy = 43,                      -- Scout
    SubUnit = 228,                  -- None
    ConstructionAnimation = 325,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 800,
    resistances = {  -- Independent Size Type
      { type = "physical", percent = 99 },
      { type = "impact", percent = 99 },
      { type = "poison", percent = 99 },
      { type = "explosion", percent = 99 },
      { type = "fire", percent = 99 },
      { type = "laser", percent = 99 },
      { type = "acid", percent = 99 },
      { type = "electric", percent = 99 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 23,          -- Nothing 2 (Normal)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 9,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagLargeOverlay = true,
    FlagMechanical = true,
    UnitDimensions = {32, 32, 31, 31},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 4, -- Neutral
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Mining Platform (Unused)
  {
    Flingy = 43,                      -- Scout
    SubUnit = 228,                  -- None
    ConstructionAnimation = 325,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 800,
    resistances = {  -- Independent Size Type
      { type = "physical", percent = 99 },
      { type = "impact", percent = 99 },
      { type = "poison", percent = 99 },
      { type = "explosion", percent = 99 },
      { type = "fire", percent = 99 },
      { type = "laser", percent = 99 },
      { type = "acid", percent = 99 },
      { type = "electric", percent = 99 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 23,          -- Nothing 2 (Normal)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 9,
    RightClickAction = 0,
    GroundWeapon = 92,               -- Laser Battery2 (Unused)
    GroundWeaponHits = 1,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagLargeOverlay = true,
    FlagMechanical = true,
    UnitDimensions = {16, 16, 15, 15},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 4, -- Neutral
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Independent Command Center (Unused)
  {
    Flingy = 43,                      -- Scout
    SubUnit = 228,                  -- None
    ConstructionAnimation = 325,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 800,
    resistances = {  -- Independent Size Type
      { type = "physical", percent = 99 },
      { type = "impact", percent = 99 },
      { type = "poison", percent = 99 },
      { type = "explosion", percent = 99 },
      { type = "fire", percent = 99 },
      { type = "laser", percent = 99 },
      { type = "acid", percent = 99 },
      { type = "electric", percent = 99 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 23,          -- Nothing 2 (Normal)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 9,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagLargeOverlay = true,
    FlagMechanical = true,
    UnitDimensions = {16, 16, 15, 15},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 3, -- Independent
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Independent Starport (Unused)
  {
    Flingy = 121,                     -- Independent Starport (Unused)
    SubUnit = 228,                  -- None
    ConstructionAnimation = 330,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 800,
    resistances = {  -- Independent Size Type
      { type = "physical", percent = 99 },
      { type = "impact", percent = 99 },
      { type = "poison", percent = 99 },
      { type = "explosion", percent = 99 },
      { type = "fire", percent = 99 },
      { type = "laser", percent = 99 },
      { type = "acid", percent = 99 },
      { type = "electric", percent = 99 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 23,          -- Nothing 2 (Normal)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 9,
    RightClickAction = 0,
    GroundWeapon = 93,               -- Laser Battery3 (Unused)
    GroundWeaponHits = 1,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagLargeOverlay = true,
    FlagMechanical = true,
    UnitDimensions = {32, 32, 31, 31},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 3, -- Independent
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Independent Jump Gate (Unused)
  {
    Flingy = 43,                      -- Scout
    SubUnit = 228,                  -- None
    ConstructionAnimation = 325,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 800,
    resistances = {  -- Independent Size Type
      { type = "physical", percent = 99 },
      { type = "impact", percent = 99 },
      { type = "poison", percent = 99 },
      { type = "explosion", percent = 99 },
      { type = "fire", percent = 99 },
      { type = "laser", percent = 99 },
      { type = "acid", percent = 99 },
      { type = "electric", percent = 99 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 23,          -- Nothing 2 (Normal)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 9,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagLargeOverlay = true,
    UnitDimensions = {16, 16, 15, 15},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 4, -- Neutral
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Ruins (Unused)
  {
    Flingy = 43,                      -- Scout
    SubUnit = 228,                  -- None
    ConstructionAnimation = 325,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 800,
    resistances = {  -- Independent Size Type
      { type = "physical", percent = 99 },
      { type = "impact", percent = 99 },
      { type = "poison", percent = 99 },
      { type = "explosion", percent = 99 },
      { type = "fire", percent = 99 },
      { type = "laser", percent = 99 },
      { type = "acid", percent = 99 },
      { type = "electric", percent = 99 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 23,          -- Nothing 2 (Normal)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 9,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagLargeOverlay = true,
    UnitDimensions = {16, 16, 15, 15},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 4, -- Neutral
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Khaydarin Crystal Formation (Unused)
  {
    Flingy = 43,                      -- Scout
    SubUnit = 228,                  -- None
    ConstructionAnimation = 325,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 800,
    resistances = {  -- Independent Size Type
      { type = "physical", percent = 99 },
      { type = "impact", percent = 99 },
      { type = "poison", percent = 99 },
      { type = "explosion", percent = 99 },
      { type = "fire", percent = 99 },
      { type = "laser", percent = 99 },
      { type = "acid", percent = 99 },
      { type = "electric", percent = 99 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 23,          -- Nothing 2 (Normal)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 9,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagLargeOverlay = true,
    UnitDimensions = {16, 16, 15, 15},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 4, -- Neutral
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Vespene Geyser
  {
    Flingy = 117,                     -- Vespene Geyser
    SubUnit = 228,                  -- None
    ConstructionAnimation = 325,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 100000,
    resistances = {  -- Independent Size Type
      { type = "physical", percent = 99 },
      { type = "impact", percent = 99 },
      { type = "poison", percent = 99 },
      { type = "explosion", percent = 99 },
      { type = "fire", percent = 99 },
      { type = "laser", percent = 99 },
      { type = "acid", percent = 99 },
      { type = "electric", percent = 99 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 23,          -- Nothing 2 (Normal)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 9,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagResourceContainer = true,
    FlagLargeOverlay = true,
    FlagInvincible = true,
    UnitDimensions = {64, 32, 63, 31},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 4, -- Neutral
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Warp Gate
  {
    Flingy = 195,                     -- Warp Gate
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 700,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 8,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagLargeOverlay = true,
    FlagMechanical = true,
    UnitDimensions = {48, 32, 47, 31},
    MineralCost = 600,
    GasCost = 200,
    BuildTime = 2400,                -- 160.00 sec on Normal, 100.00 sec on Fastest
    Race = 2, -- Protoss
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Psi Disrupter
  {
    Flingy = 194,                     -- Psi Disrupter
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 2000,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 10,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagLargeOverlay = true,
    FlagMechanical = true,
    UnitDimensions = {80, 38, 69, 47},
    MineralCost = 1000,
    GasCost = 400,
    BuildTime = 4800,                -- 320.00 sec on Normal, 200.00 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Zerg Marker
  {
    Flingy = 43,                      -- Scout
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 100000,
    resistances = {  -- Independent Size Type
      { type = "physical", percent = 99 },
      { type = "impact", percent = 99 },
      { type = "poison", percent = 99 },
      { type = "explosion", percent = 99 },
      { type = "fire", percent = 99 },
      { type = "laser", percent = 99 },
      { type = "acid", percent = 99 },
      { type = "electric", percent = 99 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 1,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 23,          -- Nothing 2 (Normal)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 8,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagInvincible = true,
    UnitDimensions = {48, 32, 47, 31},
    MineralCost = 250,
    GasCost = 0,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 0, -- Zerg
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Terran Marker
  {
    Flingy = 43,                      -- Scout
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 100000,
    resistances = {  -- Independent Size Type
      { type = "physical", percent = 99 },
      { type = "impact", percent = 99 },
      { type = "poison", percent = 99 },
      { type = "explosion", percent = 99 },
      { type = "fire", percent = 99 },
      { type = "laser", percent = 99 },
      { type = "acid", percent = 99 },
      { type = "electric", percent = 99 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 1,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 23,          -- Nothing 2 (Normal)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 8,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagInvincible = true,
    UnitDimensions = {48, 32, 47, 31},
    MineralCost = 50,
    GasCost = 50,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Protoss Marker
  {
    Flingy = 43,                      -- Scout
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 100000,
    resistances = {  -- Independent Size Type
      { type = "physical", percent = 99 },
      { type = "impact", percent = 99 },
      { type = "poison", percent = 99 },
      { type = "explosion", percent = 99 },
      { type = "fire", percent = 99 },
      { type = "laser", percent = 99 },
      { type = "acid", percent = 99 },
      { type = "electric", percent = 99 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 1,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 23,          -- Nothing 2 (Normal)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 8,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagInvincible = true,
    UnitDimensions = {48, 32, 47, 31},
    MineralCost = 100,
    GasCost = 100,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 2, -- Protoss
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Zerg Beacon
  {
    Flingy = 122,                     -- Zerg Beacon
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 100000,
    resistances = {  -- Independent Size Type
      { type = "physical", percent = 99 },
      { type = "impact", percent = 99 },
      { type = "poison", percent = 99 },
      { type = "explosion", percent = 99 },
      { type = "fire", percent = 99 },
      { type = "laser", percent = 99 },
      { type = "acid", percent = 99 },
      { type = "electric", percent = 99 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 0,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 23,          -- Nothing 2 (Normal)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 8,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagInvincible = true,
    UnitDimensions = {48, 32, 47, 31},
    MineralCost = 250,
    GasCost = 0,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 0, -- Zerg
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Terran Beacon
  {
    Flingy = 123,                     -- Terran Beacon
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 100000,
    resistances = {  -- Independent Size Type
      { type = "physical", percent = 99 },
      { type = "impact", percent = 99 },
      { type = "poison", percent = 99 },
      { type = "explosion", percent = 99 },
      { type = "fire", percent = 99 },
      { type = "laser", percent = 99 },
      { type = "acid", percent = 99 },
      { type = "electric", percent = 99 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 0,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 23,          -- Nothing 2 (Normal)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 8,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagInvincible = true,
    UnitDimensions = {48, 32, 47, 31},
    MineralCost = 50,
    GasCost = 50,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Protoss Beacon
  {
    Flingy = 124,                     -- Protoss Beacon
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 100000,
    resistances = {  -- Independent Size Type
      { type = "physical", percent = 99 },
      { type = "impact", percent = 99 },
      { type = "poison", percent = 99 },
      { type = "explosion", percent = 99 },
      { type = "fire", percent = 99 },
      { type = "laser", percent = 99 },
      { type = "acid", percent = 99 },
      { type = "electric", percent = 99 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 0,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 23,          -- Nothing 2 (Normal)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 8,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagInvincible = true,
    UnitDimensions = {48, 32, 47, 31},
    MineralCost = 100,
    GasCost = 100,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 2, -- Protoss
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Zerg Flag Beacon
  {
    Flingy = 122,                     -- Zerg Beacon
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 100000,
    resistances = {  -- Independent Size Type
      { type = "physical", percent = 99 },
      { type = "impact", percent = 99 },
      { type = "poison", percent = 99 },
      { type = "explosion", percent = 99 },
      { type = "fire", percent = 99 },
      { type = "laser", percent = 99 },
      { type = "acid", percent = 99 },
      { type = "electric", percent = 99 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 0,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 153,         -- CTF COP (Initialize)
    HumanAIIdleOrder = 153,        -- CTF COP (Initialize)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 8,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagInvincible = true,
    UnitDimensions = {48, 32, 47, 31},
    MineralCost = 250,
    GasCost = 0,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 0, -- Zerg
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Terran Flag Beacon
  {
    Flingy = 123,                     -- Terran Beacon
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 100000,
    resistances = {  -- Independent Size Type
      { type = "physical", percent = 99 },
      { type = "impact", percent = 99 },
      { type = "poison", percent = 99 },
      { type = "explosion", percent = 99 },
      { type = "fire", percent = 99 },
      { type = "laser", percent = 99 },
      { type = "acid", percent = 99 },
      { type = "electric", percent = 99 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 0,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 153,         -- CTF COP (Initialize)
    HumanAIIdleOrder = 153,        -- CTF COP (Initialize)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 8,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagInvincible = true,
    UnitDimensions = {48, 32, 47, 31},
    MineralCost = 50,
    GasCost = 50,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Protoss Flag Beacon
  {
    Flingy = 124,                     -- Protoss Beacon
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 100000,
    resistances = {  -- Independent Size Type
      { type = "physical", percent = 99 },
      { type = "impact", percent = 99 },
      { type = "poison", percent = 99 },
      { type = "explosion", percent = 99 },
      { type = "fire", percent = 99 },
      { type = "laser", percent = 99 },
      { type = "acid", percent = 99 },
      { type = "electric", percent = 99 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 0,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 153,         -- CTF COP (Initialize)
    HumanAIIdleOrder = 153,        -- CTF COP (Initialize)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 8,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagInvincible = true,
    UnitDimensions = {48, 32, 47, 31},
    MineralCost = 100,
    GasCost = 100,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 2, -- Protoss
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Power Generator
  {
    Flingy = 196,                     -- Power Generator
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 800,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 8,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagLargeOverlay = true,
    FlagMechanical = true,
    UnitDimensions = {56, 28, 63, 43},
    MineralCost = 200,
    GasCost = 50,
    BuildTime = 2400,                -- 160.00 sec on Normal, 100.00 sec on Fastest
    Race = 1, -- Terran
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Overmind Cocoon
  {
    Flingy = 193,                     -- Overmind Cocoon
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 2500,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 1,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 156,         -- Script (Computer)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 10,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    healing_per_tick = 0.0062,   -- Zerg Health Regen
    FlagDetector = true,
    FlagOrganic = true,
    FlagRequiresCreep = true,
    FlagMorphFromOtherUnit = true,
    FlagLargeOverlay = true,
    UnitDimensions = {48, 32, 47, 31},
    MineralCost = 1000,
    GasCost = 500,
    BuildTime = 2400,                -- 160.00 sec on Normal, 100.00 sec on Fastest
    Race = 0, -- Zerg
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Dark Swarm
  {
    Flingy = 125,                     -- Dark Swarm
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 800,
    resistances = {  -- Independent Size Type
      { type = "physical", percent = 99 },
      { type = "impact", percent = 99 },
      { type = "poison", percent = 99 },
      { type = "explosion", percent = 99 },
      { type = "fire", percent = 99 },
      { type = "laser", percent = 99 },
      { type = "acid", percent = 99 },
      { type = "electric", percent = 99 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 19,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 23,          -- Nothing 2 (Normal)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 8,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagInvincible = true,
    UnitDimensions = {80, 80, 79, 79},
    MineralCost = 250,
    GasCost = 200,
    BuildTime = 2400,                -- 160.00 sec on Normal, 100.00 sec on Fastest
    Race = 4, -- Neutral
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Floor Missile Trap
  {
    Flingy = 179,                     -- Floor Missile Trap
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 50,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 167,         -- Idle (Trap)
    HumanAIIdleOrder = 167,        -- Idle (Trap)
    ReturnToIdleOrder = 167,          -- Idle (Trap)
    AttackUnitOrder = 19,           -- Attack (Building)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 5,
    SightRange = 6,
    RightClickAction = 0,
    GroundWeapon = 99,               -- Hellfire Missile Pack (Floor Trap)
    GroundWeaponHits = 1,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagDetector = true,
    FlagLargeOverlay = true,
    FlagCanAttack = true,
    FlagMechanical = true,
    UnitDimensions = {32, 32, 31, 31},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 4, -- Neutral
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Floor Hatch (Unused)
  {
    Flingy = 177,                     -- Substructure Opening Hole
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 100000,
    resistances = {  -- Independent Size Type
      { type = "physical", percent = 99 },
      { type = "impact", percent = 99 },
      { type = "poison", percent = 99 },
      { type = "explosion", percent = 99 },
      { type = "fire", percent = 99 },
      { type = "laser", percent = 99 },
      { type = "acid", percent = 99 },
      { type = "electric", percent = 99 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 1,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 23,          -- Nothing 2 (Normal)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 7,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagInvincible = true,
    UnitDimensions = {128, 64, 127, 63},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 4, -- Neutral
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Left Upper Level Door
  {
    Flingy = 173,                     -- Left Upper Level Door
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 100000,
    resistances = {  -- Independent Size Type
      { type = "physical", percent = 99 },
      { type = "impact", percent = 99 },
      { type = "poison", percent = 99 },
      { type = "explosion", percent = 99 },
      { type = "fire", percent = 99 },
      { type = "laser", percent = 99 },
      { type = "acid", percent = 99 },
      { type = "electric", percent = 99 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 23,          -- Nothing 2 (Normal)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 1,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagInvincible = true,
    UnitDimensions = {25, 17, 44, 20},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 4, -- Neutral
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Right Upper Level Door
  {
    Flingy = 174,                     -- Right Upper Level Door
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 100000,
    resistances = {  -- Independent Size Type
      { type = "physical", percent = 99 },
      { type = "impact", percent = 99 },
      { type = "poison", percent = 99 },
      { type = "explosion", percent = 99 },
      { type = "fire", percent = 99 },
      { type = "laser", percent = 99 },
      { type = "acid", percent = 99 },
      { type = "electric", percent = 99 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 23,          -- Nothing 2 (Normal)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 1,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagInvincible = true,
    UnitDimensions = {44, 17, 25, 20},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 4, -- Neutral
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Left Pit Door
  {
    Flingy = 175,                     -- Substructure Left Door
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 100000,
    resistances = {  -- Independent Size Type
      { type = "physical", percent = 99 },
      { type = "impact", percent = 99 },
      { type = "poison", percent = 99 },
      { type = "explosion", percent = 99 },
      { type = "fire", percent = 99 },
      { type = "laser", percent = 99 },
      { type = "acid", percent = 99 },
      { type = "electric", percent = 99 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 23,          -- Nothing 2 (Normal)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 1,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagInvincible = true,
    UnitDimensions = {41, 17, 28, 20},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 4, -- Neutral
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Right Pit Door
  {
    Flingy = 176,                     -- Substructure Right Door
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 100000,
    resistances = {  -- Independent Size Type
      { type = "physical", percent = 99 },
      { type = "impact", percent = 99 },
      { type = "poison", percent = 99 },
      { type = "explosion", percent = 99 },
      { type = "fire", percent = 99 },
      { type = "laser", percent = 99 },
      { type = "acid", percent = 99 },
      { type = "electric", percent = 99 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 23,          -- Nothing 2 (Normal)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 1,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagInvincible = true,
    UnitDimensions = {28, 17, 41, 20},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 4, -- Neutral
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Floor Gun Trap
  {
    Flingy = 178,                     -- Floor Gun Trap
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 50,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 167,         -- Idle (Trap)
    HumanAIIdleOrder = 167,        -- Idle (Trap)
    ReturnToIdleOrder = 167,          -- Idle (Trap)
    AttackUnitOrder = 19,           -- Attack (Building)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 5,
    SightRange = 6,
    RightClickAction = 0,
    GroundWeapon = 96,               -- Twin Autocannons (Floor Trap)
    GroundWeaponHits = 1,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagDetector = true,
    FlagLargeOverlay = true,
    FlagCanAttack = true,
    FlagMechanical = true,
    UnitDimensions = {32, 32, 31, 31},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 4, -- Neutral
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Left Wall Missile Trap
  {
    Flingy = 180,                     -- Wall Missile Trap
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 50,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 167,         -- Idle (Trap)
    HumanAIIdleOrder = 167,        -- Idle (Trap)
    ReturnToIdleOrder = 167,          -- Idle (Trap)
    AttackUnitOrder = 19,           -- Attack (Building)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 5,
    SightRange = 6,
    RightClickAction = 0,
    GroundWeapon = 97,               -- Hellfire Missile Pack (Wall Trap)
    GroundWeaponHits = 1,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagDetector = true,
    FlagLargeOverlay = true,
    FlagMechanical = true,
    UnitDimensions = {16, 16, 15, 15},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 4, -- Neutral
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Left Wall Flame Trap
  {
    Flingy = 182,                     -- Wall Flame Trap
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 50,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 167,         -- Idle (Trap)
    HumanAIIdleOrder = 167,        -- Idle (Trap)
    ReturnToIdleOrder = 167,          -- Idle (Trap)
    AttackUnitOrder = 19,           -- Attack (Building)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 2,
    SightRange = 3,
    RightClickAction = 0,
    GroundWeapon = 98,               -- Flame Thrower (Wall Trap)
    GroundWeaponHits = 1,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagDetector = true,
    FlagLargeOverlay = true,
    FlagMechanical = true,
    UnitDimensions = {16, 16, 15, 15},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 4, -- Neutral
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Right Wall Missile Trap
  {
    Flingy = 181,                     -- Wall Missile Trap2
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 50,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 167,         -- Idle (Trap)
    HumanAIIdleOrder = 167,        -- Idle (Trap)
    ReturnToIdleOrder = 167,          -- Idle (Trap)
    AttackUnitOrder = 19,           -- Attack (Building)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 5,
    SightRange = 6,
    RightClickAction = 0,
    GroundWeapon = 97,               -- Hellfire Missile Pack (Wall Trap)
    GroundWeaponHits = 1,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagDetector = true,
    FlagLargeOverlay = true,
    FlagMechanical = true,
    UnitDimensions = {16, 16, 15, 15},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 4, -- Neutral
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Right Wall Flame Trap
  {
    Flingy = 183,                     -- Wall Flame Trap2
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 50,
    resistances = {  -- Large Size Type
      { type = "physical", percent = 0 },
      { type = "impact", percent = 75 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 75 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 167,         -- Idle (Trap)
    HumanAIIdleOrder = 167,        -- Idle (Trap)
    ReturnToIdleOrder = 167,          -- Idle (Trap)
    AttackUnitOrder = 19,           -- Attack (Building)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 2,
    SightRange = 3,
    RightClickAction = 0,
    GroundWeapon = 98,               -- Flame Thrower (Wall Trap)
    GroundWeaponHits = 1,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagDetector = true,
    FlagLargeOverlay = true,
    FlagMechanical = true,
    UnitDimensions = {16, 16, 15, 15},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 4, -- Neutral
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Start Location
  {
    Flingy = 140,                     -- Start Location
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 800,
    resistances = {  -- Independent Size Type
      { type = "physical", percent = 99 },
      { type = "impact", percent = 99 },
      { type = "poison", percent = 99 },
      { type = "explosion", percent = 99 },
      { type = "fire", percent = 99 },
      { type = "laser", percent = 99 },
      { type = "acid", percent = 99 },
      { type = "electric", percent = 99 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 1,
    has_belt_immunity = false,
    Rank = 0,
    CompAIIdleOrder = 23,          -- Nothing 2 (Normal)
    HumanAIIdleOrder = 23,         -- Nothing 2 (Normal)
    ReturnToIdleOrder = 23,           -- Nothing 2 (Normal)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 1,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagIsBuilding = true,
    FlagResourceDepot = true,
    UnitDimensions = {48, 32, 48, 32},
    MineralCost = 0,
    GasCost = 0,
    BuildTime = 0,                   -- 0.00 sec on Normal, 0.00 sec on Fastest
    Race = 4, -- Neutral
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Flag
  {
    Flingy = 126,                     -- Flag
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 8,
    MaxShields = 0,
    max_health = 100000,
    resistances = {  -- Independent Size Type
      { type = "physical", percent = 99 },
      { type = "impact", percent = 99 },
      { type = "poison", percent = 99 },
      { type = "explosion", percent = 99 },
      { type = "fire", percent = 99 },
      { type = "laser", percent = 99 },
      { type = "acid", percent = 99 },
      { type = "electric", percent = 99 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = true,
    Rank = 0,
    CompAIIdleOrder = 97,          -- Idle (Power-Up)
    HumanAIIdleOrder = 97,         -- Idle (Power-Up)
    ReturnToIdleOrder = 97,           -- Idle (Power-Up)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 5,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagSingleEntity = true,
    FlagInvincible = true,
    UnitDimensions = {16, 16, 15, 15},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 4, -- Neutral
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Young Chrysalis
  {
    Flingy = 127,                     -- Young Chrysalis
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 800,
    resistances = {  -- Independent Size Type
      { type = "physical", percent = 99 },
      { type = "impact", percent = 99 },
      { type = "poison", percent = 99 },
      { type = "explosion", percent = 99 },
      { type = "fire", percent = 99 },
      { type = "laser", percent = 99 },
      { type = "acid", percent = 99 },
      { type = "electric", percent = 99 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = true,
    Rank = 0,
    CompAIIdleOrder = 97,          -- Idle (Power-Up)
    HumanAIIdleOrder = 97,         -- Idle (Power-Up)
    ReturnToIdleOrder = 97,           -- Idle (Power-Up)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 5,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagSingleEntity = true,
    FlagPickupItem = true,
    FlagInvincible = true,
    UnitDimensions = {16, 16, 15, 15},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 4, -- Neutral
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Psi Emitter
  {
    Flingy = 128,                     -- Psi Emitter
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 800,
    resistances = {  -- Independent Size Type
      { type = "physical", percent = 99 },
      { type = "impact", percent = 99 },
      { type = "poison", percent = 99 },
      { type = "explosion", percent = 99 },
      { type = "fire", percent = 99 },
      { type = "laser", percent = 99 },
      { type = "acid", percent = 99 },
      { type = "electric", percent = 99 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = true,
    Rank = 0,
    CompAIIdleOrder = 97,          -- Idle (Power-Up)
    HumanAIIdleOrder = 97,         -- Idle (Power-Up)
    ReturnToIdleOrder = 97,           -- Idle (Power-Up)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 5,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagSingleEntity = true,
    FlagPickupItem = true,
    FlagInvincible = true,
    UnitDimensions = {16, 16, 15, 15},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 4, -- Neutral
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Data Disc
  {
    Flingy = 129,                     -- Data Disc
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 800,
    resistances = {  -- Independent Size Type
      { type = "physical", percent = 99 },
      { type = "impact", percent = 99 },
      { type = "poison", percent = 99 },
      { type = "explosion", percent = 99 },
      { type = "fire", percent = 99 },
      { type = "laser", percent = 99 },
      { type = "acid", percent = 99 },
      { type = "electric", percent = 99 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = true,
    Rank = 0,
    CompAIIdleOrder = 97,          -- Idle (Power-Up)
    HumanAIIdleOrder = 97,         -- Idle (Power-Up)
    ReturnToIdleOrder = 97,           -- Idle (Power-Up)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 5,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagSingleEntity = true,
    FlagPickupItem = true,
    FlagInvincible = true,
    UnitDimensions = {16, 16, 15, 15},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 4, -- Neutral
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Khaydarin Crystal
  {
    Flingy = 130,                     -- Khaydarin Crystal
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 800,
    resistances = {  -- Independent Size Type
      { type = "physical", percent = 99 },
      { type = "impact", percent = 99 },
      { type = "poison", percent = 99 },
      { type = "explosion", percent = 99 },
      { type = "fire", percent = 99 },
      { type = "laser", percent = 99 },
      { type = "acid", percent = 99 },
      { type = "electric", percent = 99 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = true,
    Rank = 0,
    CompAIIdleOrder = 97,          -- Idle (Power-Up)
    HumanAIIdleOrder = 97,         -- Idle (Power-Up)
    ReturnToIdleOrder = 97,           -- Idle (Power-Up)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 5,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagSingleEntity = true,
    FlagPickupItem = true,
    FlagInvincible = true,
    UnitDimensions = {16, 16, 15, 15},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 4, -- Neutral
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Mineral Cluster Type 1
  {
    Flingy = 131,                     -- Mineral Chunk Type1
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 800,
    resistances = {  -- Independent Size Type
      { type = "physical", percent = 99 },
      { type = "impact", percent = 99 },
      { type = "poison", percent = 99 },
      { type = "explosion", percent = 99 },
      { type = "fire", percent = 99 },
      { type = "laser", percent = 99 },
      { type = "acid", percent = 99 },
      { type = "electric", percent = 99 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = true,
    Rank = 0,
    CompAIIdleOrder = 97,          -- Idle (Power-Up)
    HumanAIIdleOrder = 97,         -- Idle (Power-Up)
    ReturnToIdleOrder = 97,           -- Idle (Power-Up)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 5,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagSingleEntity = true,
    FlagPickupItem = true,
    UnitDimensions = {16, 16, 15, 15},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 4, -- Neutral
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Mineral Cluster Type 2
  {
    Flingy = 132,                     -- Mineral Chunk Type2
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 800,
    resistances = {  -- Independent Size Type
      { type = "physical", percent = 99 },
      { type = "impact", percent = 99 },
      { type = "poison", percent = 99 },
      { type = "explosion", percent = 99 },
      { type = "fire", percent = 99 },
      { type = "laser", percent = 99 },
      { type = "acid", percent = 99 },
      { type = "electric", percent = 99 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = true,
    Rank = 0,
    CompAIIdleOrder = 97,          -- Idle (Power-Up)
    HumanAIIdleOrder = 97,         -- Idle (Power-Up)
    ReturnToIdleOrder = 97,           -- Idle (Power-Up)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 5,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagSingleEntity = true,
    FlagPickupItem = true,
    UnitDimensions = {16, 16, 15, 15},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 4, -- Neutral
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Protoss Vespene Gas Orb Type 1
  {
    Flingy = 133,                     -- Protoss Gas Orb Type1
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 800,
    resistances = {  -- Independent Size Type
      { type = "physical", percent = 99 },
      { type = "impact", percent = 99 },
      { type = "poison", percent = 99 },
      { type = "explosion", percent = 99 },
      { type = "fire", percent = 99 },
      { type = "laser", percent = 99 },
      { type = "acid", percent = 99 },
      { type = "electric", percent = 99 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = true,
    Rank = 0,
    CompAIIdleOrder = 97,          -- Idle (Power-Up)
    HumanAIIdleOrder = 97,         -- Idle (Power-Up)
    ReturnToIdleOrder = 97,           -- Idle (Power-Up)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 5,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagSingleEntity = true,
    FlagPickupItem = true,
    UnitDimensions = {16, 16, 15, 15},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 4, -- Neutral
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Protoss Vespene Gas Orb Type 2
  {
    Flingy = 134,                     -- Protoss Gas Orb Type2
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 800,
    resistances = {  -- Independent Size Type
      { type = "physical", percent = 99 },
      { type = "impact", percent = 99 },
      { type = "poison", percent = 99 },
      { type = "explosion", percent = 99 },
      { type = "fire", percent = 99 },
      { type = "laser", percent = 99 },
      { type = "acid", percent = 99 },
      { type = "electric", percent = 99 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = true,
    Rank = 0,
    CompAIIdleOrder = 97,          -- Idle (Power-Up)
    HumanAIIdleOrder = 97,         -- Idle (Power-Up)
    ReturnToIdleOrder = 97,           -- Idle (Power-Up)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 5,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagSingleEntity = true,
    FlagPickupItem = true,
    UnitDimensions = {16, 16, 15, 15},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 4, -- Neutral
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Zerg Vespene Gas Sac Type 1
  {
    Flingy = 135,                     -- Zerg Gas Sac Type1
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 800,
    resistances = {  -- Independent Size Type
      { type = "physical", percent = 99 },
      { type = "impact", percent = 99 },
      { type = "poison", percent = 99 },
      { type = "explosion", percent = 99 },
      { type = "fire", percent = 99 },
      { type = "laser", percent = 99 },
      { type = "acid", percent = 99 },
      { type = "electric", percent = 99 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = true,
    Rank = 0,
    CompAIIdleOrder = 97,          -- Idle (Power-Up)
    HumanAIIdleOrder = 97,         -- Idle (Power-Up)
    ReturnToIdleOrder = 97,           -- Idle (Power-Up)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 5,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagSingleEntity = true,
    FlagPickupItem = true,
    UnitDimensions = {16, 16, 15, 15},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 4, -- Neutral
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Zerg Vespene Gas Sac Type 2
  {
    Flingy = 136,                     -- Zerg Gas Sac Type2
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 800,
    resistances = {  -- Independent Size Type
      { type = "physical", percent = 99 },
      { type = "impact", percent = 99 },
      { type = "poison", percent = 99 },
      { type = "explosion", percent = 99 },
      { type = "fire", percent = 99 },
      { type = "laser", percent = 99 },
      { type = "acid", percent = 99 },
      { type = "electric", percent = 99 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = true,
    Rank = 0,
    CompAIIdleOrder = 97,          -- Idle (Power-Up)
    HumanAIIdleOrder = 97,         -- Idle (Power-Up)
    ReturnToIdleOrder = 97,           -- Idle (Power-Up)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 5,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagSingleEntity = true,
    FlagPickupItem = true,
    UnitDimensions = {16, 16, 15, 15},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 4, -- Neutral
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Terran Vespene Gas Tank Type 1
  {
    Flingy = 137,                     -- Terran Gas Tank Type1
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 800,
    resistances = {  -- Independent Size Type
      { type = "physical", percent = 99 },
      { type = "impact", percent = 99 },
      { type = "poison", percent = 99 },
      { type = "explosion", percent = 99 },
      { type = "fire", percent = 99 },
      { type = "laser", percent = 99 },
      { type = "acid", percent = 99 },
      { type = "electric", percent = 99 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = true,
    Rank = 0,
    CompAIIdleOrder = 97,          -- Idle (Power-Up)
    HumanAIIdleOrder = 97,         -- Idle (Power-Up)
    ReturnToIdleOrder = 97,           -- Idle (Power-Up)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 5,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagSingleEntity = true,
    FlagPickupItem = true,
    UnitDimensions = {16, 16, 15, 15},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 4, -- Neutral
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }, -- Terran Vespene Gas Tank Type 2
  {
    Flingy = 138,                     -- Terran Gas Tank Type2
    SubUnit = 228,                  -- None
    ConstructionAnimation = 0,
    SpawnDirection = 0,
    MaxShields = 0,
    max_health = 800,
    resistances = {  -- Independent Size Type
      { type = "physical", percent = 99 },
      { type = "impact", percent = 99 },
      { type = "poison", percent = 99 },
      { type = "explosion", percent = 99 },
      { type = "fire", percent = 99 },
      { type = "laser", percent = 99 },
      { type = "acid", percent = 99 },
      { type = "electric", percent = 99 }
    },
    Armor = 0,
    ArmorUpgrade = 60,               -- Unknown Upgrade60
    ElevationLevel = 4,
    has_belt_immunity = true,
    Rank = 0,
    CompAIIdleOrder = 97,          -- Idle (Power-Up)
    HumanAIIdleOrder = 97,         -- Idle (Power-Up)
    ReturnToIdleOrder = 97,           -- Idle (Power-Up)
    AttackUnitOrder = 23,           -- Nothing 2 (Normal)
    AttackMoveOrder = 23,           -- Nothing 2 (Normal)
    SeekRange = 0,
    SightRange = 5,
    RightClickAction = 0,
    GroundWeapon = 130,              -- None
    GroundWeaponHits = 0,
    AirWeapon = 130,                 -- None
    AirWeaponHits = 0,
    FlagSingleEntity = true,
    FlagPickupItem = true,
    UnitDimensions = {16, 16, 15, 15},
    MineralCost = 1,
    GasCost = 1,
    BuildTime = 1,                   -- 0.07 sec on Normal, 0.04 sec on Fastest
    Race = 4, -- Neutral
    SupplyProvided = 0,              -- 0 supply in game
    SupplyCost = 0,                  -- 0 supply in game
    CargoSize = 255,
    CargoSpace = 0
  }
}
