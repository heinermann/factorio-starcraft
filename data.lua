-- Step 2: Data stage
-- Loaded when: Factorio starts, after settings stage.
-- Purpose: Set up entity prototypes and other mod data.
--
-- https://lua-api.factorio.com/latest/Data-Lifecycle.html

require("prototypes.damage-type")
require("prototypes.item-groups")
require("prototypes.animation")
require("prototypes.unit")
