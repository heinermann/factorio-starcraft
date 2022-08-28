-- Step 2: Data stage
-- Loaded when: Factorio starts, after settings stage.
-- Purpose: Set up entity prototypes and other mod data.
--
-- https://lua-api.factorio.com/latest/Data-Lifecycle.html

require("prototypes.categories")
require("prototypes.tiles")
require("prototypes.autoplace")
require("prototypes.damage-type")
require("prototypes.item-groups")
require("prototypes.equipment-grid")
require("prototypes.item")
require("prototypes.animation")
require("prototypes.smoke")
require("prototypes.stickers")
require("prototypes.unit")
require("prototypes.weapons")

require("prototypes.entity.corpse")
require("prototypes.entity.explosion")
require("prototypes.entity.projectile")
require("prototypes.entity.neutral.resources")
require("prototypes.entity.protoss.buildings")
require("prototypes.entity.protoss.special_buildings")
require("prototypes.entity.protoss.units")
require("prototypes.entity.protoss.air_units")
require("prototypes.entity.zerg.buildings")
require("prototypes.entity.zerg.special_buildings")
