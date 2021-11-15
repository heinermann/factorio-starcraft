-- UPDATE: This file will NOT be used. It is only here to transcribe scripts to Factorio logic.
--
-- WARNING: Scripts need modification to run outside of coroutines or moved into native Factorio facilities (i.e. smoke overlays)

local convert = require("__starcraft__/glue/convert")
local Log = require('__stdlib__/stdlib/misc/logger').new("iscript")

-- Convert a BW pixel to Factorio tile
local function to_tiles(value)
  return value / 16.0
end

-- Convert a BW direction to Factorio orientation
local function to_orientation(value)
  return value / 34
end

-- Convert BW direction to Factorio direction
local function to_direction(value)
  return math.floor(to_orientation(value) * 8 + 1)
end

-- Convert BW frames to Factorio ticks
local function to_ticks(value)
  --- BW 42ms / frame, Factorio 1000/60 ms per frame
  return math.ceil((value * 42) * 0.06)
end

local function bounding_box_to_xy(bounding_box)
  return {
    (bounding_box.left_top.x + bounding_box.right_bottom.x)/2,
    (bounding_box.left_top.y + bounding_box.right_bottom.y)/2
  }
end


local iscript = {}

local function image_create(img, x, y, render_layer)
  if iscript.entity == nil then
    Log.log("WARNING: iscript.entity is nil")
    return
  end

  local imgname = convert.image.to_name(img)
  if imgname ~= nil then
    Log.log("Creating " .. imgname)

    local imgtype = convert.image.to_type(img)
    if imgtype == "animation" then
      local img_track_id = rendering.draw_animation{
        animation = imgname,
        render_layer = render_layer,
        animation_speed = 0,
        target = iscript.entity,
        target_offset = { to_tiles(x), to_tiles(y) },
        surface = iscript.entity.surface
      }
      iscript.init_obj_data(img_track_id)
      global.iscript_images[img_track_id] = {}

    elseif imgtype == "sprite" then
      local img_track_id = rendering.draw_sprite{
        sprite = imgname,
        render_layer = render_layer,
        target = iscript.entity,
        target_offset = { to_tiles(x), to_tiles(y) },
        surface = iscript.entity.surface
      }

      iscript.init_obj_data(img_track_id)
    elseif imgtype == "smoke" or imgtype == "trivial-smoke" then
      local pos = iscript.entity.position
      iscript.entity.surface.create_trivial_smoke{
        name = imgname,
        position = { pos.x + to_tiles(x), pos.y + to_tiles(y) }
      }
    end
  end
end

local function imgul(img, x, y)
  -- TODO: Relative to entity's render_layer
  Log.log("imgul(" .. img .. "," .. x .. "," .. y .. ")")

  image_create(img, x, y, "lower-object-above-shadow")
end

local function playfram(num)
  if iscript.anim == nil then return end

  -- TODO: GFXTurns
  rendering.set_animation_offset(iscript.anim, num)
end

local function waitrand(min, max)
  Log.log("waitrand(" .. min .. "," .. max .. ")")

  if iscript.entity == nil then
    Log.log("WARNING: iscript.entity is nil")
    return
  end

  iscript.edata.wait_ticks = to_ticks(math.random(min, max) - 1)
end

local function setvertpos(y_offset)
  if iscript.anim ~= nil then
    local target = rendering.get_target(iscript.anim)
    rendering.set_target(target.entity or target.position, {target.entity_offset[1], to_tiles(y_offset)})
  end
end

local function wait(amount)
  Log.log("wait(" .. amount .. ")")
  if iscript.entity == nil then
    Log.log("WARNING: iscript.entity is nil")
    return
  end

  iscript.edata.wait_ticks = to_ticks(amount - 1)
end

local function playsnd(sfx)
  -- TODO
end

local function imgol(img, x, y)
  -- TODO: Relative to entity's render_layer
  image_create(img, x, y, "higher-object-under")
end

local function sprol(sprite, x, y)
  -- TODO
end

local function attackwith(v)
  -- TODO
end

local function lowsprul(sprite, x, y)
  -- TODO
end

local function nobrkcodestart()
  iscript.edata.no_break_code_section = true
end

local function attackmelee(sfx1, sfx2)
  local chosen = sfx1
  if sfx2 ~= nil then
    local chosen = math.random(sfx1, sfx2)
  end
  playsnd(chosen)
  -- TODO: attackmelee
end

local function nobrkcodeend()
  iscript.edata.no_break_code_section = false
end

local function move(amount)
  -- TODO
end

local function setfldirect(direction)
  if iscript.anim ~= nil then
    rendering.set_orientation(iscript.anim, to_orientation(direction))
  elseif iscript.entity ~= nil then
    iscript.entity.orientation = to_orientation(direction)
    iscript.entity.direction = to_direction(direction)
  end
end

local function sigorder(value)
  iscript.edata.order_signal = value
end

local function imgoluselo(img, x, y)
  -- TODO
end

local function castspell()
  -- TODO
end

local function sproluselo(sprite)
  -- TODO
end

-- TODO: turn into native code
local function randcondjmp(chance, fn)
  -- TODO
end

local function turnccwise(amount)
  turncwise(-amount)
end

local function turncwise(amount)
  -- TODO
end

local function attack()
  -- TODO
end

local function ignorerest()
  iscript.edata.wait_ticks = math.huge
end

local function turnrand(amount)
  if math.random(1, 4) == 1 then
    turnccwise(amount)
  else
    turncwise(amount)
  end
end

local function imgolorig(imgid)
  -- TODO
end

local function attkshiftproj(distance)
  -- TODO
end

local function engframe(frame)
  -- TODO
end

local function useweapon(wpn)
  -- TODO
end

local function setflspeed(speed)
  -- TODO
end

local function tmprmgraphicstart()
  -- TODO: probable workaround is to generate an additional "blank" frame per image that uses this
end

local function tmprmgraphicend()
  -- TODO
end

local function curdirectcondjmp(angle1, angle2, jmp)
  -- TODO
end

local function trgtrangecondjmp(distance, jmp)
  -- TODO
end

local function imgulnextid(x, y)
  -- TODO
end

local function spruluselo(sprite, x, y)
  -- TODO
end

local function followmaingraphic()
  -- TODO
end

local function pwrupcondjmp(jmp)
  -- TODO? Logic is specific to carryables which will be getting different logic
end

local function switchul(imgid)
  -- Again specific to carryables
end

local function domissiledmg()
  -- TODO
end

local function sprul(sprite, x, y)
  -- TODO: only used by Yamato trail
end

local function engset(frame)
  -- TODO
end

local function setflipstate(flipped)
  -- TODO
end

local function setspawnframe(direction)
  -- TODO? Only used for floor missile traps
end

local function orderdone(signal)
  -- TODO
end

local function grdsprol(sprite, x, y)
  -- TODO Img overlay only over ground, Subterranean Spines
end

local function dogrddamage()
  -- TODO
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 000 Scourge (zerg\avenger.grp)
iscript[0] = {
  IsId =          	0,
  Type =          	12,
  Init =          	ScourgeInit,
  Death =         	ScourgeDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	ScourgeAirAttkInit,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	ScourgeAirAttkInit,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	ScourgeAirAttkToIdle,
  Unused2 =       	nil,
  Walking =       	ScourgeWalking,
  WalkingToIdle = 	ScourgeAirAttkToIdle,
  SpecialState1 = 	nil
}
-- ----------------------------------------------------------------------------- --

function ScourgeInit()
	imgul(1, 0, 42)	-- Scourge Shadow (zerg\avenger.grp)
	playfram(0x00)	-- Frame set 0
	waitrand(1, 5) 
	ScourgeAirAttkToIdle()
end

function ScourgeAirAttkToIdle()
::ScourgeAirAttkToIdle_label::
	playfram(0x00)	-- Frame set 0
	setvertpos(0) 
	wait(3) 
	playfram(0x11)	-- Frame set 1
	wait(3) 
	playfram(0x22)	-- Frame set 2
	setvertpos(1) 
	wait(3) 
	playfram(0x33)	-- Frame set 3
	setvertpos(2) 
	wait(3) 
	playfram(0x44)	-- Frame set 4
	setvertpos(1) 
	wait(3) 
	goto ScourgeAirAttkToIdle_label
end

function ScourgeDeath()
	playsnd(776)	-- Zerg\AVENGER\ZAvDth00.WAV
	imgol(3, 0, 0)	-- Scourge Death (zerg\zavDeath.grp)
	wait(1) 
end

function ScourgeAirAttkInit()
	playsnd(778)	-- Zerg\AVENGER\ZAvHit00.WAV
	sprol(132, 0, 0)	-- Scourge Explosion (zerg\zavExplo.grp)
	wait(1) 
	attackwith(2) 
	ScourgeLocal00()
end

function ScourgeLocal00()
::ScourgeLocal00_label::
	wait(125) 
	goto ScourgeLocal00_label
end

function ScourgeWalking()
	setvertpos(0) 
	ScourgeLocal01()
end

function ScourgeLocal01()
::ScourgeLocal01_label::
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(0x11)	-- Frame set 1
	wait(2) 
	playfram(0x22)	-- Frame set 2
	wait(2) 
	playfram(0x33)	-- Frame set 3
	wait(2) 
	playfram(0x44)	-- Frame set 4
	wait(2) 
	goto ScourgeLocal01_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 003 Scourge Death (zerg\zavDeath.grp)
iscript[2] = {
  IsId =          	2,
  Type =          	0,
  Init =          	ScourgeDeathInit,
  Death =         	nil
}
-- ----------------------------------------------------------------------------- --

function ScourgeDeathInit()
	playfram(0x00)	-- Frame set 0
	wait(2) 
	imgol(59, 0, 0)	-- Zerg Air Death Explosion (Small) (thingy\zAirDthS.grp)
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 004 Scourge Explosion (zerg\zavExplo.grp)
iscript[3] = {
  IsId =          	3,
  Type =          	1,
  Init =          	ScourgeExplosionInit,
  Death =         	ScourgeExplosionDeath
}
-- ----------------------------------------------------------------------------- --

function ScourgeExplosionInit()
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(1) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(1) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(1) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(1) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(1) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(1) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(1) 
end

function ScourgeExplosionDeath()
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 005 Broodling (zerg\brood.grp)
iscript[4] = {
  IsId =          	4,
  Type =          	12,
  Init =          	BroodlingInit,
  Death =         	BroodlingDeath,
  GndAttkInit =   	BroodlingGndAttkInit,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	BroodlingGndAttkInit,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	BroodlingGndAttkToIdle,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	BroodlingWalking,
  WalkingToIdle = 	BroodlingGndAttkToIdle,
  SpecialState1 = 	nil
}
-- ----------------------------------------------------------------------------- --

function BroodlingInit()
	imgul(6, 0, 0)	-- Broodling Shadow (zerg\zbrShad.grp)
	BroodlingGndAttkToIdle()
end

function BroodlingGndAttkToIdle()
::BroodlingGndAttkToIdle_label::
	playfram(0x11)	-- Frame set 1
	waitrand(25, 30) 
	playfram(0x22)	-- Frame set 2
	waitrand(25, 30) 
	goto BroodlingGndAttkToIdle_label
end

function BroodlingDeath()
	playsnd(785)	-- Zerg\BROODLING\ZBrDth00.WAV
	lowsprul(134, 0, 0)	-- Broodling Remnants (zerg\zbrDeath.grp)
	wait(1) 
end

function BroodlingGndAttkInit()
	playfram(0x77)	-- Frame set 7
	wait(1) 
	nobrkcodestart()
	playfram(0x88)	-- Frame set 8
	wait(1) 
	playfram(0x99)	-- Frame set 9
	attackmelee(786)	-- Zerg\BROODLING\ZBrAtt00.WAV
	wait(1) 
	playfram(0xaa)	-- Frame set 10
	wait(1) 
	playfram(0xbb)	-- Frame set 11
	wait(1) 
	nobrkcodeend()
	gotorepeatattk()
	BroodlingGndAttkToIdle()
end

function BroodlingWalking()
::BroodlingWalking_label::
	BroodlingLocal00()
	BroodlingLocal00()
	waitrand(3, 6) 
	BroodlingLocal00()
	waitrand(3, 6) 
	BroodlingLocal00()
	BroodlingLocal00()
	BroodlingLocal00()
	waitrand(3, 6) 
	goto BroodlingWalking_label
end

function BroodlingLocal00()
	move(8) 
	wait(1) 
	playfram(0x11)	-- Frame set 1
	move(8) 
	wait(1) 
	playfram(0x22)	-- Frame set 2
	move(8) 
	wait(1) 
	playfram(0x33)	-- Frame set 3
	move(8) 
	wait(1) 
	playfram(0x44)	-- Frame set 4
	move(8) 
	wait(1) 
	playfram(0x55)	-- Frame set 5
	move(8) 
	wait(1) 
	playfram(0x66)	-- Frame set 6
	move(8) 
	wait(1) 
	playfram(0x00)	-- Frame set 0
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 007 Broodling Remnants (zerg\zbrDeath.grp)
iscript[5] = {
  IsId =          	5,
  Type =          	0,
  Init =          	BroodlingRemnantsInit,
  Death =         	nil
}
-- ----------------------------------------------------------------------------- --

function BroodlingRemnantsInit()
	playfram(0x00)	-- Frame set 0
	wait(50) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(50) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(50) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(50) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(50) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 008 Infested Terran (zerg\bugguy.grp)
iscript[6] = {
  IsId =          	6,
  Type =          	26,
  Init =          	InfestedTerranInit,
  Death =         	InfestedTerranDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	InfestedTerranWalking,
  WalkingToIdle = 	InfestedTerranWalkingToIdle,
  SpecialState1 = 	InfestedTerranSpecialState1,
  SpecialState2 = 	InfestedTerranSpecialState2,
  AlmostBuilt =   	nil,
  Built =         	nil,
  Landing =       	nil,
  LiftOff =       	nil,
  IsWorking =     	nil,
  WorkingToIdle = 	nil,
  WarpIn =        	nil,
  Unused3 =       	nil,
  StarEditInit =  	nil,
  Disable =       	nil,
  Burrow =        	InfestedTerranBurrow,
  UnBurrow =      	InfestedTerranUnBurrow,
  Enable =        	nil
}
-- ----------------------------------------------------------------------------- --

function InfestedTerranInit()
	imgul(9, 0, 0)	-- Infested Terran Shadow (zerg\zbgShad.grp)
	InfestedTerranWalkingToIdle()
end

function InfestedTerranWalkingToIdle()
	playfram(0x00)	-- Frame set 0
	ScourgeLocal00()
end

function InfestedTerranDeath()
	playsnd(67)	-- Bullet\ZBGHit00.wav
	setfldirect(0) 
	playfram(0xee)	-- Frame set 14
	wait(1) 
	playfram(239)	-- Frame set 14,  direction 1
	wait(1) 
	playfram(240)	-- Frame set 14,  direction 2
	wait(1) 
	playfram(241)	-- Frame set 14,  direction 3
	wait(1) 
	playfram(242)	-- Frame set 14,  direction 4
	wait(1) 
	playfram(243)	-- Frame set 14,  direction 5
	wait(1) 
	playfram(244)	-- Frame set 14,  direction 6
	wait(1) 
	playfram(245)	-- Frame set 14,  direction 7
	wait(1) 
	lowsprul(236, 0, 0)	-- Marine Remnants (terran\tmaDeath.grp)
	wait(1) 
end

function InfestedTerranWalking()
::InfestedTerranWalking_label::
	move(6) 
	wait(1) 
	playfram(0x11)	-- Frame set 1
	move(6) 
	wait(1) 
	playfram(0x22)	-- Frame set 2
	move(6) 
	wait(1) 
	playfram(0x33)	-- Frame set 3
	move(6) 
	wait(1) 
	playfram(0x44)	-- Frame set 4
	move(6) 
	wait(1) 
	playfram(0x55)	-- Frame set 5
	move(6) 
	wait(1) 
	playfram(0x66)	-- Frame set 6
	move(6) 
	wait(1) 
	playfram(0x77)	-- Frame set 7
	move(6) 
	wait(1) 
	playfram(0x00)	-- Frame set 0
	goto InfestedTerranWalking_label
end

function InfestedTerranSpecialState1()
	attackwith(1) 
	sprol(136, 0, 0)	-- Infested Terran Explosion (thingy\zbgExplo.grp)
	sigorder(1) 
	ScourgeLocal00()
end

function InfestedTerranSpecialState2()
	playfram(0xdd)	-- Frame set 13
	ScourgeLocal00()
end

function InfestedTerranBurrow()
	imgol(423, 0, 0)	-- Burrowing Dust (thingy\bDust.grp)
	playfram(0x88)	-- Frame set 8
	wait(1) 
	playfram(0x99)	-- Frame set 9
	wait(1) 
	playfram(0xaa)	-- Frame set 10
	wait(1) 
	playfram(0xbb)	-- Frame set 11
	wait(1) 
	playfram(0xcc)	-- Frame set 12
	wait(1) 
	playfram(0xdd)	-- Frame set 13
	wait(1) 
	sigorder(4) 
	ScourgeLocal00()
end

function InfestedTerranUnBurrow()
	waitrand(1, 5) 
	imgul(423, 0, 0)	-- Burrowing Dust (thingy\bDust.grp)
	playfram(0xcc)	-- Frame set 12
	wait(1) 
	playfram(0xbb)	-- Frame set 11
	wait(1) 
	playfram(0xaa)	-- Frame set 10
	wait(1) 
	playfram(0x99)	-- Frame set 9
	wait(1) 
	playfram(0x88)	-- Frame set 8
	wait(1) 
	playfram(0x00)	-- Frame set 0
	sigorder(4) 
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 010 Infested Terran Explosion (thingy\zbgExplo.grp)
iscript[7] = {
  IsId =          	7,
  Type =          	1,
  Init =          	InfestedTerranExplosionInit,
  Death =         	ScourgeExplosionDeath
}
-- ----------------------------------------------------------------------------- --

function InfestedTerranExplosionInit()
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(1) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(1) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(1) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(1) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(1) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(1) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(1) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 011 Guardian Cocoon (zerg\cocoon.grp)
iscript[8] = {
  IsId =          	8,
  Type =          	14,
  Init =          	GuardianCocoonInit,
  Death =         	GuardianCocoonDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	nil,
  WalkingToIdle = 	nil,
  SpecialState1 = 	GuardianCocoonSpecialState1,
  SpecialState2 = 	GuardianCocoonSpecialState2,
  AlmostBuilt =   	nil
}
-- ----------------------------------------------------------------------------- --

function GuardianCocoonInit()
	imgul(12, 0, 42)	-- Guardian Cocoon Shadow (zerg\cocoon.grp)
	playfram(9)	-- Frame set 0,  direction 9
	wait(2) 
	playfram(10)	-- Frame set 0,  direction 10
	wait(2) 
	playfram(11)	-- Frame set 0,  direction 11
	wait(2) 
	playfram(12)	-- Frame set 0,  direction 12
	wait(2) 
	playfram(13)	-- Frame set 0,  direction 13
	wait(2) 
	playfram(14)	-- Frame set 0,  direction 14
	waitrand(10, 15) 
	GuardianCocoonLocal00()
end

function GuardianCocoonLocal00()
::GuardianCocoonLocal00_label::
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(2) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(2) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(2) 
	goto GuardianCocoonLocal00_label
end

function GuardianCocoonDeath()
	playsnd(942)	-- Zerg\Mutalid\ZMuDth00.WAV
	imgol(41, 0, 0)	-- Mutalisk Death (zerg\zmuDeath.grp)
	wait(1) 
end

function GuardianCocoonSpecialState1()
	sigorder(4) 
	ScourgeLocal00()
end

function GuardianCocoonSpecialState2()
	playfram(14)	-- Frame set 0,  direction 14
	wait(2) 
	playfram(13)	-- Frame set 0,  direction 13
	wait(2) 
	playfram(12)	-- Frame set 0,  direction 12
	wait(2) 
	playfram(11)	-- Frame set 0,  direction 11
	wait(2) 
	playfram(10)	-- Frame set 0,  direction 10
	wait(2) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(2) 
	sigorder(4) 
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 013 Defiler (zerg\defiler.grp)
iscript[9] = {
  IsId =          	9,
  Type =          	26,
  Init =          	DefilerInit,
  Death =         	DefilerDeath,
  GndAttkInit =   	DefilerGndAttkInit,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	DefilerGndAttkInit,
  AirAttkRpt =    	nil,
  CastSpell =     	DefilerCastSpell,
  GndAttkToIdle = 	DefilerGndAttkToIdle,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	DefilerWalking,
  WalkingToIdle = 	DefilerGndAttkToIdle,
  SpecialState1 = 	nil,
  SpecialState2 = 	DefilerSpecialState2,
  AlmostBuilt =   	nil,
  Built =         	nil,
  Landing =       	nil,
  LiftOff =       	nil,
  IsWorking =     	nil,
  WorkingToIdle = 	nil,
  WarpIn =        	nil,
  Unused3 =       	nil,
  StarEditInit =  	nil,
  Disable =       	nil,
  Burrow =        	DefilerBurrow,
  UnBurrow =      	DefilerUnBurrow,
  Enable =        	nil
}
-- ----------------------------------------------------------------------------- --

function DefilerInit()
	imgul(14, 0, 3)	-- Defiler Shadow (zerg\defiler.grp)
	playfram(0x00)	-- Frame set 0
	waitrand(1, 4) 
	DefilerGndAttkToIdle()
end

function DefilerGndAttkToIdle()
::DefilerGndAttkToIdle_label::
	playfram(0x00)	-- Frame set 0
	wait(3) 
	playfram(0x11)	-- Frame set 1
	wait(3) 
	playfram(0x22)	-- Frame set 2
	wait(3) 
	playfram(0x11)	-- Frame set 1
	wait(3) 
	goto DefilerGndAttkToIdle_label
end

function DefilerDeath()
	playsnd(815)	-- Zerg\DEFILER\ZDeDth00.WAV
	setfldirect(0) 
	playfram(0x88)	-- Frame set 8
	wait(2) 
	playfram(0x99)	-- Frame set 9
	wait(2) 
	playfram(0xaa)	-- Frame set 10
	wait(2) 
	playfram(0xbb)	-- Frame set 11
	wait(2) 
	lowsprul(139, 0, 0)	-- Defiler Remnants (zerg\zdeDeath.grp)
	wait(1) 
end

function DefilerGndAttkInit()
	playsnd(110)	-- Bullet\zdeAtt00.wav
	imgoluselo(518, 0, 0)	-- Guardian Attack Overlay (thingy\eplMuzz.grp)
	attackwith(1) 
	gotorepeatattk()
	DefilerGndAttkToIdle()
end

function DefilerCastSpell()
	playfram(0x00)	-- Frame set 0
	nobrkcodestart()
	wait(1) 
	playfram(0x11)	-- Frame set 1
	wait(1) 
	playfram(0x22)	-- Frame set 2
	wait(1) 
	playfram(0x11)	-- Frame set 1
	wait(1) 
	castspell()
	nobrkcodeend()
	gotorepeatattk()
	sigorder(2) 
	DefilerGndAttkToIdle()
end

function DefilerWalking()
::DefilerWalking_label::
	move(4) 
	wait(1) 
	playfram(0x00)	-- Frame set 0
	move(4) 
	wait(1) 
	playfram(0x11)	-- Frame set 1
	move(4) 
	wait(1) 
	playfram(0x22)	-- Frame set 2
	move(4) 
	wait(1) 
	playfram(0x33)	-- Frame set 3
	move(4) 
	wait(1) 
	playfram(0x44)	-- Frame set 4
	move(4) 
	wait(1) 
	playfram(0x55)	-- Frame set 5
	move(4) 
	wait(1) 
	playfram(0x66)	-- Frame set 6
	move(4) 
	wait(1) 
	playfram(0x77)	-- Frame set 7
	goto DefilerWalking_label
end

function DefilerSpecialState2()
	playfram(0x110)	-- Frame set 16
	ScourgeLocal00()
end

function DefilerBurrow()
	imgol(423, 0, 0)	-- Burrowing Dust (thingy\bDust.grp)
	playfram(0xcc)	-- Frame set 12
	wait(1) 
	playfram(0xdd)	-- Frame set 13
	wait(1) 
	playfram(0xee)	-- Frame set 14
	wait(1) 
	playfram(0xff)	-- Frame set 15
	wait(1) 
	playfram(0x110)	-- Frame set 16
	wait(1) 
	sigorder(4) 
	ScourgeLocal00()
end

function DefilerUnBurrow()
	waitrand(1, 5) 
	imgul(423, 0, 0)	-- Burrowing Dust (thingy\bDust.grp)
	playfram(0xff)	-- Frame set 15
	wait(1) 
	playfram(0xee)	-- Frame set 14
	wait(1) 
	playfram(0xdd)	-- Frame set 13
	wait(1) 
	playfram(0xcc)	-- Frame set 12
	wait(1) 
	sigorder(4) 
	DefilerGndAttkToIdle()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 016 Defiler Remnants (zerg\zdeDeath.grp)
iscript[10] = {
  IsId =          	10,
  Type =          	0,
  Init =          	DefilerRemnantsInit,
  Death =         	nil
}
-- ----------------------------------------------------------------------------- --

function DefilerRemnantsInit()
	playfram(0x00)	-- Frame set 0
	wait(50) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(50) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(50) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(50) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(50) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 017 Drone (zerg\drone.grp)
iscript[11] = {
  IsId =          	11,
  Type =          	26,
  Init =          	DroneInit,
  Death =         	DroneDeath,
  GndAttkInit =   	DroneGndAttkInit,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	DroneGndAttkInit,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	ScourgeLocal00,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	DroneWalking,
  WalkingToIdle = 	ScourgeLocal00,
  SpecialState1 = 	nil,
  SpecialState2 = 	DroneSpecialState2,
  AlmostBuilt =   	DroneAlmostBuilt,
  Built =         	nil,
  Landing =       	DroneWalking,
  LiftOff =       	DroneLiftOff,
  IsWorking =     	nil,
  WorkingToIdle = 	nil,
  WarpIn =        	nil,
  Unused3 =       	nil,
  StarEditInit =  	nil,
  Disable =       	nil,
  Burrow =        	DroneBurrow,
  UnBurrow =      	DroneUnBurrow,
  Enable =        	nil
}
-- ----------------------------------------------------------------------------- --

function DroneInit()
	imgul(18, 0, 7)	-- Drone Shadow (zerg\drone.grp)
	playfram(0x00)	-- Frame set 0
	ScourgeLocal00()
end

function DroneDeath()
	playsnd(833)	-- Zerg\DRONE\ZDrDth00.WAV
	setfldirect(0) 
	playfram(0xaa)	-- Frame set 10
	wait(2) 
	playfram(0xbb)	-- Frame set 11
	wait(2) 
	playfram(0xcc)	-- Frame set 12
	wait(2) 
	playfram(0xdd)	-- Frame set 13
	wait(2) 
	playfram(0xee)	-- Frame set 14
	wait(2) 
	playfram(0xff)	-- Frame set 15
	wait(2) 
	playfram(0x110)	-- Frame set 16
	wait(2) 
	playfram(0x121)	-- Frame set 17
	wait(2) 
	lowsprul(141, 0, 0)	-- Drone Remnants (zerg\zdrDeath.grp)
	wait(1) 
end

function DroneGndAttkInit()
	setvertpos(0) 
	playsnd(64)	-- Bullet\SpoogHit.wav
	sproluselo(332)	-- Needle Spines (thingy\spooge.grp)
	wait(1) 
	attackwith(1) 
	gotorepeatattk()
	ScourgeLocal00()
end

function DroneWalking()
	setvertpos(0) 
	DroneLocal00()
end

function DroneLocal00()
::DroneLocal00_label::
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(0x11)	-- Frame set 1
	wait(2) 
	playfram(0x22)	-- Frame set 2
	wait(2) 
	playfram(0x33)	-- Frame set 3
	wait(2) 
	playfram(0x44)	-- Frame set 4
	wait(2) 
	goto DroneLocal00_label
end

function DroneSpecialState2()
	playfram(0x176)	-- Frame set 22
	ScourgeLocal00()
end

function DroneAlmostBuilt()
::DroneAlmostBuilt_label::
	setvertpos(0) 
	waitrand(5, 8) 
	playsnd(847)	-- Zerg\DRONE\ZDrMin00.wav
	playfram(0x55)	-- Frame set 5
	wait(2) 
	playfram(0x66)	-- Frame set 6
	wait(2) 
	playfram(0x77)	-- Frame set 7
	wait(2) 
	playfram(0x88)	-- Frame set 8
	wait(2) 
	playfram(0x55)	-- Frame set 5
	goto DroneAlmostBuilt_label
end

function DroneLiftOff()
	sigorder(16) 
	ScourgeLocal00()
end

function DroneBurrow()
	imgol(423, 0, 0)	-- Burrowing Dust (thingy\bDust.grp)
	playfram(0x132)	-- Frame set 18
	wait(1) 
	playfram(0x143)	-- Frame set 19
	wait(1) 
	playfram(0x154)	-- Frame set 20
	wait(1) 
	playfram(0x165)	-- Frame set 21
	wait(1) 
	playfram(0x176)	-- Frame set 22
	wait(1) 
	sigorder(4) 
	ScourgeLocal00()
end

function DroneUnBurrow()
	waitrand(1, 5) 
	imgul(423, 0, 0)	-- Burrowing Dust (thingy\bDust.grp)
	playfram(0x165)	-- Frame set 21
	wait(1) 
	playfram(0x154)	-- Frame set 20
	wait(1) 
	playfram(0x143)	-- Frame set 19
	wait(1) 
	playfram(0x132)	-- Frame set 18
	wait(1) 
	playfram(0x00)	-- Frame set 0
	sigorder(4) 
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 020 Drone Remnants (zerg\zdrDeath.grp)
iscript[12] = {
  IsId =          	12,
  Type =          	0,
  Init =          	DroneRemnantsInit,
  Death =         	nil
}
-- ----------------------------------------------------------------------------- --

function DroneRemnantsInit()
	playfram(0x00)	-- Frame set 0
	wait(50) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(50) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(50) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(50) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(50) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 021 Egg (zerg\egg.grp)
iscript[13] = {
  IsId =          	13,
  Type =          	13,
  Init =          	EggInit,
  Death =         	EggDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	nil,
  WalkingToIdle = 	nil,
  SpecialState1 = 	EggSpecialState1
}
-- ----------------------------------------------------------------------------- --

function EggInit()
	imgul(22, 0, 0)	-- Egg Shadow (zerg\zegShad.grp)
	playfram(20)	-- Frame set 1,  direction 3
	wait(2) 
	playfram(21)	-- Frame set 1,  direction 4
	wait(2) 
	playfram(22)	-- Frame set 1,  direction 5
	wait(2) 
	playfram(23)	-- Frame set 1,  direction 6
	wait(2) 
	EggLocal00()
end

function EggLocal00()
::EggLocal00_label::
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(2) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(2) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(2) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(2) 
	playfram(10)	-- Frame set 0,  direction 10
	wait(2) 
	playfram(11)	-- Frame set 0,  direction 11
	wait(2) 
	goto EggLocal00_label
end

function EggDeath()
	playsnd(830)	-- Zerg\Egg\ZEgDth00.WAV
	lowsprul(143, 0, 0)	-- Egg Remnants (zerg\zegDeath.grp)
	wait(1) 
end

function EggSpecialState1()
	wait(1) 
	nobrkcodestart()
	playfram(12)	-- Frame set 0,  direction 12
	wait(2) 
	playfram(13)	-- Frame set 0,  direction 13
	wait(2) 
	playfram(14)	-- Frame set 0,  direction 14
	wait(2) 
	playfram(15)	-- Frame set 0,  direction 15
	wait(2) 
	playfram(16)	-- Frame set 0,  direction 16
	wait(2) 
	playfram(0x11)	-- Frame set 1
	wait(2) 
	playfram(18)	-- Frame set 1,  direction 1
	wait(2) 
	playfram(19)	-- Frame set 1,  direction 2
	wait(2) 
	sigorder(4) 
	nobrkcodeend()
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 024 Egg Remnants (zerg\zegDeath.grp)
iscript[14] = {
  IsId =          	14,
  Type =          	0,
  Init =          	EggRemnantsInit,
  Death =         	nil
}
-- ----------------------------------------------------------------------------- --

function EggRemnantsInit()
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(2) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(2) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(2) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(25) 
	playfram(10)	-- Frame set 0,  direction 10
	wait(25) 
	playfram(11)	-- Frame set 0,  direction 11
	wait(25) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 025 Guardian (zerg\guardian.grp)
iscript[15] = {
  IsId =          	15,
  Type =          	12,
  Init =          	GuardianInit,
  Death =         	GuardianDeath,
  GndAttkInit =   	GuardianGndAttkInit,
  AirAttkInit =   	GuardianGndAttkInit,
  Unused1 =       	nil,
  GndAttkRpt =    	GuardianGndAttkInit,
  AirAttkRpt =    	GuardianGndAttkInit,
  CastSpell =     	nil,
  GndAttkToIdle = 	GuardianGndAttkToIdle,
  AirAttkToIdle = 	GuardianGndAttkToIdle,
  Unused2 =       	nil,
  Walking =       	GuardianWalking,
  WalkingToIdle = 	GuardianGndAttkToIdle,
  SpecialState1 = 	nil
}
-- ----------------------------------------------------------------------------- --

function GuardianInit()
	imgul(26, 0, 42)	-- Guardian Shadow (zerg\guardian.grp)
	playfram(0x00)	-- Frame set 0
	waitrand(1, 4) 
	GuardianGndAttkToIdle()
end

function GuardianGndAttkToIdle()
::GuardianGndAttkToIdle_label::
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(0x11)	-- Frame set 1
	wait(2) 
	playfram(0x22)	-- Frame set 2
	wait(2) 
	playfram(0x33)	-- Frame set 3
	wait(2) 
	playfram(0x44)	-- Frame set 4
	wait(2) 
	playfram(0x55)	-- Frame set 5
	wait(2) 
	playfram(0x66)	-- Frame set 6
	wait(2) 
	goto GuardianGndAttkToIdle_label
end

function GuardianDeath()
	playsnd(852)	-- Zerg\Guardian\ZGuDth00.WAV
	imgol(28, 0, 0)	-- Guardian Death (zerg\zguDeath.grp)
	wait(1) 
end

function GuardianGndAttkInit()
	playsnd(71)	-- Bullet\ZGuFir00.wav
	imgoluselo(518, 0, 0)	-- Guardian Attack Overlay (thingy\eplMuzz.grp)
	attackwith(1) 
	gotorepeatattk()
	GuardianGndAttkToIdle()
end

function GuardianWalking()
::GuardianWalking_label::
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(0x11)	-- Frame set 1
	wait(1) 
	playfram(0x22)	-- Frame set 2
	wait(1) 
	playfram(0x33)	-- Frame set 3
	wait(1) 
	playfram(0x44)	-- Frame set 4
	wait(1) 
	playfram(0x55)	-- Frame set 5
	wait(1) 
	playfram(0x66)	-- Frame set 6
	wait(1) 
	goto GuardianWalking_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 027 Guardian Birth (zerg\cocoon.grp)
iscript[16] = {
  IsId =          	16,
  Type =          	13,
  Init =          	GuardianBirthInit,
  Death =         	GuardianCocoonDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	nil,
  WalkingToIdle = 	nil,
  SpecialState1 = 	GuardianBirthSpecialState1
}
-- ----------------------------------------------------------------------------- --

function GuardianBirthInit()
	imgul(12, 0, 42)	-- Guardian Cocoon Shadow (zerg\cocoon.grp)
	GuardianCocoonLocal00()
end

function GuardianBirthSpecialState1()
	wait(1) 
	nobrkcodestart()
	playfram(15)	-- Frame set 0,  direction 15
	wait(2) 
	playfram(16)	-- Frame set 0,  direction 16
	wait(2) 
	playfram(0x11)	-- Frame set 1
	wait(2) 
	playfram(18)	-- Frame set 1,  direction 1
	wait(2) 
	playfram(19)	-- Frame set 1,  direction 2
	wait(2) 
	playfram(20)	-- Frame set 1,  direction 3
	wait(2) 
	playfram(21)	-- Frame set 1,  direction 4
	wait(2) 
	playfram(22)	-- Frame set 1,  direction 5
	wait(2) 
	sigorder(4) 
	nobrkcodeend()
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 028 Guardian Death (zerg\zguDeath.grp)
iscript[17] = {
  IsId =          	17,
  Type =          	0,
  Init =          	GuardianDeathInit,
  Death =         	nil
}
-- ----------------------------------------------------------------------------- --

function GuardianDeathInit()
	playfram(0x00)	-- Frame set 0
	wait(2) 
	imgol(58, 0, 0)	-- Zerg Air Death Explosion (Large) (thingy\zAirDthL.grp)
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 029 Hydralisk (zerg\hydra.grp)
iscript[18] = {
  IsId =          	18,
  Type =          	26,
  Init =          	HydraliskInit,
  Death =         	HydraliskDeath,
  GndAttkInit =   	HydraliskGndAttkInit,
  AirAttkInit =   	HydraliskGndAttkInit,
  Unused1 =       	nil,
  GndAttkRpt =    	HydraliskGndAttkRpt,
  AirAttkRpt =    	HydraliskGndAttkRpt,
  CastSpell =     	nil,
  GndAttkToIdle = 	HydraliskGndAttkToIdle,
  AirAttkToIdle = 	HydraliskGndAttkToIdle,
  Unused2 =       	nil,
  Walking =       	HydraliskWalking,
  WalkingToIdle = 	HydraliskWalkingToIdle,
  SpecialState1 = 	nil,
  SpecialState2 = 	HydraliskSpecialState2,
  AlmostBuilt =   	nil,
  Built =         	nil,
  Landing =       	nil,
  LiftOff =       	nil,
  IsWorking =     	nil,
  WorkingToIdle = 	nil,
  WarpIn =        	nil,
  Unused3 =       	nil,
  StarEditInit =  	nil,
  Disable =       	nil,
  Burrow =        	HydraliskBurrow,
  UnBurrow =      	HydraliskUnBurrow,
  Enable =        	nil
}
-- ----------------------------------------------------------------------------- --

function HydraliskInit()
	imgul(30, 0, 0)	-- Hydralisk Shadow (zerg\zhyShad.grp)
	HydraliskWalkingToIdle()
end

function HydraliskWalkingToIdle()
	playfram(0x55)	-- Frame set 5
	HydraliskLocal00()
end

function HydraliskLocal00()
::HydraliskLocal00_label::
	waitrand(63, 75) 
	randcondjmp(25, HydraliskLocal01)
	randcondjmp(128, HydraliskLocal02)
	goto HydraliskLocal00_label
end

function HydraliskLocal01()
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(0x11)	-- Frame set 1
	wait(1) 
	playfram(0x22)	-- Frame set 2
	wait(1) 
	playfram(0x33)	-- Frame set 3
	wait(25) 
	playfram(0x22)	-- Frame set 2
	wait(1) 
	playfram(0x11)	-- Frame set 1
	wait(1) 
	playfram(0x00)	-- Frame set 0
	wait(1) 
	HydraliskWalkingToIdle()
end

function HydraliskLocal02()
	randcondjmp(128, HydraliskLocal03)
	playfram(0x66)	-- Frame set 6
	wait(1) 
	turnccwise(1) 
	playfram(0x77)	-- Frame set 7
	wait(1) 
	turnccwise(1) 
	playfram(0x88)	-- Frame set 8
	wait(1) 
	turnccwise(1) 
	playfram(0x99)	-- Frame set 9
	wait(1) 
	turnccwise(1) 
	playfram(0xaa)	-- Frame set 10
	wait(1) 
	turnccwise(1) 
	playfram(0xbb)	-- Frame set 11
	wait(1) 
	turnccwise(1) 
	HydraliskWalkingToIdle()
end

function HydraliskLocal03()
	playfram(0x66)	-- Frame set 6
	wait(1) 
	turncwise(1) 
	playfram(0x77)	-- Frame set 7
	wait(1) 
	turncwise(1) 
	playfram(0x88)	-- Frame set 8
	wait(1) 
	turncwise(1) 
	playfram(0x99)	-- Frame set 9
	wait(1) 
	turncwise(1) 
	playfram(0xaa)	-- Frame set 10
	wait(1) 
	turncwise(1) 
	playfram(0xbb)	-- Frame set 11
	wait(1) 
	turncwise(1) 
	HydraliskWalkingToIdle()
end

function HydraliskDeath()
	playsnd(867)	-- Zerg\Hydra\ZHyDth00.WAV
	setfldirect(0) 
	playfram(0xcc)	-- Frame set 12
	wait(2) 
	playfram(205)	-- Frame set 12,  direction 1
	wait(2) 
	playfram(206)	-- Frame set 12,  direction 2
	wait(2) 
	playfram(207)	-- Frame set 12,  direction 3
	wait(2) 
	playfram(208)	-- Frame set 12,  direction 4
	wait(2) 
	playfram(209)	-- Frame set 12,  direction 5
	wait(2) 
	playfram(210)	-- Frame set 12,  direction 6
	wait(2) 
	playfram(211)	-- Frame set 12,  direction 7
	wait(2) 
	lowsprul(147, 0, 0)	-- Hydralisk Remnants (zerg\zhyDeath.grp)
	wait(1) 
end

function HydraliskGndAttkInit()
	playfram(0x00)	-- Frame set 0
	wait(1) 
	nobrkcodestart()
	playfram(0x11)	-- Frame set 1
	wait(1) 
	playfram(0x22)	-- Frame set 2
	wait(1) 
	playfram(0x33)	-- Frame set 3
	wait(1) 
	HydraliskGndAttkRpt()
end

function HydraliskGndAttkRpt()
	wait(1) 
	playfram(0x44)	-- Frame set 4
	playsnd(64)	-- Bullet\SpoogHit.wav
	sproluselo(332)	-- Needle Spines (thingy\spooge.grp)
	attack()
	wait(1) 
	playfram(0x33)	-- Frame set 3
	wait(1) 
	nobrkcodeend()
	gotorepeatattk()
	ignorerest()
	HydraliskGndAttkToIdle()
end

function HydraliskGndAttkToIdle()
	playfram(0x22)	-- Frame set 2
	wait(1) 
	playfram(0x11)	-- Frame set 1
	wait(1) 
	playfram(0x00)	-- Frame set 0
	wait(1) 
	HydraliskWalkingToIdle()
end

function HydraliskWalking()
::HydraliskWalking_label::
	move(2) 
	wait(1) 
	playfram(0x66)	-- Frame set 6
	move(2) 
	wait(1) 
	playfram(0x77)	-- Frame set 7
	move(2) 
	wait(1) 
	playfram(0x88)	-- Frame set 8
	move(6) 
	wait(1) 
	playfram(0x99)	-- Frame set 9
	move(6) 
	wait(1) 
	playfram(0xaa)	-- Frame set 10
	move(6) 
	wait(1) 
	playfram(0xbb)	-- Frame set 11
	move(2) 
	wait(1) 
	playfram(0x55)	-- Frame set 5
	goto HydraliskWalking_label
end

function HydraliskSpecialState2()
	playfram(280)	-- Frame set 16,  direction 8
	ScourgeLocal00()
end

function HydraliskBurrow()
	imgol(423, 0, 0)	-- Burrowing Dust (thingy\bDust.grp)
	playfram(212)	-- Frame set 12,  direction 8
	wait(1) 
	playfram(229)	-- Frame set 13,  direction 8
	wait(1) 
	playfram(246)	-- Frame set 14,  direction 8
	wait(1) 
	playfram(263)	-- Frame set 15,  direction 8
	wait(1) 
	playfram(280)	-- Frame set 16,  direction 8
	wait(1) 
	sigorder(4) 
	ScourgeLocal00()
end

function HydraliskUnBurrow()
	waitrand(1, 5) 
	imgul(423, 0, 0)	-- Burrowing Dust (thingy\bDust.grp)
	playfram(263)	-- Frame set 15,  direction 8
	wait(1) 
	playfram(246)	-- Frame set 14,  direction 8
	wait(1) 
	playfram(229)	-- Frame set 13,  direction 8
	wait(1) 
	playfram(212)	-- Frame set 12,  direction 8
	wait(1) 
	sigorder(4) 
	HydraliskWalkingToIdle()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 032 Hydralisk Remnants (zerg\zhyDeath.grp)
iscript[19] = {
  IsId =          	19,
  Type =          	0,
  Init =          	HydraliskRemnantsInit,
  Death =         	nil
}
-- ----------------------------------------------------------------------------- --

function HydraliskRemnantsInit()
	playfram(0x00)	-- Frame set 0
	wait(50) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(50) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(50) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(50) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 033 Infested Kerrigan (zerg\uikerr.grp)
iscript[20] = {
  IsId =          	20,
  Type =          	26,
  Init =          	InfestedKerriganInit,
  Death =         	InfestedKerriganDeath,
  GndAttkInit =   	InfestedKerriganGndAttkInit,
  AirAttkInit =   	InfestedKerriganGndAttkInit,
  Unused1 =       	nil,
  GndAttkRpt =    	InfestedKerriganGndAttkRpt,
  AirAttkRpt =    	InfestedKerriganGndAttkRpt,
  CastSpell =     	InfestedKerriganCastSpell,
  GndAttkToIdle = 	InfestedKerriganGndAttkToIdle,
  AirAttkToIdle = 	InfestedKerriganGndAttkToIdle,
  Unused2 =       	nil,
  Walking =       	InfestedKerriganWalking,
  WalkingToIdle = 	InfestedKerriganWalkingToIdle,
  SpecialState1 = 	nil,
  SpecialState2 = 	nil,
  AlmostBuilt =   	nil,
  Built =         	nil,
  Landing =       	nil,
  LiftOff =       	nil,
  IsWorking =     	nil,
  WorkingToIdle = 	nil,
  WarpIn =        	nil,
  Unused3 =       	nil,
  StarEditInit =  	nil,
  Disable =       	nil,
  Burrow =        	InfestedKerriganBurrow,
  UnBurrow =      	InfestedKerriganUnBurrow,
  Enable =        	nil
}
-- ----------------------------------------------------------------------------- --

function InfestedKerriganInit()
	imgul(34, 0, 0)	-- Infested Kerrigan Shadow (zerg\uikShad.grp)
	InfestedKerriganWalkingToIdle()
end

function InfestedKerriganWalkingToIdle()
	playfram(0x88)	-- Frame set 8
	InfestedKerriganLocal00()
end

function InfestedKerriganLocal00()
::InfestedKerriganLocal00_label::
	waitrand(63, 75) 
	randcondjmp(128, InfestedKerriganLocal01)
	goto InfestedKerriganLocal00_label
end

function InfestedKerriganLocal01()
	playfram(0x88)	-- Frame set 8
	wait(1) 
	playfram(0x99)	-- Frame set 9
	wait(1) 
	turnrand(3) 
	wait(1) 
	playfram(0x88)	-- Frame set 8
	wait(1) 
	InfestedKerriganWalkingToIdle()
end

function InfestedKerriganDeath()
	playsnd(967)	-- Zerg\ZERGKERRI\UKiDth00.wav
	imgol(231, 0, 0)	-- Ghost Death (terran\ghost.grp)
	wait(1) 
end

function InfestedKerriganGndAttkInit()
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(0x11)	-- Frame set 1
	wait(2) 
	playfram(0x22)	-- Frame set 2
	wait(2) 
	InfestedKerriganGndAttkRpt()
end

function InfestedKerriganGndAttkRpt()
	nobrkcodestart()
	playsnd(112)	-- Bullet\UKiFir00.wav
	playfram(0x33)	-- Frame set 3
	wait(2) 
	playfram(0x44)	-- Frame set 4
	wait(2) 
	playfram(0x55)	-- Frame set 5
	wait(2) 
	playfram(0x66)	-- Frame set 6
	wait(2) 
	playfram(0x77)	-- Frame set 7
	attackmelee(0)	-- (nullsound)
	wait(3) 
	playfram(0x66)	-- Frame set 6
	wait(2) 
	playfram(0x55)	-- Frame set 5
	wait(2) 
	playfram(0x44)	-- Frame set 4
	wait(2) 
	playfram(0x33)	-- Frame set 3
	wait(2) 
	nobrkcodeend()
	gotorepeatattk()
	ignorerest()
	InfestedKerriganGndAttkToIdle()
end

function InfestedKerriganGndAttkToIdle()
	playfram(0x22)	-- Frame set 2
	wait(2) 
	playfram(0x11)	-- Frame set 1
	wait(2) 
	playfram(0x00)	-- Frame set 0
	wait(2) 
	InfestedKerriganWalkingToIdle()
end

function InfestedKerriganCastSpell()
	playfram(0x00)	-- Frame set 0
	nobrkcodestart()
	wait(1) 
	playfram(0x11)	-- Frame set 1
	wait(1) 
	playfram(0x22)	-- Frame set 2
	wait(1) 
	playfram(0x33)	-- Frame set 3
	wait(1) 
	playfram(0x44)	-- Frame set 4
	wait(1) 
	playfram(0x55)	-- Frame set 5
	wait(1) 
	playfram(0x66)	-- Frame set 6
	wait(1) 
	playfram(0x77)	-- Frame set 7
	castspell()
	sigorder(2) 
	wait(2) 
	playfram(0x66)	-- Frame set 6
	wait(1) 
	playfram(0x55)	-- Frame set 5
	wait(1) 
	playfram(0x44)	-- Frame set 4
	wait(1) 
	playfram(0x33)	-- Frame set 3
	wait(1) 
	playfram(0x22)	-- Frame set 2
	wait(1) 
	playfram(0x11)	-- Frame set 1
	wait(1) 
	playfram(0x00)	-- Frame set 0
	nobrkcodeend()
	gotorepeatattk()
	ScourgeLocal00()
end

function InfestedKerriganWalking()
::InfestedKerriganWalking_label::
	move(4) 
	wait(1) 
	playfram(0x99)	-- Frame set 9
	move(4) 
	wait(1) 
	playfram(0xaa)	-- Frame set 10
	move(4) 
	wait(1) 
	playfram(0xbb)	-- Frame set 11
	move(4) 
	wait(1) 
	playfram(0xcc)	-- Frame set 12
	move(4) 
	wait(1) 
	playfram(0xdd)	-- Frame set 13
	move(4) 
	wait(1) 
	playfram(0xee)	-- Frame set 14
	move(4) 
	wait(1) 
	playfram(0xff)	-- Frame set 15
	move(4) 
	wait(1) 
	playfram(0x88)	-- Frame set 8
	goto InfestedKerriganWalking_label
end

function InfestedKerriganBurrow()
	imgol(423, 0, 0)	-- Burrowing Dust (thingy\bDust.grp)
	sigorder(4) 
	ScourgeLocal00()
end

function InfestedKerriganUnBurrow()
	waitrand(1, 5) 
	imgul(423, 0, 0)	-- Burrowing Dust (thingy\bDust.grp)
	playfram(0x88)	-- Frame set 8
	sigorder(4) 
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 036 Larva (zerg\larva.grp)
iscript[21] = {
  IsId =          	21,
  Type =          	12,
  Init =          	LarvaInit,
  Death =         	LarvaDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	LarvaWalking,
  WalkingToIdle = 	LarvaInit,
  SpecialState1 = 	nil
}
-- ----------------------------------------------------------------------------- --

function LarvaInit()
	playfram(0x00)	-- Frame set 0
	ScourgeLocal00()
end

function LarvaDeath()
	playsnd(849)	-- Zerg\Larva\ZLaDth00.WAV
	lowsprul(150, 0, 0)	-- Larva Remnants (zerg\zlaDeath.grp)
	wait(1) 
end

function LarvaWalking()
::LarvaWalking_label::
	move(2) 
	wait(1) 
	playfram(0x00)	-- Frame set 0
	move(2) 
	wait(1) 
	playfram(0x11)	-- Frame set 1
	move(2) 
	wait(1) 
	playfram(0x22)	-- Frame set 2
	move(2) 
	wait(1) 
	playfram(0x33)	-- Frame set 3
	move(2) 
	wait(1) 
	playfram(0x44)	-- Frame set 4
	goto LarvaWalking_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 037 Larva Remnants (zerg\zlaDeath.grp)
iscript[22] = {
  IsId =          	22,
  Type =          	0,
  Init =          	LarvaRemnantsInit,
  Death =         	nil
}
-- ----------------------------------------------------------------------------- --

function LarvaRemnantsInit()
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(25) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(25) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(25) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 038 Mutalisk (zerg\mutalid.grp)
iscript[23] = {
  IsId =          	23,
  Type =          	12,
  Init =          	MutaliskInit,
  Death =         	MutaliskDeath,
  GndAttkInit =   	MutaliskGndAttkInit,
  AirAttkInit =   	MutaliskGndAttkInit,
  Unused1 =       	nil,
  GndAttkRpt =    	MutaliskGndAttkInit,
  AirAttkRpt =    	MutaliskGndAttkInit,
  CastSpell =     	nil,
  GndAttkToIdle = 	MutaliskGndAttkToIdle,
  AirAttkToIdle = 	MutaliskGndAttkToIdle,
  Unused2 =       	nil,
  Walking =       	MutaliskWalking,
  WalkingToIdle = 	MutaliskGndAttkToIdle,
  SpecialState1 = 	nil
}
-- ----------------------------------------------------------------------------- --

function MutaliskInit()
	imgul(39, 0, 42)	-- Mutalisk Shadow (zerg\mutalid.grp)
	playfram(0x00)	-- Frame set 0
	waitrand(1, 4) 
	MutaliskGndAttkToIdle()
end

function MutaliskGndAttkToIdle()
::MutaliskGndAttkToIdle_label::
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(0x11)	-- Frame set 1
	wait(2) 
	playfram(0x22)	-- Frame set 2
	wait(2) 
	playfram(0x33)	-- Frame set 3
	wait(2) 
	playfram(0x44)	-- Frame set 4
	wait(2) 
	goto MutaliskGndAttkToIdle_label
end

function MutaliskDeath()
	playsnd(942)	-- Zerg\Mutalid\ZMuDth00.WAV
	imgol(41, 0, 0)	-- Mutalisk Death (zerg\zmuDeath.grp)
	wait(1) 
end

function MutaliskGndAttkInit()
	playsnd(113)	-- Bullet\zmuFir00.wav
	wait(1) 
	attackwith(1) 
	gotorepeatattk()
	MutaliskGndAttkToIdle()
end

function MutaliskWalking()
::MutaliskWalking_label::
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(0x11)	-- Frame set 1
	wait(1) 
	playfram(0x22)	-- Frame set 2
	wait(1) 
	playfram(0x33)	-- Frame set 3
	wait(1) 
	playfram(0x44)	-- Frame set 4
	wait(1) 
	goto MutaliskWalking_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 041 Mutalisk Death (zerg\zmuDeath.grp)
iscript[24] = {
  IsId =          	24,
  Type =          	0,
  Init =          	MutaliskDeathInit,
  Death =         	nil
}
-- ----------------------------------------------------------------------------- --

function MutaliskDeathInit()
	playfram(0x00)	-- Frame set 0
	wait(2) 
	imgol(59, 0, 0)	-- Zerg Air Death Explosion (Small) (thingy\zAirDthS.grp)
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 042 Overlord (zerg\overlord.grp)
iscript[25] = {
  IsId =          	25,
  Type =          	12,
  Init =          	OverlordInit,
  Death =         	OverlordDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	OverlordWalking,
  WalkingToIdle = 	OverlordWalkingToIdle,
  SpecialState1 = 	nil
}
-- ----------------------------------------------------------------------------- --

function OverlordInit()
	imgul(43, 0, 42)	-- Overlord Shadow (zerg\overlord.grp)
	playfram(0x00)	-- Frame set 0
	OverlordLocal00()
end

function OverlordLocal00()
::OverlordLocal00_label::
	setvertpos(1) 
	waitrand(8, 10) 
	setvertpos(2) 
	waitrand(8, 10) 
	setvertpos(1) 
	waitrand(8, 10) 
	setvertpos(0) 
	waitrand(8, 10) 
	goto OverlordLocal00_label
end

function OverlordDeath()
	playsnd(910)	-- Zerg\OVERLORD\ZOvDth00.WAV
	imgol(45, 0, 0)	-- Overlord Death (zerg\zovDeath.grp)
	wait(1) 
end

function OverlordWalking()
	setvertpos(0) 
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(0x11)	-- Frame set 1
	wait(2) 
	OverlordLocal01()
end

function OverlordLocal01()
::OverlordLocal01_label::
	playfram(0x22)	-- Frame set 2
	wait(2) 
	playfram(0x33)	-- Frame set 3
	wait(2) 
	goto OverlordLocal01_label
end

function OverlordWalkingToIdle()
	playfram(0x33)	-- Frame set 3
	wait(2) 
	playfram(0x22)	-- Frame set 2
	wait(2) 
	playfram(0x11)	-- Frame set 1
	wait(2) 
	playfram(0x00)	-- Frame set 0
	wait(2) 
	OverlordLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 045 Overlord Death (zerg\zovDeath.grp)
iscript[26] = {
  IsId =          	26,
  Type =          	0,
  Init =          	OverlordDeathInit,
  Death =         	nil
}
-- ----------------------------------------------------------------------------- --

function OverlordDeathInit()
	playfram(0x00)	-- Frame set 0
	wait(2) 
	imgol(58, 0, 0)	-- Zerg Air Death Explosion (Large) (thingy\zAirDthL.grp)
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 046 Queen (zerg\queen.grp)
iscript[27] = {
  IsId =          	27,
  Type =          	12,
  Init =          	QueenInit,
  Death =         	QueenDeath,
  GndAttkInit =   	QueenGndAttkInit,
  AirAttkInit =   	QueenGndAttkInit,
  Unused1 =       	nil,
  GndAttkRpt =    	QueenGndAttkInit,
  AirAttkRpt =    	QueenGndAttkInit,
  CastSpell =     	QueenCastSpell,
  GndAttkToIdle = 	QueenGndAttkToIdle,
  AirAttkToIdle = 	QueenGndAttkToIdle,
  Unused2 =       	nil,
  Walking =       	QueenWalking,
  WalkingToIdle = 	QueenGndAttkToIdle,
  SpecialState1 = 	nil
}
-- ----------------------------------------------------------------------------- --

function QueenInit()
	imgul(47, 0, 42)	-- Queen Shadow (zerg\queen.grp)
	playfram(0x00)	-- Frame set 0
	waitrand(1, 4) 
	QueenGndAttkToIdle()
end

function QueenGndAttkToIdle()
::QueenGndAttkToIdle_label::
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(0x11)	-- Frame set 1
	wait(2) 
	playfram(0x22)	-- Frame set 2
	wait(2) 
	playfram(0x33)	-- Frame set 3
	wait(2) 
	playfram(0x44)	-- Frame set 4
	wait(2) 
	goto QueenGndAttkToIdle_label
end

function QueenDeath()
	playsnd(925)	-- Zerg\Queen\ZQuDth00.WAV | Zerg\Queen\ZQuDth02.WAV
	sprol(156, 0, 0)	-- Queen Death (zerg\zquDeath.grp)
	wait(1) 
end

function QueenGndAttkInit()
	setvertpos(0) 
	playfram(0x55)	-- Frame set 5
	wait(1) 
	playfram(0x66)	-- Frame set 6
	wait(1) 
	playfram(0x77)	-- Frame set 7
	wait(1) 
	playfram(0x88)	-- Frame set 8
	playsnd(90)	-- Bullet\ZQuFir00.wav
	attackwith(1) 
	wait(1) 
	playfram(0x99)	-- Frame set 9
	wait(1) 
	playfram(0xaa)	-- Frame set 10
	gotorepeatattk()
	QueenGndAttkToIdle()
end

function QueenCastSpell()
	setvertpos(0) 
	playfram(0x55)	-- Frame set 5
	nobrkcodestart()
	wait(1) 
	playfram(0x66)	-- Frame set 6
	wait(1) 
	playfram(0x77)	-- Frame set 7
	wait(1) 
	playfram(0x88)	-- Frame set 8
	castspell()
	sigorder(2) 
	wait(1) 
	playfram(0x99)	-- Frame set 9
	wait(1) 
	playfram(0xaa)	-- Frame set 10
	nobrkcodeend()
	gotorepeatattk()
	QueenGndAttkToIdle()
end

function QueenWalking()
::QueenWalking_label::
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(0x11)	-- Frame set 1
	wait(1) 
	playfram(0x22)	-- Frame set 2
	wait(1) 
	playfram(0x33)	-- Frame set 3
	wait(1) 
	playfram(0x44)	-- Frame set 4
	wait(1) 
	goto QueenWalking_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 048 Queen Death (zerg\zquDeath.grp)
iscript[28] = {
  IsId =          	28,
  Type =          	0,
  Init =          	QueenDeathInit,
  Death =         	nil
}
-- ----------------------------------------------------------------------------- --

function QueenDeathInit()
	playfram(0x00)	-- Frame set 0
	wait(2) 
	imgol(58, 0, 0)	-- Zerg Air Death Explosion (Large) (thingy\zAirDthL.grp)
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 050 Ultralisk (zerg\ultra.grp)
iscript[29] = {
  IsId =          	29,
  Type =          	12,
  Init =          	UltraliskInit,
  Death =         	UltraliskDeath,
  GndAttkInit =   	UltraliskGndAttkInit,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	UltraliskGndAttkRpt,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	UltraliskGndAttkToIdle,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	UltraliskWalking,
  WalkingToIdle = 	UltraliskGndAttkToIdle,
  SpecialState1 = 	nil
}
-- ----------------------------------------------------------------------------- --

function UltraliskInit()
	imgul(51, 0, 0)	-- Ultralisk Shadow (zerg\zulShad.grp)
	UltraliskGndAttkToIdle()
end

function UltraliskGndAttkToIdle()
	playfram(0x99)	-- Frame set 9
	ScourgeLocal00()
end

function UltraliskDeath()
	playsnd(878)	-- Zerg\Ultra\ZUlDth00.WAV
	setfldirect(0) 
	playfram(0xff)	-- Frame set 15
	wait(2) 
	playfram(256)	-- Frame set 15,  direction 1
	wait(2) 
	playfram(257)	-- Frame set 15,  direction 2
	wait(2) 
	playfram(258)	-- Frame set 15,  direction 3
	wait(2) 
	playfram(259)	-- Frame set 15,  direction 4
	wait(2) 
	playfram(260)	-- Frame set 15,  direction 5
	wait(2) 
	playfram(261)	-- Frame set 15,  direction 6
	wait(2) 
	playfram(262)	-- Frame set 15,  direction 7
	wait(2) 
	playfram(263)	-- Frame set 15,  direction 8
	wait(2) 
	playfram(264)	-- Frame set 15,  direction 9
	wait(2) 
	lowsprul(158, 0, 0)	-- Ultralisk Remnants (zerg\zulDeath.grp)
	wait(1) 
end

function UltraliskGndAttkInit()
	playfram(0xee)	-- Frame set 14
	UltraliskGndAttkRpt()
end

function UltraliskGndAttkRpt()
	wait(1) 
	nobrkcodestart()
  playsnd(891) -- Zerg\Ultra\zulAtt00.WAV | Zerg\Ultra\zulAtt01.WAV | Zerg\Ultra\zulAtt02.WAV
	wait(2) 
	playfram(0xdd)	-- Frame set 13
	wait(2) 
	playfram(0xcc)	-- Frame set 12
	attackmelee(894, 895)	-- Zerg\Ultra\zulHit00.WAV | Zerg\Ultra\zulHit01.WAV
	wait(2) 
	playfram(0xbb)	-- Frame set 11
	wait(2) 
	playfram(0xcc)	-- Frame set 12
	wait(2) 
	playfram(0xdd)	-- Frame set 13
	wait(2) 
	playfram(0xee)	-- Frame set 14
	wait(2) 
	nobrkcodeend()
	gotorepeatattk()
	UltraliskGndAttkToIdle()
end

function UltraliskWalking()
::UltraliskWalking_label::
	move(2) 
	wait(1) 
	playfram(0x00)	-- Frame set 0
	move(6) 
	wait(1) 
	playfram(0x11)	-- Frame set 1
	move(4) 
	wait(1) 
	playfram(0x22)	-- Frame set 2
	move(3) 
	wait(1) 
	playfram(0x33)	-- Frame set 3
	move(2) 
	wait(1) 
	playfram(0x44)	-- Frame set 4
	move(7) 
	wait(1) 
	playfram(0x55)	-- Frame set 5
	move(8) 
	wait(1) 
	playfram(0x66)	-- Frame set 6
	move(7) 
	wait(1) 
	playfram(0x77)	-- Frame set 7
	move(8) 
	wait(1) 
	playfram(0x88)	-- Frame set 8
	move(7) 
	wait(1) 
	playfram(0x99)	-- Frame set 9
	goto UltraliskWalking_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 053 Ultralisk Remnants (zerg\zulDeath.grp)
iscript[30] = {
  IsId =          	30,
  Type =          	0,
  Init =          	UltraliskRemnantsInit,
  Death =         	nil
}
-- ----------------------------------------------------------------------------- --

function UltraliskRemnantsInit()
	playfram(0x00)	-- Frame set 0
	wait(50) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(50) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(50) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(50) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(50) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 054 Zergling (zerg\zergling.grp)
iscript[31] = {
  IsId =          	31,
  Type =          	26,
  Init =          	ZerglingInit,
  Death =         	ZerglingDeath,
  GndAttkInit =   	ZerglingGndAttkInit,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	ZerglingGndAttkInit,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	ZerglingGndAttkToIdle,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	ZerglingWalking,
  WalkingToIdle = 	ZerglingGndAttkToIdle,
  SpecialState1 = 	nil,
  SpecialState2 = 	ZerglingSpecialState2,
  AlmostBuilt =   	nil,
  Built =         	nil,
  Landing =       	nil,
  LiftOff =       	nil,
  IsWorking =     	nil,
  WorkingToIdle = 	nil,
  WarpIn =        	nil,
  Unused3 =       	nil,
  StarEditInit =  	nil,
  Disable =       	nil,
  Burrow =        	ZerglingBurrow,
  UnBurrow =      	ZerglingUnBurrow,
  Enable =        	nil
}
-- ----------------------------------------------------------------------------- --

function ZerglingInit()
	imgul(55, 0, 0)	-- Zergling Shadow (zerg\zzeShad.grp)
	ZerglingGndAttkToIdle()
end

function ZerglingGndAttkToIdle()
	playfram(0x55)	-- Frame set 5
	ScourgeLocal00()
end

function ZerglingDeath()
	playsnd(896)	-- Zerg\Zergling\ZZeDth00.WAV
	setfldirect(0) 
	playfram(0x121)	-- Frame set 17
	wait(2) 
	playfram(290)	-- Frame set 17,  direction 1
	wait(2) 
	playfram(291)	-- Frame set 17,  direction 2
	wait(2) 
	playfram(292)	-- Frame set 17,  direction 3
	wait(2) 
	playfram(293)	-- Frame set 17,  direction 4
	wait(2) 
	playfram(294)	-- Frame set 17,  direction 5
	wait(2) 
	playfram(295)	-- Frame set 17,  direction 6
	wait(2) 
	lowsprul(160, 0, 0)	-- Zergling Remnants (zerg\zzeDeath.grp)
	wait(1) 
end

function ZerglingGndAttkInit()
	playfram(0x00)	-- Frame set 0
	wait(1) 
	nobrkcodestart()
	playfram(0x11)	-- Frame set 1
	wait(1) 
	playfram(0x22)	-- Frame set 2
	attackmelee(894)	-- Zerg\Ultra\zulHit00.WAV
	wait(1) 
	playfram(0x33)	-- Frame set 3
	wait(1) 
	playfram(0x44)	-- Frame set 4
	wait(1) 
	nobrkcodeend()
	gotorepeatattk()
	ZerglingGndAttkToIdle()
end

function ZerglingWalking()
::ZerglingWalking_label::
	move(2) 
	wait(1) 
	playfram(0x66)	-- Frame set 6
	move(8) 
	wait(1) 
	playfram(0x77)	-- Frame set 7
	move(9) 
	wait(1) 
	playfram(0x88)	-- Frame set 8
	move(5) 
	wait(1) 
	playfram(0x99)	-- Frame set 9
	move(6) 
	wait(1) 
	playfram(0xaa)	-- Frame set 10
	move(7) 
	wait(1) 
	playfram(0xbb)	-- Frame set 11
	move(2) 
	wait(1) 
	playfram(0x55)	-- Frame set 5
	goto ZerglingWalking_label
end

function ZerglingSpecialState2()
	playfram(0x110)	-- Frame set 16
	ScourgeLocal00()
end

function ZerglingBurrow()
	imgol(423, 0, 0)	-- Burrowing Dust (thingy\bDust.grp)
	playfram(0xcc)	-- Frame set 12
	wait(1) 
	playfram(0xdd)	-- Frame set 13
	wait(1) 
	playfram(0xee)	-- Frame set 14
	wait(1) 
	playfram(0xff)	-- Frame set 15
	wait(1) 
	playfram(0x110)	-- Frame set 16
	wait(1) 
	sigorder(4) 
	ScourgeLocal00()
end

function ZerglingUnBurrow()
	waitrand(1, 5) 
	imgul(423, 0, 0)	-- Burrowing Dust (thingy\bDust.grp)
	playfram(0xff)	-- Frame set 15
	wait(1) 
	playfram(0xee)	-- Frame set 14
	wait(1) 
	playfram(0xdd)	-- Frame set 13
	wait(1) 
	playfram(0xcc)	-- Frame set 12
	wait(1) 
	sigorder(4) 
	ZerglingGndAttkToIdle()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 057 Zergling Remnants (zerg\zzeDeath.grp)
iscript[32] = {
  IsId =          	32,
  Type =          	0,
  Init =          	ZerglingRemnantsInit,
  Death =         	nil
}
-- ----------------------------------------------------------------------------- --

function ZerglingRemnantsInit()
	playfram(0x00)	-- Frame set 0
	wait(50) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(50) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(50) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(50) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(50) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 058 Zerg Air Death Explosion (Large) (thingy\zAirDthL.grp)
-- 059 Zerg Air Death Explosion (Small) (thingy\zAirDthS.grp)
iscript[33] = {
  IsId =          	33,
  Type =          	1,
  Init =          	ZergAirDeathExplosionInit,
  Death =         	ScourgeExplosionDeath
}
-- ----------------------------------------------------------------------------- --

function ZergAirDeathExplosionInit()
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(2) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(2) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 002 Scourge Birth (zerg\zavBirth.grp)
-- 015 Defiler Birth (zerg\zdebirth.grp)
-- 019 Drone Birth (zerg\zdrbirth.grp)
-- 031 Hydralisk Birth (zerg\zhybirth.grp)
-- 040 Mutalisk Birth (zerg\zmubirth.grp)
-- 044 Overlord Birth (zerg\zovBirth.grp)
-- 049 Queen Birth (zerg\zquBirth.grp)
-- 052 Ultralisk Birth (zerg\zulbirth.grp)
-- 056 Zergling Birth (zerg\zzebirth.grp)
-- 919 Lurker Birth (zerg\zLubirth.grp)
iscript[36] = {
  IsId =          	36,
  Type =          	13,
  Init =          	ZergBirthInit,
  Death =         	ZergBirthDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	nil,
  WalkingToIdle = 	nil,
  SpecialState1 = 	ZergBirthSpecialState1
}
-- ----------------------------------------------------------------------------- --

function ZergBirthInit()
	playfram(0x00)	-- Frame set 0
	ScourgeLocal00()
end

function ZergBirthDeath()
	wait(1) 
end

function ZergBirthSpecialState1()
	wait(1) 
	nobrkcodestart()
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(2) 
	sigorder(4) 
	lowsprul(319, 0, 0)	-- Egg Spawn (zerg\zegspawn.grp)
	nobrkcodeend()
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 023 Egg Spawn (zerg\zegspawn.grp)
iscript[37] = {
  IsId =          	37,
  Type =          	0,
  Init =          	EggSpawnInit,
  Death =         	nil
}
-- ----------------------------------------------------------------------------- --

function EggSpawnInit()
	playfram(0x00)	-- Frame set 0
	wait(5) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(5) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(5) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(5) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(5) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 063 Infested Command Center (terran\control.grp)
iscript[39] = {
  IsId =          	39,
  Type =          	20,
  Init =          	InfestedCommandCenterInit,
  Death =         	InfestedCommandCenterDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	ScourgeLocal00,
  WalkingToIdle = 	ScourgeLocal00,
  SpecialState1 = 	InfestedCommandCenterSpecialState1,
  SpecialState2 = 	nil,
  AlmostBuilt =   	nil,
  Built =         	InfestedCommandCenterBuilt,
  Landing =       	InfestedCommandCenterLanding,
  LiftOff =       	InfestedCommandCenterLiftOff,
  IsWorking =     	InfestedCommandCenterIsWorking,
  WorkingToIdle = 	InfestedCommandCenterBuilt,
  WarpIn =        	nil
}
-- ----------------------------------------------------------------------------- --

function InfestedCommandCenterInit()
	imgul(277, 0, 0)	-- Command Center Shadow (terran\tccShad.grp)
	imgol(101, 0, 0)	-- Infested Command Center Overlay (zerg\Infest03.grp)
	InfestedCommandCenterBuilt()
end

function InfestedCommandCenterBuilt()
	playfram(0x00)	-- Frame set 0
	ScourgeLocal00()
end

function InfestedCommandCenterDeath()
	playsnd(7)	-- Misc\ExploLrg.wav
	imgol(334, 0, 0)	-- Building Explosion (Large) (thingy\tBangX.grp)
	wait(3) 
	liftoffcondjmp(ScourgeExplosionDeath)
	lowsprul(274, 0, 0)	-- Terran Building Rubble (Large) (thingy\RubbleL.grp)
	wait(1) 
end

function InfestedCommandCenterSpecialState1()
	playfram(4)	-- Frame set 0,  direction 4
	ScourgeLocal00()
end

function InfestedCommandCenterLanding()
	nobrkcodestart()
	wait(18) 
	playsnd(472)	-- Misc\Land.WAV
	playfram(4)	-- Frame set 0,  direction 4
	wait(5) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(5) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(5) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(5) 
	playfram(0x00)	-- Frame set 0
	sigorder(16) 
	nobrkcodeend()
	ScourgeLocal00()
end

function InfestedCommandCenterLiftOff()
	nobrkcodestart()
	playsnd(471)	-- Misc\LiftOff.WAV
	playfram(5)	-- Frame set 0,  direction 5
	wait(5) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(5) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(5) 
	playfram(4)	-- Frame set 0,  direction 4
	sigorder(16) 
	nobrkcodeend()
	ScourgeLocal00()
end

function InfestedCommandCenterIsWorking()
	imgol(276, 0, 0)	-- Command Center Overlay (terran\controlT.grp)
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 076 Sunken Colony (zerg\Lurker.grp)
iscript[46] = {
  IsId =          	46,
  Type =          	20,
  Init =          	SunkenColonyInit,
  Death =         	CerebrateDeath,
  GndAttkInit =   	SunkenColonyGndAttkInit,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	SunkenColonyGndAttkInit,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	SunkenColonyGndAttkToIdle,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	nil,
  WalkingToIdle = 	nil,
  SpecialState1 = 	nil,
  SpecialState2 = 	nil,
  AlmostBuilt =   	SunkenColonyAlmostBuilt,
  Built =         	SunkenColonyBuilt,
  Landing =       	nil,
  LiftOff =       	nil,
  IsWorking =     	SunkenColonyIsWorking,
  WorkingToIdle = 	SunkenColonyIsWorking,
  WarpIn =        	nil
}
-- ----------------------------------------------------------------------------- --

function SunkenColonyInit()
	playfram(0x00)	-- Frame set 0
	imgul(77, 0, 0)	-- Sunken Colony Shadow (zerg\zluShad.grp)
	ScourgeLocal00()
end

function SunkenColonyGndAttkInit()
	trgtarccondjmp(74, 42, SunkenColonyLocal00)
	trgtarccondjmp(159, 42, SunkenColonyLocal01)
	nobrkcodestart()
	playsnd(78)	-- Bullet\ZLuFir00.wav
	playfram(24)	-- Frame set 1,  direction 7
	wait(1) 
	playfram(25)	-- Frame set 1,  direction 8
	wait(1) 
	playfram(26)	-- Frame set 1,  direction 9
	wait(1) 
	playfram(27)	-- Frame set 1,  direction 10
	wait(1) 
	playfram(28)	-- Frame set 1,  direction 11
	wait(1) 
	playfram(29)	-- Frame set 1,  direction 12
	wait(1) 
	playfram(30)	-- Frame set 1,  direction 13
	wait(1) 
	playfram(31)	-- Frame set 1,  direction 14
	wait(1) 
	playfram(32)	-- Frame set 1,  direction 15
	wait(1) 
	playfram(33)	-- Frame set 1,  direction 16
	wait(1) 
	attackwith(1) 
	wait(6) 
	playfram(32)	-- Frame set 1,  direction 15
	wait(1) 
	playfram(31)	-- Frame set 1,  direction 14
	wait(1) 
	playfram(30)	-- Frame set 1,  direction 13
	wait(1) 
	playfram(29)	-- Frame set 1,  direction 12
	wait(1) 
	playfram(28)	-- Frame set 1,  direction 11
	wait(1) 
	playfram(27)	-- Frame set 1,  direction 10
	wait(1) 
	playfram(26)	-- Frame set 1,  direction 9
	wait(1) 
	playfram(25)	-- Frame set 1,  direction 8
	wait(1) 
	playfram(24)	-- Frame set 1,  direction 7
	wait(1) 
	nobrkcodeend()
	gotorepeatattk()
	ignorerest()
	SunkenColonyGndAttkToIdle()
end

function SunkenColonyGndAttkToIdle()
	SunkenColonyIsWorking()
end

function SunkenColonyIsWorking()
::SunkenColonyIsWorking_label::
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	goto SunkenColonyIsWorking_label
end

function SunkenColonyLocal00()
	nobrkcodestart()
	playsnd(78)	-- Bullet\ZLuFir00.wav
	playfram(3)	-- Frame set 0,  direction 3
	wait(1) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(1) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(1) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(1) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(1) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(1) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(1) 
	playfram(10)	-- Frame set 0,  direction 10
	wait(1) 
	playfram(11)	-- Frame set 0,  direction 11
	wait(1) 
	playfram(12)	-- Frame set 0,  direction 12
	wait(1) 
	playfram(13)	-- Frame set 0,  direction 13
	wait(1) 
	attackwith(1) 
	wait(6) 
	playfram(12)	-- Frame set 0,  direction 12
	wait(1) 
	playfram(11)	-- Frame set 0,  direction 11
	wait(1) 
	playfram(10)	-- Frame set 0,  direction 10
	wait(1) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(1) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(1) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(1) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(1) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(1) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(1) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(1) 
	nobrkcodeend()
	gotorepeatattk()
	ignorerest()
	SunkenColonyIsWorking()
end

function SunkenColonyLocal01()
	nobrkcodestart()
	playsnd(78)	-- Bullet\ZLuFir00.wav
	playfram(14)	-- Frame set 0,  direction 14
	wait(1) 
	playfram(15)	-- Frame set 0,  direction 15
	wait(1) 
	playfram(16)	-- Frame set 0,  direction 16
	wait(1) 
	playfram(0x11)	-- Frame set 1
	wait(1) 
	playfram(18)	-- Frame set 1,  direction 1
	wait(1) 
	playfram(19)	-- Frame set 1,  direction 2
	wait(1) 
	playfram(20)	-- Frame set 1,  direction 3
	wait(1) 
	playfram(21)	-- Frame set 1,  direction 4
	wait(1) 
	playfram(22)	-- Frame set 1,  direction 5
	wait(1) 
	playfram(23)	-- Frame set 1,  direction 6
	wait(1) 
	attackwith(1) 
	wait(6) 
	playfram(23)	-- Frame set 1,  direction 6
	wait(1) 
	playfram(22)	-- Frame set 1,  direction 5
	wait(1) 
	playfram(21)	-- Frame set 1,  direction 4
	wait(1) 
	playfram(20)	-- Frame set 1,  direction 3
	wait(1) 
	playfram(19)	-- Frame set 1,  direction 2
	wait(1) 
	playfram(18)	-- Frame set 1,  direction 1
	wait(1) 
	playfram(0x11)	-- Frame set 1
	wait(1) 
	playfram(16)	-- Frame set 0,  direction 16
	wait(1) 
	playfram(15)	-- Frame set 0,  direction 15
	wait(1) 
	playfram(14)	-- Frame set 0,  direction 14
	wait(1) 
	nobrkcodeend()
	gotorepeatattk()
	ignorerest()
	SunkenColonyIsWorking()
end

function SunkenColonyAlmostBuilt()
	imgol(107, 0, 0)	-- Zerg Building Spawn (Small) (zerg\zSpawn01.grp)
	SunkenColonyBuilt()
end

function SunkenColonyBuilt()
	playfram(0x00)	-- Frame set 0
	waitrand(1, 2) 
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	SunkenColonyIsWorking()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 088 Overmind With Shell (zerg\Over1.grp)
iscript[52] = {
  IsId =          	52,
  Type =          	20,
  Init =          	Overmind_withShell_Init,
  Death =         	Overmind_withShell_Death,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	nil,
  WalkingToIdle = 	nil,
  SpecialState1 = 	nil,
  SpecialState2 = 	nil,
  AlmostBuilt =   	Overmind_withShell_AlmostBuilt,
  Built =         	Overmind_withShell_Built,
  Landing =       	nil,
  LiftOff =       	nil,
  IsWorking =     	Overmind_withShell_IsWorking,
  WorkingToIdle = 	Overmind_withShell_IsWorking,
  WarpIn =        	nil
}
-- ----------------------------------------------------------------------------- --

function Overmind_withShell_Init()
	playfram(0x00)	-- Frame set 0
	ScourgeLocal00()
end

function Overmind_withShell_Death()
	playsnd(774)	-- Zerg\Bldg\ZBldgDth.WAV
	imgol(60, 0, 0)	-- Zerg Building Explosion (thingy\zBldDthS.grp)
	wait(3) 
	imgol(89, 0, 0)	-- Overmind Remnants (zerg\Over2.grp)
	wait(1) 
end

function Overmind_withShell_AlmostBuilt()
	imgol(108, 0, 0)	-- Zerg Building Spawn (Medium) (zerg\zSpawn02.grp)
	playfram(0x00)	-- Frame set 0
	Overmind_withShell_Built()
end

function Overmind_withShell_Built()
	waitrand(1, 3) 
  Overmind_withShell_IsWorking()
end

function Overmind_withShell_IsWorking()
::Overmind_withShell_IsWorking_label::
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(4) 
	wait(1) 
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(0x00)	-- Frame set 0
	wait(4) 
	goto Overmind_withShell_IsWorking_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 089 Overmind Remnants (zerg\Over2.grp)
iscript[53] = {
  IsId =          	53,
  Type =          	1,
  Init =          	OvermindRemnantsInit,
  Death =         	HatcheryDeath
}
-- ----------------------------------------------------------------------------- --

function OvermindRemnantsInit()
	playfram(0x00)	-- Frame set 0
	wait(63) 
	HatcheryDeath()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 093 Extractor (zerg\Extract.grp)
iscript[56] = {
  IsId =          	56,
  Type =          	20,
  Init =          	ExtractorInit,
  Death =         	ExtractorDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	nil,
  WalkingToIdle = 	nil,
  SpecialState1 = 	nil,
  SpecialState2 = 	nil,
  AlmostBuilt =   	ExtractorAlmostBuilt,
}
-- ----------------------------------------------------------------------------- --

function ExtractorInit()
	imgul(94, 0, 0)	-- Extractor Shadow (zerg\zreShad.grp)
	playfram(0x00)	-- Frame set 0
	ScourgeLocal00()
end

function ExtractorDeath()
	playsnd(774)	-- Zerg\Bldg\ZBldgDth.WAV
	sprol(185, 0, 0)	-- Zerg Building Explosion (thingy\zBldDthS.grp)
	wait(3) 
end

function ExtractorAlmostBuilt()
	imgol(109, 0, 0)	-- Zerg Building Spawn (Large) (zerg\zSpawn03.grp)
	--ExtractorBuilt()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 099 Spore Colony (zerg\SColony.grp)
iscript[59] = {
  IsId =          	59,
  Type =          	20,
  Init =          	SporeColonyInit,
  Death =         	CerebrateDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	SporeColonyAirAttkInit,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	SporeColonyAirAttkInit,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	SporeColonyAirAttkToIdle,
  Unused2 =       	nil,
  Walking =       	nil,
  WalkingToIdle = 	nil,
  SpecialState1 = 	nil,
  SpecialState2 = 	nil,
  AlmostBuilt =   	SporeColonyAlmostBuilt,
  Built =         	SporeColonyBuilt,
  Landing =       	nil,
  LiftOff =       	nil,
  IsWorking =     	SporeColonyAirAttkToIdle,
  WorkingToIdle = 	SporeColonyAirAttkToIdle,
  WarpIn =        	nil
}
-- ----------------------------------------------------------------------------- --

function SporeColonyInit()
	imgul(100, 0, 0)	-- Spore Colony Shadow (zerg\zscShad.grp)
	playfram(0x00)	-- Frame set 0
	ScourgeLocal00()
end

function SporeColonyAirAttkInit()
	wait(1) 
	attackwith(2) 
	gotorepeatattk()
	ScourgeLocal00()
end

function SporeColonyAirAttkToIdle()
::SporeColonyAirAttkToIdle_label::
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	goto SporeColonyAirAttkToIdle_label
end

function SporeColonyAlmostBuilt()
	imgol(108, 0, 0)	-- Zerg Building Spawn (Medium) (zerg\zSpawn02.grp)
	playfram(0x00)	-- Frame set 0
	SporeColonyBuilt()
end

function SporeColonyBuilt()
	waitrand(1, 3) 
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	SporeColonyAirAttkToIdle()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 101 Infested Command Center Overlay (zerg\Infest03.grp)
iscript[60] = {
  IsId =          	60,
  Type =          	1,
  Init =          	InfestedCommandCenterOverlayInit,
  Death =         	InfestedCommandCenterOverlayDeath
}
-- ----------------------------------------------------------------------------- --

function InfestedCommandCenterOverlayInit()
::InfestedCommandCenterOverlayInit_label::
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	goto InfestedCommandCenterOverlayInit_label
end

function InfestedCommandCenterOverlayDeath()
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 105 Zerg Construction (Small) (zerg\ZBuild.grp)
iscript[61] = {
  IsId =          	61,
  Type =          	15,
  Init =          	ZergConstruction_Small_Init,
  Death =         	CerebrateDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	nil,
  WalkingToIdle = 	nil,
  SpecialState1 = 	ZergConstruction_Small_SpecialState1,
  SpecialState2 = 	ZergConstruction_Small_SpecialState1,
  AlmostBuilt =   	ZergConstruction_Small_AlmostBuilt
}
-- ----------------------------------------------------------------------------- --

function ZergConstruction_Small_Init()
	imgul(106, 0, 0)	-- Zerg Building Construction Shadow (zerg\ZBShad.grp)
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
  ZergConstruction_Small_SpecialState1()
end

function ZergConstruction_Small_SpecialState1()
::ZergConstruction_Small_SpecialState1_label::
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(2) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(2) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(2) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(2) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(2) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(2) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	goto ZergConstruction_Small_SpecialState1_label
end

function ZergConstruction_Small_AlmostBuilt()
	playfram(10)	-- Frame set 0,  direction 10
	wait(2) 
	playfram(11)	-- Frame set 0,  direction 11
	wait(2) 
	playfram(12)	-- Frame set 0,  direction 12
	wait(2) 
	sigorder(4) 
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 104 Zerg Construction (Medium) (zerg\ZBuild.grp)
iscript[62] = {
  IsId =          	62,
  Type =          	15,
  Init =          	ZergConstruction_Medium_Init,
  Death =         	CerebrateDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	nil,
  WalkingToIdle = 	nil,
  SpecialState1 = 	ZergConstruction_Medium_SpecialState1,
  SpecialState2 = 	ZergConstruction_Medium_SpecialState1,
  AlmostBuilt =   	ZergConstruction_Medium_AlmostBuilt
}
-- ----------------------------------------------------------------------------- --

function ZergConstruction_Medium_Init()
	imgul(106, 0, 0)	-- Zerg Building Construction Shadow (zerg\ZBShad.grp)
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
  ZergConstruction_Medium_Local00()
end

function ZergConstruction_Medium_Local00()
::ZergConstruction_Medium_Local00_label::
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(2) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(2) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(2) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(2) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(2) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(2) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	goto ZergConstruction_Medium_Local00_label
end

function ZergConstruction_Medium_SpecialState1()
::ZergConstruction_Medium_SpecialState1_label::
	playfram(13)	-- Frame set 0,  direction 13
	wait(2) 
	playfram(14)	-- Frame set 0,  direction 14
	wait(2) 
	playfram(15)	-- Frame set 0,  direction 15
	wait(2) 
	playfram(16)	-- Frame set 0,  direction 16
	wait(2) 
	playfram(0x11)	-- Frame set 1
	wait(2) 
	playfram(18)	-- Frame set 1,  direction 1
	wait(2) 
	playfram(0x11)	-- Frame set 1
	wait(2) 
	playfram(16)	-- Frame set 0,  direction 16
	wait(2) 
	playfram(15)	-- Frame set 0,  direction 15
	wait(2) 
	playfram(14)	-- Frame set 0,  direction 14
	wait(2) 
	goto ZergConstruction_Medium_SpecialState1_label
end

function ZergConstruction_Medium_AlmostBuilt()
	playfram(19)	-- Frame set 1,  direction 2
	wait(2) 
	playfram(20)	-- Frame set 1,  direction 3
	wait(2) 
	playfram(21)	-- Frame set 1,  direction 4
	wait(2) 
	sigorder(4) 
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 103 Zerg Building Morph (zerg\ZBuild.grp)
iscript[63] = {
  IsId =          	63,
  Type =          	15,
  Init =          	ZergBuildingMorphInit,
  Death =         	HatcheryDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	nil,
  WalkingToIdle = 	nil,
  SpecialState1 = 	ZergBuildingMorphSpecialState1,
  SpecialState2 = 	ZergBuildingMorphSpecialState2,
  AlmostBuilt =   	ZergBuildingMorphAlmostBuilt
}
-- ----------------------------------------------------------------------------- --

function ZergBuildingMorphInit()
	imgul(106, 0, 0)	-- Zerg Building Construction Shadow (zerg\ZBShad.grp)
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	ZergBuildingMorphLocal00()
end

function ZergBuildingMorphLocal00()
::ZergBuildingMorphLocal00_label::
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(2) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(2) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(2) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(2) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	goto ZergBuildingMorphLocal00_label
end

function ZergBuildingMorphSpecialState1()
::ZergBuildingMorphSpecialState1_label::
	playfram(13)	-- Frame set 0,  direction 13
	wait(2) 
	playfram(14)	-- Frame set 0,  direction 14
	wait(2) 
	playfram(15)	-- Frame set 0,  direction 15
	wait(2) 
	playfram(16)	-- Frame set 0,  direction 16
	wait(2) 
	playfram(0x11)	-- Frame set 1
	wait(2) 
	playfram(18)	-- Frame set 1,  direction 1
	wait(2) 
	playfram(0x11)	-- Frame set 1
	wait(2) 
	playfram(16)	-- Frame set 0,  direction 16
	wait(2) 
	playfram(15)	-- Frame set 0,  direction 15
	wait(2) 
	playfram(14)	-- Frame set 0,  direction 14
	wait(2) 
	goto ZergBuildingMorphSpecialState1_label
end

function ZergBuildingMorphSpecialState2()
::ZergBuildingMorphSpecialState2_label::
	playfram(22)	-- Frame set 1,  direction 5
	wait(2) 
	playfram(23)	-- Frame set 1,  direction 6
	wait(2) 
	playfram(24)	-- Frame set 1,  direction 7
	wait(2) 
	playfram(25)	-- Frame set 1,  direction 8
	wait(2) 
	playfram(26)	-- Frame set 1,  direction 9
	wait(2) 
	playfram(27)	-- Frame set 1,  direction 10
	wait(2) 
	playfram(26)	-- Frame set 1,  direction 9
	wait(2) 
	playfram(25)	-- Frame set 1,  direction 8
	wait(2) 
	playfram(24)	-- Frame set 1,  direction 7
	wait(2) 
	playfram(23)	-- Frame set 1,  direction 6
	wait(2) 
	goto ZergBuildingMorphSpecialState2_label
end

function ZergBuildingMorphAlmostBuilt()
	playfram(28)	-- Frame set 1,  direction 11
	wait(2) 
	playfram(29)	-- Frame set 1,  direction 12
	wait(2) 
	playfram(30)	-- Frame set 1,  direction 13
	wait(2) 
	sigorder(4) 
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 102 Zerg Construction (Large) (zerg\ZBuild.grp)
iscript[64] = {
  IsId =          	64,
  Type =          	15,
  Init =          	ZergConstruction_Large_Init,
  Death =         	ZergConstruction_Large_Death,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	nil,
  WalkingToIdle = 	nil,
  SpecialState1 = 	ZergBuildingMorphSpecialState2,
  SpecialState2 = 	ZergBuildingMorphSpecialState2,
  AlmostBuilt =   	ZergBuildingMorphAlmostBuilt
}
-- ----------------------------------------------------------------------------- --

function ZergConstruction_Large_Init()
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	ZergBuildingMorphSpecialState2()
end

function ZergConstruction_Large_Death()
	playsnd(774)	-- Zerg\Bldg\ZBldgDth.WAV
	sprol(185, 0, 0)	-- Zerg Building Explosion (thingy\zBldDthS.grp)
	wait(3) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 107 Zerg Building Spawn (Small) (zerg\zSpawn01.grp)
-- 108 Zerg Building Spawn (Medium) (zerg\zSpawn02.grp)
-- 109 Zerg Building Spawn (Large) (zerg\zSpawn03.grp)
iscript[65] = {
  IsId =          	65,
  Type =          	1,
  Init =          	ZergBuildingSpawnInit,
  Death =         	ZergBuildingSpawnDeath
}
-- ----------------------------------------------------------------------------- --

function ZergBuildingSpawnInit()
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
end

function ZergBuildingSpawnDeath()
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 218 Battlecruiser (terran\BattleCr.grp)
iscript[66] = {
  IsId =          	66,
  Type =          	12,
  Init =          	BattlecruiserInit,
  Death =         	BattlecruiserDeath,
  GndAttkInit =   	BattlecruiserGndAttkInit,
  AirAttkInit =   	BattlecruiserAirAttkInit,
  Unused1 =       	nil,
  GndAttkRpt =    	BattlecruiserGndAttkInit,
  AirAttkRpt =    	BattlecruiserAirAttkInit,
  CastSpell =     	BattlecruiserCastSpell,
  GndAttkToIdle = 	ScourgeLocal00,
  AirAttkToIdle = 	ScourgeLocal00,
  Unused2 =       	nil,
  Walking =       	BattlecruiserWalking,
  WalkingToIdle = 	OverlordLocal00,
  SpecialState1 = 	nil
}
-- ----------------------------------------------------------------------------- --

function BattlecruiserInit()
	imgul(219, 0, 42)	-- Battlecruiser Shadow (terran\BattleCr.grp)
	playfram(0x00)	-- Frame set 0
	ScourgeLocal00()
end

function BattlecruiserDeath()
	playsnd(177)	-- Terran\BATTLE\tbaDth00.wav
	imgol(333, 0, 0)	-- Explosion2 (Medium) (thingy\tBangL.grp)
	wait(3) 
end

function BattlecruiserGndAttkInit()
	imgol(446, 0, 0)	-- Battlecruiser Attack Overlay (thingy\elbBat.grp)
	BattlecruiserLocal00()
end

function BattlecruiserLocal00()
	wait(1) 
	attackwith(1) 
	gotorepeatattk()
	ScourgeLocal00()
end

function BattlecruiserAirAttkInit()
	imgol(446, 0, 0)	-- Battlecruiser Attack Overlay (thingy\elbBat.grp)
	SporeColonyAirAttkInit()
end

function BattlecruiserCastSpell()
	imgolorig(543)	-- Yamato Gun Overlay (thingy\eycBlast.grp)
	ScourgeLocal00()
end

function BattlecruiserWalking()
	imgol(220, 0, 0)	-- Battlecruiser Engines (thingy\tbaGlow.grp)
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 221 Civilian (neutral\civilian.grp)
iscript[67] = {
  IsId =          	67,
  Type =          	12,
  Init =          	CivilianInit,
  Death =         	CivilianDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	CivilianWalking,
  WalkingToIdle = 	CivilianWalkingToIdle,
  SpecialState1 = 	nil
}
-- ----------------------------------------------------------------------------- --

function CivilianInit()
	imgul(222, 0, 0)	-- Civilian Shadow (neutral\nciShad.grp)
	CivilianWalkingToIdle()
end

function CivilianWalkingToIdle()
	playfram(0x77)	-- Frame set 7
	CivilianLocal00()
end

function CivilianLocal00()
::CivilianLocal00_label::
	waitrand(63, 75) 
	randcondjmp(128, CivilianLocal01)
	goto CivilianLocal00_label
end

function CivilianLocal01()
	turnrand(3) 
	CivilianWalkingToIdle()
end

function CivilianDeath()
	playsnd(276)	-- Terran\MARINE\TMaDth00.WAV | Terran\MARINE\TMaDth01.WAV
	imgol(242, 0, 0)	-- Marine Death (terran\marine.grp)
	wait(1) 
end

function CivilianWalking()
::CivilianWalking_label::
	move(4) 
	wait(1) 
	playfram(0x00)	-- Frame set 0
	move(4) 
	wait(1) 
	playfram(0x11)	-- Frame set 1
	move(4) 
	wait(1) 
	playfram(0x22)	-- Frame set 2
	move(4) 
	wait(1) 
	playfram(0x33)	-- Frame set 3
	move(4) 
	wait(1) 
	playfram(0x44)	-- Frame set 4
	move(4) 
	wait(1) 
	playfram(0x55)	-- Frame set 5
	move(4) 
	wait(1) 
	playfram(0x66)	-- Frame set 6
	move(4) 
	wait(1) 
	playfram(0x77)	-- Frame set 7
	goto CivilianWalking_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 223 Dropship (terran\dropship.grp)
iscript[68] = {
  IsId =          	68,
  Type =          	12,
  Init =          	DropshipInit,
  Death =         	DropshipDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	DropshipWalking,
  WalkingToIdle = 	OverlordLocal00,
  SpecialState1 = 	nil
}
-- ----------------------------------------------------------------------------- --

function DropshipInit()
	imgul(224, 0, 42)	-- Dropship Shadow (terran\dropship.grp)
	playfram(0x00)	-- Frame set 0
	OverlordLocal00()
end

function DropshipDeath()
	playsnd(210)	-- Terran\DROPSHIP\TDrDth00.wav
	imgol(332, 0, 0)	-- Explosion2 (Small) (thingy\tBangS.grp)
	wait(3) 
end

function DropshipWalking()
	imgol(225, 0, 0)	-- Dropship Engines (thingy\tdrGlow.grp)
	setvertpos(0) 
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 226 Firebat (terran\firebat.grp)
iscript[69] = {
  IsId =          	69,
  Type =          	12,
  Init =          	FirebatInit,
  Death =         	FirebatDeath,
  GndAttkInit =   	FirebatGndAttkInit,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	FirebatGndAttkRpt,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	FirebatGndAttkToIdle,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	FirebatWalking,
  WalkingToIdle = 	FirebatWalkingToIdle,
  SpecialState1 = 	nil
}
-- ----------------------------------------------------------------------------- --

function FirebatInit()
	imgul(227, 0, 0)	-- Firebat Shadow (terran\tfbShad.grp)
	FirebatWalkingToIdle()
end

function FirebatWalkingToIdle()
	playfram(0x22)	-- Frame set 2
	FirebatLocal00()
end

function FirebatLocal00()
::FirebatLocal00_label::
	waitrand(63, 75) 
	randcondjmp(25, FirebatLocal01)
	randcondjmp(128, FirebatLocal02)
	goto FirebatLocal00_label
end

function FirebatLocal01()
	playfram(0x00)	-- Frame set 0
	wait(1) 
	randcondjmp(192, FirebatLocal03)
	turnccwise(2) 
	wait(3) 
	turnccwise(2) 
	wait(3) 
	turnccwise(2) 
	wait(3) 
	turnccwise(2) 
	wait(3) 
	turnccwise(2) 
	wait(3) 
	wait(6) 
	turncwise(2) 
	wait(3) 
	turncwise(2) 
	wait(3) 
	turncwise(2) 
	wait(3) 
	turncwise(2) 
	wait(3) 
	turncwise(2) 
	wait(3) 
	wait(6) 
	turnccwise(2) 
	wait(3) 
	turnccwise(2) 
	wait(3) 
	turnccwise(2) 
	wait(3) 
	FirebatWalkingToIdle()
end

function FirebatLocal03()
	wait(13) 
	FirebatWalkingToIdle()
end

function FirebatLocal02()
	playfram(0x33)	-- Frame set 3
	wait(1) 
	playfram(0x44)	-- Frame set 4
	wait(1) 
	turnrand(3) 
	wait(1) 
	playfram(0x33)	-- Frame set 3
	wait(1) 
	FirebatWalkingToIdle()
end

function FirebatDeath()
	playsnd(296)	-- Terran\Firebat\TFBDth00.WAV | Terran\Firebat\TFBDth02.WAV
	imgol(332, 0, 0)	-- Explosion2 (Small) (thingy\tBangS.grp)
	wait(3) 
end

function FirebatGndAttkInit()
	playfram(0x00)	-- Frame set 0
	FirebatGndAttkRpt()
end

function FirebatGndAttkRpt()
	wait(1) 
	nobrkcodestart()
	imgol(421, 0, 0)	-- FlameThrower (thingy\flamer.grp)
	playfram(0x11)	-- Frame set 1
	attkshiftproj(24) 
	wait(1) 
	attkshiftproj(52) 
	wait(1) 
	attkshiftproj(80) 
	wait(5) 
	playfram(0x00)	-- Frame set 0
	wait(2) 
	ignorerest()
	FirebatGndAttkToIdle()
end

function FirebatGndAttkToIdle()
	FirebatWalkingToIdle()
end

function FirebatWalking()
::FirebatWalking_label::
	move(4) 
	wait(1) 
	playfram(0x33)	-- Frame set 3
	move(4) 
	wait(1) 
	playfram(0x44)	-- Frame set 4
	move(4) 
	wait(1) 
	playfram(0x55)	-- Frame set 5
	move(4) 
	wait(1) 
	playfram(0x66)	-- Frame set 6
	move(4) 
	wait(1) 
	playfram(0x77)	-- Frame set 7
	move(4) 
	wait(1) 
	playfram(0x88)	-- Frame set 8
	move(4) 
	wait(1) 
	playfram(0x99)	-- Frame set 9
	move(4) 
	wait(1) 
	playfram(0x22)	-- Frame set 2
	goto FirebatWalking_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 228 Ghost (terran\ghost.grp)
iscript[70] = {
  IsId =          	70,
  Type =          	13,
  Init =          	GhostInit,
  Death =         	GhostDeath,
  GndAttkInit =   	GhostGndAttkInit,
  AirAttkInit =   	GhostGndAttkInit,
  Unused1 =       	nil,
  GndAttkRpt =    	GhostGndAttkRpt,
  AirAttkRpt =    	GhostGndAttkRpt,
  CastSpell =     	GhostCastSpell,
  GndAttkToIdle = 	GhostGndAttkToIdle,
  AirAttkToIdle = 	GhostGndAttkToIdle,
  Unused2 =       	nil,
  Walking =       	GhostWalking,
  WalkingToIdle = 	GhostWalkingToIdle,
  SpecialState1 = 	GhostSpecialState1
}
-- ----------------------------------------------------------------------------- --

function GhostInit()
	imgul(229, 0, 0)	-- Ghost Shadow (terran\tghShad.grp)
	GhostWalkingToIdle()
end

function GhostWalkingToIdle()
	playfram(0x33)	-- Frame set 3
	GhostLocal00()
end

function GhostLocal00()
::GhostLocal00_label::
	waitrand(63, 75) 
	randcondjmp(25, GhostLocal01)
	randcondjmp(128, GhostLocal02)
	goto GhostLocal00_label
end

function GhostLocal01()
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(0x11)	-- Frame set 1
	wait(1) 
	playfram(0x22)	-- Frame set 2
	randcondjmp(192, GhostLocal03)
	turnccwise(2) 
	wait(3) 
	turnccwise(2) 
	wait(3) 
	turnccwise(2) 
	wait(3) 
	turnccwise(2) 
	wait(3) 
	turnccwise(2) 
	wait(3) 
	wait(6) 
	turncwise(2) 
	wait(3) 
	turncwise(2) 
	wait(3) 
	turncwise(2) 
	wait(3) 
	turncwise(2) 
	wait(3) 
	turncwise(2) 
	wait(3) 
	wait(6) 
	turnccwise(2) 
	wait(3) 
	turnccwise(2) 
	wait(3) 
	turnccwise(2) 
	wait(3) 
	GhostLocal04()
end

function GhostLocal04()
	playfram(0x11)	-- Frame set 1
	wait(1) 
	playfram(0x00)	-- Frame set 0
	wait(1) 
	GhostWalkingToIdle()
end

function GhostLocal03()
	wait(13) 
	playfram(0x11)	-- Frame set 1
	wait(1) 
	playfram(0x00)	-- Frame set 0
	wait(1) 
	GhostWalkingToIdle()
end

function GhostLocal02()
	playfram(0x44)	-- Frame set 4
	wait(1) 
	playfram(0x55)	-- Frame set 5
	wait(1) 
	turnrand(3) 
	wait(1) 
	playfram(0x44)	-- Frame set 4
	wait(1) 
	GhostWalkingToIdle()
end

function GhostDeath()
	playsnd(238)	-- Terran\GHOST\TGhDth00.wav
	GhostLocal05()
end

function GhostLocal05()
	setfldirect(0) 
	playfram(0xdd)	-- Frame set 13
	wait(2) 
	playfram(222)	-- Frame set 13,  direction 1
	wait(2) 
	playfram(223)	-- Frame set 13,  direction 2
	wait(2) 
	playfram(224)	-- Frame set 13,  direction 3
	wait(2) 
	playfram(225)	-- Frame set 13,  direction 4
	wait(2) 
	playfram(226)	-- Frame set 13,  direction 5
	wait(2) 
	playfram(227)	-- Frame set 13,  direction 6
	wait(2) 
	playfram(228)	-- Frame set 13,  direction 7
	wait(2) 
	lowsprul(230, 0, 0)	-- Ghost Remnants (terran\tghDeath.grp)
	wait(1) 
end

function GhostGndAttkInit()
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(0x11)	-- Frame set 1
	wait(1) 
	playfram(0x22)	-- Frame set 2
	GhostGndAttkRpt()
end

function GhostGndAttkRpt()
	wait(1) 
	nobrkcodestart()
	playsnd(98)	-- Bullet\TGhFir00.wav
	attack()
	playfram(0xcc)	-- Frame set 12
	wait(1) 
	playfram(0x22)	-- Frame set 2
	nobrkcodeend()
	gotorepeatattk()
	ignorerest()
	GhostGndAttkToIdle()
end

function GhostGndAttkToIdle()
	playfram(0x11)	-- Frame set 1
	wait(1) 
	playfram(0x00)	-- Frame set 0
	wait(1) 
	GhostWalkingToIdle()
end

function GhostCastSpell()
	nobrkcodestart()
	wait(1) 
	playsnd(240)	-- Terran\GHOST\TGhLkd00.wav
	castspell()
	playfram(0xcc)	-- Frame set 12
	wait(2) 
	playfram(0x22)	-- Frame set 2
	nobrkcodeend()
	gotorepeatattk()
	sigorder(2) 
	GhostGndAttkToIdle()
end

function GhostWalking()
::GhostWalking_label::
	move(4) 
	wait(1) 
	playfram(0x44)	-- Frame set 4
	move(4) 
	wait(1) 
	playfram(0x55)	-- Frame set 5
	move(4) 
	wait(1) 
	playfram(0x66)	-- Frame set 6
	move(4) 
	wait(1) 
	playfram(0x77)	-- Frame set 7
	move(4) 
	wait(1) 
	playfram(0x88)	-- Frame set 8
	move(4) 
	wait(1) 
	playfram(0x99)	-- Frame set 9
	move(4) 
	wait(1) 
	playfram(0xaa)	-- Frame set 10
	move(4) 
	wait(1) 
	playfram(0xbb)	-- Frame set 11
	move(4) 
	wait(1) 
	playfram(0x33)	-- Frame set 3
	goto GhostWalking_label
end

function GhostSpecialState1()
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(0x11)	-- Frame set 1
	wait(1) 
	playfram(0x22)	-- Frame set 2
	wait(1) 
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 230 Ghost Remnants (terran\tghDeath.grp)
iscript[71] = {
  IsId =          	71,
  Type =          	0,
  Init =          	GhostRemnantsInit,
  Death =         	nil
}
-- ----------------------------------------------------------------------------- --

function GhostRemnantsInit()
	playfram(0x00)	-- Frame set 0
	wait(50) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(50) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(50) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 231 Ghost Death (terran\ghost.grp)
iscript[72] = {
  IsId =          	72,
  Type =          	1,
  Init =          	GhostLocal05,
  Death =         	ScourgeExplosionDeath
}
-- ----------------------------------------------------------------------------- --

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 232 Nuke Beam (thingy\NukeBeam.grp)
iscript[73] = {
  IsId =          	73,
  Type =          	12,
  Init =          	NukeBeamInit,
  Death =         	NukeBeamDeath,
  GndAttkInit =   	NukeBeamDeath,
  AirAttkInit =   	NukeBeamDeath,
  Unused1 =       	nil,
  GndAttkRpt =    	NukeBeamDeath,
  AirAttkRpt =    	NukeBeamDeath,
  CastSpell =     	nil,
  GndAttkToIdle = 	NukeBeamDeath,
  AirAttkToIdle = 	NukeBeamDeath,
  Unused2 =       	nil,
  Walking =       	NukeBeamDeath,
  WalkingToIdle = 	NukeBeamDeath,
  SpecialState1 = 	nil
}
-- ----------------------------------------------------------------------------- --

function NukeBeamInit()
::NukeBeamInit_label::
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(0x11)	-- Frame set 1
	wait(1) 
	goto NukeBeamInit_label
end

function NukeBeamDeath()
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 233 Nuke Target Dot (thingy\NukeTarg.grp)
iscript[74] = {
  IsId =          	74,
  Type =          	1,
  Init =          	NukeTargetDotInit,
  Death =         	NukeTargetDotDeath
}
-- ----------------------------------------------------------------------------- --

function NukeTargetDotInit()
::NukeTargetDotInit_label::
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	goto NukeTargetDotInit_label
end

function NukeTargetDotDeath()
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 234 Goliath Base (terran\goliath.grp)
iscript[75] = {
  IsId =          	75,
  Type =          	23,
  Init =          	Goliath_Base_Init,
  Death =         	Goliath_Base_Death,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	Goliath_Base_Walking,
  WalkingToIdle = 	Goliath_Base_WalkingToIdle,
  SpecialState1 = 	nil,
  SpecialState2 = 	nil,
  AlmostBuilt =   	nil,
  Built =         	nil,
  Landing =       	nil,
  LiftOff =       	nil,
  IsWorking =     	nil,
  WorkingToIdle = 	nil,
  WarpIn =        	nil,
  Unused3 =       	nil,
  StarEditInit =  	Goliath_Base_StarEditInit
}
-- ----------------------------------------------------------------------------- --

function Goliath_Base_Init()
	imgul(236, 0, 0)	-- Goliath Shadow (terran\tgoShad.grp)
  Goliath_Base_WalkingToIdle()
end

function Goliath_Base_WalkingToIdle()
	playfram(0x77)	-- Frame set 7
	ScourgeLocal00()
end

function Goliath_Base_Death()
	playsnd(8)	-- Misc\ExploMed.wav
	imgol(332, 0, 0)	-- Explosion2 (Small) (thingy\tBangS.grp)
	wait(3) 
end

function Goliath_Base_Walking()
::Goliath_Base_Walking_label::
	move(6) 
	wait(1) 
	playfram(0x88)	-- Frame set 8
	move(3) 
	wait(1) 
	playfram(0x99)	-- Frame set 9
	move(3) 
	wait(1) 
	playfram(0x00)	-- Frame set 0
	move(3) 
	wait(1) 
	playfram(0x11)	-- Frame set 1
	move(5) 
	wait(1) 
	playfram(0x22)	-- Frame set 2
	move(5) 
	wait(1) 
	playfram(0x33)	-- Frame set 3
	move(4) 
	wait(1) 
	playfram(0x44)	-- Frame set 4
	move(8) 
	wait(1) 
	playfram(0x55)	-- Frame set 5
	move(6) 
	wait(1) 
	playfram(0x66)	-- Frame set 6
	move(4) 
	wait(1) 
	playfram(0x77)	-- Frame set 7
	goto Goliath_Base_Walking_label
end

function Goliath_Base_StarEditInit()
	imgol(235, 0, 0)	-- Goliath Turret (terran\goliathT.grp)
	imgul(236, 0, 0)	-- Goliath Shadow (terran\tgoShad.grp)
	playfram(0x77)	-- Frame set 7
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 235 Goliath Turret (terran\goliathT.grp)
iscript[76] = {
  IsId =          	76,
  Type =          	12,
  Init =          	Goliath_Turret_Init,
  Death =         	ScourgeExplosionDeath,
  GndAttkInit =   	Goliath_Turret_GndAttkInit,
  AirAttkInit =   	Goliath_Turret_AirAttkInit,
  Unused1 =       	nil,
  GndAttkRpt =    	Goliath_Turret_GndAttkInit,
  AirAttkRpt =    	Goliath_Turret_AirAttkInit,
  CastSpell =     	nil,
  GndAttkToIdle = 	Goliath_Turret_Init,
  AirAttkToIdle = 	Goliath_Turret_Init,
  Unused2 =       	nil,
  Walking =       	Goliath_Turret_Walking,
  WalkingToIdle = 	Goliath_Turret_Init,
  SpecialState1 = 	nil
}
-- ----------------------------------------------------------------------------- --

function Goliath_Turret_Init()
	playfram(0x77)	-- Frame set 7
	ScourgeLocal00()
end

function Goliath_Turret_GndAttkInit()
	playfram(0xaa)	-- Frame set 10
	playsnd(70)	-- Bullet\TGoFir00.wav
	attackwith(1) 
	wait(1) 
	playfram(0x77)	-- Frame set 7
	wait(1) 
	playfram(0xaa)	-- Frame set 10
	wait(1) 
	playfram(0x77)	-- Frame set 7
	wait(1) 
	playfram(0xaa)	-- Frame set 10
	wait(1) 
	gotorepeatattk()
	Goliath_Turret_Init()
end

function Goliath_Turret_AirAttkInit()
	wait(1) 
	attackwith(2) 
	gotorepeatattk()
	Goliath_Turret_Init()
end

function Goliath_Turret_Walking()
::Goliath_Turret_Walking_label::
	move(0) 
	wait(1) 
	playfram(0x88)	-- Frame set 8
	move(0) 
	wait(1) 
	playfram(0x99)	-- Frame set 9
	move(0) 
	wait(1) 
	playfram(0x00)	-- Frame set 0
	move(0) 
	wait(1) 
	playfram(0x11)	-- Frame set 1
	move(0) 
	wait(1) 
	playfram(0x22)	-- Frame set 2
	move(0) 
	wait(1) 
	playfram(0x33)	-- Frame set 3
	move(0) 
	wait(1) 
	playfram(0x44)	-- Frame set 4
	move(0) 
	wait(1) 
	playfram(0x55)	-- Frame set 5
	move(0) 
	wait(1) 
	playfram(0x66)	-- Frame set 6
	move(0) 
	wait(1) 
	playfram(0x77)	-- Frame set 7
	goto Goliath_Turret_Walking_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 237 Sarah Kerrigan (terran\ughost.grp)
iscript[77] = {
  IsId =          	77,
  Type =          	13,
  Init =          	SarahKerriganInit,
  Death =         	SarahKerriganDeath,
  GndAttkInit =   	SarahKerriganGndAttkInit,
  AirAttkInit =   	SarahKerriganGndAttkInit,
  Unused1 =       	nil,
  GndAttkRpt =    	SarahKerriganGndAttkRpt,
  AirAttkRpt =    	SarahKerriganGndAttkRpt,
  CastSpell =     	SarahKerriganCastSpell,
  GndAttkToIdle = 	SarahKerriganGndAttkToIdle,
  AirAttkToIdle = 	SarahKerriganGndAttkToIdle,
  Unused2 =       	nil,
  Walking =       	SarahKerriganWalking,
  WalkingToIdle = 	SarahKerriganWalkingToIdle,
  SpecialState1 = 	SarahKerriganSpecialState1
}
-- ----------------------------------------------------------------------------- --

function SarahKerriganInit()
	imgul(238, 0, 0)	-- Sarah Kerrigan Shadow (terran\ughShad.grp)
	SarahKerriganWalkingToIdle()
end

function SarahKerriganWalkingToIdle()
	playfram(0x33)	-- Frame set 3
	SarahKerriganLocal00()
end

function SarahKerriganLocal00()
::SarahKerriganLocal00_label::
	waitrand(63, 75) 
	randcondjmp(25, SarahKerriganLocal01)
	randcondjmp(128, SarahKerriganLocal02)
	goto SarahKerriganLocal00_label
end

function SarahKerriganLocal01()
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(0x11)	-- Frame set 1
	wait(1) 
	playfram(0x22)	-- Frame set 2
	randcondjmp(192, SarahKerriganLocal03)
	turnccwise(2) 
	wait(3) 
	turnccwise(2) 
	wait(3) 
	turnccwise(2) 
	wait(3) 
	turnccwise(2) 
	wait(3) 
	turnccwise(2) 
	wait(3) 
	wait(6) 
	turncwise(2) 
	wait(3) 
	turncwise(2) 
	wait(3) 
	turncwise(2) 
	wait(3) 
	turncwise(2) 
	wait(3) 
	turncwise(2) 
	wait(3) 
	wait(6) 
	turnccwise(2) 
	wait(3) 
	turnccwise(2) 
	wait(3) 
	turnccwise(2) 
	wait(3) 
	SarahKerriganLocal04()
end

function SarahKerriganLocal04()
	playfram(0x11)	-- Frame set 1
	wait(1) 
	playfram(0x00)	-- Frame set 0
	wait(1) 
	SarahKerriganWalkingToIdle()
end

function SarahKerriganLocal03()
	wait(13) 
	playfram(0x11)	-- Frame set 1
	wait(1) 
	playfram(0x00)	-- Frame set 0
	wait(1) 
	SarahKerriganWalkingToIdle()
end

function SarahKerriganLocal02()
	playfram(0x44)	-- Frame set 4
	wait(1) 
	playfram(0x55)	-- Frame set 5
	wait(1) 
	turnrand(3) 
	wait(1) 
	playfram(0x44)	-- Frame set 4
	wait(1) 
	SarahKerriganWalkingToIdle()
end

function SarahKerriganDeath()
	playsnd(470)	-- Terran\KERRIGAN\UKeDth00.wav
	imgol(231, 0, 0)	-- Ghost Death (terran\ghost.grp)
	wait(1) 
end

function SarahKerriganGndAttkInit()
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(0x11)	-- Frame set 1
	wait(1) 
	playfram(0x22)	-- Frame set 2
	SarahKerriganGndAttkRpt()
end

function SarahKerriganGndAttkRpt()
	wait(1) 
	nobrkcodestart()
	playsnd(98)	-- Bullet\TGhFir00.wav
	attack()
	playfram(0xcc)	-- Frame set 12
	wait(1) 
	playfram(0x22)	-- Frame set 2
	nobrkcodeend()
	gotorepeatattk()
	ignorerest()
	SarahKerriganGndAttkToIdle()
end

function SarahKerriganGndAttkToIdle()
	playfram(0x11)	-- Frame set 1
	wait(1) 
	playfram(0x00)	-- Frame set 0
	wait(1) 
	SarahKerriganWalkingToIdle()
end

function SarahKerriganCastSpell()
	nobrkcodestart()
	wait(1) 
	playsnd(240)	-- Terran\GHOST\TGhLkd00.wav
	castspell()
	playfram(0xcc)	-- Frame set 12
	wait(2) 
	playfram(0x22)	-- Frame set 2
	nobrkcodeend()
	gotorepeatattk()
	sigorder(2) 
	SarahKerriganGndAttkToIdle()
end

function SarahKerriganWalking()
::SarahKerriganWalking_label::
	move(4) 
	wait(1) 
	playfram(0x44)	-- Frame set 4
	move(4) 
	wait(1) 
	playfram(0x55)	-- Frame set 5
	move(4) 
	wait(1) 
	playfram(0x66)	-- Frame set 6
	move(4) 
	wait(1) 
	playfram(0x77)	-- Frame set 7
	move(4) 
	wait(1) 
	playfram(0x88)	-- Frame set 8
	move(4) 
	wait(1) 
	playfram(0x99)	-- Frame set 9
	move(4) 
	wait(1) 
	playfram(0xaa)	-- Frame set 10
	move(4) 
	wait(1) 
	playfram(0xbb)	-- Frame set 11
	move(4) 
	wait(1) 
	playfram(0x33)	-- Frame set 3
	goto SarahKerriganWalking_label
end

function SarahKerriganSpecialState1()
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(0x11)	-- Frame set 1
	wait(1) 
	playfram(0x22)	-- Frame set 2
	wait(1) 
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 239 Marine (terran\marine.grp)
iscript[78] = {
  IsId =          	78,
  Type =          	12,
  Init =          	MarineInit,
  Death =         	MarineDeath,
  GndAttkInit =   	MarineGndAttkInit,
  AirAttkInit =   	MarineGndAttkInit,
  Unused1 =       	nil,
  GndAttkRpt =    	MarineGndAttkRpt,
  AirAttkRpt =    	MarineGndAttkRpt,
  CastSpell =     	nil,
  GndAttkToIdle = 	MarineGndAttkToIdle,
  AirAttkToIdle = 	MarineGndAttkToIdle,
  Unused2 =       	nil,
  Walking =       	MarineWalking,
  WalkingToIdle = 	MarineWalkingToIdle,
  SpecialState1 = 	nil
}
-- ----------------------------------------------------------------------------- --

function MarineInit()
	imgul(240, 0, 0)	-- Marine Shadow (terran\tmaShad.grp)
	MarineWalkingToIdle()
end

function MarineWalkingToIdle()
	playfram(0x44)	-- Frame set 4
	MarineLocal00()
end

function MarineLocal00()
::MarineLocal00_label::
	waitrand(63, 75) 
	randcondjmp(25, MarineLocal01)
	randcondjmp(128, MarineLocal02)
	goto MarineLocal00_label
end

function MarineLocal01()
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(0x11)	-- Frame set 1
	wait(1) 
	playfram(0x22)	-- Frame set 2
	randcondjmp(192, MarineLocal03)
	turnccwise(2) 
	wait(3) 
	turnccwise(2) 
	wait(3) 
	turnccwise(2) 
	wait(3) 
	turnccwise(2) 
	wait(3) 
	turnccwise(2) 
	wait(3) 
	wait(6) 
	turncwise(2) 
	wait(3) 
	turncwise(2) 
	wait(3) 
	turncwise(2) 
	wait(3) 
	turncwise(2) 
	wait(3) 
	turncwise(2) 
	wait(3) 
	wait(6) 
	turnccwise(2) 
	wait(3) 
	turnccwise(2) 
	wait(3) 
	turnccwise(2) 
	wait(3) 
	MarineLocal04()
end

function MarineLocal04()
	playfram(0x11)	-- Frame set 1
	wait(1) 
	playfram(0x00)	-- Frame set 0
	wait(1) 
	MarineWalkingToIdle()
end

function MarineLocal03()
	wait(13) 
	playfram(0x11)	-- Frame set 1
	wait(1) 
	playfram(0x00)	-- Frame set 0
	wait(1) 
	MarineWalkingToIdle()
end

function MarineLocal02()
	playfram(0x55)	-- Frame set 5
	wait(1) 
	playfram(0x66)	-- Frame set 6
	wait(1) 
	turnrand(3) 
	wait(1) 
	playfram(0x55)	-- Frame set 5
	wait(1) 
	MarineWalkingToIdle()
end

function MarineDeath()
	playsnd(276)	-- Terran\MARINE\TMaDth00.WAV | Terran\MARINE\TMaDth01.WAV
	MarineLocal05()
end

function MarineLocal05()
	setfldirect(0) 
	playfram(0xdd)	-- Frame set 13
	wait(2) 
	playfram(222)	-- Frame set 13,  direction 1
	wait(2) 
	playfram(223)	-- Frame set 13,  direction 2
	wait(2) 
	playfram(224)	-- Frame set 13,  direction 3
	wait(2) 
	playfram(225)	-- Frame set 13,  direction 4
	wait(2) 
	playfram(226)	-- Frame set 13,  direction 5
	wait(2) 
	playfram(227)	-- Frame set 13,  direction 6
	wait(2) 
	playfram(228)	-- Frame set 13,  direction 7
	wait(2) 
	lowsprul(236, 0, 0)	-- Marine Remnants (terran\tmaDeath.grp)
	wait(1) 
end

function MarineGndAttkInit()
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(0x11)	-- Frame set 1
	wait(1) 
	playfram(0x22)	-- Frame set 2
	MarineGndAttkRpt()
end

function MarineGndAttkRpt()
	wait(1) 
	nobrkcodestart()
	playsnd(69)	-- Bullet\TMaFir00.wav
	attackwith(1) 
	playfram(0x33)	-- Frame set 3
	wait(1) 
	playfram(0x22)	-- Frame set 2
	wait(1) 
	playfram(0x33)	-- Frame set 3
	wait(1) 
	playfram(0x22)	-- Frame set 2
	wait(1) 
	playfram(0x33)	-- Frame set 3
	wait(1) 
	playfram(0x22)	-- Frame set 2
	wait(1) 
	nobrkcodeend()
	gotorepeatattk()
	ignorerest()
	MarineGndAttkToIdle()
end

function MarineGndAttkToIdle()
	playfram(0x11)	-- Frame set 1
	wait(1) 
	playfram(0x00)	-- Frame set 0
	wait(1) 
	MarineWalkingToIdle()
end

function MarineWalking()
::MarineWalking_label::
	move(4) 
	wait(1) 
	playfram(0x55)	-- Frame set 5
	move(4) 
	wait(1) 
	playfram(0x66)	-- Frame set 6
	move(4) 
	wait(1) 
	playfram(0x77)	-- Frame set 7
	move(4) 
	wait(1) 
	playfram(0x88)	-- Frame set 8
	move(4) 
	wait(1) 
	playfram(0x99)	-- Frame set 9
	move(4) 
	wait(1) 
	playfram(0xaa)	-- Frame set 10
	move(4) 
	wait(1) 
	playfram(0xbb)	-- Frame set 11
	move(4) 
	wait(1) 
	playfram(0xcc)	-- Frame set 12
	move(4) 
	wait(1) 
	playfram(0x44)	-- Frame set 4
	goto MarineWalking_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 241 Marine Remnants (terran\tmaDeath.grp)
iscript[79] = {
  IsId =          	79,
  Type =          	0,
  Init =          	MarineRemnantsInit,
  Death =         	nil
}
-- ----------------------------------------------------------------------------- --

function MarineRemnantsInit()
	playfram(0x00)	-- Frame set 0
	wait(50) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(50) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(50) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 242 Marine Death (terran\marine.grp)
iscript[80] = {
  IsId =          	80,
  Type =          	1,
  Init =          	MarineLocal05,
  Death =         	ScourgeExplosionDeath
}
-- ----------------------------------------------------------------------------- --

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 246 Scanner Sweep (terran\marine.grp)
iscript[81] = {
  IsId =          	81,
  Type =          	1,
  Init =          	ScannerSweepInit,
  Death =         	ScannerSweepDeath
}
-- ----------------------------------------------------------------------------- --

function ScannerSweepInit()
	sprol(380, 0, 0)	-- Scanner Sweep Hit (thingy\eveCast.grp)
	wait(6) 
	sprol(380, 32, 32)	-- Scanner Sweep Hit (thingy\eveCast.grp)
	wait(2) 
	sprol(380, 48, 5)	-- Scanner Sweep Hit (thingy\eveCast.grp)
	wait(5) 
	sprol(380, 32, -32)	-- Scanner Sweep Hit (thingy\eveCast.grp)
	wait(2) 
	sprol(380, -5, -48)	-- Scanner Sweep Hit (thingy\eveCast.grp)
	wait(2) 
	sprol(380, -32, -32)	-- Scanner Sweep Hit (thingy\eveCast.grp)
	wait(5) 
	sprol(380, -48, -2)	-- Scanner Sweep Hit (thingy\eveCast.grp)
	wait(3) 
	sprol(380, -32, 32)	-- Scanner Sweep Hit (thingy\eveCast.grp)
	wait(5) 
	sprol(380, 3, 48)	-- Scanner Sweep Hit (thingy\eveCast.grp)
	wait(63) 
	wait(63) 
	sigorder(4) 
	ScourgeLocal00()
end

function ScannerSweepDeath()
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 243 Wraith (terran\phoenix.grp)
iscript[82] = {
  IsId =          	82,
  Type =          	12,
  Init =          	WraithInit,
  Death =         	WraithDeath,
  GndAttkInit =   	BattlecruiserLocal00,
  AirAttkInit =   	SporeColonyAirAttkInit,
  Unused1 =       	nil,
  GndAttkRpt =    	BattlecruiserLocal00,
  AirAttkRpt =    	SporeColonyAirAttkInit,
  CastSpell =     	nil,
  GndAttkToIdle = 	OverlordLocal00,
  AirAttkToIdle = 	OverlordLocal00,
  Unused2 =       	nil,
  Walking =       	WraithWalking,
  WalkingToIdle = 	OverlordLocal00,
  SpecialState1 = 	nil
}
-- ----------------------------------------------------------------------------- --

function WraithInit()
	imgul(244, 0, 42)	-- Wraith Shadow (terran\phoenix.grp)
	playfram(0x00)	-- Frame set 0
	OverlordLocal00()
end

function WraithDeath()
	playsnd(257)	-- Terran\PHOENIX\TPhDth00.WAV
	imgol(332, 0, 0)	-- Explosion2 (Small) (thingy\tBangS.grp)
	wait(3) 
end

function WraithWalking()
	imgol(245, 0, 0)	-- Wraith Engines (thingy\tphGlow.grp)
	setvertpos(0) 
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 245 Wraith Engines (thingy\tphGlow.grp)
iscript[83] = {
  IsId =          	83,
  Type =          	12,
  Init =          	WraithAfterburnersInit,
  Death =         	ScourgeExplosionDeath,
  GndAttkInit =   	ScourgeExplosionDeath,
  AirAttkInit =   	ScourgeExplosionDeath,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	ScourgeExplosionDeath,
  AirAttkToIdle = 	ScourgeExplosionDeath,
  Unused2 =       	nil,
  Walking =       	WraithAfterburnersInit,
  WalkingToIdle = 	ScourgeExplosionDeath,
  SpecialState1 = 	nil
}
-- ----------------------------------------------------------------------------- --

function WraithAfterburnersInit()
::WraithAfterburnersInit_label::
	wait(1) 
	engframe(0) 
	wait(1) 
	engframe(17) 
	goto WraithAfterburnersInit_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 247 SCV (terran\SCV.grp)
iscript[84] = {
  IsId =          	84,
  Type =          	15,
  Init =          	SCVInit,
  Death =         	SCVDeath,
  GndAttkInit =   	SCVGndAttkInit,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	SCVGndAttkInit,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	SCVGndAttkToIdle,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	SCVWalking,
  WalkingToIdle = 	ScourgeLocal00,
  SpecialState1 = 	nil,
  SpecialState2 = 	nil,
  AlmostBuilt =   	SCVAlmostBuilt
}
-- ----------------------------------------------------------------------------- --

function SCVInit()
	imgul(248, 0, 7)	-- SCV Shadow (terran\SCV.grp)
	playfram(0x00)	-- Frame set 0
	ScourgeLocal00()
end

function SCVDeath()
	playsnd(369)	-- Terran\SCV\TSCDth00.WAV
	imgol(332, 0, 0)	-- Explosion2 (Small) (thingy\tBangS.grp)
	wait(3) 
end

function SCVGndAttkInit()
	setvertpos(0) 
	wait(1) 
	playfram(0x22)	-- Frame set 2
	attackwith(1) 
	wait(1) 
	playfram(0x11)	-- Frame set 1
	wait(1) 
	gotorepeatattk()
	ScourgeLocal00()
end

function SCVGndAttkToIdle()
	playfram(0x00)	-- Frame set 0
	ScourgeLocal00()
end

function SCVWalking()
	playfram(0x00)	-- Frame set 0
	imgol(249, 0, 0)	-- SCV Glow (thingy\tscGlow.grp)
	setvertpos(0) 
	ScourgeLocal00()
end

function SCVAlmostBuilt()
	setvertpos(0) 
	wait(1) 
	SCVLocal00()
end

function SCVLocal00()
::SCVLocal00_label::
	playfram(0x22)	-- Frame set 2
	useweapon(14)	-- Fusion Cutter (Harvest) (Fusion, Cutter)
	wait(1) 
	playfram(0x11)	-- Frame set 1
	waitrand(8, 10) 
	goto SCVLocal00_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 256 Vulture (terran\Vulture.grp)
iscript[86] = {
  IsId =          	86,
  Type =          	13,
  Init =          	VultureInit,
  Death =         	VultureDeath,
  GndAttkInit =   	BattlecruiserLocal00,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	BattlecruiserLocal00,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	ScourgeLocal00,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	ScourgeLocal00,
  WalkingToIdle = 	ScourgeLocal00,
  SpecialState1 = 	VultureSpecialState1
}
-- ----------------------------------------------------------------------------- --

function VultureInit()
	imgul(257, 0, 7)	-- Vulture Shadow (terran\Vulture.grp)
	playfram(0x00)	-- Frame set 0
	ScourgeLocal00()
end

function VultureDeath()
	playsnd(353)	-- Terran\VULTURE\TVuDth00.WAV
	imgol(332, 0, 0)	-- Explosion2 (Small) (thingy\tBangS.grp)
	wait(3) 
end

function VultureSpecialState1()
	attackwith(1) 
	sigorder(1) 
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 258 Spider Mine (terran\Spider.grp)
iscript[87] = {
  IsId =          	87,
  Type =          	26,
  Init =          	SpiderMineInit,
  Death =         	SpiderMineDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	SpiderMineWalking,
  WalkingToIdle = 	SpiderMineWalkingToIdle,
  SpecialState1 = 	SpiderMineSpecialState1,
  SpecialState2 = 	nil,
  AlmostBuilt =   	nil,
  Built =         	nil,
  Landing =       	nil,
  LiftOff =       	nil,
  IsWorking =     	nil,
  WorkingToIdle = 	nil,
  WarpIn =        	nil,
  Unused3 =       	nil,
  StarEditInit =  	nil,
  Disable =       	nil,
  Burrow =        	SpiderMineBurrow,
  UnBurrow =      	SpiderMineUnBurrow,
  Enable =        	nil
}
-- ----------------------------------------------------------------------------- --

function SpiderMineInit()
	imgul(259, 0, 0)	-- Spider Mine Shadow (terran\tsmShad.grp)
	SpiderMineWalkingToIdle()
end

function SpiderMineWalkingToIdle()
	playfram(0x00)	-- Frame set 0
	ScourgeLocal00()
end

function SpiderMineDeath()
	imgol(429, 0, 0)	-- Spider Mine Death (thingy\tmnExplo.grp)
	wait(1) 
end

function SpiderMineWalking()
::SpiderMineWalking_label::
	playsnd(355)	-- Terran\VULTURE\TVuMin00.WAV
	move(16) 
	wait(1) 
	playfram(0x00)	-- Frame set 0
	move(16) 
	wait(1) 
	playfram(1)	-- Frame set 0,  direction 1
	move(16) 
	wait(1) 
	playfram(2)	-- Frame set 0,  direction 2
	move(16) 
	wait(1) 
	playfram(3)	-- Frame set 0,  direction 3
	move(16) 
	wait(1) 
	playfram(4)	-- Frame set 0,  direction 4
	move(16) 
	wait(1) 
	playfram(5)	-- Frame set 0,  direction 5
	move(16) 
	wait(1) 
	playfram(6)	-- Frame set 0,  direction 6
	move(16) 
	wait(1) 
	playfram(7)	-- Frame set 0,  direction 7
	goto SpiderMineWalking_label
end

function SpiderMineSpecialState1()
	castspell()
	sigorder(1) 
	ScourgeLocal00()
end

function SpiderMineBurrow()
	nobrkcodestart()
	imgol(423, 0, 0)	-- Burrowing Dust (thingy\bDust.grp)
	playsnd(354)	-- Terran\VULTURE\TVuMin01.WAV
	playfram(8)	-- Frame set 0,  direction 8
	wait(1) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(1) 
	playfram(10)	-- Frame set 0,  direction 10
	wait(1) 
	playfram(11)	-- Frame set 0,  direction 11
	wait(1) 
	sigorder(4) 
	nobrkcodeend()
	ScourgeLocal00()
end

function SpiderMineUnBurrow()
	nobrkcodestart()
	imgul(423, 0, 0)	-- Burrowing Dust (thingy\bDust.grp)
	playsnd(354)	-- Terran\VULTURE\TVuMin01.WAV
	playfram(10)	-- Frame set 0,  direction 10
	wait(1) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(1) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(1) 
	playfram(0x00)	-- Frame set 0
	sigorder(4) 
	nobrkcodeend()
	SpiderMineWalkingToIdle()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 260 Science Vessel (Base) (terran\wessel.grp)
iscript[88] = {
  IsId =          	88,
  Type =          	12,
  Init =          	ScienceVessel_Base_Init,
  Death =         	ScienceVessel_Base_Death,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	ScienceVessel_Base_CastSpell,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	ScourgeLocal00,
  WalkingToIdle = 	ScourgeLocal00,
  SpecialState1 = 	nil
}
-- ----------------------------------------------------------------------------- --

function ScienceVessel_Base_Init()
	imgol(261, 0, 0)	-- Science Vessel (Turret) (terran\wesselt.grp)
	imgul(262, 0, 42)	-- Science Vessel Shadow (terran\tveShad.grp)
	playfram(0x00)	-- Frame set 0
	ScourgeLocal00()
end

function ScienceVessel_Base_Death()
	playsnd(348)	-- Terran\VESSEL\TVeDth00.WAV
	imgol(333, 0, 0)	-- Explosion2 (Medium) (thingy\tBangL.grp)
	wait(3) 
end

function ScienceVessel_Base_CastSpell()
	imgol(539, 0, 0)	-- Science Vessel Overlay (Part2) (thingy\tveGlowO.grp)
	nobrkcodestart()
	wait(3) 
	castspell()
	nobrkcodeend()
	gotorepeatattk()
	sigorder(2) 
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 261 Science Vessel (Turret) (terran\wesselt.grp)
iscript[89] = {
  IsId =          	89,
  Type =          	12,
  Init =          	ScienceVessel_Turret_Init,
  Death =         	ScourgeExplosionDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	ScourgeLocal00,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	ScourgeLocal00,
  WalkingToIdle = 	ScourgeLocal00,
  SpecialState1 = 	nil
}
-- ----------------------------------------------------------------------------- --

function ScienceVessel_Turret_Init()
	playfram(0x00)	-- Frame set 0
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 250 Siege Tank (Tank) Base (terran\tank.grp)
iscript[90] = {
  IsId =          	90,
  Type =          	23,
  Init =          	SiegeTank_Tank_BaseInit,
  Death =         	SiegeTank_Tank_BaseDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	SiegeTank_Tank_BaseWalking,
  WalkingToIdle = 	SiegeTank_Tank_BaseWalkingToIdle,
  SpecialState1 = 	nil,
  SpecialState2 = 	nil,
  AlmostBuilt =   	nil,
  Built =         	nil,
  Landing =       	nil,
  LiftOff =       	nil,
  IsWorking =     	nil,
  WorkingToIdle = 	nil,
  WarpIn =        	nil,
  Unused3 =       	nil,
  StarEditInit =  	SiegeTank_Tank_BaseStarEditInit
}
-- ----------------------------------------------------------------------------- --

function SiegeTank_Tank_BaseInit()
	wait(1) 
	imgul(252, 0, 0)	-- Siege Tank (Tank) Base Shadow (terran\ttaShad.grp)
	setfldirect(12) 
  SiegeTank_Tank_BaseWalkingToIdle()
end

function SiegeTank_Tank_BaseWalkingToIdle()
	playfram(0x00)	-- Frame set 0
	ScourgeLocal00()
end

function SiegeTank_Tank_BaseDeath()
	playsnd(317)	-- Terran\TANK\TTaDth00.WAV
	imgol(333, 0, 0)	-- Explosion2 (Medium) (thingy\tBangL.grp)
	wait(3) 
end

function SiegeTank_Tank_BaseWalking()
::SiegeTank_Tank_BaseWalking_label::
	move(4) 
	wait(1) 
	playfram(0x00)	-- Frame set 0
	move(4) 
	wait(1) 
	playfram(0x11)	-- Frame set 1
	move(4) 
	wait(1) 
	playfram(0x22)	-- Frame set 2
	goto SiegeTank_Tank_BaseWalking_label
end

function SiegeTank_Tank_BaseStarEditInit()
	setfldirect(12) 
	imgoluselo(251, 2, 0)	-- Siege Tank (Tank) Turret (terran\tankt.grp)
	wait(1) 
	imgul(252, 0, 0)	-- Siege Tank (Tank) Base Shadow (terran\ttaShad.grp)
	setfldirect(12) 
	playfram(0x00)	-- Frame set 0
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 251 Siege Tank (Tank) Turret (terran\tankt.grp)
iscript[91] = {
  IsId =          	91,
  Type =          	13,
  Init =          	SiegeTank_Tank_TurretInit,
  Death =         	ScourgeExplosionDeath,
  GndAttkInit =   	SiegeTank_Tank_TurretGndAttkInit,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	SiegeTank_Tank_TurretGndAttkInit,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	ScourgeLocal00,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	ScourgeLocal00,
  WalkingToIdle = 	ScourgeLocal00,
  SpecialState1 = 	ScourgeLocal00
}
-- ----------------------------------------------------------------------------- --

function SiegeTank_Tank_TurretInit()
	wait(1) 
	setfldirect(12) 
	ScourgeLocal00()
end

function SiegeTank_Tank_TurretGndAttkInit()
	wait(1) 
	nobrkcodestart()
	playsnd(68)	-- Bullet\TTaFir00.wav
	imgol(536, 0, 0)	-- Siege Tank(Tank) Turret Attack Overlay (thingy\ettFlash.grp)
	wait(2) 
	attackwith(1) 
	nobrkcodeend()
	gotorepeatattk()
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 253 Siege Tank (Siege) Base (terran\stank.grp)
iscript[92] = {
  IsId =          	92,
  Type =          	23,
  Init =          	SiegeTank_Siege_BaseInit,
  Death =         	SiegeTank_Siege_BaseDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	nil,
  WalkingToIdle = 	nil,
  SpecialState1 = 	nil,
  SpecialState2 = 	SiegeTank_Siege_BaseSpecialState2,
  AlmostBuilt =   	nil,
  Built =         	nil,
  Landing =       	nil,
  LiftOff =       	nil,
  IsWorking =     	nil,
  WorkingToIdle = 	nil,
  WarpIn =        	nil,
  Unused3 =       	nil,
  StarEditInit =  	SiegeTank_Siege_BaseStarEditInit
}
-- ----------------------------------------------------------------------------- --

function SiegeTank_Siege_BaseInit()
	imgul(255, 0, 0)	-- Siege Tank (Siege) Base Shadow (terran\tstShad.grp)
	wait(1) 
	setflspeed(0) 
	playsnd(319)	-- Terran\TANK\TTaTra01.WAV
	playfram(0x00)	-- Frame set 0
	wait(5) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(5) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(5) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(5) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(5) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(38) 
	sigorder(1) 
	ScourgeLocal00()
end

function SiegeTank_Siege_BaseDeath()
	playsnd(317)	-- Terran\TANK\TTaDth00.WAV
	imgol(333, 0, 0)	-- Explosion2 (Medium) (thingy\tBangL.grp)
	wait(3) 
end

function SiegeTank_Siege_BaseSpecialState2()
	wait(38) 
	playsnd(319)	-- Terran\TANK\TTaTra01.WAV
	playfram(4)	-- Frame set 0,  direction 4
	wait(5) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(5) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(5) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(5) 
	playfram(0x00)	-- Frame set 0
	wait(5) 
	sigorder(1) 
	ScourgeLocal00()
end

function SiegeTank_Siege_BaseStarEditInit()
	imgoluselo(254, 2, 0)	-- Siege Tank (Siege) Turret (terran\stankt.grp)
	imgul(255, 0, 0)	-- Siege Tank (Siege) Base Shadow (terran\tstShad.grp)
	wait(1) 
	setflspeed(0) 
	playsnd(319)	-- Terran\TANK\TTaTra01.WAV
	playfram(0x00)	-- Frame set 0
	wait(5) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(5) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(5) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(5) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(5) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(38) 
	sigorder(1) 
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 254 Siege Tank (Siege) Turret (terran\stankt.grp)
iscript[93] = {
  IsId =          	93,
  Type =          	14,
  Init =          	SiegeTank_Siege_TurretInit,
  Death =         	ScourgeExplosionDeath,
  GndAttkInit =   	SiegeTank_Siege_TurretGndAttkInit,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	SiegeTank_Siege_TurretGndAttkInit,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	ScourgeLocal00,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	nil,
  WalkingToIdle = 	ScourgeLocal00,
  SpecialState1 = 	ScourgeLocal00,
  SpecialState2 = 	SiegeTank_Siege_TurretSpecialState2,
  AlmostBuilt =   	nil
}
-- ----------------------------------------------------------------------------- --

function SiegeTank_Siege_TurretInit()
	playfram(0x11)	-- Frame set 1
	wait(1) 
	nobrkcodestart()
	wait(38) 
	playsnd(318)	-- Terran\TANK\TTaTra00.WAV
	wait(3) 
	playfram(0x22)	-- Frame set 2
	wait(3) 
	playfram(0x33)	-- Frame set 3
	wait(3) 
	playfram(0x44)	-- Frame set 4
	wait(3) 
	playfram(0x55)	-- Frame set 5
	wait(3) 
	setfldirect(28) 
	playfram(0x00)	-- Frame set 0
	nobrkcodeend()
	ScourgeLocal00()
end

function SiegeTank_Siege_TurretGndAttkInit()
	wait(1) 
	nobrkcodestart()
	playsnd(96)	-- Bullet\TTaFi200.wav
	imgoluselo(537, 2, 0)	-- Siege Tank(Siege) Turret Attack Overlay (thingy\esiFire.grp)
	wait(2) 
	attackwith(1) 
	wait(1) 
	playfram(0x00)	-- Frame set 0
	nobrkcodeend()
	gotorepeatattk()
	ignorerest()
	ScourgeLocal00()
end

function SiegeTank_Siege_TurretSpecialState2()
	setfldirect(12) 
	playsnd(318)	-- Terran\TANK\TTaTra00.WAV
	playfram(0x55)	-- Frame set 5
	wait(3) 
	playfram(0x44)	-- Frame set 4
	wait(3) 
	playfram(0x33)	-- Frame set 3
	wait(3) 
	playfram(0x22)	-- Frame set 2
	wait(3) 
	playfram(0x11)	-- Frame set 1
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 263 Terran Academy (terran\Academy.grp)
iscript[94] = {
  IsId =          	94,
  Type =          	20,
  Init =          	AcademyInit,
  Death =         	AcademyDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	nil,
  WalkingToIdle = 	nil,
  SpecialState1 = 	nil,
  SpecialState2 = 	nil,
  AlmostBuilt =   	AcademyAlmostBuilt,
  Built =         	AcademyBuilt,
  Landing =       	ScourgeLocal00,
  LiftOff =       	ScourgeLocal00,
  IsWorking =     	AcademyIsWorking,
  WorkingToIdle = 	AcademyBuilt,
  WarpIn =        	nil
}
-- ----------------------------------------------------------------------------- --

function AcademyInit()
	playfram(0x00)	-- Frame set 0
	imgul(265, 0, 0)	-- Academy Shadow (terran\tacShad.grp)
	ScourgeLocal00()
end

function AcademyDeath()
	playsnd(7)	-- Misc\ExploLrg.wav
	imgol(334, 0, 0)	-- Building Explosion (Large) (thingy\tBangX.grp)
	wait(3) 
	liftoffcondjmp(ScourgeExplosionDeath)
	lowsprul(273, 0, 0)	-- Terran Building Rubble (Small) (thingy\RubbleS.grp)
	wait(1) 
end

function AcademyAlmostBuilt()
	playfram(1)	-- Frame set 0,  direction 1
	ScourgeLocal00()
end

function AcademyBuilt()
	playfram(0x00)	-- Frame set 0
	ScourgeLocal00()
end

function AcademyIsWorking()
	imgol(264, 0, 0)	-- Academy Overlay (terran\AcademyT.grp)
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 264 Academy Overlay (terran\AcademyT.grp)
iscript[95] = {
  IsId =          	95,
  Type =          	24,
  Init =          	AcademyOverlayInit,
  Death =         	AcademyOverlayDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	nil,
  WalkingToIdle = 	nil,
  SpecialState1 = 	nil,
  SpecialState2 = 	nil,
  AlmostBuilt =   	nil,
  Built =         	nil,
  Landing =       	AcademyOverlayDeath,
  LiftOff =       	AcademyOverlayDeath,
  IsWorking =     	AcademyOverlayIsWorking,
  WorkingToIdle = 	AcademyOverlayDeath,
  WarpIn =        	nil,
  Unused3 =       	nil,
  StarEditInit =  	nil,
  Disable =       	AcademyOverlayDeath,
  Burrow =        	nil
}
-- ----------------------------------------------------------------------------- --

function AcademyOverlayInit()
	playfram(0x00)	-- Frame set 0
	AcademyOverlayIsWorking()
end

function AcademyOverlayIsWorking()
::AcademyOverlayIsWorking_label::
	wait(2) 
	tmprmgraphicstart()
	waitrand(2, 5) 
	tmprmgraphicend()
	goto AcademyOverlayIsWorking_label
end

function AcademyOverlayDeath()
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 266 Barracks (terran\TBarrack.grp)
iscript[96] = {
  IsId =          	96,
  Type =          	24,
  Init =          	BarracksInit,
  Death =         	InfestedCommandCenterDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	ScourgeLocal00,
  WalkingToIdle = 	ScourgeLocal00,
  SpecialState1 = 	BarracksSpecialState1,
  SpecialState2 = 	nil,
  AlmostBuilt =   	BarracksAlmostBuilt,
  Built =         	BarracksBuilt,
  Landing =       	BarracksLanding,
  LiftOff =       	BarracksLiftOff,
  IsWorking =     	BarracksIsWorking,
  WorkingToIdle = 	BarracksBuilt,
  WarpIn =        	nil,
  Unused3 =       	nil,
  StarEditInit =  	nil,
  Disable =       	BarracksDisable,
  Burrow =        	nil
}
-- ----------------------------------------------------------------------------- --

function BarracksInit()
	playfram(0x00)	-- Frame set 0
	imgul(267, 0, 0)	-- Barracks Shadow (terran\tbrShad.grp)
	ScourgeLocal00()
end

function BarracksSpecialState1()
	playfram(4)	-- Frame set 0,  direction 4
	ScourgeLocal00()
end

function BarracksAlmostBuilt()
	playfram(1)	-- Frame set 0,  direction 1
	ScourgeLocal00()
end

function BarracksBuilt()
	playfram(0x00)	-- Frame set 0
	ScourgeLocal00()
end

function BarracksLanding()
	nobrkcodestart()
	wait(15) 
	playsnd(472)	-- Misc\Land.WAV
	playfram(4)	-- Frame set 0,  direction 4
	wait(8) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(8) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(8) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(8) 
	playfram(0x00)	-- Frame set 0
	sigorder(16) 
	nobrkcodeend()
	ScourgeLocal00()
end

function BarracksLiftOff()
	nobrkcodestart()
	playsnd(471)	-- Misc\LiftOff.WAV
	playfram(5)	-- Frame set 0,  direction 5
	wait(8) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(8) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(8) 
	playfram(4)	-- Frame set 0,  direction 4
	sigorder(16) 
	nobrkcodeend()
	ScourgeLocal00()
end

function BarracksIsWorking()
::BarracksIsWorking_label::
	playfram(7)	-- Frame set 0,  direction 7
	wait(4) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(2) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(2) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(2) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(4) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(2) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(2) 
	goto BarracksIsWorking_label
end

function BarracksDisable()
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 268 Armory (terran\chemlab.grp)
iscript[97] = {
  IsId =          	97,
  Type =          	20,
  Init =          	ArmoryInit,
  Death =         	AcademyDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	nil,
  WalkingToIdle = 	nil,
  SpecialState1 = 	nil,
  SpecialState2 = 	nil,
  AlmostBuilt =   	ArmoryAlmostBuilt,
  Built =         	ArmoryBuilt,
  Landing =       	ScourgeLocal00,
  LiftOff =       	ScourgeLocal00,
  IsWorking =     	ArmoryIsWorking,
  WorkingToIdle = 	ArmoryBuilt,
  WarpIn =        	nil
}
-- ----------------------------------------------------------------------------- --

function ArmoryInit()
	imgul(270, 0, 0)	-- Armory Shadow (terran\tclShad.grp)
	ArmoryBuilt()
end

function ArmoryBuilt()
	playfram(0x00)	-- Frame set 0
	ScourgeLocal00()
end

function ArmoryAlmostBuilt()
	playfram(1)	-- Frame set 0,  direction 1
	ScourgeLocal00()
end

function ArmoryIsWorking()
	imgol(269, 0, 0)	-- Armory Overlay (terran\chemlabT.grp)
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 269 Armory Overlay (terran\chemlabT.grp)
iscript[98] = {
  IsId =          	98,
  Type =          	24,
  Init =          	ArmoryOverlayInit,
  Death =         	ArmoryOverlayDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	nil,
  WalkingToIdle = 	nil,
  SpecialState1 = 	nil,
  SpecialState2 = 	nil,
  AlmostBuilt =   	nil,
  Built =         	nil,
  Landing =       	ArmoryOverlayDeath,
  LiftOff =       	ArmoryOverlayDeath,
  IsWorking =     	ArmoryOverlayInit,
  WorkingToIdle = 	ArmoryOverlayDeath,
  WarpIn =        	nil,
  Unused3 =       	nil,
  StarEditInit =  	nil,
  Disable =       	ArmoryOverlayDeath,
  Burrow =        	nil
}
-- ----------------------------------------------------------------------------- --

function ArmoryOverlayInit()
::ArmoryOverlayInit_label::
	playfram(0x00)	-- Frame set 0
	wait(3) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(3) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(3) 
	goto ArmoryOverlayInit_label
end

function ArmoryOverlayDeath()
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 271 Comsat Station (terran\ComSat.grp)
iscript[99] = {
  IsId =          	99,
  Type =          	20,
  Init =          	ComsatStationInit,
  Death =         	AcademyDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	nil,
  WalkingToIdle = 	nil,
  SpecialState1 = 	nil,
  SpecialState2 = 	nil,
  AlmostBuilt =   	ComsatStationAlmostBuilt,
  Built =         	ComsatStationBuilt,
  Landing =       	ComsatStationLanding,
  LiftOff =       	ScourgeLocal00,
  IsWorking =     	ScourgeLocal00,
  WorkingToIdle = 	ComsatStationWorkingToIdle,
  WarpIn =        	nil
}
-- ----------------------------------------------------------------------------- --

function ComsatStationInit()
	playfram(0x00)	-- Frame set 0
	imgul(274, 0, 0)	-- Comsat Station Shadow (terran\tcsShad.grp)
	ScourgeLocal00()
end

function ComsatStationAlmostBuilt()
	playfram(1)	-- Frame set 0,  direction 1
	ScourgeLocal00()
end

function ComsatStationBuilt()
	imgol(273, 0, 0)	-- Comsat Station Overlay (terran\ComSatT.grp)
	ComsatStationWorkingToIdle()
end

function ComsatStationWorkingToIdle()
	playfram(0x00)	-- Frame set 0
	ScourgeLocal00()
end

function ComsatStationLanding()
	imgol(272, 0, 0)	-- Comsat Station Connector (terran\ComSatC.grp)
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 272 Comsat Station Connector (terran\ComSatC.grp)
iscript[100] = {
  IsId =          	100,
  Type =          	24,
  Init =          	ComsatConnectorInit,
  Death =         	ComsatConnectorDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	nil,
  WalkingToIdle = 	nil,
  SpecialState1 = 	nil,
  SpecialState2 = 	nil,
  AlmostBuilt =   	nil,
  Built =         	nil,
  Landing =       	ComsatConnectorDeath,
  LiftOff =       	ComsatConnectorLiftOff,
  IsWorking =     	ComsatConnectorIsWorking,
  WorkingToIdle = 	ScourgeLocal00,
  WarpIn =        	nil,
  Unused3 =       	nil,
  StarEditInit =  	nil,
  Disable =       	ScourgeLocal00,
  Burrow =        	nil
}
-- ----------------------------------------------------------------------------- --

function ComsatConnectorInit()
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	ComsatConnectorIsWorking()
end

function ComsatConnectorIsWorking()
	playfram(3)	-- Frame set 0,  direction 3
	ScourgeLocal00()
end

function ComsatConnectorDeath()
	wait(1) 
end

function ComsatConnectorLiftOff()
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(0x00)	-- Frame set 0
	wait(2) 
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 273 Comsat Station Overlay (terran\ComSatT.grp)
iscript[101] = {
  IsId =          	101,
  Type =          	24,
  Init =          	ComsatOverlayInit,
  Death =         	ComsatOverlayDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	nil,
  WalkingToIdle = 	nil,
  SpecialState1 = 	nil,
  SpecialState2 = 	nil,
  AlmostBuilt =   	nil,
  Built =         	nil,
  Landing =       	ComsatOverlayLanding,
  LiftOff =       	ScourgeLocal00,
  IsWorking =     	ComsatOverlayIsWorking,
  WorkingToIdle = 	ComsatOverlayIsWorking,
  WarpIn =        	nil,
  Unused3 =       	nil,
  StarEditInit =  	nil,
  Disable =       	ScourgeLocal00,
  Burrow =        	nil
}
-- ----------------------------------------------------------------------------- --

function ComsatOverlayInit()
	playfram(0x00)	-- Frame set 0
	ScourgeLocal00()
end

function ComsatOverlayDeath()
	wait(1) 
end

function ComsatOverlayLanding()
	wait(13) 
	ComsatOverlayIsWorking()
end

function ComsatOverlayIsWorking()
::ComsatOverlayIsWorking_label::
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(2) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(2) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(2) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(2) 
	goto ComsatOverlayIsWorking_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 275 Command Center (terran\control.grp)
iscript[102] = {
  IsId =          	102,
  Type =          	20,
  Init =          	CommandCenterInit,
  Death =         	InfestedCommandCenterDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	ScourgeLocal00,
  WalkingToIdle = 	ScourgeLocal00,
  SpecialState1 = 	CommandCenterSpecialState1,
  SpecialState2 = 	nil,
  AlmostBuilt =   	CommandCenterAlmostBuilt,
  Built =         	CommandCenterBuilt,
  Landing =       	CommandCenterLanding,
  LiftOff =       	CommandCenterLiftOff,
  IsWorking =     	CommandCenterIsWorking,
  WorkingToIdle = 	CommandCenterBuilt,
  WarpIn =        	nil
}
-- ----------------------------------------------------------------------------- --

function CommandCenterInit()
	imgul(277, 0, 0)	-- Command Center Shadow (terran\tccShad.grp)
	CommandCenterBuilt()
end

function CommandCenterBuilt()
	playfram(0x00)	-- Frame set 0
	ScourgeLocal00()
end

function CommandCenterSpecialState1()
	playfram(4)	-- Frame set 0,  direction 4
	ScourgeLocal00()
end

function CommandCenterAlmostBuilt()
	playfram(1)	-- Frame set 0,  direction 1
	ScourgeLocal00()
end

function CommandCenterLanding()
	nobrkcodestart()
	wait(18) 
	playsnd(472)	-- Misc\Land.WAV
	playfram(4)	-- Frame set 0,  direction 4
	wait(5) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(5) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(5) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(5) 
	playfram(0x00)	-- Frame set 0
	sigorder(16) 
	nobrkcodeend()
	ScourgeLocal00()
end

function CommandCenterLiftOff()
	nobrkcodestart()
	playsnd(471)	-- Misc\LiftOff.WAV
	playfram(5)	-- Frame set 0,  direction 5
	wait(5) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(5) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(5) 
	playfram(4)	-- Frame set 0,  direction 4
	sigorder(16) 
	nobrkcodeend()
	ScourgeLocal00()
end

function CommandCenterIsWorking()
	imgol(276, 0, 0)	-- Command Center Overlay (terran\controlT.grp)
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 276 Command Center Overlay (terran\controlT.grp)
iscript[103] = {
  IsId =          	103,
  Type =          	24,
  Init =          	CommandCenterOverlayInit,
  Death =         	CommandCenterOverlayDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	CommandCenterOverlayDeath,
  WalkingToIdle = 	CommandCenterOverlayDeath,
  SpecialState1 = 	CommandCenterOverlayDeath,
  SpecialState2 = 	nil,
  AlmostBuilt =   	nil,
  Built =         	nil,
  Landing =       	CommandCenterOverlayDeath,
  LiftOff =       	CommandCenterOverlayDeath,
  IsWorking =     	CommandCenterOverlayInit,
  WorkingToIdle = 	CommandCenterOverlayDeath,
  WarpIn =        	nil,
  Unused3 =       	nil,
  StarEditInit =  	nil,
  Disable =       	CommandCenterOverlayDeath,
  Burrow =        	nil
}
-- ----------------------------------------------------------------------------- --

function CommandCenterOverlayInit()
::CommandCenterOverlayInit_label::
	playfram(0x00)	-- Frame set 0
	tmprmgraphicend()
	wait(4) 
	tmprmgraphicstart()
	wait(1) 
	tmprmgraphicend()
	wait(1) 
	tmprmgraphicstart()
	wait(1) 
	tmprmgraphicend()
	wait(3) 
	tmprmgraphicstart()
	wait(1) 
	tmprmgraphicend()
	wait(3) 
	tmprmgraphicstart()
	wait(1) 
	tmprmgraphicend()
	wait(4) 
	tmprmgraphicstart()
	wait(1) 
	tmprmgraphicend()
	wait(1) 
	tmprmgraphicstart()
	wait(1) 
	tmprmgraphicend()
	wait(3) 
	tmprmgraphicstart()
	wait(1) 
	tmprmgraphicend()
	wait(3) 
	tmprmgraphicstart()
	wait(1) 
	tmprmgraphicend()
	wait(4) 
	tmprmgraphicstart()
	wait(1) 
	tmprmgraphicend()
	wait(3) 
	tmprmgraphicstart()
	wait(1) 
	tmprmgraphicend()
	wait(1) 
	tmprmgraphicstart()
	wait(1) 
	tmprmgraphicend()
	wait(1) 
	tmprmgraphicstart()
	wait(1) 
	goto CommandCenterOverlayInit_label
end

function CommandCenterOverlayDeath()
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 299 Crashed Batlecruiser (neutral\Cbattle.grp)
iscript[104] = {
  IsId =          	104,
  Type =          	20,
  Init =          	CrashedBattlecruiserInit,
  Death =         	AcademyDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	nil,
  WalkingToIdle = 	nil,
  SpecialState1 = 	nil,
  SpecialState2 = 	nil,
  AlmostBuilt =   	nil,
  Built =         	CrashedBattlecruiserBuilt,
  Landing =       	nil,
  LiftOff =       	nil,
  IsWorking =     	ScourgeLocal00,
  WorkingToIdle = 	ScourgeLocal00,
  WarpIn =        	nil
}
-- ----------------------------------------------------------------------------- --

function CrashedBattlecruiserInit()
	imgul(300, 0, 0)	-- Crashed Battlecruiser Shadow (neutral\cbaShad.grp)
	CrashedBattlecruiserBuilt()
end

function CrashedBattlecruiserBuilt()
	playfram(0x00)	-- Frame set 0
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 278 Supply Depot (terran\Depot.grp)
iscript[105] = {
  IsId =          	105,
  Type =          	24,
  Init =          	SupplyDepotInit,
  Death =         	AcademyDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	nil,
  WalkingToIdle = 	nil,
  SpecialState1 = 	nil,
  SpecialState2 = 	nil,
  AlmostBuilt =   	SupplyDepotAlmostBuilt,
  Built =         	SupplyDepotBuilt,
  Landing =       	nil,
  LiftOff =       	nil,
  IsWorking =     	ScourgeLocal00,
  WorkingToIdle = 	SupplyDepotWorkingToIdle,
  WarpIn =        	nil,
  Unused3 =       	nil,
  StarEditInit =  	nil,
  Disable =       	SupplyDepotDisable,
  Burrow =        	nil
}
-- ----------------------------------------------------------------------------- --

function SupplyDepotInit()
	imgul(280, 0, 0)	-- Supply Depot Shadow (terran\tdeShad.grp)
	playfram(0x00)	-- Frame set 0
	ScourgeLocal00()
end

function SupplyDepotAlmostBuilt()
	playfram(1)	-- Frame set 0,  direction 1
	ScourgeLocal00()
end

function SupplyDepotBuilt()
	imgol(279, 0, 0)	-- Supply Depot Overlay (terran\DepotT.grp)
	SupplyDepotWorkingToIdle()
end

function SupplyDepotWorkingToIdle()
	playfram(0x00)	-- Frame set 0
	ScourgeLocal00()
end

function SupplyDepotDisable()
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 279 Supply Depot Overlay (terran\DepotT.grp)
iscript[106] = {
  IsId =          	106,
  Type =          	24,
  Init =          	SupplyDepotOverlayInit,
  Death =         	SupplyDepotOverlayDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	nil,
  WalkingToIdle = 	nil,
  SpecialState1 = 	nil,
  SpecialState2 = 	nil,
  AlmostBuilt =   	nil,
  Built =         	nil,
  Landing =       	nil,
  LiftOff =       	nil,
  IsWorking =     	SupplyDepotOverlayInit,
  WorkingToIdle = 	SupplyDepotOverlayInit,
  WarpIn =        	nil,
  Unused3 =       	nil,
  StarEditInit =  	nil,
  Disable =       	ScourgeLocal00,
  Burrow =        	nil
}
-- ----------------------------------------------------------------------------- --

function SupplyDepotOverlayInit()
::SupplyDepotOverlayInit_label::
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	goto SupplyDepotOverlayInit_label
end

function SupplyDepotOverlayDeath()
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 281 Control Tower (terran\DryDocks.grp)
iscript[107] = {
  IsId =          	107,
  Type =          	24,
  Init =          	ControlTowerInit,
  Death =         	AcademyDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	nil,
  WalkingToIdle = 	nil,
  SpecialState1 = 	nil,
  SpecialState2 = 	nil,
  AlmostBuilt =   	ControlTowerAlmostBuilt,
  Built =         	ControlTowerBuilt,
  Landing =       	ControlTowerLanding,
  LiftOff =       	ScourgeLocal00,
  IsWorking =     	ControlTowerIsWorking,
  WorkingToIdle = 	ControlTowerBuilt,
  WarpIn =        	nil,
  Unused3 =       	nil,
  StarEditInit =  	nil,
  Disable =       	ControlTowerDisable,
  Burrow =        	nil
}
-- ----------------------------------------------------------------------------- --

function ControlTowerInit()
	imgul(284, 0, 0)	-- Control Tower Shadow (terran\tddShad.grp)
	ControlTowerBuilt()
end

function ControlTowerBuilt()
	playfram(0x00)	-- Frame set 0
	ScourgeLocal00()
end

function ControlTowerAlmostBuilt()
	playfram(1)	-- Frame set 0,  direction 1
	ScourgeLocal00()
end

function ControlTowerLanding()
	imgol(282, 0, 0)	-- Control Tower Connector (terran\DryDockC.grp)
	ScourgeLocal00()
end

function ControlTowerIsWorking()
	imgol(283, 0, 0)	-- Control Tower Overlay (terran\DryDockT.grp)
	ScourgeLocal00()
end

function ControlTowerDisable()
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 282 Control Tower Connector (terran\DryDockC.grp)
iscript[108] = {
  IsId =          	108,
  Type =          	24,
  Init =          	ControlTowerConnectorInit,
  Death =         	ControlTowerConnectorDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	nil,
  WalkingToIdle = 	nil,
  SpecialState1 = 	nil,
  SpecialState2 = 	nil,
  AlmostBuilt =   	nil,
  Built =         	nil,
  Landing =       	ControlTowerConnectorDeath,
  LiftOff =       	ControlTowerConnectorLiftOff,
  IsWorking =     	ControlTowerConnectorIsWorking,
  WorkingToIdle = 	ControlTowerConnectorIsWorking,
  WarpIn =        	nil,
  Unused3 =       	nil,
  StarEditInit =  	nil,
  Disable =       	ScourgeLocal00,
  Burrow =        	nil
}
-- ----------------------------------------------------------------------------- --

function ControlTowerConnectorInit()
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	ControlTowerConnectorIsWorking()
end

function ControlTowerConnectorIsWorking()
	playfram(4)	-- Frame set 0,  direction 4
	ScourgeLocal00()
end

function ControlTowerConnectorDeath()
	wait(1) 
end

function ControlTowerConnectorLiftOff()
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(0x00)	-- Frame set 0
	wait(2) 
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 283 Control Tower Overlay (terran\DryDockT.grp)
iscript[109] = {
  IsId =          	109,
  Type =          	24,
  Init =          	ControlTowerOverlayInit,
  Death =         	ControlTowerOverlayDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	nil,
  WalkingToIdle = 	nil,
  SpecialState1 = 	nil,
  SpecialState2 = 	nil,
  AlmostBuilt =   	nil,
  Built =         	nil,
  Landing =       	ControlTowerOverlayDeath,
  LiftOff =       	ControlTowerOverlayDeath,
  IsWorking =     	ControlTowerOverlayIsWorking,
  WorkingToIdle = 	ControlTowerOverlayDeath,
  WarpIn =        	nil,
  Unused3 =       	nil,
  StarEditInit =  	nil,
  Disable =       	ControlTowerOverlayDeath,
  Burrow =        	nil
}
-- ----------------------------------------------------------------------------- --

function ControlTowerOverlayInit()
	playfram(0x00)	-- Frame set 0
	ControlTowerOverlayIsWorking()
end

function ControlTowerOverlayIsWorking()
::ControlTowerOverlayIsWorking_label::
	tmprmgraphicend()
	wait(5) 
	tmprmgraphicstart()
	wait(5) 
	goto ControlTowerOverlayIsWorking_label
end

function ControlTowerOverlayDeath()
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 285 Factory (terran\factory.grp)
iscript[111] = {
  IsId =          	111,
  Type =          	24,
  Init =          	FactoryInit,
  Death =         	AcademyDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	ScourgeLocal00,
  WalkingToIdle = 	ScourgeLocal00,
  SpecialState1 = 	FactorySpecialState1,
  SpecialState2 = 	nil,
  AlmostBuilt =   	FactoryAlmostBuilt,
  Built =         	FactoryBuilt,
  Landing =       	FactoryLanding,
  LiftOff =       	FactoryLiftOff,
  IsWorking =     	FactoryIsWorking,
  WorkingToIdle = 	FactoryBuilt,
  WarpIn =        	nil,
  Unused3 =       	nil,
  StarEditInit =  	nil,
  Disable =       	FactoryDisable,
  Burrow =        	nil
}
-- ----------------------------------------------------------------------------- --

function FactoryInit()
	playfram(0x00)	-- Frame set 0
	imgul(287, 0, 0)	-- Factory Shadow (terran\tfaShad.grp)
	ScourgeLocal00()
end

function FactorySpecialState1()
	playfram(5)	-- Frame set 0,  direction 5
	ScourgeLocal00()
end

function FactoryAlmostBuilt()
	playfram(1)	-- Frame set 0,  direction 1
	ScourgeLocal00()
end

function FactoryBuilt()
	playfram(0x00)	-- Frame set 0
	ScourgeLocal00()
end

function FactoryLanding()
	nobrkcodestart()
	wait(15) 
	playsnd(472)	-- Misc\Land.WAV
	playfram(5)	-- Frame set 0,  direction 5
	wait(5) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(5) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(5) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(5) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(5) 
	playfram(0x00)	-- Frame set 0
	sigorder(16) 
	nobrkcodeend()
	ScourgeLocal00()
end

function FactoryLiftOff()
	nobrkcodestart()
	playsnd(471)	-- Misc\LiftOff.WAV
	playfram(6)	-- Frame set 0,  direction 6
	wait(5) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(5) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(5) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(5) 
	playfram(5)	-- Frame set 0,  direction 5
	sigorder(16) 
	nobrkcodeend()
	ScourgeLocal00()
end

function FactoryIsWorking()
	imgol(286, 0, 0)	-- Factory Overlay (terran\factoryT.grp)
	ScourgeLocal00()
end

function FactoryDisable()
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 286 Factory Overlay (terran\factoryT.grp)
iscript[112] = {
  IsId =          	112,
  Type =          	24,
  Init =          	FactoryOverlayInit,
  Death =         	FactoryOverlayDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	FactoryOverlayDeath,
  WalkingToIdle = 	FactoryOverlayDeath,
  SpecialState1 = 	FactoryOverlayDeath,
  SpecialState2 = 	nil,
  AlmostBuilt =   	nil,
  Built =         	nil,
  Landing =       	FactoryOverlayDeath,
  LiftOff =       	FactoryOverlayDeath,
  IsWorking =     	FactoryOverlayInit,
  WorkingToIdle = 	FactoryOverlayDeath,
  WarpIn =        	nil,
  Unused3 =       	nil,
  StarEditInit =  	nil,
  Disable =       	FactoryOverlayDeath,
  Burrow =        	nil
}
-- ----------------------------------------------------------------------------- --

function FactoryOverlayInit()
::FactoryOverlayInit_label::
	playfram(0x00)	-- Frame set 0
	wait(5) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(5) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(5) 
	goto FactoryOverlayInit_label
end

function FactoryOverlayDeath()
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 288 Covert Ops (terran\GeneLab.grp)
iscript[113] = {
  IsId =          	113,
  Type =          	20,
  Init =          	CovertOpsInit,
  Death =         	AcademyDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	nil,
  WalkingToIdle = 	nil,
  SpecialState1 = 	nil,
  SpecialState2 = 	nil,
  AlmostBuilt =   	CovertOpsAlmostBuilt,
  Built =         	CovertOpsBuilt,
  Landing =       	CovertOpsLanding,
  LiftOff =       	ScourgeLocal00,
  IsWorking =     	CovertOpsIsWorking,
  WorkingToIdle = 	CovertOpsBuilt,
  WarpIn =        	nil
}
-- ----------------------------------------------------------------------------- --

function CovertOpsInit()
	imgul(291, 0, 0)	-- Covert Ops Shadow (terran\tglShad.grp)
	CovertOpsBuilt()
end

function CovertOpsBuilt()
	playfram(0x00)	-- Frame set 0
	ScourgeLocal00()
end

function CovertOpsAlmostBuilt()
	playfram(1)	-- Frame set 0,  direction 1
	ScourgeLocal00()
end

function CovertOpsLanding()
	imgol(289, 0, 0)	-- Covert Ops Connector (terran\GeneLabC.grp)
	ScourgeLocal00()
end

function CovertOpsIsWorking()
	imgol(290, 0, 0)	-- Covert Ops Overlay (terran\GeneLabT.grp)
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 289 Covert Ops Connector (terran\GeneLabC.grp)
iscript[114] = {
  IsId =          	114,
  Type =          	24,
  Init =          	CovertOpsConnectorInit,
  Death =         	CovertOpsConnectorDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	nil,
  WalkingToIdle = 	nil,
  SpecialState1 = 	nil,
  SpecialState2 = 	nil,
  AlmostBuilt =   	nil,
  Built =         	nil,
  Landing =       	CovertOpsConnectorDeath,
  LiftOff =       	CovertOpsConnectorLiftOff,
  IsWorking =     	CovertOpsConnectorIsWorking,
  WorkingToIdle = 	ScourgeLocal00,
  WarpIn =        	nil,
  Unused3 =       	nil,
  StarEditInit =  	nil,
  Disable =       	ScourgeLocal00,
  Burrow =        	nil
}
-- ----------------------------------------------------------------------------- --

function CovertOpsConnectorInit()
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	CovertOpsConnectorIsWorking()
end

function CovertOpsConnectorIsWorking()
	playfram(4)	-- Frame set 0,  direction 4
	ScourgeLocal00()
end

function CovertOpsConnectorDeath()
	wait(1) 
end

function CovertOpsConnectorLiftOff()
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(0x00)	-- Frame set 0
	wait(2) 
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 290 Covert Ops Overlay (terran\GeneLabT.grp)
iscript[115] = {
  IsId =          	115,
  Type =          	24,
  Init =          	CovertOpsOverlayInit,
  Death =         	CovertOpsOverlayDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	nil,
  WalkingToIdle = 	nil,
  SpecialState1 = 	nil,
  SpecialState2 = 	nil,
  AlmostBuilt =   	nil,
  Built =         	nil,
  Landing =       	CovertOpsOverlayDeath,
  LiftOff =       	CovertOpsOverlayDeath,
  IsWorking =     	CovertOpsOverlayIsWorking,
  WorkingToIdle = 	CovertOpsOverlayDeath,
  WarpIn =        	nil,
  Unused3 =       	nil,
  StarEditInit =  	nil,
  Disable =       	CovertOpsOverlayDeath,
  Burrow =        	nil
}
-- ----------------------------------------------------------------------------- --

function CovertOpsOverlayInit()
	playfram(0x00)	-- Frame set 0
	CovertOpsOverlayIsWorking()
end

function CovertOpsOverlayIsWorking()
::CovertOpsOverlayIsWorking_label::
	tmprmgraphicend()
	wait(5) 
	tmprmgraphicstart()
	wait(5) 
	goto CovertOpsOverlayIsWorking_label
end

function CovertOpsOverlayDeath()
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 292 Ion Cannon (neutral\ion.grp)
iscript[116] = {
  IsId =          	116,
  Type =          	20,
  Init =          	IonCannonInit,
  Death =         	AcademyDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	nil,
  WalkingToIdle = 	nil,
  SpecialState1 = 	nil,
  SpecialState2 = 	nil,
  AlmostBuilt =   	nil,
  Built =         	IonCannonInit,
  Landing =       	nil,
  LiftOff =       	nil,
  IsWorking =     	ScourgeLocal00,
  WorkingToIdle = 	ScourgeLocal00,
  WarpIn =        	nil
}
-- ----------------------------------------------------------------------------- --

function IonCannonInit()
	playfram(0x00)	-- Frame set 0
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 293 Machine Shop (terran\machines.grp)
iscript[117] = {
  IsId =          	117,
  Type =          	24,
  Init =          	MachineShopInit,
  Death =         	AcademyDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	nil,
  WalkingToIdle = 	nil,
  SpecialState1 = 	nil,
  SpecialState2 = 	nil,
  AlmostBuilt =   	MachineShopAlmostBuilt,
  Built =         	MachineShopBuilt,
  Landing =       	MachineShopLanding,
  LiftOff =       	ScourgeLocal00,
  IsWorking =     	MachineShopIsWorking,
  WorkingToIdle = 	MachineShopBuilt,
  WarpIn =        	nil,
  Unused3 =       	nil,
  StarEditInit =  	nil,
  Disable =       	MachineShopDisable,
  Burrow =        	nil
}
-- ----------------------------------------------------------------------------- --

function MachineShopInit()
	playfram(0x00)	-- Frame set 0
	imgul(295, 0, 0)	-- Machine Shop Shadow (terran\tmsShad.grp)
	ScourgeLocal00()
end

function MachineShopAlmostBuilt()
	playfram(4)	-- Frame set 0,  direction 4
	ScourgeLocal00()
end

function MachineShopBuilt()
	playfram(0x00)	-- Frame set 0
	ScourgeLocal00()
end

function MachineShopLanding()
	imgol(294, 0, 0)	-- Machine Shop Connector (terran\machineC.grp)
	ScourgeLocal00()
end

function MachineShopIsWorking()
::MachineShopIsWorking_label::
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(1) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(1) 
	goto MachineShopIsWorking_label
end

function MachineShopDisable()
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 294 Machine Shop Connector (terran\machineC.grp)
iscript[118] = {
  IsId =          	118,
  Type =          	24,
  Init =          	MachineShopConnectorInit,
  Death =         	MachineShopConnectorDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	nil,
  WalkingToIdle = 	nil,
  SpecialState1 = 	nil,
  SpecialState2 = 	nil,
  AlmostBuilt =   	nil,
  Built =         	nil,
  Landing =       	MachineShopConnectorDeath,
  LiftOff =       	MachineShopConnectorLiftOff,
  IsWorking =     	MachineShopConnectorIsWorking,
  WorkingToIdle = 	ScourgeLocal00,
  WarpIn =        	nil,
  Unused3 =       	nil,
  StarEditInit =  	nil,
  Disable =       	ScourgeLocal00,
  Burrow =        	nil
}
-- ----------------------------------------------------------------------------- --

function MachineShopConnectorInit()
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	MachineShopConnectorIsWorking()
end

function MachineShopConnectorIsWorking()
	playfram(3)	-- Frame set 0,  direction 3
	ScourgeLocal00()
end

function MachineShopConnectorDeath()
	wait(1) 
end

function MachineShopConnectorLiftOff()
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(0x00)	-- Frame set 0
	wait(2) 
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 296 Missile Turret (Base) (terran\missile.grp)
iscript[119] = {
  IsId =          	119,
  Type =          	20,
  Init =          	MissileTurret_Base_Init,
  Death =         	AcademyDeath,
  GndAttkInit =   	ScourgeLocal00,
  AirAttkInit =   	ScourgeLocal00,
  Unused1 =       	nil,
  GndAttkRpt =    	ScourgeLocal00,
  AirAttkRpt =    	ScourgeLocal00,
  CastSpell =     	nil,
  GndAttkToIdle = 	ScourgeLocal00,
  AirAttkToIdle = 	ScourgeLocal00,
  Unused2 =       	nil,
  Walking =       	nil,
  WalkingToIdle = 	nil,
  SpecialState1 = 	nil,
  SpecialState2 = 	nil,
  AlmostBuilt =   	MissileTurret_Base_AlmostBuilt,
  Built =         	MissileTurret_Base_Built,
  Landing =       	nil,
  LiftOff =       	nil,
  IsWorking =     	ScourgeLocal00,
  WorkingToIdle = 	MissileTurret_Base_WorkingToIdle,
  WarpIn =        	nil
}
-- ----------------------------------------------------------------------------- --

function MissileTurret_Base_Init()
	playfram(2)	-- Frame set 0,  direction 2
	imgul(298, 0, 0)	-- Missile Turret (Base) Shadow (terran\tmiShad.grp)
	ScourgeLocal00()
end

function MissileTurret_Base_AlmostBuilt()
	playfram(1)	-- Frame set 0,  direction 1
	ScourgeLocal00()
end

function MissileTurret_Base_Built()
	imgol(297, 0, 0)	-- Missile Turret (Turret) (terran\missileT.grp)
  MissileTurret_Base_WorkingToIdle()
end

function MissileTurret_Base_WorkingToIdle()
	playfram(2)	-- Frame set 0,  direction 2
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 297 Missile Turret (Turret) (terran\missileT.grp)
iscript[120] = {
  IsId =          	120,
  Type =          	24,
  Init =          	MissileTurret_Turret_Init,
  Death =         	MissileTurret_Turret_Death,
  GndAttkInit =   	MissileTurret_Turret_GndAttkInit,
  AirAttkInit =   	MissileTurret_Turret_GndAttkInit,
  Unused1 =       	nil,
  GndAttkRpt =    	MissileTurret_Turret_GndAttkInit,
  AirAttkRpt =    	MissileTurret_Turret_GndAttkInit,
  CastSpell =     	nil,
  GndAttkToIdle = 	MissileTurret_Turret_GndAttkToIdle,
  AirAttkToIdle = 	MissileTurret_Turret_GndAttkToIdle,
  Unused2 =       	nil,
  Walking =       	nil,
  WalkingToIdle = 	nil,
  SpecialState1 = 	nil,
  SpecialState2 = 	nil,
  AlmostBuilt =   	ScourgeLocal00,
  Built =         	MissileTurret_Turret_Built,
  Landing =       	nil,
  LiftOff =       	nil,
  IsWorking =     	MissileTurret_Turret_Built,
  WorkingToIdle = 	MissileTurret_Turret_Built,
  WarpIn =        	nil,
  Unused3 =       	nil,
  StarEditInit =  	nil,
  Disable =       	ScourgeLocal00,
  Burrow =        	nil
}
-- ----------------------------------------------------------------------------- --

function MissileTurret_Turret_Init()
	playfram(0x00)	-- Frame set 0
  MissileTurret_Turret_Built()
end

function MissileTurret_Turret_Built()
::MissileTurret_Turret_Built_label::
	wait(1) 
	turncwise(1)
	goto MissileTurret_Turret_Built_label
end

function MissileTurret_Turret_Death()
	wait(1) 
end

function MissileTurret_Turret_GndAttkInit()
	wait(1) 
	attack()
	gotorepeatattk()
	sigorder(1) 
	wait(13) 
	ignorerest()
  MissileTurret_Turret_GndAttkToIdle()
end

function MissileTurret_Turret_GndAttkToIdle()
	MissileTurret_Turret_Built()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 301 Physics Lab (terran\physics.grp)
iscript[121] = {
  IsId =          	121,
  Type =          	20,
  Init =          	PhysicsLabInit,
  Death =         	AcademyDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	nil,
  WalkingToIdle = 	nil,
  SpecialState1 = 	nil,
  SpecialState2 = 	nil,
  AlmostBuilt =   	PhysicsLabAlmostBuilt,
  Built =         	PhysicsLabBuilt,
  Landing =       	PhysicsLabLanding,
  LiftOff =       	PhysicsLabBuilt,
  IsWorking =     	PhysicsLabIsWorking,
  WorkingToIdle = 	PhysicsLabBuilt,
  WarpIn =        	nil
}
-- ----------------------------------------------------------------------------- --

function PhysicsLabInit()
	imgul(303, 0, 0)	-- Physics Lab Shadow (terran\tplShad.grp)
	PhysicsLabBuilt()
end

function PhysicsLabBuilt()
	playfram(0x00)	-- Frame set 0
	ScourgeLocal00()
end

function PhysicsLabAlmostBuilt()
	playfram(6)	-- Frame set 0,  direction 6
	ScourgeLocal00()
end

function PhysicsLabLanding()
	imgol(302, 0, 0)	-- Physics Lab Connector (terran\physicsC.grp)
	ScourgeLocal00()
end

function PhysicsLabIsWorking()
::PhysicsLabIsWorking_label::
	playfram(1)	-- Frame set 0,  direction 1
	wait(3) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(3) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(3) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(3) 
	playfram(0x00)	-- Frame set 0
	wait(3) 
	goto PhysicsLabIsWorking_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 302 Physics Lab Connector (terran\physicsC.grp)
iscript[122] = {
  IsId =          	122,
  Type =          	24,
  Init =          	PhysicsLabConnectorInit,
  Death =         	PhysicsLabConnectorDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	nil,
  WalkingToIdle = 	nil,
  SpecialState1 = 	nil,
  SpecialState2 = 	nil,
  AlmostBuilt =   	nil,
  Built =         	nil,
  Landing =       	PhysicsLabConnectorDeath,
  LiftOff =       	PhysicsLabConnectorLiftOff,
  IsWorking =     	PhysicsLabConnectorIsWorking,
  WorkingToIdle = 	ScourgeLocal00,
  WarpIn =        	nil,
  Unused3 =       	nil,
  StarEditInit =  	nil,
  Disable =       	ScourgeLocal00,
  Burrow =        	nil
}
-- ----------------------------------------------------------------------------- --

function PhysicsLabConnectorInit()
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	PhysicsLabConnectorIsWorking()
end

function PhysicsLabConnectorIsWorking()
	playfram(4)	-- Frame set 0,  direction 4
	ScourgeLocal00()
end

function PhysicsLabConnectorDeath()
	wait(1) 
end

function PhysicsLabConnectorLiftOff()
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(0x00)	-- Frame set 0
	wait(2) 
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 304 Bunker (terran\PillBox.grp)
iscript[123] = {
  IsId =          	123,
  Type =          	24,
  Init =          	BunkerInit,
  Death =         	AcademyDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	nil,
  WalkingToIdle = 	nil,
  SpecialState1 = 	nil,
  SpecialState2 = 	nil,
  AlmostBuilt =   	BunkerAlmostBuilt,
  Built =         	BunkerBuilt,
  Landing =       	nil,
  LiftOff =       	nil,
  IsWorking =     	nil,
  WorkingToIdle = 	nil,
  WarpIn =        	nil,
  Unused3 =       	nil,
  StarEditInit =  	nil,
  Disable =       	ScourgeLocal00,
  Burrow =        	nil
}
-- ----------------------------------------------------------------------------- --

function BunkerInit()
	imgul(305, 0, 0)	-- Bunker Shadow (terran\tpbShad.grp)
	BunkerBuilt()
end

function BunkerBuilt()
	playfram(0x00)	-- Frame set 0
	ScourgeLocal00()
end

function BunkerAlmostBuilt()
	playfram(1)	-- Frame set 0,  direction 1
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 306 Bunker Overlay (terran\PillBoxT.grp)
iscript[124] = {
  IsId =          	124,
  Type =          	0,
  Init =          	BunkerOverlayInit,
  Death =         	nil
}
-- ----------------------------------------------------------------------------- --

function BunkerOverlayInit()
	playfram(0x00)	-- Frame set 0
	wait(1) 
	tmprmgraphicstart()
	wait(1) 
	tmprmgraphicend()
	wait(1) 
	tmprmgraphicstart()
	wait(1) 
	tmprmgraphicend()
	wait(1) 
	tmprmgraphicstart()
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 307 Refinery (terran\refinery.grp)
iscript[125] = {
  IsId =          	125,
  Type =          	20,
  Death =         	RefineryDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	nil,
  WalkingToIdle = 	nil,
  SpecialState1 = 	RefinerySpecialState1,
  SpecialState2 = 	RefinerySpecialState2,
  AlmostBuilt =   	RefineryAlmostBuilt,
  Built =         	RefineryBuilt,
  Landing =       	nil,
  LiftOff =       	nil,
  IsWorking =     	ScourgeLocal00,
  WorkingToIdle = 	RefineryBuilt,
  WarpIn =        	nil
}
-- ----------------------------------------------------------------------------- --

function RefineryDeath()
	playsnd(7)	-- Misc\ExploLrg.wav
	sprol(272, 0, 0)	-- Building Explosion (Large) (thingy\tBangX.grp)
	wait(3) 
end

function RefinerySpecialState1()
	playfram(2)	-- Frame set 0,  direction 2
	--RefineryLocal00()
end

function RefinerySpecialState2()
	playfram(3)	-- Frame set 0,  direction 3
	--RefineryLocal00()
end

function RefineryAlmostBuilt()
	playfram(4)	-- Frame set 0,  direction 4
	--RefineryLocal00()
end

function RefineryBuilt()
	playfram(0x00)	-- Frame set 0
	wait(5) 
	RefineryLocal01()
end

function RefineryLocal01()
::RefineryLocal01_label::
	--creategasoverlays(0) 
	wait(20) 
	waitrand(5, 100) 
	goto RefineryLocal01_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 309 Science Facility (terran\research.grp)
iscript[126] = {
  IsId =          	126,
  Type =          	20,
  Init =          	ScienceFacilityInit,
  Death =         	AcademyDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	ScourgeLocal00,
  WalkingToIdle = 	ScourgeLocal00,
  SpecialState1 = 	ScienceFacilitySpecialState1,
  SpecialState2 = 	nil,
  AlmostBuilt =   	ScienceFacilityAlmostBuilt,
  Built =         	ScienceFacilityBuilt,
  Landing =       	ScienceFacilityLanding,
  LiftOff =       	ScienceFacilityLiftOff,
  IsWorking =     	ScienceFacilityIsWorking,
  WorkingToIdle = 	ScienceFacilityBuilt,
  WarpIn =        	nil
}
-- ----------------------------------------------------------------------------- --

function ScienceFacilityInit()
	imgul(311, 0, 0)	-- Science Facility Shadow (terran\trlShad.grp)
	ScienceFacilityBuilt()
end

function ScienceFacilityBuilt()
	playfram(0x00)	-- Frame set 0
	ScourgeLocal00()
end

function ScienceFacilitySpecialState1()
	playfram(5)	-- Frame set 0,  direction 5
	ScourgeLocal00()
end

function ScienceFacilityAlmostBuilt()
	playfram(1)	-- Frame set 0,  direction 1
	ScourgeLocal00()
end

function ScienceFacilityLanding()
	nobrkcodestart()
	wait(18) 
	playsnd(472)	-- Misc\Land.WAV
	playfram(4)	-- Frame set 0,  direction 4
	wait(5) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(5) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(5) 
	playfram(0x00)	-- Frame set 0
	sigorder(16) 
	nobrkcodeend()
	ScourgeLocal00()
end

function ScienceFacilityLiftOff()
	nobrkcodestart()
	playsnd(471)	-- Misc\LiftOff.WAV
	playfram(2)	-- Frame set 0,  direction 2
	wait(5) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(5) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(5) 
	playfram(5)	-- Frame set 0,  direction 5
	sigorder(16) 
	nobrkcodeend()
	ScourgeLocal00()
end

function ScienceFacilityIsWorking()
	imgol(310, 0, 0)	-- Science Facility Overlay (terran\ResearcT.grp)
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 310 Science Facility Overlay (terran\ResearcT.grp)
iscript[127] = {
  IsId =          	127,
  Type =          	24,
  Init =          	ScienceFacilityOverlayInit,
  Death =         	ScienceFacilityOverlayDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	ScienceFacilityOverlayDeath,
  WalkingToIdle = 	ScienceFacilityOverlayDeath,
  SpecialState1 = 	ScienceFacilityOverlayDeath,
  SpecialState2 = 	nil,
  AlmostBuilt =   	nil,
  Built =         	nil,
  Landing =       	ScienceFacilityOverlayDeath,
  LiftOff =       	ScienceFacilityOverlayDeath,
  IsWorking =     	ScienceFacilityOverlayIsWorking,
  WorkingToIdle = 	ScienceFacilityOverlayDeath,
  WarpIn =        	nil,
  Unused3 =       	nil,
  StarEditInit =  	nil,
  Disable =       	ScienceFacilityOverlayDeath,
  Burrow =        	nil
}
-- ----------------------------------------------------------------------------- --

function ScienceFacilityOverlayInit()
	playfram(0x00)	-- Frame set 0
	ScienceFacilityOverlayIsWorking()
end

function ScienceFacilityOverlayIsWorking()
::ScienceFacilityOverlayIsWorking_label::
	tmprmgraphicend()
	wait(5) 
	tmprmgraphicstart()
	wait(5) 
	goto ScienceFacilityOverlayIsWorking_label
end

function ScienceFacilityOverlayDeath()
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 312 Nuclear Silo (terran\nukesilo.grp)
iscript[128] = {
  IsId =          	128,
  Type =          	24,
  Init =          	NuclearSiloInit,
  Death =         	AcademyDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	nil,
  WalkingToIdle = 	nil,
  SpecialState1 = 	nil,
  SpecialState2 = 	nil,
  AlmostBuilt =   	NuclearSiloAlmostBuilt,
  Built =         	NuclearSiloBuilt,
  Landing =       	NuclearSiloLanding,
  LiftOff =       	ScourgeLocal00,
  IsWorking =     	NuclearSiloIsWorking,
  WorkingToIdle = 	NuclearSiloBuilt,
  WarpIn =        	nil,
  Unused3 =       	nil,
  StarEditInit =  	nil,
  Disable =       	NuclearSiloDisable,
  Burrow =        	nil
}
-- ----------------------------------------------------------------------------- --

function NuclearSiloInit()
	imgul(315, 0, 0)	-- Nuclear Silo Shadow (terran\tnsShad.grp)
	NuclearSiloBuilt()
end

function NuclearSiloBuilt()
	playfram(0x00)	-- Frame set 0
	ScourgeLocal00()
end

function NuclearSiloAlmostBuilt()
	playfram(1)	-- Frame set 0,  direction 1
	ScourgeLocal00()
end

function NuclearSiloLanding()
	imgol(313, 0, 0)	-- Nuclear Silo Connector (terran\NukeSilC.grp)
	ScourgeLocal00()
end

function NuclearSiloIsWorking()
	imgol(314, 0, 0)	-- Nuclear Silo Overlay (terran\NukeSilT.grp)
	ScourgeLocal00()
end

function NuclearSiloDisable()
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 313 Nuclear Silo Connector (terran\NukeSilC.grp)
iscript[129] = {
  IsId =          	129,
  Type =          	24,
  Init =          	NuclearSiloConnectorInit,
  Death =         	NuclearSiloConnectorDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	nil,
  WalkingToIdle = 	nil,
  SpecialState1 = 	nil,
  SpecialState2 = 	nil,
  AlmostBuilt =   	nil,
  Built =         	nil,
  Landing =       	NuclearSiloConnectorDeath,
  LiftOff =       	NuclearSiloConnectorLiftOff,
  IsWorking =     	NuclearSiloConnectorIsWorking,
  WorkingToIdle = 	ScourgeLocal00,
  WarpIn =        	nil,
  Unused3 =       	nil,
  StarEditInit =  	nil,
  Disable =       	ScourgeLocal00,
  Burrow =        	nil
}
-- ----------------------------------------------------------------------------- --

function NuclearSiloConnectorInit()
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	NuclearSiloConnectorIsWorking()
end

function NuclearSiloConnectorIsWorking()
	playfram(4)	-- Frame set 0,  direction 4
	ScourgeLocal00()
end

function NuclearSiloConnectorDeath()
	wait(1) 
end

function NuclearSiloConnectorLiftOff()
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(0x00)	-- Frame set 0
	wait(2) 
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 314 Nuclear Silo Overlay (terran\NukeSilT.grp)
iscript[130] = {
  IsId =          	130,
  Type =          	24,
  Init =          	NuclearSiloOverlayInit,
  Death =         	NuclearSiloOverlayDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	nil,
  WalkingToIdle = 	nil,
  SpecialState1 = 	nil,
  SpecialState2 = 	nil,
  AlmostBuilt =   	nil,
  Built =         	nil,
  Landing =       	NuclearSiloOverlayDeath,
  LiftOff =       	NuclearSiloOverlayDeath,
  IsWorking =     	NuclearSiloOverlayIsWorking,
  WorkingToIdle = 	NuclearSiloOverlayDeath,
  WarpIn =        	nil,
  Unused3 =       	nil,
  StarEditInit =  	nil,
  Disable =       	NuclearSiloOverlayDeath,
  Burrow =        	nil
}
-- ----------------------------------------------------------------------------- --

function NuclearSiloOverlayInit()
	playfram(0x00)	-- Frame set 0
	NuclearSiloOverlayIsWorking()
end

function NuclearSiloOverlayIsWorking()
::NuclearSiloOverlayIsWorking_label::
	tmprmgraphicend()
	wait(5) 
	tmprmgraphicstart()
	wait(5) 
	goto NuclearSiloOverlayIsWorking_label
end

function NuclearSiloOverlayDeath()
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 316 Nuclear Missile (terran\nukemiss.grp)
iscript[131] = {
  IsId =          	131,
  Type =          	21,
  Init =          	NuclearMissileInit,
  Death =         	NuclearMissileDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	NuclearMissileWalking,
  WalkingToIdle = 	ScourgeLocal00,
  SpecialState1 = 	NuclearMissileSpecialState1,
  SpecialState2 = 	nil,
  AlmostBuilt =   	nil,
  Built =         	nil,
  Landing =       	nil,
  LiftOff =       	nil,
  IsWorking =     	nil,
  WorkingToIdle = 	nil,
  WarpIn =        	NuclearMissileWarpIn
}
-- ----------------------------------------------------------------------------- --

function NuclearMissileInit()
	playfram(0x00)	-- Frame set 0
	ScourgeLocal00()
end

function NuclearMissileDeath()
	imgol(428, 0, 0)	-- Nuclear Missile Death (thingy\small.grp)
	wait(1) 
end

function NuclearMissileWalking()
	curdirectcondjmp(128, 32, NuclearMissileLocal00)
	NuclearMissileLocal01()
end

function NuclearMissileLocal01()
::NuclearMissileLocal01_label::
	sprol(309, 0, 10)	-- Longbolt/Gemini Missiles Trail (thingy\smoke.grp)
	wait(3) 
	goto NuclearMissileLocal01_label
end

function NuclearMissileLocal00()
::NuclearMissileLocal00_label::
	wait(3) 
	sprol(309, 0, -10)	-- Longbolt/Gemini Missiles Trail (thingy\smoke.grp)
	goto NuclearMissileLocal00_label
end

function NuclearMissileSpecialState1()
	castspell()
	sigorder(1) 
	tmprmgraphicstart()
	imgol(428, 0, 0)	-- Nuclear Missile Death (thingy\small.grp)
	sprol(267, 0, -42)	-- Nuke Hit (thingy\NukeHit.grp)
	ScourgeLocal00()
end

function NuclearMissileWarpIn()
	wait(125) 
	wait(125) 
	sigorder(2) 
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 318 Nuke Hit (thingy\NukeHit.grp)
iscript[133] = {
  IsId =          	133,
  Type =          	1,
  Init =          	NukeExplosionInit,
  Death =         	ScourgeExplosionDeath
}
-- ----------------------------------------------------------------------------- --

function NukeExplosionInit()
	playsnd(85)	-- Bullet\TNsHit00.wav
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playsnd(13)	-- Misc\Explo4.wav
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(2) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(2) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(2) 
	playsnd(13)	-- Misc\Explo4.wav
	playfram(9)	-- Frame set 0,  direction 9
	wait(2) 
	playfram(10)	-- Frame set 0,  direction 10
	wait(2) 
	playfram(11)	-- Frame set 0,  direction 11
	wait(2) 
	playfram(12)	-- Frame set 0,  direction 12
	wait(2) 
	playfram(13)	-- Frame set 0,  direction 13
	wait(2) 
	playsnd(13)	-- Misc\Explo4.wav
	playfram(14)	-- Frame set 0,  direction 14
	wait(2) 
	playfram(15)	-- Frame set 0,  direction 15
	wait(2) 
	playfram(16)	-- Frame set 0,  direction 16
	wait(2) 
	playfram(0x11)	-- Frame set 1
	wait(2) 
	playfram(18)	-- Frame set 1,  direction 1
	wait(2) 
	playsnd(13)	-- Misc\Explo4.wav
	playfram(19)	-- Frame set 1,  direction 2
	wait(2) 
	playfram(20)	-- Frame set 1,  direction 3
	wait(2) 
	playfram(21)	-- Frame set 1,  direction 4
	wait(2) 
	playfram(22)	-- Frame set 1,  direction 5
	wait(2) 
	playfram(23)	-- Frame set 1,  direction 6
	wait(2) 
	playfram(24)	-- Frame set 1,  direction 7
	wait(2) 
	playfram(25)	-- Frame set 1,  direction 8
	wait(2) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 319 Starport (terran\starport.grp)
iscript[134] = {
  IsId =          	134,
  Type =          	20,
  Init =          	StarportInit,
  Death =         	InfestedCommandCenterDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	ScourgeLocal00,
  WalkingToIdle = 	ScourgeLocal00,
  SpecialState1 = 	StarportSpecialState1,
  SpecialState2 = 	nil,
  AlmostBuilt =   	StarportAlmostBuilt,
  Built =         	StarportBuilt,
  Landing =       	StarportLanding,
  LiftOff =       	StarportLiftOff,
  IsWorking =     	StarportIsWorking,
  WorkingToIdle = 	StarportBuilt,
  WarpIn =        	nil
}
-- ----------------------------------------------------------------------------- --

function StarportInit()
	imgul(321, 0, 0)	-- Starport Shadow (terran\tspShad.grp)
	StarportBuilt()
end

function StarportBuilt()
	playfram(0x00)	-- Frame set 0
	ScourgeLocal00()
end

function StarportSpecialState1()
	playfram(3)	-- Frame set 0,  direction 3
	ScourgeLocal00()
end

function StarportAlmostBuilt()
	playfram(5)	-- Frame set 0,  direction 5
	ScourgeLocal00()
end

function StarportLanding()
	nobrkcodestart()
	wait(20) 
	playsnd(472)	-- Misc\Land.WAV
	playfram(3)	-- Frame set 0,  direction 3
	wait(5) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(5) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(5) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(5) 
	playfram(0x00)	-- Frame set 0
	sigorder(16) 
	nobrkcodeend()
	ScourgeLocal00()
end

function StarportLiftOff()
	nobrkcodestart()
	playsnd(471)	-- Misc\LiftOff.WAV
	playfram(4)	-- Frame set 0,  direction 4
	wait(5) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(5) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(5) 
	playfram(3)	-- Frame set 0,  direction 3
	sigorder(16) 
	nobrkcodeend()
	ScourgeLocal00()
end

function StarportIsWorking()
	imgol(320, 0, 0)	-- Starport Overlay (terran\StarpoT.grp)
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 320 Starport Overlay (terran\StarpoT.grp)
iscript[135] = {
  IsId =          	135,
  Type =          	24,
  Init =          	StarportOverlayInit,
  Death =         	StarportOverlayDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	StarportOverlayInit,
  WalkingToIdle = 	StarportOverlayInit,
  SpecialState1 = 	StarportOverlayDeath,
  SpecialState2 = 	nil,
  AlmostBuilt =   	nil,
  Built =         	nil,
  Landing =       	StarportOverlayInit,
  LiftOff =       	StarportOverlayInit,
  IsWorking =     	StarportOverlayInit,
  WorkingToIdle = 	StarportOverlayDeath,
  WarpIn =        	nil,
  Unused3 =       	nil,
  StarEditInit =  	nil,
  Disable =       	StarportOverlayDeath,
  Burrow =        	nil
}
-- ----------------------------------------------------------------------------- --

function StarportOverlayInit()
::StarportOverlayInit_label::
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	goto StarportOverlayInit_label
end

function StarportOverlayDeath()
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 322 Engineering Bay (terran\weaponpl.grp)
iscript[136] = {
  IsId =          	136,
  Type =          	24,
  Init =          	EngineeringBayInit,
  Death =         	AcademyDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	ScourgeLocal00,
  WalkingToIdle = 	ScourgeLocal00,
  SpecialState1 = 	EngineeringBaySpecialState1,
  SpecialState2 = 	nil,
  AlmostBuilt =   	EngineeringBayAlmostBuilt,
  Built =         	EngineeringBayBuilt,
  Landing =       	EngineeringBayLanding,
  LiftOff =       	EngineeringBayLiftOff,
  IsWorking =     	ScourgeLocal00,
  WorkingToIdle = 	EngineeringBayWorkingToIdle,
  WarpIn =        	nil,
  Unused3 =       	nil,
  StarEditInit =  	nil,
  Disable =       	EngineeringBayDisable,
  Burrow =        	nil
}
-- ----------------------------------------------------------------------------- --

function EngineeringBayInit()
	playfram(0x00)	-- Frame set 0
	imgul(324, 0, 0)	-- Engineering Bay Shadow (terran\twpShad.grp)
	ScourgeLocal00()
end

function EngineeringBaySpecialState1()
	playfram(4)	-- Frame set 0,  direction 4
	ScourgeLocal00()
end

function EngineeringBayAlmostBuilt()
	playfram(1)	-- Frame set 0,  direction 1
	ScourgeLocal00()
end

function EngineeringBayBuilt()
	imgol(323, 0, 0)	-- Engineering Bay Overlay (terran\weaponpT.grp)
	EngineeringBayWorkingToIdle()
end

function EngineeringBayWorkingToIdle()
	playfram(0x00)	-- Frame set 0
	ScourgeLocal00()
end

function EngineeringBayLanding()
	nobrkcodestart()
	wait(25) 
	playsnd(472)	-- Misc\Land.WAV
	playfram(4)	-- Frame set 0,  direction 4
	wait(4) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(4) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(4) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(4) 
	playfram(0x00)	-- Frame set 0
	sigorder(16) 
	nobrkcodeend()
	ScourgeLocal00()
end

function EngineeringBayLiftOff()
	nobrkcodestart()
	playsnd(471)	-- Misc\LiftOff.WAV
	playfram(5)	-- Frame set 0,  direction 5
	wait(4) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(4) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(4) 
	playfram(4)	-- Frame set 0,  direction 4
	sigorder(16) 
	nobrkcodeend()
	ScourgeLocal00()
end

function EngineeringBayDisable()
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 323 Engineering Bay Overlay (terran\weaponpT.grp)
iscript[137] = {
  IsId =          	137,
  Type =          	24,
  Init =          	EngineeringBayOverlayInit,
  Death =         	EngineeringBayOverlayDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	ScourgeLocal00,
  WalkingToIdle = 	ScourgeLocal00,
  SpecialState1 = 	EngineeringBayOverlayDeath,
  SpecialState2 = 	nil,
  AlmostBuilt =   	nil,
  Built =         	ScourgeLocal00,
  Landing =       	ScourgeLocal00,
  LiftOff =       	ScourgeLocal00,
  IsWorking =     	EngineeringBayOverlayIsWorking,
  WorkingToIdle = 	EngineeringBayOverlayInit,
  WarpIn =        	nil,
  Unused3 =       	nil,
  StarEditInit =  	nil,
  Disable =       	EngineeringBayOverlayInit,
  Burrow =        	nil
}
-- ----------------------------------------------------------------------------- --

function EngineeringBayOverlayInit()
	playfram(0x00)	-- Frame set 0
	ScourgeLocal00()
end

function EngineeringBayOverlayDeath()
	wait(1) 
end

function EngineeringBayOverlayIsWorking()
::EngineeringBayOverlayIsWorking_label::
	playfram(0x00)	-- Frame set 0
	wait(5) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(5) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(5) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(5) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(5) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(5) 
	goto EngineeringBayOverlayIsWorking_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 325 Terran Construction (Large) (terran\TBldLrg.grp)
iscript[138] = {
  IsId =          	138,
  Type =          	14,
  Init =          	TerranConstruction_Large_Init,
  Death =         	AcademyDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	nil,
  WalkingToIdle = 	nil,
  SpecialState1 = 	TerranConstruction_Large_SpecialState1,
  SpecialState2 = 	TerranConstruction_Large_SpecialState2,
  AlmostBuilt =   	nil
}
-- ----------------------------------------------------------------------------- --

function TerranConstruction_Large_Init()
	playfram(0x00)	-- Frame set 0
	imgul(326, 0, 0)	-- Terran Construction (Large) Shadow (terran\tb2Shad.grp)
	ScourgeLocal00()
end

function TerranConstruction_Large_SpecialState1()
	playfram(1)	-- Frame set 0,  direction 1
	ScourgeLocal00()
end

function TerranConstruction_Large_SpecialState2()
	playfram(2)	-- Frame set 0,  direction 2
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 327 Terran Construction (Medium) (terran\tBldMed.grp)
iscript[139] = {
  IsId =          	139,
  Type =          	14,
  Init =          	TerranConstruction_Medium_Init,
  Death =         	AcademyDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	nil,
  WalkingToIdle = 	nil,
  SpecialState1 = 	TerranConstruction_Medium_SpecialState1,
  SpecialState2 = 	TerranConstruction_Medium_SpecialState2,
  AlmostBuilt =   	nil
}
-- ----------------------------------------------------------------------------- --

function TerranConstruction_Medium_Init()
	playfram(0x00)	-- Frame set 0
	imgul(328, 0, 0)	-- Terran Construction (Medium) Shadow (terran\tb3Shad.grp)
	ScourgeLocal00()
end

function TerranConstruction_Medium_SpecialState1()
	playfram(1)	-- Frame set 0,  direction 1
	ScourgeLocal00()
end

function TerranConstruction_Medium_SpecialState2()
	playfram(2)	-- Frame set 0,  direction 2
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 330 Terran Construction (Small) (terran\TBldSml.grp)
iscript[140] = {
  IsId =          	140,
  Type =          	14,
  Init =          	TerranConstruction_Small_Init,
  Death =         	AcademyDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	nil,
  WalkingToIdle = 	nil,
  SpecialState1 = 	TerranConstruction_Small_SpecialState1,
  SpecialState2 = 	TerranConstruction_Small_SpecialState2,
  AlmostBuilt =   	nil
}
-- ----------------------------------------------------------------------------- --

function TerranConstruction_Small_Init()
	playfram(0x00)	-- Frame set 0
	imgul(331, 0, 0)	-- Terran Construction (Small) Shadow (terran\tb1Shad.grp)
	ScourgeLocal00()
end

function TerranConstruction_Small_SpecialState1()
	playfram(1)	-- Frame set 0,  direction 1
	ScourgeLocal00()
end

function TerranConstruction_Small_SpecialState2()
	playfram(2)	-- Frame set 0,  direction 2
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 329 Addon Construction (terran\TBldSml.grp)
iscript[141] = {
  IsId =          	141,
  Type =          	14,
  Init =          	TerranConstruction_Small_Init,
  Death =         	AcademyDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	nil,
  WalkingToIdle = 	nil,
  SpecialState1 = 	ScourgeLocal00,
  SpecialState2 = 	ScourgeLocal00,
  AlmostBuilt =   	nil
}
-- ----------------------------------------------------------------------------- --

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 213 Explosion1 (Small) (thingy\tBangS.grp)
-- 332 Explosion2 (Small) (thingy\tBangS.grp)
iscript[142] = {
  IsId =          	142,
  Type =          	0,
  Init =          	Explosion_Small_Init,
  Death =         	nil
}
-- ----------------------------------------------------------------------------- --

function Explosion_Small_Init()
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(2) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(2) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(2) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 214 Explosion1 (Medium) (thingy\tBangL.grp)
-- 333 Explosion2 (Medium) (thingy\tBangL.grp)
iscript[143] = {
  IsId =          	143,
  Type =          	0,
  Init =          	Explosion_Medium_Init,
  Death =         	nil
}
-- ----------------------------------------------------------------------------- --

function Explosion_Medium_Init()
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(2) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(2) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(2) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(2) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 215 Explosion (Large) (thingy\tBangX.grp)
-- 334 Building Explosion (Large) (thingy\tBangX.grp)
iscript[144] = {
  IsId =          	144,
  Type =          	0,
  Init =          	Explosion_Large_Init,
  Death =         	nil
}
-- ----------------------------------------------------------------------------- --

function Explosion_Large_Init()
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(2) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(2) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(2) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(2) 
	playfram(10)	-- Frame set 0,  direction 10
	wait(2) 
	playfram(11)	-- Frame set 0,  direction 11
	wait(2) 
	playfram(12)	-- Frame set 0,  direction 12
	wait(2) 
	playfram(13)	-- Frame set 0,  direction 13
	wait(2) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 110 Zerg Building Rubble (Small) (thingy\ZRubbleS.grp)
-- 111 Zerg Building Rubble (Large) (thingy\ZRubbleL.grp)
-- 216 Protoss Building Rubble (Small) (thingy\PRubbleS.grp)
-- 217 Protoss Building Rubble (Large) (thingy\PRubbleL.grp)
-- 335 Terran Building Rubble (Small) (thingy\RubbleS.grp)
-- 336 Terran Building Rubble (Large) (thingy\RubbleL.grp)
iscript[145] = {
  IsId =          	145,
  Type =          	1,
  Init =          	BuildingRubbleHeaderInit,
  Death =         	ScourgeExplosionDeath
}
-- ----------------------------------------------------------------------------- --

function BuildingRubbleHeaderInit()
	playfram(0x00)	-- Frame set 0
	wait(125) 
	wait(125) 
	wait(125) 
	wait(125) 
	wait(125) 
	wait(125) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(125) 
	wait(125) 
	wait(125) 
	wait(125) 
	wait(125) 
	wait(125) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(125) 
	wait(125) 
	wait(125) 
	wait(125) 
	wait(125) 
	wait(125) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(125) 
	wait(125) 
	wait(125) 
	wait(125) 
	wait(125) 
	wait(125) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 130 Arbiter (protoss\arbiter.grp)
iscript[146] = {
  IsId =          	146,
  Type =          	21,
  Init =          	ArbiterInit,
  Death =         	ArbiterDeath,
  GndAttkInit =   	ArbiterGndAttkInit,
  AirAttkInit =   	ArbiterGndAttkInit,
  Unused1 =       	nil,
  GndAttkRpt =    	ArbiterGndAttkRpt,
  AirAttkRpt =    	ArbiterGndAttkRpt,
  CastSpell =     	ArbiterCastSpell,
  GndAttkToIdle = 	OverlordLocal00,
  AirAttkToIdle = 	OverlordLocal00,
  Unused2 =       	nil,
  Walking =       	ArbiterWalking,
  WalkingToIdle = 	OverlordLocal00,
  SpecialState1 = 	nil,
  SpecialState2 = 	nil,
  AlmostBuilt =   	nil,
  Built =         	nil,
  Landing =       	nil,
  LiftOff =       	nil,
  IsWorking =     	nil,
  WorkingToIdle = 	nil,
  WarpIn =        	ArbiterWarpIn
}
-- ----------------------------------------------------------------------------- --

function ArbiterInit()
	imgul(131, 0, 42)	-- Arbiter Shadow (protoss\arbiter.grp)
	playfram(0x00)	-- Frame set 0
	OverlordLocal00()
end

function ArbiterDeath()
	playsnd(7)	-- Misc\ExploLrg.wav
	imgol(213, 0, 0)	-- Explosion1 (Small) (thingy\tBangS.grp)
	wait(3) 
end

function ArbiterGndAttkInit()
	setvertpos(0) 
	ArbiterGndAttkRpt()
end

function ArbiterGndAttkRpt()
	playfram(0x11)	-- Frame set 1
	wait(1) 
	nobrkcodestart()
	attackwith(1) 
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(0x11)	-- Frame set 1
	wait(1) 
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(0x11)	-- Frame set 1
	wait(1) 
	playfram(0x00)	-- Frame set 0
	nobrkcodeend()
	gotorepeatattk()
	ScourgeLocal00()
end

function ArbiterCastSpell()
	nobrkcodestart()
	wait(1) 
	playsnd(548)	-- Protoss\ARBITER\PAbCag00.WAV
	castspell()
	nobrkcodeend()
	gotorepeatattk()
	sigorder(2) 
	ScourgeLocal00()
end

function ArbiterWalking()
	imgol(132, 0, 0)	-- Arbiter Engines (thingy\pabGlow.grp)
	playfram(0x00)	-- Frame set 0
	setvertpos(0) 
	ScourgeLocal00()
end

function ArbiterWarpIn()
	imgol(133, 0, 0)	-- Arbiter Warp Flash (protoss\arbiter.grp)
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 134 Archon Energy (protoss\archon.grp)
iscript[147] = {
  IsId =          	147,
  Type =          	13,
  Init =          	ArchonEnergyInit,
  Death =         	ArchonEnergyDeath,
  GndAttkInit =   	ArchonEnergyGndAttkInit,
  AirAttkInit =   	ArchonEnergyGndAttkInit,
  Unused1 =       	nil,
  GndAttkRpt =    	ArchonEnergyGndAttkInit,
  AirAttkRpt =    	ArchonEnergyGndAttkInit,
  CastSpell =     	nil,
  GndAttkToIdle = 	ArchonEnergyGndAttkInit,
  AirAttkToIdle = 	ArchonEnergyGndAttkInit,
  Unused2 =       	nil,
  Walking =       	ArchonEnergyGndAttkInit,
  WalkingToIdle = 	ArchonEnergyGndAttkInit,
  SpecialState1 = 	ArchonEnergySpecialState1
}
-- ----------------------------------------------------------------------------- --

function ArchonEnergyInit()
	playfram(18)	-- Frame set 1,  direction 1
	wait(1) 
	nobrkcodestart()
	wait(1) 
	playfram(19)	-- Frame set 1,  direction 2
	wait(2) 
	playfram(20)	-- Frame set 1,  direction 3
	wait(2) 
	playfram(21)	-- Frame set 1,  direction 4
	wait(2) 
	playfram(22)	-- Frame set 1,  direction 5
	wait(2) 
	playfram(23)	-- Frame set 1,  direction 6
	wait(2) 
	playfram(24)	-- Frame set 1,  direction 7
	wait(2) 
	playfram(25)	-- Frame set 1,  direction 8
	wait(2) 
	playfram(26)	-- Frame set 1,  direction 9
	wait(2) 
	imgol(135, 0, 0)	-- Archon Being (protoss\archonT.grp)
	imgol(136, 0, 0)	-- Archon Swirl (protoss\archonT2.grp)
	sigorder(4) 
	nobrkcodeend()
	wait(2) 
	ArchonEnergyGndAttkInit()
end

function ArchonEnergyGndAttkInit()
::ArchonEnergyGndAttkInit_label::
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(1) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(1) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(1) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(1) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(1) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(1) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(1) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(1) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(1) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(1) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(1) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(1) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(1) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(1) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(1) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	goto ArchonEnergyGndAttkInit_label
end

function ArchonEnergyDeath()
	playsnd(7)	-- Misc\ExploLrg.wav
	imgol(214, 0, 0)	-- Explosion1 (Medium) (thingy\tBangL.grp)
	wait(3) 
end

function ArchonEnergySpecialState1()
	playsnd(617)	-- Protoss\TEMPLAR\PTeSum00.WAV
	playfram(10)	-- Frame set 0,  direction 10
	wait(2) 
	playfram(11)	-- Frame set 0,  direction 11
	wait(2) 
	ArchonEnergyLocal00()
end

function ArchonEnergyLocal00()
::ArchonEnergyLocal00_label::
	playfram(12)	-- Frame set 0,  direction 12
	wait(2) 
	playfram(13)	-- Frame set 0,  direction 13
	wait(2) 
	playfram(14)	-- Frame set 0,  direction 14
	wait(2) 
	playfram(15)	-- Frame set 0,  direction 15
	wait(2) 
	playfram(16)	-- Frame set 0,  direction 16
	wait(2) 
	playfram(0x11)	-- Frame set 1
	wait(2) 
	playfram(16)	-- Frame set 0,  direction 16
	wait(2) 
	playfram(15)	-- Frame set 0,  direction 15
	wait(2) 
	playfram(14)	-- Frame set 0,  direction 14
	wait(2) 
	playfram(13)	-- Frame set 0,  direction 13
	wait(2) 
	goto ArchonEnergyLocal00_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 135 Archon Being (protoss\archonT.grp)
iscript[148] = {
  IsId =          	148,
  Type =          	12,
  Init =          	ArchonBeingInit,
  Death =         	ScourgeExplosionDeath,
  GndAttkInit =   	ArchonBeingGndAttkInit,
  AirAttkInit =   	ArchonBeingGndAttkInit,
  Unused1 =       	nil,
  GndAttkRpt =    	ArchonBeingGndAttkInit,
  AirAttkRpt =    	ArchonBeingGndAttkInit,
  CastSpell =     	nil,
  GndAttkToIdle = 	ArchonBeingGndAttkToIdle,
  AirAttkToIdle = 	ArchonBeingGndAttkToIdle,
  Unused2 =       	nil,
  Walking =       	ArchonBeingGndAttkToIdle,
  WalkingToIdle = 	ArchonBeingGndAttkToIdle,
  SpecialState1 = 	nil
}
-- ----------------------------------------------------------------------------- --

function ArchonBeingInit()
	setfldirect(15) 
	ArchonBeingGndAttkToIdle()
end

function ArchonBeingGndAttkToIdle()
::ArchonBeingGndAttkToIdle_label::
	playfram(0xaa)	-- Frame set 10
	wait(4) 
	playfram(0xbb)	-- Frame set 11
	wait(4) 
	playfram(0xcc)	-- Frame set 12
	wait(4) 
	playfram(0xdd)	-- Frame set 13
	wait(4) 
	playfram(0xcc)	-- Frame set 12
	wait(4) 
	playfram(0xbb)	-- Frame set 11
	wait(4) 
	goto ArchonBeingGndAttkToIdle_label
end

function ArchonBeingGndAttkInit()
	playfram(0x00)	-- Frame set 0
	wait(1) 
	nobrkcodestart()
	playfram(0x11)	-- Frame set 1
	wait(1) 
	playfram(0x22)	-- Frame set 2
	wait(1) 
	playfram(0x33)	-- Frame set 3
	wait(1) 
	playfram(0x44)	-- Frame set 4
	wait(1) 
	playfram(0x55)	-- Frame set 5
	trgtrangecondjmp(48, ArchonBeingLocal00)
	imgoluselo(549, 0, 0)	-- Archon Beam (thingy\emsBeam.grp)
	playsnd(58)	-- Bullet\PArFir00.wav
	attack()
	wait(1) 
	playfram(0x66)	-- Frame set 6
	wait(3) 
	playfram(0x77)	-- Frame set 7
	wait(1) 
	playfram(0x88)	-- Frame set 8
	wait(1) 
	playfram(0x99)	-- Frame set 9
	wait(1) 
	playfram(0x22)	-- Frame set 2
	wait(2) 
	playfram(0x11)	-- Frame set 1
	wait(2) 
	playfram(0x00)	-- Frame set 0
	wait(2) 
	nobrkcodeend()
	gotorepeatattk()
	ArchonBeingGndAttkToIdle()
end

function ArchonBeingLocal00()
	playsnd(58)	-- Bullet\PArFir00.wav
	attack()
	wait(1) 
	playfram(0x66)	-- Frame set 6
	wait(3) 
	playfram(0x77)	-- Frame set 7
	wait(1) 
	playfram(0x88)	-- Frame set 8
	wait(1) 
	playfram(0x99)	-- Frame set 9
	wait(1) 
	playfram(0x22)	-- Frame set 2
	wait(2) 
	playfram(0x11)	-- Frame set 1
	wait(2) 
	playfram(0x00)	-- Frame set 0
	wait(2) 
	nobrkcodeend()
	gotorepeatattk()
	ArchonBeingGndAttkToIdle()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 136 Archon Swirl (protoss\archonT2.grp)
iscript[149] = {
  IsId =          	149,
  Type =          	1,
  Init =          	ArchonSwirlInit,
  Death =         	ScourgeExplosionDeath
}
-- ----------------------------------------------------------------------------- --

function ArchonSwirlInit()
	tmprmgraphicstart()
	waitrand(1, 5) 
	tmprmgraphicend()
	ArchonSwirlLocal00()
end

function ArchonSwirlLocal00()
::ArchonSwirlLocal00_label::
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(1) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(1) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(1) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(1) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(1) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(1) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(1) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(1) 
	playfram(10)	-- Frame set 0,  direction 10
	wait(1) 
	playfram(11)	-- Frame set 0,  direction 11
	wait(1) 
	playfram(12)	-- Frame set 0,  direction 12
	wait(1) 
	playfram(13)	-- Frame set 0,  direction 13
	wait(1) 
	playfram(14)	-- Frame set 0,  direction 14
	wait(1) 
	goto ArchonSwirlLocal00_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 112 Carrier (protoss\carrier.grp)
iscript[151] = {
  IsId =          	151,
  Type =          	21,
  Init =          	CarrierInit,
  Death =         	CarrierDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	CarrierWalking,
  WalkingToIdle = 	OverlordLocal00,
  SpecialState1 = 	nil,
  SpecialState2 = 	nil,
  AlmostBuilt =   	nil,
  Built =         	nil,
  Landing =       	nil,
  LiftOff =       	nil,
  IsWorking =     	nil,
  WorkingToIdle = 	nil,
  WarpIn =        	CarrierWarpIn
}
-- ----------------------------------------------------------------------------- --

function CarrierInit()
	imgulnextid(0, 42) 
	playfram(0x00)	-- Frame set 0
	OverlordLocal00()
end

function CarrierDeath()
	playsnd(595)	-- Protoss\Carrier\PCaDth00.WAV | Protoss\Carrier\PCaDth01.WAV
	imgol(214, 0, 0)	-- Explosion1 (Medium) (thingy\tBangL.grp)
	wait(3) 
end

function CarrierWalking()
	imgol(114, 0, 0)	-- Carrier Engines (thingy\pcaGlow.grp)
	ScourgeLocal00()
end

function CarrierWarpIn()
	imgol(115, 0, 0)	-- Carrier Warp Flash (protoss\carrier.grp)
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 129 Dark Templar (Hero) (protoss\dtemplar.grp)
iscript[152] = {
  IsId =          	152,
  Type =          	12,
  Init =          	DarkTemplar_Hero_Init,
  Death =         	DarkTemplar_Hero_Death,
  GndAttkInit =   	DarkTemplar_Hero_GndAttkInit,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	DarkTemplar_Hero_GndAttkInit,
  AirAttkRpt =    	nil,
  CastSpell =     	DarkTemplar_Hero_CastSpell,
  GndAttkToIdle = 	ScourgeLocal00,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	DarkTemplar_Hero_Walking,
  WalkingToIdle = 	DarkTemplar_Hero_Init,
  SpecialState1 = 	nil
}
-- ----------------------------------------------------------------------------- --

function DarkTemplar_Hero_Init()
	playfram(0xdd)	-- Frame set 13
	ScourgeLocal00()
end

function DarkTemplar_Hero_Death()
	playsnd(741)	-- Protoss\DARKTEMPLAR\PDTDth00.WAV
	imgol(153, 0, 0)	-- Zealot Death (protoss\zealot.grp)
	wait(1) 
end

function DarkTemplar_Hero_GndAttkInit()
	playsnd(111)	-- Bullet\UZeFir00.wav
	playfram(0x00)	-- Frame set 0
	wait(1) 
	nobrkcodestart()
	playfram(0x11)	-- Frame set 1
	wait(1) 
	playfram(0x22)	-- Frame set 2
	wait(1) 
	playfram(0x33)	-- Frame set 3
	wait(1) 
	playfram(0x44)	-- Frame set 4
	wait(1) 
	attackwith(1) 
	playfram(0x55)	-- Frame set 5
	wait(1) 
	playfram(0x66)	-- Frame set 6
	wait(1) 
	playfram(0x77)	-- Frame set 7
	wait(1) 
	playfram(0x88)	-- Frame set 8
	wait(1) 
	playfram(0x99)	-- Frame set 9
	wait(1) 
	nobrkcodeend()
	gotorepeatattk()
	DarkTemplar_Hero_Init()
end

function DarkTemplar_Hero_CastSpell()
	castspell()
	sigorder(2) 
	gotorepeatattk()
	DarkTemplar_Hero_Init()
end

function DarkTemplar_Hero_Walking()
::DarkTemplar_Hero_Walking_label::
	move(4) 
	wait(1) 
	playfram(0xee)	-- Frame set 14
	move(4) 
	wait(1) 
	playfram(0xff)	-- Frame set 15
	move(4) 
	wait(1) 
	playfram(0x110)	-- Frame set 16
	move(4) 
	wait(1) 
	playfram(0x121)	-- Frame set 17
	move(4) 
	wait(1) 
	playfram(0xaa)	-- Frame set 10
	move(4) 
	wait(1) 
	playfram(0xbb)	-- Frame set 11
	move(4) 
	wait(1) 
	playfram(0xcc)	-- Frame set 12
	move(4) 
	wait(1) 
	playfram(0xdd)	-- Frame set 13
	goto DarkTemplar_Hero_Walking_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 122 Dragoon (protoss\dragoon.grp)
iscript[153] = {
  IsId =          	153,
  Type =          	21,
  Init =          	DragoonInit,
  Death =         	DragoonDeath,
  GndAttkInit =   	DragoonGndAttkInit,
  AirAttkInit =   	DragoonGndAttkInit,
  Unused1 =       	nil,
  GndAttkRpt =    	DragoonGndAttkRpt,
  AirAttkRpt =    	DragoonGndAttkRpt,
  CastSpell =     	nil,
  GndAttkToIdle = 	DragoonGndAttkToIdle,
  AirAttkToIdle = 	DragoonGndAttkToIdle,
  Unused2 =       	nil,
  Walking =       	DragoonWalking,
  WalkingToIdle = 	DragoonWalkingToIdle,
  SpecialState1 = 	nil,
  SpecialState2 = 	nil,
  AlmostBuilt =   	nil,
  Built =         	nil,
  Landing =       	nil,
  LiftOff =       	nil,
  IsWorking =     	nil,
  WorkingToIdle = 	nil,
  WarpIn =        	DragoonWarpIn
}
-- ----------------------------------------------------------------------------- --

function DragoonInit()
	imgul(123, 0, 0)	-- Dragoon Shadow (protoss\pdrShad.grp)
	DragoonWalkingToIdle()
end

function DragoonWalkingToIdle()
	playfram(0x00)	-- Frame set 0
	waitrand(1, 3) 
	DragoonLocal00()
end

function DragoonLocal00()
::DragoonLocal00_label::
	playfram(0x11)	-- Frame set 1
	wait(2) 
	playfram(0x22)	-- Frame set 2
	wait(2) 
	playfram(0x33)	-- Frame set 3
	wait(2) 
	playfram(0x44)	-- Frame set 4
	wait(2) 
	playfram(0x55)	-- Frame set 5
	wait(2) 
	playfram(0x66)	-- Frame set 6
	wait(2) 
	playfram(0x77)	-- Frame set 7
	wait(2) 
	playfram(0x00)	-- Frame set 0
	wait(2) 
	goto DragoonLocal00_label
end

function DragoonDeath()
	playsnd(493)	-- Protoss\DRAGOON\PDrDth00.WAV
	setfldirect(0) 
	playfram(0x198)	-- Frame set 24
	wait(2) 
	playfram(409)	-- Frame set 24,  direction 1
	wait(2) 
	playfram(410)	-- Frame set 24,  direction 2
	wait(2) 
	playfram(411)	-- Frame set 24,  direction 3
	wait(2) 
	playfram(412)	-- Frame set 24,  direction 4
	wait(2) 
	playfram(413)	-- Frame set 24,  direction 5
	wait(2) 
	playfram(414)	-- Frame set 24,  direction 6
	wait(2) 
	lowsprul(192, 0, 0)	-- Dragoon Remnants (protoss\pdrDeath.grp)
	wait(1) 
end

function DragoonGndAttkInit()
	playfram(0x110)	-- Frame set 16
	wait(1) 
	playfram(0x121)	-- Frame set 17
	wait(1) 
	playfram(0x132)	-- Frame set 18
	wait(1) 
	playfram(0x143)	-- Frame set 19
	wait(1) 
	playfram(0x154)	-- Frame set 20
	wait(1) 
	playfram(0x165)	-- Frame set 21
	wait(1) 
	DragoonGndAttkRpt()
end

function DragoonGndAttkRpt()
	playfram(0x176)	-- Frame set 22
	wait(1) 
	playfram(0x187)	-- Frame set 23
	wait(1) 
	attackwith(1) 
	playfram(0x176)	-- Frame set 22
	wait(1) 
	playfram(0x165)	-- Frame set 21
	gotorepeatattk()
	ignorerest()
	DragoonGndAttkToIdle()
end

function DragoonGndAttkToIdle()
	wait(1) 
	playfram(0x154)	-- Frame set 20
	wait(1) 
	playfram(0x143)	-- Frame set 19
	wait(1) 
	playfram(0x132)	-- Frame set 18
	wait(1) 
	playfram(0x121)	-- Frame set 17
	wait(1) 
	playfram(0x110)	-- Frame set 16
	DragoonWalkingToIdle()
end

function DragoonWalking()
::DragoonWalking_label::
	move(4) 
	wait(1) 
	playfram(0x88)	-- Frame set 8
	move(6) 
	wait(1) 
	playfram(0x99)	-- Frame set 9
	move(8) 
	wait(1) 
	playfram(0xaa)	-- Frame set 10
	move(8) 
	wait(1) 
	playfram(0xbb)	-- Frame set 11
	move(2) 
	wait(1) 
	playfram(0xcc)	-- Frame set 12
	move(2) 
	wait(1) 
	playfram(0xdd)	-- Frame set 13
	move(6) 
	wait(1) 
	playfram(0xee)	-- Frame set 14
	move(6) 
	wait(1) 
	playfram(0xff)	-- Frame set 15
	goto DragoonWalking_label
end

function DragoonWarpIn()
	imgol(125, 0, 0)	-- Dragoon Warp Flash (protoss\dragoon.grp)
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 124 Dragoon Remnants (protoss\pdrDeath.grp)
iscript[154] = {
  IsId =          	154,
  Type =          	0,
  Init =          	DragoonRemnantsInit,
  Death =         	nil
}
-- ----------------------------------------------------------------------------- --

function DragoonRemnantsInit()
	playfram(0x00)	-- Frame set 0
	wait(50) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(50) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(50) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(50) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(50) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 116 Interceptor (protoss\Intercep.grp)
iscript[155] = {
  IsId =          	155,
  Type =          	12,
  Init =          	InterceptorInit,
  Death =         	InterceptorDeath,
  GndAttkInit =   	InterceptorGndAttkInit,
  AirAttkInit =   	InterceptorGndAttkInit,
  Unused1 =       	nil,
  GndAttkRpt =    	InterceptorGndAttkInit,
  AirAttkRpt =    	InterceptorGndAttkInit,
  CastSpell =     	nil,
  GndAttkToIdle = 	ScourgeLocal00,
  AirAttkToIdle = 	ScourgeLocal00,
  Unused2 =       	nil,
  Walking =       	InterceptorWalking,
  WalkingToIdle = 	OverlordLocal00,
  SpecialState1 = 	nil
}
-- ----------------------------------------------------------------------------- --

function InterceptorInit()
	imgul(117, 0, 42)	-- Interceptor Shadow (protoss\Intercep.grp)
	playfram(0x00)	-- Frame set 0
	OverlordLocal00()
end

function InterceptorDeath()
	playsnd(8)	-- Misc\ExploMed.wav
	imgol(213, 0, 0)	-- Explosion1 (Small) (thingy\tBangS.grp)
	wait(3) 
end

function InterceptorGndAttkInit()
	wait(1) 
	attackwith(1) 
	playfram(0x11)	-- Frame set 1
	wait(1) 
	playfram(0x00)	-- Frame set 0
	gotorepeatattk()
	ScourgeLocal00()
end

function InterceptorWalking()
	playfram(0x00)	-- Frame set 0
	setvertpos(0) 
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 137 Probe (protoss\probe.grp)
iscript[156] = {
  IsId =          	156,
  Type =          	21,
  Init =          	ProbeInit,
  Death =         	ProbeDeath,
  GndAttkInit =   	BattlecruiserLocal00,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	BattlecruiserLocal00,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	ScourgeLocal00,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	ProbeWalking,
  WalkingToIdle = 	ScourgeLocal00,
  SpecialState1 = 	nil,
  SpecialState2 = 	nil,
  AlmostBuilt =   	ProbeAlmostBuilt,
  Built =         	nil,
  Landing =       	nil,
  LiftOff =       	nil,
  IsWorking =     	nil,
  WorkingToIdle = 	nil,
  WarpIn =        	ProbeWarpIn
}
-- ----------------------------------------------------------------------------- --

function ProbeInit()
	imgul(138, 0, 7)	-- Probe Shadow (protoss\probe.grp)
	playfram(0x00)	-- Frame set 0
	ScourgeLocal00()
end

function ProbeDeath()
	playsnd(598)	-- Protoss\PROBE\PPrDth00.WAV
	imgol(213, 0, 0)	-- Explosion1 (Small) (thingy\tBangS.grp)
	wait(3) 
end

function ProbeWalking()
	setvertpos(0) 
	ScourgeLocal00()
end

function ProbeAlmostBuilt()
::ProbeAlmostBuilt_label::
	useweapon(63)	-- Particle Beam (Harvest) (Particle, Beam)
	wait(1) 
	waitrand(8, 10) 
	goto ProbeAlmostBuilt_label
end

function ProbeWarpIn()
	imgol(139, 0, 0)	-- Probe Warp Flash (protoss\probe.grp)
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 118 Shuttle (protoss\shuttle.grp)
iscript[157] = {
  IsId =          	157,
  Type =          	21,
  Init =          	ShuttleInit,
  Death =         	ShuttleDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	ShuttleWalking,
  WalkingToIdle = 	ShuttleWalkingToIdle,
  SpecialState1 = 	nil,
  SpecialState2 = 	nil,
  AlmostBuilt =   	nil,
  Built =         	nil,
  Landing =       	nil,
  LiftOff =       	nil,
  IsWorking =     	nil,
  WorkingToIdle = 	nil,
  WarpIn =        	ShuttleWarpIn
}
-- ----------------------------------------------------------------------------- --

function ShuttleInit()
	imgul(119, 0, 42)	-- Shuttle Shadow (protoss\shuttle.grp)
	ShuttleWalkingToIdle()
end

function ShuttleWalkingToIdle()
	playfram(0x00)	-- Frame set 0
	OverlordLocal00()
end

function ShuttleDeath()
	playsnd(514)	-- Protoss\SHUTTLE\PShDth00.WAV
	imgol(213, 0, 0)	-- Explosion1 (Small) (thingy\tBangS.grp)
	wait(3) 
end

function ShuttleWalking()
	imgol(120, 0, 0)	-- Shuttle Engines (thingy\pshGlow.grp)
	setvertpos(0) 
	playfram(0x00)	-- Frame set 0
	ScourgeLocal00()
end

function ShuttleWarpIn()
	imgol(121, 0, 0)	-- Shuttle Warp Flash (protoss\shuttle.grp)
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 126 High Templar (protoss\templar.grp)
iscript[158] = {
  IsId =          	158,
  Type =          	21,
  Init =          	HighTemplarInit,
  Death =         	HighTemplarDeath,
  GndAttkInit =   	HighTemplarGndAttkInit,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	HighTemplarGndAttkInit,
  AirAttkRpt =    	nil,
  CastSpell =     	HighTemplarCastSpell,
  GndAttkToIdle = 	HighTemplarGndAttkToIdle,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	HighTemplarWalking,
  WalkingToIdle = 	HighTemplarWalkingToIdle,
  SpecialState1 = 	nil,
  SpecialState2 = 	nil,
  AlmostBuilt =   	nil,
  Built =         	nil,
  Landing =       	nil,
  LiftOff =       	nil,
  IsWorking =     	nil,
  WorkingToIdle = 	nil,
  WarpIn =        	HighTemplarWarpIn
}
-- ----------------------------------------------------------------------------- --

function HighTemplarInit()
	imgul(127, 0, 0)	-- High Templar Shadow (protoss\pteShad.grp)
	playfram(0x66)	-- Frame set 6
	waitrand(1, 2) 
	HighTemplarGndAttkToIdle()
end

function HighTemplarGndAttkToIdle()
::HighTemplarGndAttkToIdle_label::
	playfram(0x66)	-- Frame set 6
	wait(2) 
	playfram(0x77)	-- Frame set 7
	wait(2) 
	playfram(0x88)	-- Frame set 8
	wait(2) 
	playfram(0x99)	-- Frame set 9
	wait(2) 
	playfram(0xaa)	-- Frame set 10
	wait(2) 
	playfram(0xbb)	-- Frame set 11
	wait(2) 
	playfram(0xcc)	-- Frame set 12
	wait(2) 
	goto HighTemplarGndAttkToIdle_label
end

function HighTemplarDeath()
	playsnd(635)	-- Protoss\TEMPLAR\PTeDth00.WAV
	setfldirect(0) 
	playfram(0x121)	-- Frame set 17
	wait(2) 
	playfram(290)	-- Frame set 17,  direction 1
	wait(2) 
	playfram(291)	-- Frame set 17,  direction 2
	wait(2) 
	playfram(292)	-- Frame set 17,  direction 3
	wait(2) 
	playfram(293)	-- Frame set 17,  direction 4
	wait(2) 
	playfram(294)	-- Frame set 17,  direction 5
	wait(2) 
	playfram(295)	-- Frame set 17,  direction 6
	wait(2) 
end

function HighTemplarGndAttkInit()
	playsnd(101)	-- Bullet\LaserB.wav
	playfram(0x00)	-- Frame set 0
	wait(1) 
	nobrkcodestart()
	playfram(0x11)	-- Frame set 1
	wait(1) 
	playfram(0x22)	-- Frame set 2
	wait(1) 
	playfram(0x33)	-- Frame set 3
	wait(1) 
	attackwith(1) 
	playfram(0x44)	-- Frame set 4
	wait(1) 
	nobrkcodeend()
	gotorepeatattk()
	playfram(0x66)	-- Frame set 6
	ScourgeLocal00()
end

function HighTemplarCastSpell()
	playfram(0x00)	-- Frame set 0
	nobrkcodestart()
	wait(1) 
	playfram(0x11)	-- Frame set 1
	wait(1) 
	playfram(0x22)	-- Frame set 2
	wait(1) 
	playfram(0x33)	-- Frame set 3
	wait(1) 
	castspell()
	sigorder(2) 
	playfram(0x44)	-- Frame set 4
	wait(1) 
	nobrkcodeend()
	gotorepeatattk()
	playfram(0x66)	-- Frame set 6
	ScourgeLocal00()
end

function HighTemplarWalking()
	playfram(0xee)	-- Frame set 14
	wait(1) 
	playfram(0xff)	-- Frame set 15
	wait(1) 
	playfram(0x110)	-- Frame set 16
	wait(1) 
	playfram(0x55)	-- Frame set 5
	setvertpos(0) 
	HighTemplarLocal00()
end

function HighTemplarLocal00()
::HighTemplarLocal00_label::
	wait(3) 
	spruluselo(320, 0, 0)	-- High Templar Glow (thingy\pteglow.grp)
	goto HighTemplarLocal00_label
end

function HighTemplarWalkingToIdle()
	playfram(0x110)	-- Frame set 16
	wait(1) 
	playfram(0xff)	-- Frame set 15
	wait(1) 
	playfram(0xee)	-- Frame set 14
	wait(1) 
	HighTemplarGndAttkToIdle()
end

function HighTemplarWarpIn()
	imgol(128, 0, 0)	-- High Templar Warp Flash (protoss\templar.grp)
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 144 Reaver (protoss\trilob.grp)
iscript[159] = {
  IsId =          	159,
  Type =          	21,
  Init =          	ReaverInit,
  Death =         	ReaverDeath,
  GndAttkInit =   	ReaverGndAttkInit,
  AirAttkInit =   	ReaverGndAttkInit,
  Unused1 =       	nil,
  GndAttkRpt =    	ReaverGndAttkInit,
  AirAttkRpt =    	ReaverGndAttkInit,
  CastSpell =     	nil,
  GndAttkToIdle = 	ReaverGndAttkToIdle,
  AirAttkToIdle = 	ReaverGndAttkToIdle,
  Unused2 =       	nil,
  Walking =       	ReaverWalking,
  WalkingToIdle = 	ReaverWalkingToIdle,
  SpecialState1 = 	nil,
  SpecialState2 = 	nil,
  AlmostBuilt =   	nil,
  Built =         	nil,
  Landing =       	nil,
  LiftOff =       	nil,
  IsWorking =     	nil,
  WorkingToIdle = 	nil,
  WarpIn =        	ReaverWarpIn
}
-- ----------------------------------------------------------------------------- --

function ReaverInit()
	imgul(145, 0, 0)	-- Reaver Shadow (protoss\ptrShad.grp)
	ReaverWalkingToIdle()
end

function ReaverWalkingToIdle()
	playfram(0x00)	-- Frame set 0
	ScourgeLocal00()
end

function ReaverDeath()
	playsnd(638)	-- Protoss\TRILOBYTE\PTrDth00.WAV
	imgol(214, 0, 0)	-- Explosion1 (Medium) (thingy\tBangL.grp)
	wait(3) 
end

function ReaverGndAttkInit()
	wait(1) 
	playsnd(102)	-- Bullet\pTrFir00.wav | Bullet\pTrFir01.wav
	attackwith(1) 
	wait(1) 
	gotorepeatattk()
	ignorerest()
	ReaverGndAttkToIdle()
end

function ReaverGndAttkToIdle()
	ReaverWalkingToIdle()
end

function ReaverWalking()
::ReaverWalking_label::
	move(0) 
	wait(1) 
	playfram(0x11)	-- Frame set 1
	move(0) 
	wait(1) 
	playfram(0x22)	-- Frame set 2
	move(1) 
	wait(1) 
	playfram(0x33)	-- Frame set 3
	move(1) 
	wait(1) 
	playfram(0x44)	-- Frame set 4
	move(2) 
	wait(1) 
	playfram(0x55)	-- Frame set 5
	move(2) 
	wait(1) 
	playfram(0x66)	-- Frame set 6
	move(3) 
	wait(1) 
	playfram(0x77)	-- Frame set 7
	move(1) 
	wait(1) 
	playfram(0x88)	-- Frame set 8
	move(6) 
	wait(1) 
	playfram(0x00)	-- Frame set 0
	goto ReaverWalking_label
end

function ReaverWarpIn()
	imgol(146, 0, 0)	-- Reaver Warp Flash (protoss\trilob.grp)
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 147 Scarab (protoss\sapper.grp)
iscript[160] = {
  IsId =          	160,
  Type =          	13,
  Init =          	ScarabInit,
  Death =         	ScarabDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	ScarabWalking,
  WalkingToIdle = 	ScarabInit,
  SpecialState1 = 	ScarabSpecialState1
}
-- ----------------------------------------------------------------------------- --

function ScarabInit()
	playfram(0x00)	-- Frame set 0
	ScourgeLocal00()
end

function ScarabDeath()
	imgol(444, 0, 0)	-- Scarab Hit (thingy\psaExplo.grp)
	wait(1) 
end

function ScarabWalking()
::ScarabWalking_label::
	setflspeed(2048) 
	move(16) 
	sprol(373, 0, 0)	-- Scarab/Anti-Matter Missile Overlay (thingy\HKTrail.grp)
	wait(1) 
	goto ScarabWalking_label
end

function ScarabSpecialState1()
	useweapon(82)	-- Scarab (Scarab)
	sigorder(1) 
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 140 Scout (protoss\scout.grp)
iscript[161] = {
  IsId =          	161,
  Type =          	21,
  Init =          	ScoutInit,
  Death =         	ScoutDeath,
  GndAttkInit =   	ScoutGndAttkInit,
  AirAttkInit =   	ScoutAirAttkInit,
  Unused1 =       	nil,
  GndAttkRpt =    	ScoutGndAttkInit,
  AirAttkRpt =    	ScoutAirAttkInit,
  CastSpell =     	nil,
  GndAttkToIdle = 	ScoutGndAttkToIdle,
  AirAttkToIdle = 	ScoutGndAttkToIdle,
  Unused2 =       	nil,
  Walking =       	ScoutWalking,
  WalkingToIdle = 	OverlordLocal00,
  SpecialState1 = 	nil,
  SpecialState2 = 	nil,
  AlmostBuilt =   	nil,
  Built =         	nil,
  Landing =       	nil,
  LiftOff =       	nil,
  IsWorking =     	nil,
  WorkingToIdle = 	nil,
  WarpIn =        	ScoutWarpIn
}
-- ----------------------------------------------------------------------------- --

function ScoutInit()
	imgul(141, 0, 42)	-- Scout Shadow (protoss\scout.grp)
	ScoutGndAttkToIdle()
end

function ScoutGndAttkToIdle()
	playfram(0x00)	-- Frame set 0
	OverlordLocal00()
end

function ScoutDeath()
	playsnd(533)	-- Protoss\Scout\PScDth00.WAV
	imgol(213, 0, 0)	-- Explosion1 (Small) (thingy\tBangS.grp)
	wait(3) 
end

function ScoutGndAttkInit()
	playfram(0x11)	-- Frame set 1
	wait(1) 
	attackwith(1) 
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(0x11)	-- Frame set 1
	wait(1) 
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(0x11)	-- Frame set 1
	wait(1) 
	playfram(0x00)	-- Frame set 0
	gotorepeatattk()
	ScourgeLocal00()
end

function ScoutAirAttkInit()
	playfram(0x11)	-- Frame set 1
	wait(1) 
	attackwith(2) 
	playfram(0x00)	-- Frame set 0
	gotorepeatattk()
	ScourgeLocal00()
end

function ScoutWalking()
	imgol(142, 0, 0)	-- Scout Engines (thingy\pscGlow.grp)
	playfram(0x00)	-- Frame set 0
	setvertpos(0) 
	ScourgeLocal00()
end

function ScoutWarpIn()
	imgol(143, 0, 0)	-- Scout Warp Flash (protoss\scout.grp)
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 142 Scout Engines (thingy\pscGlow.grp)
iscript[162] = {
  IsId =          	162,
  Type =          	12,
  Init =          	ScoutEnginesInit,
  Death =         	ScourgeExplosionDeath,
  GndAttkInit =   	ScourgeExplosionDeath,
  AirAttkInit =   	ScourgeExplosionDeath,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	ScourgeExplosionDeath,
  AirAttkToIdle = 	ScourgeExplosionDeath,
  Unused2 =       	nil,
  Walking =       	ScoutEnginesInit,
  WalkingToIdle = 	ScourgeExplosionDeath,
  SpecialState1 = 	nil
}
-- ----------------------------------------------------------------------------- --

function ScoutEnginesInit()
::ScoutEnginesInit_label::
	wait(1) 
	engframe(0) 
	wait(1) 
	engframe(17) 
	goto ScoutEnginesInit_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 151 Zealot (protoss\zealot.grp)
iscript[163] = {
  IsId =          	163,
  Type =          	21,
  Init =          	ZealotInit,
  Death =         	ZealotDeath,
  GndAttkInit =   	ZealotGndAttkInit,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	ZealotGndAttkRpt,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	ZealotGndAttkToIdle,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	ZealotWalking,
  WalkingToIdle = 	ZealotWalkingToIdle,
  SpecialState1 = 	nil,
  SpecialState2 = 	nil,
  AlmostBuilt =   	nil,
  Built =         	nil,
  Landing =       	nil,
  LiftOff =       	nil,
  IsWorking =     	nil,
  WorkingToIdle = 	nil,
  WarpIn =        	ZealotWarpIn
}
-- ----------------------------------------------------------------------------- --

function ZealotInit()
	imgul(152, 0, 0)	-- Zealot Shadow (protoss\pzeShad.grp)
	ZealotWalkingToIdle()
end

function ZealotWalkingToIdle()
	playfram(0x55)	-- Frame set 5
	ScourgeLocal00()
end

function ZealotDeath()
	playsnd(678)	-- Protoss\ZEALOT\PZeDth00.WAV
	ZealotLocal00()
end

function ZealotLocal00()
	setfldirect(0) 
	playfram(0xdd)	-- Frame set 13
	wait(2) 
	playfram(222)	-- Frame set 13,  direction 1
	wait(2) 
	playfram(223)	-- Frame set 13,  direction 2
	wait(2) 
	playfram(224)	-- Frame set 13,  direction 3
	wait(2) 
	playfram(225)	-- Frame set 13,  direction 4
	wait(2) 
	playfram(226)	-- Frame set 13,  direction 5
	wait(2) 
	playfram(227)	-- Frame set 13,  direction 6
	wait(2) 
end

function ZealotGndAttkInit()
	playfram(0x00)	-- Frame set 0
	wait(1) 
	ZealotGndAttkRpt()
end

function ZealotGndAttkRpt()
	playsnd(662)	-- Protoss\ZEALOT\pzeAtt00.WAV | Protoss\ZEALOT\pzeAtt01.WAV
	playfram(0x11)	-- Frame set 1
	wait(1) 
	nobrkcodestart()
	playfram(0x22)	-- Frame set 2
	wait(1) 
	playfram(0x33)	-- Frame set 3
	wait(1) 
	playfram(0x44)	-- Frame set 4
	attackmelee(664)	-- Protoss\ZEALOT\pzeHit00.WAV
	wait(1) 
	playfram(0x33)	-- Frame set 3
	wait(1) 
	playfram(0x22)	-- Frame set 2
	attackmelee(664)	-- Protoss\ZEALOT\pzeHit00.WAV
	wait(1) 
	playfram(0x11)	-- Frame set 1
	wait(1) 
	playfram(0x00)	-- Frame set 0
	nobrkcodeend()
	gotorepeatattk()
	ignorerest()
	ZealotGndAttkToIdle()
end

function ZealotGndAttkToIdle()
	ZealotWalkingToIdle()
end

function ZealotWalking()
::ZealotWalking_label::
	move(4) 
	wait(1) 
	playfram(0x55)	-- Frame set 5
	move(4) 
	wait(1) 
	playfram(0x66)	-- Frame set 6
	move(4) 
	wait(1) 
	playfram(0x77)	-- Frame set 7
	move(4) 
	wait(1) 
	playfram(0x88)	-- Frame set 8
	move(4) 
	wait(1) 
	playfram(0x99)	-- Frame set 9
	move(4) 
	wait(1) 
	playfram(0xaa)	-- Frame set 10
	move(4) 
	wait(1) 
	playfram(0xbb)	-- Frame set 11
	move(4) 
	wait(1) 
	playfram(0xcc)	-- Frame set 12
	goto ZealotWalking_label
end

function ZealotWarpIn()
	imgol(154, 0, 0)	-- Zealot Warp Flash (protoss\zealot.grp)
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 153 Zealot Death (protoss\zealot.grp)
iscript[164] = {
  IsId =          	164,
  Type =          	1,
  Init =          	ZealotLocal00,
  Death =         	ScourgeExplosionDeath
}
-- ----------------------------------------------------------------------------- --

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 148 Observer (protoss\witness.grp)
iscript[165] = {
  IsId =          	165,
  Type =          	21,
  Init =          	ObserverInit,
  Death =         	ObserverDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	ObserverWalking,
  WalkingToIdle = 	OverlordLocal00,
  SpecialState1 = 	nil,
  SpecialState2 = 	nil,
  AlmostBuilt =   	nil,
  Built =         	nil,
  Landing =       	nil,
  LiftOff =       	nil,
  IsWorking =     	nil,
  WorkingToIdle = 	nil,
  WarpIn =        	ObserverWarpIn
}
-- ----------------------------------------------------------------------------- --

function ObserverInit()
	imgul(149, 0, 42)	-- Observer Shadow (protoss\witness.grp)
	playfram(0x00)	-- Frame set 0
	OverlordLocal00()
end

function ObserverDeath()
	playsnd(651)	-- Protoss\Witness\PWiDth00.WAV | Protoss\Witness\PWiDth01.WAV
	imgol(214, 0, 0)	-- Explosion1 (Medium) (thingy\tBangL.grp)
	wait(3) 
end

function ObserverWalking()
	playfram(0x00)	-- Frame set 0
	setvertpos(0) 
	ScourgeLocal00()
end

function ObserverWarpIn()
	imgol(150, 0, 0)	-- Observer Warp Flash (protoss\witness.grp)
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 338 Ragnasaur (Ash) (neutral\Acritter.grp)
iscript[198] = {
  IsId =          	198,
  Type =          	12,
  Init =          	Ragnasaur_AshworldCritter_Init,
  Death =         	Ragnasaur_AshworldCritter_Death,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	Ragnasaur_AshworldCritter_Walking,
  WalkingToIdle = 	Ragnasaur_AshworldCritter_WalkingToIdle,
  SpecialState1 = 	nil
}
-- ----------------------------------------------------------------------------- --

function Ragnasaur_AshworldCritter_Init()
	imgul(339, 0, 0)	-- Ragnasaur (Ash) Shadow (neutral\nacShad.grp)
  Ragnasaur_AshworldCritter_WalkingToIdle()
end

function Ragnasaur_AshworldCritter_WalkingToIdle()
	playfram(0x66)	-- Frame set 6
	ScourgeLocal00()
end

function Ragnasaur_AshworldCritter_Death()
	playsnd(53)	-- Misc\CRITTERS\LCrDth00.wav
	setfldirect(0) 
	playfram(0x99)	-- Frame set 9
	wait(1) 
	playfram(154)	-- Frame set 9,  direction 1
	wait(1) 
	playfram(155)	-- Frame set 9,  direction 2
	wait(1) 
	playfram(156)	-- Frame set 9,  direction 3
	wait(1) 
	playfram(157)	-- Frame set 9,  direction 4
	wait(1) 
	playfram(158)	-- Frame set 9,  direction 5
	wait(1) 
	playfram(159)	-- Frame set 9,  direction 6
	wait(1) 
	playfram(160)	-- Frame set 9,  direction 7
	wait(1) 
end

function Ragnasaur_AshworldCritter_Walking()
::Ragnasaur_AshworldCritter_Walking_label::
	move(4) 
	wait(1) 
	playfram(0x77)	-- Frame set 7
	move(4) 
	wait(1) 
	playfram(0x88)	-- Frame set 8
	move(4) 
	wait(1) 
	playfram(0x00)	-- Frame set 0
	move(4) 
	wait(1) 
	playfram(0x11)	-- Frame set 1
	move(4) 
	wait(1) 
	playfram(0x22)	-- Frame set 2
	move(4) 
	wait(1) 
	playfram(0x33)	-- Frame set 3
	move(4) 
	wait(1) 
	playfram(0x44)	-- Frame set 4
	move(4) 
	wait(1) 
	playfram(0x55)	-- Frame set 5
	move(4) 
	wait(1) 
	playfram(0x66)	-- Frame set 6
	goto Ragnasaur_AshworldCritter_Walking_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 340 Rhynadon (Badlands) (neutral\Bcritter.grp)
iscript[199] = {
  IsId =          	199,
  Type =          	12,
  Init =          	Rhynadon_BadlandsCritter_Init,
  Death =         	Rhynadon_BadlandsCritter_Death,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	Rhynadon_BadlandsCritter_Walking,
  WalkingToIdle = 	Rhynadon_BadlandsCritter_WalkingToIdle,
  SpecialState1 = 	nil
}
-- ----------------------------------------------------------------------------- --

function Rhynadon_BadlandsCritter_Init()
	imgul(341, 0, 0)	-- Rhynadon (Badlands) Shadow (neutral\nbcShad.grp)
  Rhynadon_BadlandsCritter_WalkingToIdle()
end

function Rhynadon_BadlandsCritter_WalkingToIdle()
	playfram(0x66)	-- Frame set 6
	ScourgeLocal00()
end

function Rhynadon_BadlandsCritter_Death()
	playsnd(57)	-- Misc\CRITTERS\BCrDth00.wav
	setfldirect(0) 
	playfram(0xbb)	-- Frame set 11
	wait(1) 
	playfram(188)	-- Frame set 11,  direction 1
	wait(1) 
	playfram(189)	-- Frame set 11,  direction 2
	wait(1) 
	playfram(190)	-- Frame set 11,  direction 3
	wait(1) 
	playfram(191)	-- Frame set 11,  direction 4
	wait(1) 
	playfram(192)	-- Frame set 11,  direction 5
	wait(1) 
	playfram(193)	-- Frame set 11,  direction 6
	wait(1) 
	playfram(194)	-- Frame set 11,  direction 7
	wait(1) 
end

function Rhynadon_BadlandsCritter_Walking()
::Rhynadon_BadlandsCritter_Walking_label::
	move(4) 
	wait(1) 
	playfram(0x77)	-- Frame set 7
	move(4) 
	wait(1) 
	playfram(0x88)	-- Frame set 8
	move(4) 
	wait(1) 
	playfram(0x99)	-- Frame set 9
	move(4) 
	wait(1) 
	playfram(0xaa)	-- Frame set 10
	move(4) 
	wait(1) 
	playfram(0x00)	-- Frame set 0
	move(4) 
	wait(1) 
	playfram(0x11)	-- Frame set 1
	move(4) 
	wait(1) 
	playfram(0x22)	-- Frame set 2
	move(4) 
	wait(1) 
	playfram(0x33)	-- Frame set 3
	move(4) 
	wait(1) 
	playfram(0x44)	-- Frame set 4
	move(4) 
	wait(1) 
	playfram(0x55)	-- Frame set 5
	move(4) 
	wait(1) 
	playfram(0x66)	-- Frame set 6
	goto Rhynadon_BadlandsCritter_Walking_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 342 Bengalaas (Jungle) (neutral\Jcritter.grp)
iscript[200] = {
  IsId =          	200,
  Type =          	12,
  Init =          	Bengalaas_JungleCritter_Init,
  Death =         	Bengalaas_JungleCritter_Death,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	Bengalaas_JungleCritter_Walking,
  WalkingToIdle = 	Bengalaas_JungleCritter_WalkingToIdle,
  SpecialState1 = 	nil
}
-- ----------------------------------------------------------------------------- --

function Bengalaas_JungleCritter_Init()
	imgul(343, 0, 0)	-- Bengalaas (Jungle) Shadow (neutral\njcShad.grp)
  Bengalaas_JungleCritter_WalkingToIdle()
end

function Bengalaas_JungleCritter_WalkingToIdle()
	playfram(0x00)	-- Frame set 0
	ScourgeLocal00()
end

function Bengalaas_JungleCritter_Death()
	playsnd(49)	-- Misc\CRITTERS\JCrDth00.wav
	setfldirect(0) 
	playfram(0xcc)	-- Frame set 12
	wait(1) 
	playfram(205)	-- Frame set 12,  direction 1
	wait(1) 
	playfram(206)	-- Frame set 12,  direction 2
	wait(1) 
	playfram(207)	-- Frame set 12,  direction 3
	wait(1) 
	playfram(208)	-- Frame set 12,  direction 4
	wait(1) 
	playfram(209)	-- Frame set 12,  direction 5
	wait(1) 
	playfram(210)	-- Frame set 12,  direction 6
	wait(1) 
	playfram(211)	-- Frame set 12,  direction 7
	wait(1) 
end

function Bengalaas_JungleCritter_Walking()
::Bengalaas_JungleCritter_Walking_label::
	move(4) 
	wait(1) 
	playfram(0x11)	-- Frame set 1
	move(4) 
	wait(1) 
	playfram(0x22)	-- Frame set 2
	move(4) 
	wait(1) 
	playfram(0x33)	-- Frame set 3
	move(4) 
	wait(1) 
	playfram(0x44)	-- Frame set 4
	move(4) 
	wait(1) 
	playfram(0x55)	-- Frame set 5
	move(4) 
	wait(1) 
	playfram(0x66)	-- Frame set 6
	move(4) 
	wait(1) 
	playfram(0x77)	-- Frame set 7
	move(4) 
	wait(1) 
	playfram(0x88)	-- Frame set 8
	move(4) 
	wait(1) 
	playfram(0x99)	-- Frame set 9
	move(4) 
	wait(1) 
	playfram(0xaa)	-- Frame set 10
	move(4) 
	wait(1) 
	playfram(0xbb)	-- Frame set 11
	move(4) 
	wait(1) 
	playfram(0x00)	-- Frame set 0
	goto Bengalaas_JungleCritter_Walking_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 355 Zerg Beacon Overlay (zerg\zCirGlow.grp)
iscript[208] = {
  IsId =          	208,
  Type =          	1,
  Init =          	ZergBeaconOverlayInit,
  Death =         	ScourgeExplosionDeath
}
-- ----------------------------------------------------------------------------- --

function ZergBeaconOverlayInit()
::ZergBeaconOverlayInit_label::
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	goto ZergBeaconOverlayInit_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 357 Terran Beacon Overlay (terran\tCirGlow.grp)
iscript[209] = {
  IsId =          	209,
  Type =          	1,
  Init =          	TerranBeaconOverlayInit,
  Death =         	ScourgeExplosionDeath
}
-- ----------------------------------------------------------------------------- --

function TerranBeaconOverlayInit()
::TerranBeaconOverlayInit_label::
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	goto TerranBeaconOverlayInit_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 359 Protoss Beacon Overlay (protoss\pCirGlow.grp)
iscript[210] = {
  IsId =          	210,
  Type =          	1,
  Init =          	ProtossBeaconOverlayInit,
  Death =         	ScourgeExplosionDeath
}
-- ----------------------------------------------------------------------------- --

function ProtossBeaconOverlayInit()
::ProtossBeaconOverlayInit_label::
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	goto ProtossBeaconOverlayInit_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 354 Zerg Beacon (zerg\zmarker.grp)
iscript[211] = {
  IsId =          	211,
  Type =          	1,
  Init =          	ZergBeaconInit,
  Death =         	ScourgeExplosionDeath
}
-- ----------------------------------------------------------------------------- --

function ZergBeaconInit()
	playfram(0x00)	-- Frame set 0
	imgol(355, 0, 0)	-- Zerg Beacon Overlay (zerg\zCirGlow.grp)
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 358 Protoss Beacon (protoss\pMarker.grp)
iscript[212] = {
  IsId =          	212,
  Type =          	1,
  Init =          	ProtossBeaconInit,
  Death =         	ScourgeExplosionDeath
}
-- ----------------------------------------------------------------------------- --

function ProtossBeaconInit()
	playfram(0x00)	-- Frame set 0
	imgol(359, 0, 0)	-- Protoss Beacon Overlay (protoss\pCirGlow.grp)
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 356 Terran Beacon (terran\tMarker.grp)
iscript[213] = {
  IsId =          	213,
  Type =          	1,
  Init =          	TerranBeaconInit,
  Death =         	ScourgeExplosionDeath
}
-- ----------------------------------------------------------------------------- --

function TerranBeaconInit()
	playfram(0x00)	-- Frame set 0
	imgol(357, 0, 0)	-- Terran Beacon Overlay (terran\tCirGlow.grp)
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
iscript[214] = {
  IsId =          	214,
  Type =          	1,
  Init =          	Unknwon214Init,
  Death =         	Unknwon214Death
}
-- ----------------------------------------------------------------------------- --

function Unknwon214Init()
	playfram(0x00)	-- Frame set 0
	ScourgeLocal00()
end

function Unknwon214Death()
	imgol(332, 0, 0)	-- Explosion2 (Small) (thingy\tBangS.grp)
	wait(3) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 405 Mineral Chunk Shadow (neutral\norShad.grp)
-- 406 Protoss Gas Orb Shadow (neutral\ngoShad.grp)
-- 407 Zerg Gas Sac Shadow (neutral\ngsShad.grp)
-- 408 Terran Gas Tank Shadow (neutral\ngcShad.grp)
-- 409 Data Disk Shadow (Ground) (neutral\nddShad.grp)
-- 410 Data Disk Shadow (Carried) (neutral\nddSha2.grp)
-- 411 Flag Shadow (Ground) (neutral\nflShad.grp)
-- 412 Flag Shadow (Carried) (neutral\nflSha2.grp)
-- 413 Crystal Shadow (Ground) (neutral\nkhShad.grp)
-- 414 Crystal Shadow (Carried) (neutral\nkhSha2.grp)
-- 415 Young Chrysalis Shadow (Ground) (neutral\nkeShad.grp)
-- 416 Young Chrysalis Shadow (Carried) (neutral\nkeSha2.grp)
-- 417 Psi Emitter Shadow (Ground) (neutral\npsShad.grp)
-- 418 Psi Emitter Shadow (Carried) (neutral\npsSha2.grp)
iscript[215] = {
  IsId =          	215,
  Type =          	1,
  Init =          	PowerupsShadowHeaderInit,
  Death =         	ScourgeExplosionDeath
}
-- ----------------------------------------------------------------------------- --

function PowerupsShadowHeaderInit()
	playfram(0x00)	-- Frame set 0
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 392 Flag (neutral\Flag.grp)
iscript[216] = {
  IsId =          	216,
  Type =          	1,
  Init =          	FlagInit,
  Death =         	FlagDeath
}
-- ----------------------------------------------------------------------------- --

function FlagInit()
	playfram(0x00)	-- Frame set 0
	pwrupcondjmp(FlagLocal00)
	imgul(411, 0, 0)	-- Flag Shadow (Ground) (neutral\nflShad.grp)
	FlagLocal01()
end

function FlagLocal01()
::FlagLocal01_label::
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	goto FlagLocal01_label
end

function FlagLocal00()
	wait(1) 
	switchul(412)	-- Flag Shadow (Carried) (neutral\nflSha2.grp)
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	FlagLocal01()
end

function FlagDeath()
	imgol(332, 0, 0)	-- Explosion2 (Small) (thingy\tBangS.grp)
	wait(3) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 394 Psi Emitter (neutral\PsiEmit.grp)
iscript[217] = {
  IsId =          	217,
  Type =          	1,
  Init =          	PsiEmitterInit,
  Death =         	PsiEmitterDeath
}
-- ----------------------------------------------------------------------------- --

function PsiEmitterInit()
	pwrupcondjmp(PsiEmitterLocal00)
	imgul(417, 0, 0)	-- Psi Emitter Shadow (Ground) (neutral\npsShad.grp)
	PsiEmitterLocal01()
end

function PsiEmitterLocal01()
::PsiEmitterLocal01_label::
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(2) 
	goto PsiEmitterLocal01_label
end

function PsiEmitterLocal00()
	wait(1) 
	switchul(418)	-- Psi Emitter Shadow (Carried) (neutral\npsSha2.grp)
	PsiEmitterLocal01()
end

function PsiEmitterDeath()
	imgol(332, 0, 0)	-- Explosion2 (Small) (thingy\tBangS.grp)
	wait(3) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 395 Data Disc (neutral\DataDisk.grp)
iscript[218] = {
  IsId =          	218,
  Type =          	1,
  Init =          	DataDiskInit,
  Death =         	DataDiskDeath
}
-- ----------------------------------------------------------------------------- --

function DataDiskInit()
	playfram(0x00)	-- Frame set 0
	pwrupcondjmp(DataDiskLocal00)
	imgul(409, 0, 0)	-- Data Disk Shadow (Ground) (neutral\nddShad.grp)
	ScourgeLocal00()
end

function DataDiskLocal00()
	wait(1) 
	switchul(410)	-- Data Disk Shadow (Carried) (neutral\nddSha2.grp)
	ScourgeLocal00()
end

function DataDiskDeath()
	imgol(332, 0, 0)	-- Explosion2 (Small) (thingy\tBangS.grp)
	wait(3) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 396 Khaydarin Crystal (neutral\KhChunk.grp)
-- 958 Uraj (neutral\Uraj.grp)
-- 959 Khalis (neutral\Khalis.grp)
iscript[219] = {
  IsId =          	219,
  Type =          	1,
  Init =          	CrystalsShadowsInit,
  Death =         	CrystalsShadowsDeath
}
-- ----------------------------------------------------------------------------- --

function CrystalsShadowsInit()
	playfram(0x00)	-- Frame set 0
	pwrupcondjmp(CrystalsShadowsLocal00)
	imgul(413, 0, 0)	-- Crystal Shadow (Ground) (neutral\nkhShad.grp)
	ScourgeLocal00()
end

function CrystalsShadowsLocal00()
	wait(1) 
	switchul(414)	-- Crystal Shadow (Carried) (neutral\nkhSha2.grp)
	ScourgeLocal00()
end

function CrystalsShadowsDeath()
	imgol(332, 0, 0)	-- Explosion2 (Small) (thingy\tBangS.grp)
	wait(3) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 393 Young Chrysalis (neutral\KerrEgg.grp)
iscript[220] = {
  IsId =          	220,
  Type =          	1,
  Init =          	YoungChrysalisInit,
  Death =         	YoungChrysalisDeath
}
-- ----------------------------------------------------------------------------- --

function YoungChrysalisInit()
	playfram(0x00)	-- Frame set 0
	pwrupcondjmp(YoungChrysalisLocal00)
	imgul(415, 0, 0)	-- Young Chrysalis Shadow (Ground) (neutral\nkeShad.grp)
	ScourgeLocal00()
end

function YoungChrysalisLocal00()
	wait(1) 
	switchul(416)	-- Young Chrysalis Shadow (Carried) (neutral\nkeSha2.grp)
	ScourgeLocal00()
end

function YoungChrysalisDeath()
	imgol(332, 0, 0)	-- Explosion2 (Small) (thingy\tBangS.grp)
	wait(3) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 397 Mineral Chunk   Type =1 (neutral\OreChunk.grp)
iscript[221] = {
  IsId =          	221,
  Type =          	1,
  Init =          	OreChunkInit,
  Death =         	OreChunkDeath
}
-- ----------------------------------------------------------------------------- --

function OreChunkInit()
	playfram(0x00)	-- Frame set 0
	pwrupcondjmp(ScourgeLocal00)
	imgul(405, 0, 0)	-- Mineral Chunk Shadow (neutral\norShad.grp)
	ScourgeLocal00()
end

function OreChunkDeath()
	imgol(332, 0, 0)	-- Explosion2 (Small) (thingy\tBangS.grp)
	wait(3) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 398 Mineral Chunk   Type =2 (neutral\OreChunk.grp)
iscript[222] = {
  IsId =          	222,
  Type =          	1,
  Init =          	OreChunkInit,
  Death =         	OreChunkDeath
}
-- ----------------------------------------------------------------------------- --

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 401 Zerg Gas Sac   Type =1 (neutral\GasSac.grp)
iscript[223] = {
  IsId =          	223,
  Type =          	1,
  Init =          	GasSacInit,
  Death =         	GasSacDeath
}
-- ----------------------------------------------------------------------------- --

function GasSacInit()
	playfram(0x00)	-- Frame set 0
	pwrupcondjmp(ScourgeLocal00)
	imgul(407, 0, 0)	-- Zerg Gas Sac Shadow (neutral\ngsShad.grp)
	ScourgeLocal00()
end

function GasSacDeath()
	imgol(332, 0, 0)	-- Explosion2 (Small) (thingy\tBangS.grp)
	wait(3) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 402 Zerg Gas Sac   Type =2 (neutral\GasSac.grp)
iscript[224] = {
  IsId =          	224,
  Type =          	1,
  Init =          	GasSac2Init,
  Death =         	GasSacDeath
}
-- ----------------------------------------------------------------------------- --

function GasSac2Init()
	playfram(0x11)	-- Frame set 1
	pwrupcondjmp(ScourgeLocal00)
	imgul(407, 0, 0)	-- Zerg Gas Sac Shadow (neutral\ngsShad.grp)
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 399 Protoss Gas Orb   Type =1 (neutral\GasOrb.grp)
iscript[225] = {
  IsId =          	225,
  Type =          	1,
  Init =          	GasOrbInit,
  Death =         	GasOrbDeath
}
-- ----------------------------------------------------------------------------- --

function GasOrbInit()
	playfram(0x00)	-- Frame set 0
	pwrupcondjmp(ScourgeLocal00)
	imgul(406, 0, 0)	-- Protoss Gas Orb Shadow (neutral\ngoShad.grp)
	ScourgeLocal00()
end

function GasOrbDeath()
	imgol(332, 0, 0)	-- Explosion2 (Small) (thingy\tBangS.grp)
	wait(3) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 400 Protoss Gas Orb   Type =2 (neutral\GasOrb.grp)
iscript[226] = {
  IsId =          	226,
  Type =          	1,
  Init =          	GasOrb2Init,
  Death =         	GasOrbDeath
}
-- ----------------------------------------------------------------------------- --

function GasOrb2Init()
	playfram(0x11)	-- Frame set 1
	pwrupcondjmp(ScourgeLocal00)
	imgul(406, 0, 0)	-- Protoss Gas Orb Shadow (neutral\ngoShad.grp)
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 403 Terran Gas Tank   Type =1 (neutral\GasTank.grp)
iscript[227] = {
  IsId =          	227,
  Type =          	1,
  Init =          	GasTankInit,
  Death =         	GasTankDeath
}
-- ----------------------------------------------------------------------------- --

function GasTankInit()
	playfram(0x00)	-- Frame set 0
	pwrupcondjmp(ScourgeLocal00)
	imgul(408, 0, 0)	-- Terran Gas Tank Shadow (neutral\ngcShad.grp)
	ScourgeLocal00()
end

function GasTankDeath()
	imgol(332, 0, 0)	-- Explosion2 (Small) (thingy\tBangS.grp)
	wait(3) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 404 Terran Gas Tank   Type =2 (neutral\GasTank.grp)
iscript[228] = {
  IsId =          	228,
  Type =          	1,
  Init =          	GasTank2Init,
  Death =         	GasTankDeath
}
-- ----------------------------------------------------------------------------- --

function GasTank2Init()
	playfram(1)	-- Frame set 0,  direction 1
	pwrupcondjmp(ScourgeLocal00)
	imgul(408, 0, 0)	-- Terran Gas Tank Shadow (neutral\ngcShad.grp)
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 549 Archon Beam (thingy\emsBeam.grp)
iscript[229] = {
  IsId =          	229,
  Type =          	1,
  Init =          	ArchonOverlayInit,
  Death =         	ArchonOverlayDeath
}
-- ----------------------------------------------------------------------------- --

function ArchonOverlayInit()
	nobrkcodestart()
	tmprmgraphicstart()
	trgtrangecondjmp(70, ArchonOverlayLocal00)
	playfram(0x00)	-- Frame set 0
	wait(1) 
	tmprmgraphicend()
	wait(1) 
	playfram(0x11)	-- Frame set 1
	wait(1) 
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(0x11)	-- Frame set 1
	wait(1) 
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(0x11)	-- Frame set 1
	wait(1) 
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(0x11)	-- Frame set 1
	wait(1) 
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(0x11)	-- Frame set 1
	wait(1) 
	ArchonOverlayDeath()
end

function ArchonOverlayDeath()
	nobrkcodeend()
	wait(1) 
end

function ArchonOverlayLocal00()
	playfram(0x22)	-- Frame set 2
	wait(1) 
	tmprmgraphicend()
	wait(1) 
	playfram(0x33)	-- Frame set 3
	wait(1) 
	playfram(0x22)	-- Frame set 2
	wait(1) 
	playfram(0x33)	-- Frame set 3
	wait(1) 
	playfram(0x22)	-- Frame set 2
	wait(1) 
	playfram(0x33)	-- Frame set 3
	wait(1) 
	playfram(0x22)	-- Frame set 2
	wait(1) 
	playfram(0x33)	-- Frame set 3
	wait(1) 
	playfram(0x22)	-- Frame set 2
	wait(1) 
	playfram(0x33)	-- Frame set 3
	wait(1) 
	nobrkcodeend()
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 520 Particle Beam Hit (bullet\ephFire.grp)
iscript[230] = {
  IsId =          	230,
  Type =          	2,
  Init =          	ParticleBeamHitInit,
  Death =         	ParticleBeamHitDeath,
  GndAttkInit =   	ParticleBeamHitDeath,
  AirAttkInit =   	nil
}
-- ----------------------------------------------------------------------------- --

function ParticleBeamHitInit()
	wait(1) 
	sigorder(1) 
	wait(1) 
	ParticleBeamHitDeath()
end

function ParticleBeamHitDeath()
	playfram(0x00)	-- Frame set 0
	playsnd(614)	-- Protoss\PROBE\PPrMin00.WAV
	domissiledmg()
	wait(1) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(1) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(1) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(1) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(1) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(1) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(1) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(1) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(1) 
	playfram(10)	-- Frame set 0,  direction 10
	wait(1) 
	playfram(11)	-- Frame set 0,  direction 11
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 519 Dual Photon Blasters Hit (bullet\pspark.grp)
iscript[231] = {
  IsId =          	231,
  Type =          	2,
  Init =          	DualPhotonBlasterHitInit,
  Death =         	DualPhotonBlasterHitDeath,
  GndAttkInit =   	DualPhotonBlasterHitDeath,
  AirAttkInit =   	nil
}
-- ----------------------------------------------------------------------------- --

function DualPhotonBlasterHitInit()
	wait(1) 
	sigorder(1) 
	wait(1) 
	DualPhotonBlasterHitDeath()
end

function DualPhotonBlasterHitDeath()
	playfram(0x00)	-- Frame set 0
	playsnd(66)	-- Bullet\BlastGn2.wav
	domissiledmg()
	wait(1) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(1) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(1) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(1) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(1) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(1) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 521 Anti-Matter Missile (bullet\hks.grp)
iscript[232] = {
  IsId =          	232,
  Type =          	2,
  Init =          	Anti_MatterMissileInit,
  Death =         	Anti_MatterMissileDeath,
  GndAttkInit =   	Anti_MatterMissileGndAttkInit,
  AirAttkInit =   	nil
}
-- ----------------------------------------------------------------------------- --

function Anti_MatterMissileInit()
	playfram(0x00)	-- Frame set 0
	playsnd(80)	-- Bullet\HKMISSLE.wav
	wait(1) 
	sigorder(1) 
  Anti_MatterMissileGndAttkInit()
end

function Anti_MatterMissileGndAttkInit()
::Anti_MatterMissileGndAttkInit_label::
	wait(2) 
	sprol(373, 0, 0)	-- Scarab/Anti-Matter Missile Overlay (thingy\HKTrail.grp)
	goto Anti_MatterMissileGndAttkInit_label
end

function Anti_MatterMissileDeath()
	imgol(442, 0, 0)	-- Anti-Matter Missile Hit (thingy\HKexplod.grp)
	domissiledmg()
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 522 Pulse Cannon (bullet\blastcan.grp)
iscript[233] = {
  IsId =          	233,
  Type =          	2,
  Init =          	PulseCannonInit,
  Death =         	PulseCannonDeath,
  GndAttkInit =   	PulseCannonGndAttkInit,
  AirAttkInit =   	nil
}
-- ----------------------------------------------------------------------------- --

function PulseCannonInit()
	playsnd(65)	-- Bullet\BlastCan.wav
	wait(1) 
	sigorder(1) 
	wait(1) 
	PulseCannonGndAttkInit()
end

function PulseCannonGndAttkInit()
::PulseCannonGndAttkInit_label::
	playfram(0x00)	-- Frame set 0
	wait(1) 
	goto PulseCannonGndAttkInit_label
end

function PulseCannonDeath()
	playsnd(9)	-- Misc\ExploSm.wav
	domissiledmg()
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 525 Psionic Storm (thingy\psiStorm.grp)
iscript[236] = {
  IsId =          	236,
  Type =          	14,
  Init =          	PsionicStormInit,
  Death =         	PsionicStormDeath,
  GndAttkInit =   	PsionicStormDeath,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	nil,
  WalkingToIdle = 	nil,
  SpecialState1 = 	nil,
  SpecialState2 = 	PsionicStormSpecialState2,
  AlmostBuilt =   	nil
}
-- ----------------------------------------------------------------------------- --

function PsionicStormInit()
	playfram(0x00)	-- Frame set 0
	playsnd(620)	-- Protoss\TEMPLAR\PTeSto00.WAV
	tmprmgraphicstart()
	wait(5) 
	sigorder(1) 
	PsionicStormDeath()
end

function PsionicStormDeath()
	wait(1) 
end

function PsionicStormSpecialState2()
	tmprmgraphicend()
	PsionicStormLocal00()
end

function PsionicStormLocal00()
::PsionicStormLocal00_label::
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(2) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(2) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(2) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(2) 
	playfram(10)	-- Frame set 0,  direction 10
	wait(2) 
	playfram(11)	-- Frame set 0,  direction 11
	wait(2) 
	playfram(12)	-- Frame set 0,  direction 12
	wait(2) 
	playfram(13)	-- Frame set 0,  direction 13
	wait(2) 
	goto PsionicStormLocal00_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 526 Fusion Cutter Hit (bullet\scvspark.grp)
iscript[237] = {
  IsId =          	237,
  Type =          	2,
  Init =          	FusionCutterHitInit,
  Death =         	FusionCutterHitDeath,
  GndAttkInit =   	FusionCutterHitDeath,
  AirAttkInit =   	nil
}
-- ----------------------------------------------------------------------------- --

function FusionCutterHitInit()
	wait(1) 
	sigorder(1) 
	wait(1) 
	FusionCutterHitDeath()
end

function FusionCutterHitDeath()
	playfram(0x00)	-- Frame set 0
	playsnd(35)	-- terran\SCV\EDrRep00.wav | terran\SCV\EDrRep04.wav
	domissiledmg()
	wait(1) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(1) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(1) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(1) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(1) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(1) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(1) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(1) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 527 Gauss Rifle Hit (bullet\tspark.grp)
iscript[238] = {
  IsId =          	238,
  Type =          	2,
  Init =          	GaussRifleHitInit,
  Death =         	GaussRifleHitDeath,
  GndAttkInit =   	GaussRifleHitDeath,
  AirAttkInit =   	nil
}
-- ----------------------------------------------------------------------------- --

function GaussRifleHitInit()
	wait(1) 
	sigorder(1) 
	wait(1) 
	GaussRifleHitDeath()
end

function GaussRifleHitDeath()
	playfram(0x00)	-- Frame set 0
	domissiledmg()
	wait(1) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(1) 
	playfram(18)	-- Frame set 1,  direction 1
	wait(1) 
	playfram(27)	-- Frame set 1,  direction 10
	wait(1) 
	playfram(36)	-- Frame set 2,  direction 2
	wait(1) 
	playfram(45)	-- Frame set 2,  direction 11
	wait(1) 
	playfram(54)	-- Frame set 3,  direction 3
	wait(1) 
	playfram(63)	-- Frame set 3,  direction 12
	wait(1) 
	playfram(72)	-- Frame set 4,  direction 4
	wait(1) 
	playfram(81)	-- Frame set 4,  direction 13
	wait(1) 
	playfram(90)	-- Frame set 5,  direction 5
	wait(1) 
	playfram(99)	-- Frame set 5,  direction 14
	wait(1) 
	playfram(108)	-- Frame set 6,  direction 6
	wait(1) 
	playfram(117)	-- Frame set 6,  direction 15
	wait(1) 
	playfram(126)	-- Frame set 7,  direction 7
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 528 Gemini Missiles (bullet\gemini.grp)
iscript[239] = {
  IsId =          	239,
  Type =          	2,
  Init =          	GeminiMissilesInit,
  Death =         	GeminiMissilesDeath,
  GndAttkInit =   	GeminiMissilesGndAttkInit,
  AirAttkInit =   	nil
}
-- ----------------------------------------------------------------------------- --

function GeminiMissilesInit()
	playfram(0x00)	-- Frame set 0
	playsnd(82)	-- Bullet\TPhFi200.wav | Bullet\TPhFi200.wav
	wait(1) 
	sigorder(1) 
	wait(1) 
	GeminiMissilesGndAttkInit()
end

function GeminiMissilesGndAttkInit()
::GeminiMissilesGndAttkInit_label::
	sprol(309, 0, 0)	-- Longbolt/Gemini Missiles Trail (thingy\smoke.grp)
	wait(2) 
	goto GeminiMissilesGndAttkInit_label
end

function GeminiMissilesDeath()
	playsnd(9)	-- Misc\ExploSm.wav
	imgol(530, 0, 0)	-- Gemini Missiles Explosion (thingy\ecaHit.grp)
	domissiledmg()
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 529 Lockdown/LongBolt/Hellfire Missile (bullet\missile.grp)
iscript[240] = {
  IsId =          	240,
  Type =          	2,
  Init =          	LongboltMissileInit,
  Death =         	LongboltMissileDeath,
  GndAttkInit =   	LongboltMissileGndAttkInit,
  AirAttkInit =   	nil
}
-- ----------------------------------------------------------------------------- --

function LongboltMissileInit()
	playfram(0x00)	-- Frame set 0
	playsnd(80)	-- Bullet\HKMISSLE.wav
	wait(1) 
	sigorder(1) 
	wait(1) 
	LongboltMissileGndAttkInit()
end

function LongboltMissileGndAttkInit()
::LongboltMissileGndAttkInit_label::
	sprol(309, 0, 0)	-- Longbolt/Gemini Missiles Trail (thingy\smoke.grp)
	wait(3) 
	goto LongboltMissileGndAttkInit_label
end

function LongboltMissileDeath()
	playsnd(9)	-- Misc\ExploSm.wav
	imgol(530, 0, 0)	-- Gemini Missiles Explosion (thingy\ecaHit.grp)
	domissiledmg()
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 531 C-10 Canister Rifle Hit (thingy\ecaHit.grp)
iscript[241] = {
  IsId =          	241,
  Type =          	2,
  Init =          	C_10CanisterRifleHitInit,
  Death =         	C_10CanisterRifleHitDeath,
  GndAttkInit =   	C_10CanisterRifleHitDeath,
  AirAttkInit =   	nil
}
-- ----------------------------------------------------------------------------- --

function C_10CanisterRifleHitInit()
	wait(1) 
	sigorder(1) 
	wait(1) 
  C_10CanisterRifleHitDeath()
end

function C_10CanisterRifleHitDeath()
	playfram(0x00)	-- Frame set 0
	domissiledmg()
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(2) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(2) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(2) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(2) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 532 Fragmentation Grenade (bullet\grenade.grp)
iscript[242] = {
  IsId =          	242,
  Type =          	2,
  Init =          	FragmentationGrenadeInit,
  Death =         	FragmentationGrenadeDeath,
  GndAttkInit =   	FragmentationGrenadeGndAttkInit,
  AirAttkInit =   	nil
}
-- ----------------------------------------------------------------------------- --

function FragmentationGrenadeInit()
	playfram(0x00)	-- Frame set 0
	playsnd(106)	-- Bullet\tvuFir00.wav
	wait(1) 
	sigorder(1) 
	wait(1) 
	FragmentationGrenadeGndAttkInit()
end

function FragmentationGrenadeGndAttkInit()
	sprol(310, 0, 0)	-- Grenade Shot Smoke (thingy\GreSmoke.grp)
	wait(1) 
	FragmentationGrenadeLocal00()
end

function FragmentationGrenadeLocal00()
::FragmentationGrenadeLocal00_label::
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	goto FragmentationGrenadeLocal00_label
end

function FragmentationGrenadeDeath()
	imgol(440, 0, 0)	-- Fragmentation Grenade Hit (thingy\efgHit.grp)
	domissiledmg()
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 534 ATS/ATA Laser Battery (thingy\elbfire.grp)
-- 535 Burst Lasers (thingy\elbfireW.grp)
iscript[243] = {
  IsId =          	243,
  Type =          	2,
  Init =          	ATA_ATSLaserBattery_BurstLasersInit,
  Death =         	ATA_ATSLaserBattery_BurstLasersDeath,
  GndAttkInit =   	ScourgeLocal00,
  AirAttkInit =   	nil
}
-- ----------------------------------------------------------------------------- --

function ATA_ATSLaserBattery_BurstLasersInit()
	tmprmgraphicstart()
	trgtrangecondjmp(40, ATA_ATSLaserBattery_BurstLasersLocal00)
	tmprmgraphicend()
	playfram(0x00)	-- Frame set 0
	playsnd(74)	-- Bullet\TPhFi100.wav
	wait(1) 
	sigorder(1) 
	wait(1) 
	ScourgeLocal00()
end

function ATA_ATSLaserBattery_BurstLasersLocal00()
	playfram(0x00)	-- Frame set 0
	playsnd(74)	-- Bullet\TPhFi100.wav
	wait(1) 
	sigorder(1) 
	wait(1) 
	ScourgeLocal00()
end

function ATA_ATSLaserBattery_BurstLasersDeath()
	imgol(447, 0, 0)	-- Burst Lasers Hit (thingy\elbHit.grp)
	domissiledmg()
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 361 Lockdown Field (Small) (thingy\eldSmall.grp)
-- 362 Lockdown Field (Medium) (thingy\eldMed.grp)
-- 363 Lockdown Field (Large) (thingy\eldLarge.grp)
iscript[245] = {
  IsId =          	245,
  Type =          	1,
  Init =          	LockdownHitInit,
  Death =         	LockdownHitDeath
}
-- ----------------------------------------------------------------------------- --

function LockdownHitInit()
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(2) 
	LockdownHitLocal00()
end

function LockdownHitLocal00()
::LockdownHitLocal00_label::
	playfram(7)	-- Frame set 0,  direction 7
	wait(2) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(2) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(2) 
	playfram(10)	-- Frame set 0,  direction 10
	wait(2) 
	playfram(11)	-- Frame set 0,  direction 11
	wait(2) 
	playfram(12)	-- Frame set 0,  direction 12
	wait(2) 
	playfram(11)	-- Frame set 0,  direction 11
	wait(2) 
	playfram(10)	-- Frame set 0,  direction 10
	wait(2) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(2) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(2) 
	goto LockdownHitLocal00_label
end

function LockdownHitDeath()
	playfram(13)	-- Frame set 0,  direction 13
	wait(2) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 533 Arclite Shock Cannon Hit (thingy\mushroom.grp)
iscript[246] = {
  IsId =          	246,
  Type =          	2,
  Init =          	ArcliteShockCannonHitInit,
  Death =         	ArcliteShockCannonHitDeath,
  GndAttkInit =   	ArcliteShockCannonHitDeath,
  AirAttkInit =   	nil
}
-- ----------------------------------------------------------------------------- --

function ArcliteShockCannonHitInit()
	wait(1) 
	sigorder(1) 
	wait(1) 
	ArcliteShockCannonHitDeath()
end

function ArcliteShockCannonHitDeath()
	playfram(0x00)	-- Frame set 0
	playsnd(7)	-- Misc\ExploLrg.wav
	wait(1) 
	domissiledmg()
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(1) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(1) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(1) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(1) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(1) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(1) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(1) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(1) 
	playfram(10)	-- Frame set 0,  direction 10
	wait(1) 
	playfram(11)	-- Frame set 0,  direction 11
	wait(1) 
	playfram(12)	-- Frame set 0,  direction 12
	wait(1) 
	playfram(13)	-- Frame set 0,  direction 13
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 541 Yamato Gun (bullet\eycBull.grp)
iscript[247] = {
  IsId =          	247,
  Type =          	2,
  Init =          	YamatoGunInit,
  Death =         	YamatoGunDeath,
  GndAttkInit =   	YamatoGunGndAttkInit,
  AirAttkInit =   	nil
}
-- ----------------------------------------------------------------------------- --

function YamatoGunInit()
	playfram(0x00)	-- Frame set 0
	playsnd(179)	-- Terran\BATTLE\tBaYam02.wav
	wait(1) 
	sigorder(1) 
	wait(1) 
	YamatoGunGndAttkInit()
end

function YamatoGunGndAttkInit()
::YamatoGunGndAttkInit_label::
	wait(3) 
	sprul(351, 0, 0)	-- Yamato Gun Trail (bullet\eycBull.grp)
	goto YamatoGunGndAttkInit_label
end

function YamatoGunDeath()
	imgol(544, 0, 0)	-- Yamato Gun Hit (thingy\eycHit.grp)
	domissiledmg()
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 542 Yamato Gun Trail (bullet\eycBull.grp)
iscript[248] = {
  IsId =          	248,
  Type =          	0,
  Init =          	YamatoGunTrailInit,
  Death =         	nil
}
-- ----------------------------------------------------------------------------- --

function YamatoGunTrailInit()
	playfram(0x11)	-- Frame set 1
	wait(2) 
	playfram(0x22)	-- Frame set 2
	wait(2) 
	playfram(0x33)	-- Frame set 3
	wait(2) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 554 EMP Shockwave Missile (bullet\missile.grp)
iscript[249] = {
  IsId =          	249,
  Type =          	2,
  Init =          	Lockdown_EMPShockwaveMissileInit,
  Death =         	Lockdown_EMPShockwaveMissileDeath,
  GndAttkInit =   	Lockdown_EMPShockwaveMissileGndAttkInit,
  AirAttkInit =   	nil
}
-- ----------------------------------------------------------------------------- --

function Lockdown_EMPShockwaveMissileInit()
	playfram(0x00)	-- Frame set 0
	wait(1) 
	sigorder(1) 
	wait(1) 
  Lockdown_EMPShockwaveMissileGndAttkInit()
end

function Lockdown_EMPShockwaveMissileGndAttkInit()
::Lockdown_EMPShockwaveMissileGndAttkInit_label::
	sprol(309, 0, 0)	-- Longbolt/Gemini Missiles Trail (thingy\smoke.grp)
	wait(3) 
	goto Lockdown_EMPShockwaveMissileGndAttkInit_label
end

function Lockdown_EMPShockwaveMissileDeath()
	imgol(556, 0, 0)	-- EMP Shockwave Hit (Part2) (thingy\empl.grp)
	domissiledmg()
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 536 Siege Tank(Tank) Turret Attack Overlay (thingy\ettFlash.grp)
iscript[250] = {
  IsId =          	250,
  Type =          	1,
  Init =          	SiegeTank_Tank_TurretOverlayInit,
  Death =         	ScourgeExplosionDeath
}
-- ----------------------------------------------------------------------------- --

function SiegeTank_Tank_TurretOverlayInit()
	playfram(0x00)	-- Frame set 0
	wait(2) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 537 Siege Tank(Siege) Turret Attack Overlay (thingy\esiFire.grp)
iscript[251] = {
  IsId =          	251,
  Type =          	1,
  Init =          	SiegeTank_Siege_TurretOverlayInit,
  Death =         	ScourgeExplosionDeath
}
-- ----------------------------------------------------------------------------- --

function SiegeTank_Siege_TurretOverlayInit()
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(0x11)	-- Frame set 1
	wait(1) 
	playfram(0x22)	-- Frame set 2
	wait(1) 
	playfram(0x33)	-- Frame set 3
	wait(1) 
	playfram(0x44)	-- Frame set 4
	wait(1) 
	playfram(0x55)	-- Frame set 5
	wait(1) 
	playfram(0x66)	-- Frame set 6
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 538 Science Vessel Overlay (Part1) (thingy\tveGlowB.grp)
-- 539 Science Vessel Overlay (Part2) (thingy\tveGlowO.grp)
-- 540 Science Vessel Overlay (Part3) (thingy\tveGlowW.grp)
iscript[252] = {
  IsId =          	252,
  Type =          	1,
  Init =          	ScienceVesselOverlayInit,
  Death =         	ScienceVesselOverlayDeath
}
-- ----------------------------------------------------------------------------- --

function ScienceVesselOverlayInit()
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	ScienceVesselOverlayDeath()
end

function ScienceVesselOverlayDeath()
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 545 Hallucination Hit (thingy\halmind.grp)
-- 546 Scanner Sweep Hit (thingy\eveCast.grp)
iscript[253] = {
  IsId =          	253,
  Type =          	1,
  Init =          	HallucinationHitInit,
  Death =         	HallucinationHitDeath
}
-- ----------------------------------------------------------------------------- --

function HallucinationHitInit()
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(2) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(2) 
	HallucinationHitDeath()
end

function HallucinationHitDeath()
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 504 Needle Spine Hit (bullet\zspark.grp)
iscript[256] = {
  IsId =          	256,
  Type =          	2,
  Init =          	NeedleSpinesHitInit,
  Death =         	NeedleSpinesHitDeath,
  GndAttkInit =   	NeedleSpinesHitDeath,
  AirAttkInit =   	nil
}
-- ----------------------------------------------------------------------------- --

function NeedleSpinesHitInit()
	wait(1) 
	sigorder(1) 
	wait(1) 
	NeedleSpinesHitDeath()
end

function NeedleSpinesHitDeath()
	playfram(0x00)	-- Frame set 0
	domissiledmg()
	wait(1) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(1) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(1) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(1) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(1) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(1) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 506 Sunken Colony Tentacle (bullet\Tentacle.grp)
iscript[258] = {
  IsId =          	258,
  Type =          	2,
  Init =          	SubterraneanTentacleInit,
  Death =         	SubterraneanTentacleDeath,
  GndAttkInit =   	SubterraneanTentacleDeath,
  AirAttkInit =   	nil
}
-- ----------------------------------------------------------------------------- --

function SubterraneanTentacleInit()
	playsnd(79)	-- Bullet\ZLuHit00.wav
	wait(1) 
	sigorder(1) 
	wait(1) 
	SubterraneanTentacleDeath()
end

function SubterraneanTentacleDeath()
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(1) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(1) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(1) 
	playfram(5)	-- Frame set 0,  direction 5
	domissiledmg()
	wait(2) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(1) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(1) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(1) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	playfram(0x00)	-- Frame set 0
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 509 Acid Spore (thingy\ep3Shot.grp)
iscript[260] = {
  IsId =          	260,
  Type =          	2,
  Init =          	AcidSporeInit,
  Death =         	AcidSporeDeath,
  GndAttkInit =   	AcidSporeGndAttkInit,
  AirAttkInit =   	nil
}
-- ----------------------------------------------------------------------------- --

function AcidSporeInit()
	playfram(0x00)	-- Frame set 0
	wait(1) 
	sigorder(1) 
	wait(1) 
	AcidSporeGndAttkInit()
end

function AcidSporeGndAttkInit()
::AcidSporeGndAttkInit_label::
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	goto AcidSporeGndAttkInit_label
end

function AcidSporeDeath()
	domissiledmg()
	playsnd(72)	-- Bullet\ZGuHit00.wav
	imgol(510, 0, 0)	-- Acid Spore Hit (thingy\ep3Burst.grp)
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 510 Acid Spore Hit (thingy\ep3Burst.grp)
iscript[261] = {
  IsId =          	261,
  Type =          	1,
  Init =          	AcidSporeHitInit,
  Death =         	ScourgeExplosionDeath
}
-- ----------------------------------------------------------------------------- --

function AcidSporeHitInit()
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(1) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(1) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(1) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(1) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(1) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(1) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(1) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(1) 
	playfram(10)	-- Frame set 0,  direction 10
	wait(1) 
	playfram(11)	-- Frame set 0,  direction 11
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 518 Guardian Attack Overlay (thingy\eplMuzz.grp)
iscript[262] = {
  IsId =          	262,
  Type =          	1,
  Init =          	GuardianAttackOverlayInit,
  Death =         	ScourgeExplosionDeath
}
-- ----------------------------------------------------------------------------- --

function GuardianAttackOverlayInit()
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(0x11)	-- Frame set 1
	wait(1) 
	playfram(0x22)	-- Frame set 2
	wait(1) 
	playfram(0x33)	-- Frame set 3
	wait(1) 
	playfram(0x44)	-- Frame set 4
	wait(1) 
	playfram(0x55)	-- Frame set 5
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 511 Glave Wurm (bullet\spores.grp)
iscript[264] = {
  IsId =          	264,
  Type =          	13,
  Init =          	GlaveWurmInit,
  Death =         	GlaveWurmDeath,
  GndAttkInit =   	GlaveWurmGndAttkInit,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	nil,
  WalkingToIdle = 	nil,
  SpecialState1 = 	GlaveWurmSpecialState1
}
-- ----------------------------------------------------------------------------- --

function GlaveWurmInit()
	playfram(0x00)	-- Frame set 0
	wait(1) 
	sigorder(1) 
	wait(1) 
	GlaveWurmGndAttkInit()
end

function GlaveWurmGndAttkInit()
::GlaveWurmGndAttkInit_label::
	sprol(367, 0, 0)	-- Glave Wurm Trail (thingy\SpoTrail.grp)
	playfram(0x00)	-- Frame set 0
	wait(1) 
	sprol(367, 0, 0)	-- Glave Wurm Trail (thingy\SpoTrail.grp)
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	sprol(367, 0, 0)	-- Glave Wurm Trail (thingy\SpoTrail.grp)
	playfram(2)	-- Frame set 0,  direction 2
	wait(1) 
	sprol(367, 0, 0)	-- Glave Wurm Trail (thingy\SpoTrail.grp)
	playfram(3)	-- Frame set 0,  direction 3
	wait(1) 
	sprol(367, 0, 0)	-- Glave Wurm Trail (thingy\SpoTrail.grp)
	playfram(4)	-- Frame set 0,  direction 4
	wait(1) 
	sprol(367, 0, 0)	-- Glave Wurm Trail (thingy\SpoTrail.grp)
	playfram(5)	-- Frame set 0,  direction 5
	wait(1) 
	sprol(367, 0, 0)	-- Glave Wurm Trail (thingy\SpoTrail.grp)
	playfram(6)	-- Frame set 0,  direction 6
	wait(1) 
	sprol(367, 0, 0)	-- Glave Wurm Trail (thingy\SpoTrail.grp)
	playfram(7)	-- Frame set 0,  direction 7
	wait(1) 
	sprol(367, 0, 0)	-- Glave Wurm Trail (thingy\SpoTrail.grp)
	playfram(8)	-- Frame set 0,  direction 8
	wait(1) 
	sprol(367, 0, 0)	-- Glave Wurm Trail (thingy\SpoTrail.grp)
	playfram(9)	-- Frame set 0,  direction 9
	wait(1) 
	goto GlaveWurmGndAttkInit_label
end

function GlaveWurmDeath()
	playsnd(93)	-- Bullet\ZQuHit02.wav
	sprol(365, 0, 0)	-- Glave Wurm/Seeker Spores Hit (thingy\SporeHit.grp)
	domissiledmg()
	wait(1) 
end

function GlaveWurmSpecialState1()
	playsnd(91)	-- Bullet\ZQuHit00.wav | Bullet\ZQuHit01.wav
	sprol(365, 0, 0)	-- Glave Wurm/Seeker Spores Hit (thingy\SporeHit.grp)
	domissiledmg()
	GlaveWurmGndAttkInit()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 512 Glave Wurm/Seeker Spores Hit (thingy\SporeHit.grp)
iscript[265] = {
  IsId =          	265,
  Type =          	1,
  Init =          	GlaveWurmHitInit,
  Death =         	ScourgeExplosionDeath
}
-- ----------------------------------------------------------------------------- --

function GlaveWurmHitInit()
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(2) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(2) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(2) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(2) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 515 Seeker Spores (bullet\Spore2.grp)
iscript[266] = {
  IsId =          	266,
  Type =          	2,
  Init =          	SeekerSporesInit,
  Death =         	SeekerSporesDeath,
  GndAttkInit =   	SeekerSporesGndAttkInit,
  AirAttkInit =   	nil
}
-- ----------------------------------------------------------------------------- --

function SeekerSporesInit()
	playfram(0x00)	-- Frame set 0
	playsnd(78)	-- Bullet\ZLuFir00.wav
	wait(1) 
	sigorder(1) 
	wait(1) 
	SeekerSporesGndAttkInit()
end

function SeekerSporesGndAttkInit()
::SeekerSporesGndAttkInit_label::
	sprol(368, 0, 0)	-- Seeker Spores Overlay (thingy\gSmoke.grp)
	playfram(0x00)	-- Frame set 0
	wait(1) 
	sprol(368, 0, 0)	-- Seeker Spores Overlay (thingy\gSmoke.grp)
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	sprol(368, 0, 0)	-- Seeker Spores Overlay (thingy\gSmoke.grp)
	playfram(2)	-- Frame set 0,  direction 2
	wait(1) 
	sprol(368, 0, 0)	-- Seeker Spores Overlay (thingy\gSmoke.grp)
	playfram(3)	-- Frame set 0,  direction 3
	wait(1) 
	sprol(368, 0, 0)	-- Seeker Spores Overlay (thingy\gSmoke.grp)
	goto SeekerSporesGndAttkInit_label
end

function SeekerSporesDeath()
	playsnd(79)	-- Bullet\ZLuHit00.wav
	sprol(365, 0, 0)	-- Glave Wurm/Seeker Spores Hit (thingy\SporeHit.grp)
	domissiledmg()
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 516 Queen Spell Holder (bullet\parasite.grp)
iscript[267] = {
  IsId =          	267,
  Type =          	2,
  Init =          	QueenSpellHolderInit,
  Death =         	QueenSpellHolderDeath,
  GndAttkInit =   	QueenSpellHolderGndAttkInit,
  AirAttkInit =   	nil
}
-- ----------------------------------------------------------------------------- --

function QueenSpellHolderInit()
	playfram(0x00)	-- Frame set 0
	wait(1) 
	sigorder(1) 
	QueenSpellHolderGndAttkInit()
end

function QueenSpellHolderGndAttkInit()
	ScourgeLocal00()
end

function QueenSpellHolderDeath()
	sprol(365, 0, 0)	-- Glave Wurm/Seeker Spores Hit (thingy\SporeHit.grp)
	domissiledmg()
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 548 Psionic Shockwave Hit (thingy\emsHit.grp)
iscript[268] = {
  IsId =          	268,
  Type =          	2,
  Init =          	PsionicShockwaveHitInit,
  Death =         	PsionicShockwaveHitDeath,
  GndAttkInit =   	PsionicShockwaveHitDeath,
  AirAttkInit =   	nil
}
-- ----------------------------------------------------------------------------- --

function PsionicShockwaveHitInit()
	wait(1) 
	sigorder(1) 
	wait(1) 
	PsionicShockwaveHitDeath()
end

function PsionicShockwaveHitDeath()
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(1) 
	playfram(3)	-- Frame set 0,  direction 3
	domissiledmg()
	wait(1) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(1) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(1) 
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(1) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(1) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(1) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 513 Glave Wurm Trail (thingy\SpoTrail.grp)
iscript[269] = {
  IsId =          	269,
  Type =          	1,
  Init =          	GlaveWurmTrailInit,
  Death =         	ScourgeExplosionDeath
}
-- ----------------------------------------------------------------------------- --

function GlaveWurmTrailInit()
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(1) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 514 Seeker Spores Overlay (thingy\gSmoke.grp)
iscript[270] = {
  IsId =          	270,
  Type =          	1,
  Init =          	SeekerSporesOverlayInit,
  Death =         	ScourgeExplosionDeath
}
-- ----------------------------------------------------------------------------- --

function SeekerSporesOverlayInit()
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(1) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(1) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(1) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(1) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 422 Longbolt/Gemini Missiles Trail (thingy\smoke.grp)
-- 960 Halo Rockets Trail (thingy\bsmoke.grp)
iscript[273] = {
  IsId =          	273,
  Type =          	1,
  Init =          	GeminiMissilesTrailInit,
  Death =         	ScourgeExplosionDeath
}
-- ----------------------------------------------------------------------------- --

function GeminiMissilesTrailInit()
	tmprmgraphicstart()
	wait(2) 
	tmprmgraphicend()
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(1) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(1) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(1) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(1) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(1) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 426 Double Explosion (thingy\dbl_exp.grp)
iscript[278] = {
  IsId =          	278,
  Type =          	1,
  Init =          	DoubleExplosionInit,
  Death =         	ScourgeExplosionDeath
}
-- ----------------------------------------------------------------------------- --

function DoubleExplosionInit()
	playsnd(9)	-- Misc\ExploSm.wav
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(1) 
	playfram(18)	-- Frame set 1,  direction 1
	wait(1) 
	playfram(27)	-- Frame set 1,  direction 10
	wait(1) 
	playfram(36)	-- Frame set 2,  direction 2
	wait(1) 
	playfram(45)	-- Frame set 2,  direction 11
	wait(1) 
	playfram(54)	-- Frame set 3,  direction 3
	wait(1) 
	playfram(63)	-- Frame set 3,  direction 12
	wait(1) 
	playfram(72)	-- Frame set 4,  direction 4
	wait(1) 
	playfram(81)	-- Frame set 4,  direction 13
	wait(1) 
	playfram(90)	-- Frame set 5,  direction 5
	wait(1) 
	playfram(99)	-- Frame set 5,  direction 14
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 428 Nuclear Missile Death (thingy\small.grp)
iscript[279] = {
  IsId =          	279,
  Type =          	1,
  Init =          	NuclearMissileDeathInit,
  Death =         	NuclearMissileDeathDeath
}
-- ----------------------------------------------------------------------------- --

function NuclearMissileDeathInit()
	playsnd(9)	-- Misc\ExploSm.wav
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(2) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(2) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(2) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(1) 
	NuclearMissileDeathDeath()
end

function NuclearMissileDeathDeath()
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 429 Spider Mine Death (thingy\tmnExplo.grp)
iscript[280] = {
  IsId =          	280,
  Type =          	0,
  Init =          	SpiderMineExplosionInit,
  Death =         	nil
}
-- ----------------------------------------------------------------------------- --

function SpiderMineExplosionInit()
	playsnd(10)	-- Misc\Explo1.wav
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(1) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(1) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(1) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(1) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(1) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(1) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(1) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 440 Fragmentation Grenade Hit (thingy\efgHit.grp)
iscript[283] = {
  IsId =          	283,
  Type =          	1,
  Init =          	FragmentationGrenadeHitInit,
  Death =         	ScourgeExplosionDeath
}
-- ----------------------------------------------------------------------------- --

function FragmentationGrenadeHitInit()
	playsnd(107)	-- Bullet\tvuHit00.wav | Bullet\tvuHit02.wav
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(2) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(2) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(2) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 441 Grenade Shot Smoke (thingy\GreSmoke.grp)
iscript[284] = {
  IsId =          	284,
  Type =          	1,
  Init =          	GrenadeShotSmokeInit,
  Death =         	ScourgeExplosionDeath
}
-- ----------------------------------------------------------------------------- --

function GrenadeShotSmokeInit()
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(2) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(2) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 427 Phase Disruptor Hit (thingy\HKexplod.grp)
-- 442 Anti-Matter Missile Hit (thingy\HKexplod.grp)
iscript[285] = {
  IsId =          	285,
  Type =          	1,
  Init =          	PhaseDisruptor_Anti_MatterMissileHitInit,
  Death =         	ScourgeExplosionDeath
}
-- ----------------------------------------------------------------------------- --

function PhaseDisruptor_Anti_MatterMissileHitInit()
	playsnd(8)	-- Misc\ExploMed.wav
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(1) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(1) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(1) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(1) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(1) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(1) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(1) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(1) 
	playfram(10)	-- Frame set 0,  direction 10
	wait(1) 
	playfram(11)	-- Frame set 0,  direction 11
	wait(1) 
	playfram(12)	-- Frame set 0,  direction 12
	wait(1) 
	playfram(13)	-- Frame set 0,  direction 13
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 443 Scarab/Anti-Matter Missile Overlay (thingy\HKTrail.grp)
iscript[286] = {
  IsId =          	286,
  Type =          	1,
  Init =          	Scarab_Anti_MatterMissileOverlayInit,
  Death =         	ScourgeExplosionDeath
}
-- ----------------------------------------------------------------------------- --

function Scarab_Anti_MatterMissileOverlayInit()
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(1) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(1) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(1) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(1) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(1) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 444 Scarab Hit (thingy\psaExplo.grp)
iscript[287] = {
  IsId =          	287,
  Type =          	1,
  Init =          	ScarabHitInit,
  Death =         	ScourgeExplosionDeath
}
-- ----------------------------------------------------------------------------- --

function ScarabHitInit()
	playsnd(100)	-- Bullet\psaHit00.wav
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(1) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(1) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(1) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(1) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(1) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(1) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(1) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 114 Carrier Engines (thingy\pcaGlow.grp)
-- 120 Shuttle Engines (thingy\pshGlow.grp)
iscript[290] = {
  IsId =          	290,
  Type =          	12,
  Init =          	CarrierEnginesInit,
  Death =         	ScourgeExplosionDeath,
  GndAttkInit =   	ScourgeExplosionDeath,
  AirAttkInit =   	ScourgeExplosionDeath,
  Unused1 =       	nil,
  GndAttkRpt =    	ScourgeExplosionDeath,
  AirAttkRpt =    	ScourgeExplosionDeath,
  CastSpell =     	ScourgeExplosionDeath,
  GndAttkToIdle = 	ScourgeExplosionDeath,
  AirAttkToIdle = 	ScourgeExplosionDeath,
  Unused2 =       	nil,
  Walking =       	CarrierEnginesInit,
  WalkingToIdle = 	ScourgeExplosionDeath,
  SpecialState1 = 	nil
}
-- ----------------------------------------------------------------------------- --

function CarrierEnginesInit()
::CarrierEnginesInit_label::
	wait(1) 
	followmaingraphic()
	goto CarrierEnginesInit_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 132 Arbiter Engines (thingy\pabGlow.grp)
-- 220 Battlecruiser Engines (thingy\tbaGlow.grp)
-- 225 Dropship Engines (thingy\tdrGlow.grp)
-- 249 SCV Glow (thingy\tscGlow.grp)
-- 941 Valkyrie Engines (thingy\tbmGlow.grp)
-- 942 Valkyrie Engines2 (Unused) (thingy\tbmGlow.grp)
-- 943 Valkyrie Afterburners (Unused) (thingy\tbmAfter.grp)
iscript[291] = {
  IsId =          	291,
  Type =          	15,
  Init =          	Engines_GlowHeaderInit,
  Death =         	ScourgeExplosionDeath,
  GndAttkInit =   	ScourgeExplosionDeath,
  AirAttkInit =   	ScourgeExplosionDeath,
  Unused1 =       	nil,
  GndAttkRpt =    	ScourgeExplosionDeath,
  AirAttkRpt =    	ScourgeExplosionDeath,
  CastSpell =     	ScourgeExplosionDeath,
  GndAttkToIdle = 	ScourgeExplosionDeath,
  AirAttkToIdle = 	ScourgeExplosionDeath,
  Unused2 =       	nil,
  Walking =       	Engines_GlowHeaderInit,
  WalkingToIdle = 	ScourgeExplosionDeath,
  SpecialState1 = 	nil,
  SpecialState2 = 	nil,
  AlmostBuilt =   	ScourgeExplosionDeath
}
-- ----------------------------------------------------------------------------- --

function Engines_GlowHeaderInit()
::Engines_GlowHeaderInit_label::
	engset(1280)	-- Frame set 75,  direction 5
	playframtile(300)	-- Frame set 17,  direction 11
	wait(1) 
	goto Engines_GlowHeaderInit_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 503 White Circle (bullet\circle14.grp)
iscript[292] = {
  IsId =          	292,
  Type =          	2,
  Init =          	WhiteCircleInit,
  Death =         	WhiteCircleDeath,
  GndAttkInit =   	WhiteCircleDeath,
  AirAttkInit =   	nil
}
-- ----------------------------------------------------------------------------- --

function WhiteCircleInit()
	wait(1) 
	sigorder(1) 
	wait(1) 
	WhiteCircleDeath()
end

function WhiteCircleDeath()
	playfram(0x00)	-- Frame set 0
	wait(5) 
	domissiledmg()
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 446 Battlecruiser Attack Overlay (thingy\elbBat.grp)
iscript[293] = {
  IsId =          	293,
  Type =          	1,
  Init =          	BattlecruiserAttackOverlayInit,
  Death =         	BattlecruiserAttackOverlayDeath
}
-- ----------------------------------------------------------------------------- --

function BattlecruiserAttackOverlayInit()
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(0x11)	-- Frame set 1
	wait(2) 
	playfram(0x22)	-- Frame set 2
	wait(2) 
	playfram(0x33)	-- Frame set 3
	wait(2) 
	playfram(0x44)	-- Frame set 4
	wait(1) 
	BattlecruiserAttackOverlayDeath()
end

function BattlecruiserAttackOverlayDeath()
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 447 Burst Lasers Hit (thingy\elbHit.grp)
iscript[294] = {
  IsId =          	294,
  Type =          	1,
  Init =          	ATA_ATSLaserBattery_BurstLasersHitInit,
  Death =         	ATA_ATSLaserBattery_BurstLasersHitDeath
}
-- ----------------------------------------------------------------------------- --

function ATA_ATSLaserBattery_BurstLasersHitInit()
	playsnd(77)	-- Bullet\LASRHIT3.wav
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(1) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(1) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(1) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(1) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(1) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(1) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(1) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(1) 
  ATA_ATSLaserBattery_BurstLasersHitDeath()
end

function ATA_ATSLaserBattery_BurstLasersHitDeath()
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 387 Plague Cloud (thingy\ebbCloud.grp)
iscript[296] = {
  IsId =          	296,
  Type =          	2,
  Init =          	PlagueCloudInit,
  Death =         	PlagueCloudDeath,
  GndAttkInit =   	PlagueCloudDeath,
  AirAttkInit =   	nil
}
-- ----------------------------------------------------------------------------- --

function PlagueCloudInit()
	playfram(0x00)	-- Frame set 0
	wait(1) 
	sigorder(1) 
	wait(1) 
	PlagueCloudDeath()
end

function PlagueCloudDeath()
	playsnd(816)	-- Zerg\DEFILER\ZDeBlo00.WAV
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	domissiledmg()
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(2) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(2) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(2) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(2) 
	playfram(10)	-- Frame set 0,  direction 10
	wait(2) 
	playfram(11)	-- Frame set 0,  direction 11
	wait(2) 
	playfram(12)	-- Frame set 0,  direction 12
	wait(2) 
	playfram(13)	-- Frame set 0,  direction 13
	wait(2) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 388 Plague Overlay (Small) (thingy\ebbHitS.grp)
-- 389 Plague Overlay (Medium) (thingy\ebbHitM.grp)
-- 390 Plague Overlay (Large) (thingy\ebbHitL.grp)
iscript[297] = {
  IsId =          	297,
  Type =          	1,
  Init =          	PlagueOverlayInit,
  Death =         	ScourgeExplosionDeath
}
-- ----------------------------------------------------------------------------- --

function PlagueOverlayInit()
	tmprmgraphicstart()
	waitrand(1, 3) 
	tmprmgraphicend()
	PlagueOverlayLocal00()
end

function PlagueOverlayLocal00()
::PlagueOverlayLocal00_label::
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	waitrand(2, 3) 
	goto PlagueOverlayLocal00_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 517 Consume (thingy\consume.grp)
iscript[298] = {
  IsId =          	298,
  Type =          	2,
  Init =          	ConsumeInit,
  Death =         	ConsumeDeath,
  GndAttkInit =   	ConsumeDeath,
  AirAttkInit =   	nil
}
-- ----------------------------------------------------------------------------- --

function ConsumeInit()
	wait(1) 
	sigorder(1) 
	wait(1) 
	ConsumeDeath()
end

function ConsumeDeath()
	playsnd(813)	-- Zerg\DEFILER\ZDeCon00.WAV
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(2) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(2) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(2) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(2) 
	playfram(10)	-- Frame set 0,  direction 10
	wait(2) 
	playfram(11)	-- Frame set 0,  direction 11
	wait(2) 
	playfram(12)	-- Frame set 0,  direction 12
	wait(2) 
	playfram(13)	-- Frame set 0,  direction 13
	wait(2) 
	playfram(14)	-- Frame set 0,  direction 14
	wait(2) 
	playfram(15)	-- Frame set 0,  direction 15
	wait(2) 
	playfram(16)	-- Frame set 0,  direction 16
	domissiledmg()
	wait(2) 
	playfram(0x11)	-- Frame set 1
	wait(2) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 337 Dark Swarm (thingy\Dswarm.grp)
iscript[299] = {
  IsId =          	299,
  Type =          	1,
  Init =          	DarkSwarmInit,
  Death =         	DarkSwarmDeath
}
-- ----------------------------------------------------------------------------- --

function DarkSwarmInit()
	playsnd(922)	-- Zerg\Queen\ZQuSwm00.WAV
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(1) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(1) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(1) 
	DarkSwarmLocal00()
end

function DarkSwarmLocal00()
::DarkSwarmLocal00_label::
	playfram(5)	-- Frame set 0,  direction 5
	wait(3) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(3) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(3) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(3) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(3) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(3) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(3) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(3) 
	goto DarkSwarmLocal00_label
end

function DarkSwarmDeath()
	playfram(4)	-- Frame set 0,  direction 4
	wait(1) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(1) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(1) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	playfram(0x00)	-- Frame set 0
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 371 Defensive Matrix Front (Small) (thingy\edmFronS.grp)
-- 372 Defensive Matrix Front (Medium) (thingy\edmFronM.grp)
-- 373 Defensive Matrix Front (Large) (thingy\edmFronL.grp)
-- 374 Defensive Matrix Back (Small) (thingy\edmBackS.grp)
-- 375 Defensive Matrix Back (Medium) (thingy\edmBackM.grp)
-- 376 Defensive Matrix Back (Large) (thingy\edmBackL.grp)
iscript[300] = {
  IsId =          	300,
  Type =          	1,
  Init =          	DefensiveMatrixOverlayInit,
  Death =         	ScourgeExplosionDeath
}
-- ----------------------------------------------------------------------------- --

function DefensiveMatrixOverlayInit()
::DefensiveMatrixOverlayInit_label::
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(1) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(1) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(1) 
	goto DefensiveMatrixOverlayInit_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 377 Defensive Matrix Hit (Small) (thingy\edmHitS.grp)
-- 378 Defensive Matrix Hit (Medium) (thingy\edmHitM.grp)
-- 379 Defensive Matrix Hit (Large) (thingy\edmHitL.grp)
iscript[301] = {
  IsId =          	301,
  Type =          	1,
  Init =          	DefensiveMatrixHitInit,
  Death =         	DefensiveMatrixHitDeath
}
-- ----------------------------------------------------------------------------- --

function DefensiveMatrixHitInit()
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	DefensiveMatrixHitDeath()
end

function DefensiveMatrixHitDeath()
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 383 Ensnare Cloud (thingy\Ensnare.grp)
iscript[302] = {
  IsId =          	302,
  Type =          	1,
  Init =          	EnsnareInit,
  Death =         	ScourgeExplosionDeath
}
-- ----------------------------------------------------------------------------- --

function EnsnareInit()
	playsnd(924)	-- Zerg\Queen\ZQuEns00.WAV
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(1) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(1) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(1) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(1) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(1) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(1) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(1) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(1) 
	playfram(10)	-- Frame set 0,  direction 10
	wait(1) 
	playfram(11)	-- Frame set 0,  direction 11
	wait(1) 
	playfram(12)	-- Frame set 0,  direction 12
	wait(1) 
	playfram(13)	-- Frame set 0,  direction 13
	wait(1) 
	playfram(14)	-- Frame set 0,  direction 14
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 384 Ensnare Overlay (Small) (thingy\ensGooS.grp)
-- 385 Ensnare Overlay (Medium) (thingy\ensGooM.grp)
-- 386 Ensnare Overlay (Large) (thingy\ensGooL.grp)
iscript[303] = {
  IsId =          	303,
  Type =          	1,
  Init =          	EnsnareOverlayInit,
  Death =         	ScourgeExplosionDeath
}
-- ----------------------------------------------------------------------------- --

function EnsnareOverlayInit()
	tmprmgraphicstart()
	waitrand(1, 3) 
	tmprmgraphicend()
	EnsnareOverlayLocal00()
end

function EnsnareOverlayLocal00()
::EnsnareOverlayLocal00_label::
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	waitrand(2, 3) 
	goto EnsnareOverlayLocal00_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 380 Irradiate (Small) (thingy\eradLrg.grp)
-- 381 Irradiate (Medium) (thingy\eradLrg.grp)
-- 382 Irradiate (Large) (thingy\eradLrg.grp)
iscript[304] = {
  IsId =          	304,
  Type =          	1,
  Init =          	IrradiateInit,
  Death =         	ScourgeExplosionDeath
}
-- ----------------------------------------------------------------------------- --

function IrradiateInit()
::IrradiateInit_label::
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	goto IrradiateInit_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 391 Recall Field (thingy\recall.grp)
iscript[305] = {
  IsId =          	305,
  Type =          	1,
  Init =          	RecallFieldInit,
  Death =         	ScourgeExplosionDeath
}
-- ----------------------------------------------------------------------------- --

function RecallFieldInit()
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(1) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(1) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(1) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(1) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(1) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(1) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(1) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(1) 
	playfram(10)	-- Frame set 0,  direction 10
	wait(1) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(1) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(1) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(1) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(1) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(1) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(1) 
	playfram(10)	-- Frame set 0,  direction 10
	wait(1) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(1) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(1) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(1) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(1) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(1) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(1) 
	playfram(10)	-- Frame set 0,  direction 10
	wait(1) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(1) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(1) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(1) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	playfram(0x00)	-- Frame set 0
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 365 Stasis Field (Small) (thingy\esfSmall.grp)
-- 366 Stasis Field (Medium) (thingy\esfSmall.grp)
-- 367 Stasis Field (Large) (thingy\esfLarge.grp)
iscript[306] = {
  IsId =          	306,
  Type =          	1,
  Init =          	StasisFieldOverlayInit,
  Death =         	StasisFieldOverlayDeath
}
-- ----------------------------------------------------------------------------- --

function StasisFieldOverlayInit()
	playfram(0x00)	-- Frame set 0
	tmprmgraphicstart()
	waitrand(3, 8) 
	tmprmgraphicend()
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(2) 
	StasisFieldOverlayLocal00()
end

function StasisFieldOverlayLocal00()
::StasisFieldOverlayLocal00_label::
	waitrand(1, 3) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(2) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(2) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(2) 
	playfram(10)	-- Frame set 0,  direction 10
	wait(2) 
	playfram(11)	-- Frame set 0,  direction 11
	wait(2) 
	playfram(12)	-- Frame set 0,  direction 12
	wait(2) 
	goto StasisFieldOverlayLocal00_label
end

function StasisFieldOverlayDeath()
	playfram(6)	-- Frame set 0,  direction 6
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(0x00)	-- Frame set 0
	wait(2) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 364 Stasis Field Hit (thingy\esfHit.grp)
iscript[307] = {
  IsId =          	307,
  Type =          	1,
  Init =          	StasisFieldHitInit,
  Death =         	ScourgeExplosionDeath
}
-- ----------------------------------------------------------------------------- --

function StasisFieldHitInit()
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(1) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(1) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(1) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(1) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(1) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(1) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 370 Recharge Shields (Large) (thingy\sbaLarge.grp)
iscript[308] = {
  IsId =          	308,
  Type =          	1,
  Init =          	RechargeShields_Large_Init,
  Death =         	ScourgeExplosionDeath
}
-- ----------------------------------------------------------------------------- --

function RechargeShields_Large_Init()
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(2) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(2) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(2) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(2) 
	playfram(10)	-- Frame set 0,  direction 10
	wait(2) 
	playfram(11)	-- Frame set 0,  direction 11
	wait(2) 
	playfram(12)	-- Frame set 0,  direction 12
	wait(2) 
	playfram(13)	-- Frame set 0,  direction 13
	wait(2) 
	playfram(14)	-- Frame set 0,  direction 14
	wait(2) 
	playfram(15)	-- Frame set 0,  direction 15
	wait(2) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 368 Recharge Shields (Small) (thingy\sbaSmall.grp)
-- 369 Recharge Shields (Medium) (thingy\sbaSmall.grp)
iscript[309] = {
  IsId =          	309,
  Type =          	1,
  Init =          	RechargeShields_Small_Init,
  Death =         	ScourgeExplosionDeath
}
-- ----------------------------------------------------------------------------- --

function RechargeShields_Small_Init()
::RechargeShields_Small_Init_label::
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	goto RechargeShields_Small_Init_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 449 High Templar Glow (thingy\pteglow.grp)
iscript[310] = {
  IsId =          	310,
  Type =          	1,
  Init =          	HighTemplarGlowInit,
  Death =         	ScourgeExplosionDeath
}
-- ----------------------------------------------------------------------------- --

function HighTemplarGlowInit()
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(0x11)	-- Frame set 1
	wait(2) 
	playfram(0x22)	-- Frame set 2
	wait(2) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 035 Needle Spines (thingy\spooge.grp)
iscript[311] = {
  IsId =          	311,
  Type =          	1,
  Init =          	NeedleSpinesOverlayInit,
  Death =         	ScourgeExplosionDeath
}
-- ----------------------------------------------------------------------------- --

function NeedleSpinesOverlayInit()
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(0x11)	-- Frame set 1
	wait(2) 
	playfram(0x22)	-- Frame set 2
	wait(2) 
	playfram(0x33)	-- Frame set 3
	wait(2) 
	playfram(0x44)	-- Frame set 4
	wait(2) 
	playfram(0x55)	-- Frame set 5
	wait(2) 
	playfram(0x66)	-- Frame set 6
	wait(2) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 421 FlameThrower (thingy\flamer.grp)
iscript[312] = {
  IsId =          	312,
  Type =          	1,
  Init =          	FlamethrowerInit,
  Death =         	FlamethrowerDeath
}
-- ----------------------------------------------------------------------------- --

function FlamethrowerInit()
	playsnd(314)	-- Terran\Firebat\TFBFir00.WAV | Terran\Firebat\TFBFir01.WAV
	FlamethrowerLocal00()
end

function FlamethrowerLocal00()
	playfram(0x11)	-- Frame set 1
	wait(1) 
	playfram(0x22)	-- Frame set 2
	wait(1) 
	playfram(0x33)	-- Frame set 3
	wait(1) 
	playfram(0x44)	-- Frame set 4
	wait(1) 
	playfram(0x55)	-- Frame set 5
	wait(1) 
	playfram(0x66)	-- Frame set 6
	wait(1) 
	FlamethrowerLocal01()
end

function FlamethrowerLocal01()
	playfram(0x99)	-- Frame set 9
	wait(1) 
	playfram(0xaa)	-- Frame set 10
	wait(1) 
	playfram(0xbb)	-- Frame set 11
	wait(1) 
	FlamethrowerDeath()
end

function FlamethrowerDeath()
	nobrkcodeend()
	gotorepeatattk()
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 530 Gemini Missiles Explosion (thingy\ecaHit.grp)
iscript[313] = {
  IsId =          	313,
  Type =          	1,
  Init =          	GeminiMissilesExplosionInit,
  Death =         	ScourgeExplosionDeath
}
-- ----------------------------------------------------------------------------- --

function GeminiMissilesExplosionInit()
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(2) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(2) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(2) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(2) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 543 Yamato Gun Overlay (thingy\eycBlast.grp)
iscript[314] = {
  IsId =          	314,
  Type =          	1,
  Init =          	YamatoGunOverlayInit,
  Death =         	YamatoGunOverlayDeath
}
-- ----------------------------------------------------------------------------- --

function YamatoGunOverlayInit()
	playsnd(178)	-- Terran\BATTLE\tBaYam01.wav
	playfram(4)	-- Frame set 0,  direction 4
	nobrkcodestart()
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(2) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(2) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(2) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(2) 
	playfram(10)	-- Frame set 0,  direction 10
	wait(2) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(2) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(2) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(2) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(2) 
	playfram(10)	-- Frame set 0,  direction 10
	wait(2) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(2) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(2) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(2) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(2) 
	playfram(10)	-- Frame set 0,  direction 10
	wait(2) 
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	castspell()
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(1) 
	sigorder(2) 
	nobrkcodeend()
	gotorepeatattk()
	YamatoGunOverlayDeath()
end

function YamatoGunOverlayDeath()
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 544 Yamato Gun Hit (thingy\eycHit.grp)
iscript[315] = {
  IsId =          	315,
  Type =          	1,
  Init =          	YamatoGunHitInit,
  Death =         	ScourgeExplosionDeath
}
-- ----------------------------------------------------------------------------- --

function YamatoGunHitInit()
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(2) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(2) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(2) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(2) 
	playfram(10)	-- Frame set 0,  direction 10
	wait(2) 
	playfram(11)	-- Frame set 0,  direction 11
	wait(2) 
	playfram(12)	-- Frame set 0,  direction 12
	wait(2) 
	playfram(13)	-- Frame set 0,  direction 13
	wait(2) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 555 EMP Shockwave Hit (Part1) (thingy\emp.grp)
iscript[319] = {
  IsId =          	319,
  Type =          	0,
  Init =          	EMPShockwaveHit_Part1_Init,
  Death =         	nil
}
-- ----------------------------------------------------------------------------- --

function EMPShockwaveHit_Part1_Init()
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(1) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(1) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(1) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(1) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 556 EMP Shockwave Hit (Part2) (thingy\empl.grp)
iscript[320] = {
  IsId =          	320,
  Type =          	0,
  Init =          	EMPShockwaveHit_Part2_Init,
  Death =         	nil
}
-- ----------------------------------------------------------------------------- --

function EMPShockwaveHit_Part2_Init()
	playsnd(7)	-- Misc\ExploLrg.wav
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(1) 
	playfram(3)	-- Frame set 0,  direction 3
	imgul(555, 0, 0)	-- EMP Shockwave Hit (Part1) (thingy\emp.grp)
	wait(1) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(1) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(1) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 557 Hallucination Death1 (thingy\ehaMed.grp)
-- 558 Hallucination Death2 (thingy\ehaMed.grp)
-- 559 Hallucination Death3 (thingy\ehaMed.grp)
iscript[321] = {
  IsId =          	321,
  Type =          	0,
  Init =          	HallucinationDeathInit,
  Death =         	nil
}
-- ----------------------------------------------------------------------------- --

function HallucinationDeathInit()
	playfram(0x00)	-- Frame set 0
	wait(3) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(3) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(3) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(3) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(3) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(3) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(3) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(3) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(3) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(3) 
	playfram(10)	-- Frame set 0,  direction 10
	wait(3) 
	playfram(11)	-- Frame set 0,  direction 11
	wait(3) 
	playfram(12)	-- Frame set 0,  direction 12
	wait(3) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 679 7/8 Platform (thingy\tileset\Platform\tree01.grp)
iscript[338] = {
  IsId =          	338,
  Type =          	0,
  Init =          	SpacePlatformDoodadInit,
  Death =         	nil
}
-- ----------------------------------------------------------------------------- --

function SpacePlatformDoodadInit()
	playfram(0x00)	-- Frame set 0
	SpacePlatformDoodadLocal00()
end

function SpacePlatformDoodadLocal00()
::SpacePlatformDoodadLocal00_label::
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(1) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(1) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(1) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(1) 
	goto SpacePlatformDoodadLocal00_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 680 7/7 Platform (thingy\tileset\Platform\tree02.grp)
iscript[339] = {
  IsId =          	339,
  Type =          	0,
  Init =          	SpacePlatformDoodad2Init,
  Death =         	nil
}
-- ----------------------------------------------------------------------------- --

function SpacePlatformDoodad2Init()
	playfram(0x00)	-- Frame set 0
	SpacePlatformDoodad2Local00()
end

function SpacePlatformDoodad2Local00()
::SpacePlatformDoodad2Local00_label::
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(1) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(1) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(1) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(1) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(1) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(1) 
	goto SpacePlatformDoodad2Local00_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 742 Left Upper Level Door (thingy\tileset\install\CRDoor1.grp)
-- 750 Substructure Left Door (thingy\tileset\install\DIDoor1.grp)
-- 754 Substructure Opening Hole (thingy\tileset\install\DIHatc1.grp)
iscript[340] = {
  IsId =          	340,
  Type =          	27,
  Init =          	InstallationDoodadInit,
  Death =         	ScourgeExplosionDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	nil,
  WalkingToIdle = 	nil,
  SpecialState1 = 	nil,
  SpecialState2 = 	nil,
  AlmostBuilt =   	InstallationDoodadAlmostBuilt,
  Built =         	nil,
  Landing =       	nil,
  LiftOff =       	nil,
  IsWorking =     	nil,
  WorkingToIdle = 	nil,
  WarpIn =        	nil,
  Unused3 =       	nil,
  StarEditInit =  	InstallationDoodadStarEditInit,
  Disable =       	InstallationDoodadDisable,
  Burrow =        	nil,
  UnBurrow =      	nil,
  Enable =        	InstallationDoodadStarEditInit
}
-- ----------------------------------------------------------------------------- --

function InstallationDoodadInit()
	playfram(0x00)	-- Frame set 0
	ScourgeLocal00()
end

function InstallationDoodadAlmostBuilt()
	playfram(9)	-- Frame set 0,  direction 9
	ScourgeLocal00()
end

function InstallationDoodadStarEditInit()
	playfram(9)	-- Frame set 0,  direction 9
	wait(2) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(2) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(2) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(0x00)	-- Frame set 0
	sigorder(1) 
	ScourgeLocal00()
end

function InstallationDoodadDisable()
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(2) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(2) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(2) 
	playfram(9)	-- Frame set 0,  direction 9
	sigorder(1) 
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 743 Right Upper Level Door (thingy\tileset\install\CRDoor1.grp)
-- 751 Substructure Right Door (thingy\tileset\install\DIDoor1.grp)
iscript[341] = {
  IsId =          	341,
  Type =          	27,
  Init =          	InstallationDoodad2Init,
  Death =         	ScourgeExplosionDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	nil,
  WalkingToIdle = 	nil,
  SpecialState1 = 	nil,
  SpecialState2 = 	nil,
  AlmostBuilt =   	InstallationDoodad2AlmostBuilt,
  Built =         	nil,
  Landing =       	nil,
  LiftOff =       	nil,
  IsWorking =     	nil,
  WorkingToIdle = 	nil,
  WarpIn =        	nil,
  Unused3 =       	nil,
  StarEditInit =  	InstallationDoodad2StarEditInit,
  Disable =       	InstallationDoodad2Disable,
  Burrow =        	nil,
  UnBurrow =      	nil,
  Enable =        	InstallationDoodad2StarEditInit
}
-- ----------------------------------------------------------------------------- --

function InstallationDoodad2Init()
	playfram(0x00)	-- Frame set 0
	setflipstate(1) 
	ScourgeLocal00()
end

function InstallationDoodad2AlmostBuilt()
	playfram(9)	-- Frame set 0,  direction 9
	setflipstate(1) 
	ScourgeLocal00()
end

function InstallationDoodad2StarEditInit()
	playfram(9)	-- Frame set 0,  direction 9
	setflipstate(1) 
	wait(2) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(2) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(2) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(0x00)	-- Frame set 0
	sigorder(1) 
	ScourgeLocal00()
end

function InstallationDoodad2Disable()
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(2) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(2) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(2) 
	playfram(9)	-- Frame set 0,  direction 9
	sigorder(1) 
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 744 4/15 Installation1 (thingy\tileset\install\DCFan1.grp)
iscript[342] = {
  IsId =          	342,
  Type =          	0,
  Init =          	InstallationRightWallFansInit,
  Death =         	nil
}
-- ----------------------------------------------------------------------------- --

function InstallationRightWallFansInit()
::InstallationRightWallFansInit_label::
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(2) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(2) 
	goto InstallationRightWallFansInit_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 745 4/15 Installation2 (thingy\tileset\install\DCFan1.grp)
iscript[343] = {
  IsId =          	343,
  Type =          	0,
  Init =          	InstallationLeftWallFansInit,
  Death =         	nil
}
-- ----------------------------------------------------------------------------- --

function InstallationLeftWallFansInit()
	playfram(0x00)	-- Frame set 0
	setflipstate(1) 
	wait(2) 
	InstallationLeftWallFansLocal00()
end

function InstallationLeftWallFansLocal00()
::InstallationLeftWallFansLocal00_label::
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(2) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(2) 
	playfram(0x00)	-- Frame set 0
	wait(2) 
	goto InstallationLeftWallFansLocal00_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 752 3/1 Installation (thingy\tileset\install\DIGear1.grp)
-- 753 3/2 Installation (thingy\tileset\install\DIGear2.grp)
iscript[344] = {
  IsId =          	344,
  Type =          	0,
  Init =          	InstallationGearInit,
  Death =         	nil
}
-- ----------------------------------------------------------------------------- --

function InstallationGearInit()
::InstallationGearInit_label::
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	goto InstallationGearInit_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 736 Floor Missile Trap (thingy\tileset\install\CLPlate1.grp)
iscript[345] = {
  IsId =          	345,
  Type =          	27,
  Init =          	FloorMissileTrapInit,
  Death =         	FloorMissileTrapDeath,
  GndAttkInit =   	FloorMissileTrapGndAttkInit,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	FloorMissileTrapGndAttkInit,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	ScourgeLocal00,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	nil,
  WalkingToIdle = 	nil,
  SpecialState1 = 	FloorMissileTrapSpecialState1,
  SpecialState2 = 	FloorMissileTrapSpecialState2,
  AlmostBuilt =   	ScourgeLocal00,
  Built =         	nil,
  Landing =       	nil,
  LiftOff =       	nil,
  IsWorking =     	nil,
  WorkingToIdle = 	nil,
  WarpIn =        	nil,
  Unused3 =       	nil,
  StarEditInit =  	FloorMissileTrapStarEditInit,
  Disable =       	FloorMissileTrapSpecialState2,
  Burrow =        	nil,
  UnBurrow =      	nil,
  Enable =        	ScourgeLocal00
}
-- ----------------------------------------------------------------------------- --

function FloorMissileTrapInit()
	playfram(1)	-- Frame set 0,  direction 1
	ScourgeLocal00()
end

function FloorMissileTrapDeath()
	imgol(332, 0, 0)	-- Explosion2 (Small) (thingy\tBangS.grp)
	wait(1) 
end

function FloorMissileTrapGndAttkInit()
	wait(1) 
	attackwith(1) 
	gotorepeatattk()
	ignorerest()
	ScourgeLocal00()
end

function FloorMissileTrapSpecialState1()
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(2) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(2) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(2) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(2) 
	playfram(10)	-- Frame set 0,  direction 10
	wait(2) 
	playfram(11)	-- Frame set 0,  direction 11
	imgol(737, 0, 0)	-- Floor Missile Trap Turret (thingy\tileset\install\CLPlat1T.grp)
	sigorder(1) 
	ScourgeLocal00()
end

function FloorMissileTrapSpecialState2()
	setspawnframe(20) 
	wait(1) 
	FloorMissileTrapLocal00()
end

function FloorMissileTrapLocal00()
::FloorMissileTrapLocal00_label::
	curdirectcondjmp(160, 10, FloorMissileTrapLocal01)
	wait(2) 
	goto FloorMissileTrapLocal00_label
end

function FloorMissileTrapLocal01()
	wait(1) 
	playfram(10)	-- Frame set 0,  direction 10
	wait(2) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(2) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(2) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(2) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	sigorder(1) 
	ScourgeLocal00()
end

function FloorMissileTrapStarEditInit()
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(2) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(2) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(2) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(2) 
	playfram(10)	-- Frame set 0,  direction 10
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 737 Floor Missile Trap Turret (thingy\tileset\install\CLPlat1T.grp)
iscript[346] = {
  IsId =          	346,
  Type =          	24,
  Init =          	FloorMissileTrapTurretInit,
  Death =         	ScourgeExplosionDeath,
  GndAttkInit =   	ScourgeLocal00,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	ScourgeLocal00,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	ScourgeLocal00,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	nil,
  WalkingToIdle = 	nil,
  SpecialState1 = 	nil,
  SpecialState2 = 	FloorMissileTrapTurretSpecialState2,
  AlmostBuilt =   	nil,
  Built =         	nil,
  Landing =       	nil,
  LiftOff =       	nil,
  IsWorking =     	nil,
  WorkingToIdle = 	nil,
  WarpIn =        	nil,
  Unused3 =       	nil,
  StarEditInit =  	nil,
  Disable =       	FloorMissileTrapTurretSpecialState2,
  Burrow =        	nil
}
-- ----------------------------------------------------------------------------- --

function FloorMissileTrapTurretInit()
	playfram(0x00)	-- Frame set 0
	wait(1) 
	setfldirect(20) 
	ScourgeLocal00()
end

function FloorMissileTrapTurretSpecialState2()
	wait(1) 
	FloorMissileTrapTurretLocal00()
end

function FloorMissileTrapTurretLocal00()
::FloorMissileTrapTurretLocal00_label::
	curdirectcondjmp(160, 10, FloorMissileTrapTurretLocal01)
	wait(2) 
	goto FloorMissileTrapTurretLocal00_label
end

function FloorMissileTrapTurretLocal01()
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 735 Floor Gun Trap (thingy\tileset\install\CLPlate2.grp)
iscript[347] = {
  IsId =          	347,
  Type =          	27,
  Init =          	FloorGunTrapInit,
  Death =         	FloorGunTrapDeath,
  GndAttkInit =   	FloorGunTrapGndAttkInit,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	FloorGunTrapGndAttkInit,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	FloorGunTrapGndAttkToIdle,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	nil,
  WalkingToIdle = 	nil,
  SpecialState1 = 	FloorGunTrapSpecialState1,
  SpecialState2 = 	FloorGunTrapSpecialState2,
  AlmostBuilt =   	ScourgeLocal00,
  Built =         	nil,
  Landing =       	nil,
  LiftOff =       	nil,
  IsWorking =     	nil,
  WorkingToIdle = 	nil,
  WarpIn =        	nil,
  Unused3 =       	nil,
  StarEditInit =  	FloorGunTrapSpecialState1,
  Disable =       	FloorGunTrapSpecialState2,
  Burrow =        	nil,
  UnBurrow =      	nil,
  Enable =        	ScourgeLocal00
}
-- ----------------------------------------------------------------------------- --

function FloorGunTrapInit()
	playfram(1)	-- Frame set 0,  direction 1
	ScourgeLocal00()
end

function FloorGunTrapDeath()
	imgol(332, 0, 0)	-- Explosion2 (Small) (thingy\tBangS.grp)
	wait(1) 
end

function FloorGunTrapGndAttkInit()
	wait(1) 
	nobrkcodestart()
	playsnd(70)	-- Bullet\TGoFir00.wav
	attackwith(1) 
	playfram(11)	-- Frame set 0,  direction 11
	wait(1) 
	playfram(10)	-- Frame set 0,  direction 10
	wait(1) 
	playfram(11)	-- Frame set 0,  direction 11
	wait(1) 
	playfram(10)	-- Frame set 0,  direction 10
	wait(1) 
	playfram(11)	-- Frame set 0,  direction 11
	wait(1) 
	playfram(10)	-- Frame set 0,  direction 10
	wait(1) 
	nobrkcodeend()
	gotorepeatattk()
	ignorerest()
	ScourgeLocal00()
end

function FloorGunTrapGndAttkToIdle()
	playfram(10)	-- Frame set 0,  direction 10
	ScourgeLocal00()
end

function FloorGunTrapSpecialState1()
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(2) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(2) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(2) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(2) 
	sigorder(1) 
	playfram(10)	-- Frame set 0,  direction 10
	ScourgeLocal00()
end

function FloorGunTrapSpecialState2()
	playfram(9)	-- Frame set 0,  direction 9
	wait(2) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(2) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(2) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	sigorder(1) 
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 738 Wall Missile Trap (thingy\tileset\install\DCGun1.grp)
iscript[348] = {
  IsId =          	348,
  Type =          	27,
  Init =          	WallMissileTrapType1Init,
  Death =         	WallMissileTrapType1Death,
  GndAttkInit =   	WallMissileTrapType1GndAttkInit,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	WallMissileTrapType1GndAttkInit,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	ScourgeLocal00,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	nil,
  WalkingToIdle = 	nil,
  SpecialState1 = 	WallMissileTrapType1SpecialState1,
  SpecialState2 = 	WallMissileTrapType1SpecialState2,
  AlmostBuilt =   	ScourgeLocal00,
  Built =         	nil,
  Landing =       	nil,
  LiftOff =       	nil,
  IsWorking =     	nil,
  WorkingToIdle = 	nil,
  WarpIn =        	nil,
  Unused3 =       	nil,
  StarEditInit =  	WallMissileTrapType1SpecialState1,
  Disable =       	WallMissileTrapType1SpecialState2,
  Burrow =        	nil,
  UnBurrow =      	nil,
  Enable =        	ScourgeLocal00
}
-- ----------------------------------------------------------------------------- --

function WallMissileTrapType1Init()
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	setfldirect(12) 
	ScourgeLocal00()
end

function WallMissileTrapType1Death()
	imgol(332, 0, 0)	-- Explosion2 (Small) (thingy\tBangS.grp)
	wait(1) 
end

function WallMissileTrapType1GndAttkInit()
	wait(1) 
	attackwith(1) 
	gotorepeatattk()
	ignorerest()
	ScourgeLocal00()
end

function WallMissileTrapType1SpecialState1()
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	playfram(6)	-- Frame set 0,  direction 6
	sigorder(1) 
	ScourgeLocal00()
end

function WallMissileTrapType1SpecialState2()
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	sigorder(1) 
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 739 Wall Missile Trap2 (thingy\tileset\install\DCGun1.grp)
iscript[349] = {
  IsId =          	349,
  Type =          	27,
  Init =          	WallMissileTrapTypet2Init,
  Death =         	WallMissileTrapTypet2Death,
  GndAttkInit =   	WallMissileTrapTypet2GndAttkInit,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	WallMissileTrapTypet2GndAttkInit,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	ScourgeLocal00,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	nil,
  WalkingToIdle = 	nil,
  SpecialState1 = 	WallMissileTrapTypet2SpecialState1,
  SpecialState2 = 	WallMissileTrapTypet2SpecialState2,
  AlmostBuilt =   	ScourgeLocal00,
  Built =         	nil,
  Landing =       	nil,
  LiftOff =       	nil,
  IsWorking =     	nil,
  WorkingToIdle = 	nil,
  WarpIn =        	nil,
  Unused3 =       	nil,
  StarEditInit =  	WallMissileTrapTypet2SpecialState1,
  Disable =       	WallMissileTrapTypet2SpecialState2,
  Burrow =        	nil,
  UnBurrow =      	nil,
  Enable =        	ScourgeLocal00
}
-- ----------------------------------------------------------------------------- --

function WallMissileTrapTypet2Init()
	playfram(1)	-- Frame set 0,  direction 1
	setflipstate(1) 
	wait(1) 
	setfldirect(20) 
	ScourgeLocal00()
end

function WallMissileTrapTypet2Death()
	imgol(332, 0, 0)	-- Explosion2 (Small) (thingy\tBangS.grp)
	wait(1) 
end

function WallMissileTrapTypet2GndAttkInit()
	wait(1) 
	attackwith(1) 
	gotorepeatattk()
	ignorerest()
	ScourgeLocal00()
end

function WallMissileTrapTypet2SpecialState1()
	playfram(1)	-- Frame set 0,  direction 1
	setflipstate(1) 
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	playfram(6)	-- Frame set 0,  direction 6
	sigorder(1) 
	ScourgeLocal00()
end

function WallMissileTrapTypet2SpecialState2()
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	sigorder(1) 
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 740 Wall Flame Trap (thingy\tileset\install\DCGun2.grp)
iscript[350] = {
  IsId =          	350,
  Type =          	27,
  Init =          	WallFlameTrapType1Init,
  Death =         	WallFlameTrapType1Death,
  GndAttkInit =   	WallFlameTrapType1GndAttkInit,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	WallFlameTrapType1GndAttkInit,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	ScourgeLocal00,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	nil,
  WalkingToIdle = 	nil,
  SpecialState1 = 	WallFlameTrapType1SpecialState1,
  SpecialState2 = 	WallFlameTrapType1SpecialState2,
  AlmostBuilt =   	ScourgeLocal00,
  Built =         	nil,
  Landing =       	nil,
  LiftOff =       	nil,
  IsWorking =     	nil,
  WorkingToIdle = 	nil,
  WarpIn =        	nil,
  Unused3 =       	nil,
  StarEditInit =  	WallFlameTrapType1SpecialState1,
  Disable =       	WallFlameTrapType1SpecialState2,
  Burrow =        	nil,
  UnBurrow =      	nil,
  Enable =        	ScourgeLocal00
}
-- ----------------------------------------------------------------------------- --

function WallFlameTrapType1Init()
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	setfldirect(12) 
	ScourgeLocal00()
end

function WallFlameTrapType1Death()
	imgol(332, 0, 0)	-- Explosion2 (Small) (thingy\tBangS.grp)
	wait(1) 
end

function WallFlameTrapType1GndAttkInit()
	wait(1) 
	nobrkcodestart()
	imgoluselo(421, 0, 0)	-- FlameThrower (thingy\flamer.grp)
	setfldirect(12) 
	attkshiftproj(24) 
	wait(2) 
	attkshiftproj(52) 
	wait(1) 
	attkshiftproj(80) 
	wait(10) 
	ignorerest()
	ScourgeLocal00()
end

function WallFlameTrapType1SpecialState1()
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(2) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(2) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(2) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(2) 
	playfram(10)	-- Frame set 0,  direction 10
	sigorder(1) 
	ScourgeLocal00()
end

function WallFlameTrapType1SpecialState2()
	playfram(9)	-- Frame set 0,  direction 9
	wait(2) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(2) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(2) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	sigorder(1) 
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 741 Wall Flame Trap2 (thingy\tileset\install\DCGun2.grp)
iscript[351] = {
  IsId =          	351,
  Type =          	27,
  Init =          	WallFlameTrapType2Init,
  Death =         	WallFlameTrapType2Death,
  GndAttkInit =   	WallFlameTrapType2GndAttkInit,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	WallFlameTrapType2GndAttkInit,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	ScourgeLocal00,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	nil,
  WalkingToIdle = 	nil,
  SpecialState1 = 	WallFlameTrapType2SpecialState1,
  SpecialState2 = 	WallFlameTrapType2SpecialState2,
  AlmostBuilt =   	ScourgeLocal00,
  Built =         	nil,
  Landing =       	nil,
  LiftOff =       	nil,
  IsWorking =     	nil,
  WorkingToIdle = 	nil,
  WarpIn =        	nil,
  Unused3 =       	nil,
  StarEditInit =  	WallFlameTrapType2SpecialState1,
  Disable =       	WallFlameTrapType2SpecialState2,
  Burrow =        	nil,
  UnBurrow =      	nil,
  Enable =        	ScourgeLocal00
}
-- ----------------------------------------------------------------------------- --

function WallFlameTrapType2Init()
	playfram(1)	-- Frame set 0,  direction 1
	setflipstate(1) 
	wait(1) 
	setfldirect(20) 
	ScourgeLocal00()
end

function WallFlameTrapType2Death()
	imgol(332, 0, 0)	-- Explosion2 (Small) (thingy\tBangS.grp)
	wait(1) 
end

function WallFlameTrapType2GndAttkInit()
	wait(1) 
	nobrkcodestart()
	imgoluselo(421, 0, 0)	-- FlameThrower (thingy\flamer.grp)
	setfldirect(20) 
	attkshiftproj(24) 
	wait(2) 
	attkshiftproj(52) 
	wait(1) 
	attkshiftproj(80) 
	wait(10) 
	ignorerest()
	ScourgeLocal00()
end

function WallFlameTrapType2SpecialState1()
	playfram(1)	-- Frame set 0,  direction 1
	setflipstate(1) 
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(2) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(2) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(2) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(2) 
	playfram(10)	-- Frame set 0,  direction 10
	sigorder(1) 
	ScourgeLocal00()
end

function WallFlameTrapType2SpecialState2()
	playfram(9)	-- Frame set 0,  direction 9
	wait(2) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(2) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(2) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	sigorder(1) 
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 582 Map Revealer (neutral\maprev.grp)
iscript[352] = {
  IsId =          	352,
  Type =          	1,
  Init =          	MapRevealerInit,
  Death =         	MapRevealerDeath
}
-- ----------------------------------------------------------------------------- --

function MapRevealerInit()
	playfram(0x00)	-- Frame set 0
	MapRevealerLocal00()
end

function MapRevealerLocal00()
::MapRevealerLocal00_label::
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	goto MapRevealerLocal00_label
end

function MapRevealerDeath()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 914 Lurker Egg (zerg\Lurkegg.grp)
iscript[353] = {
  IsId =          	353,
  Type =          	14,
  Init =          	LurkerEggInit,
  Death =         	LurkerEggDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	nil,
  WalkingToIdle = 	nil,
  SpecialState1 = 	LurkerEggSpecialState1,
  SpecialState2 = 	LurkerEggSpecialState2,
  AlmostBuilt =   	nil
}
-- ----------------------------------------------------------------------------- --

function LurkerEggInit()
	imgul(22, 0, 0)	-- Egg Shadow (zerg\zegShad.grp)
	playfram(12)	-- Frame set 0,  direction 12
	wait(2) 
	playfram(13)	-- Frame set 0,  direction 13
	wait(2) 
	playfram(14)	-- Frame set 0,  direction 14
	wait(2) 
	playfram(15)	-- Frame set 0,  direction 15
	wait(2) 
	playfram(16)	-- Frame set 0,  direction 16
	wait(2) 
	playfram(0x11)	-- Frame set 1
	wait(2) 
	playfram(18)	-- Frame set 1,  direction 1
	waitrand(1, 3) 
	LurkerEggLocal00()
end

function LurkerEggLocal00()
::LurkerEggLocal00_label::
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(2) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(2) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(2) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(2) 
	playfram(10)	-- Frame set 0,  direction 10
	wait(2) 
	playfram(11)	-- Frame set 0,  direction 11
	wait(2) 
	goto LurkerEggLocal00_label
end

function LurkerEggDeath()
	playsnd(830)	-- Zerg\Egg\ZEgDth00.WAV
	lowsprul(143, 0, 0)	-- Egg Remnants (zerg\zegDeath.grp)
	wait(1) 
end

function LurkerEggSpecialState1()
	sigorder(4) 
	ScourgeLocal00()
end

function LurkerEggSpecialState2()
	playfram(19)	-- Frame set 1,  direction 2
	wait(2) 
	playfram(18)	-- Frame set 1,  direction 1
	wait(2) 
	playfram(0x11)	-- Frame set 1
	wait(2) 
	playfram(16)	-- Frame set 0,  direction 16
	wait(2) 
	playfram(15)	-- Frame set 0,  direction 15
	wait(2) 
	playfram(14)	-- Frame set 0,  direction 14
	wait(2) 
	playfram(13)	-- Frame set 0,  direction 13
	wait(2) 
	playfram(12)	-- Frame set 0,  direction 12
	wait(2) 
	sigorder(4) 
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 921 Lurker (zerg\Zlurker.grp)
iscript[354] = {
  IsId =          	354,
  Type =          	26,
  Init =          	LurkerInit,
  Death =         	LurkerDeath,
  GndAttkInit =   	LurkerGndAttkInit,
  AirAttkInit =   	LurkerGndAttkInit,
  Unused1 =       	nil,
  GndAttkRpt =    	LurkerGndAttkRpt,
  AirAttkRpt =    	LurkerGndAttkRpt,
  CastSpell =     	nil,
  GndAttkToIdle = 	LurkerGndAttkToIdle,
  AirAttkToIdle = 	LurkerGndAttkToIdle,
  Unused2 =       	nil,
  Walking =       	LurkerWalking,
  WalkingToIdle = 	LurkerWalkingToIdle,
  SpecialState1 = 	nil,
  SpecialState2 = 	LurkerSpecialState2,
  AlmostBuilt =   	nil,
  Built =         	nil,
  Landing =       	nil,
  LiftOff =       	nil,
  IsWorking =     	nil,
  WorkingToIdle = 	nil,
  WarpIn =        	nil,
  Unused3 =       	nil,
  StarEditInit =  	nil,
  Disable =       	nil,
  Burrow =        	LurkerBurrow,
  UnBurrow =      	LurkerUnBurrow,
  Enable =        	nil
}
-- ----------------------------------------------------------------------------- --

function LurkerInit()
	imgul(922, 0, 0)	-- Lurker Shadow (zerg\zZluShad.grp)
	LurkerWalkingToIdle()
end

function LurkerWalkingToIdle()
	playfram(0x00)	-- Frame set 0
	LurkerLocal00()
end

function LurkerLocal00()
::LurkerLocal00_label::
	waitrand(63, 75) 
	randcondjmp(128, LurkerLocal01)
	goto LurkerLocal00_label
end

function LurkerLocal01()
	randcondjmp(128, LurkerLocal02)
	playfram(0x11)	-- Frame set 1
	wait(1) 
	turnccwise(1) 
	playfram(0x22)	-- Frame set 2
	wait(1) 
	turnccwise(1) 
	playfram(0x33)	-- Frame set 3
	wait(1) 
	turnccwise(1) 
	playfram(0x44)	-- Frame set 4
	wait(1) 
	turnccwise(1) 
	playfram(0x55)	-- Frame set 5
	wait(1) 
	turnccwise(1) 
	playfram(0x66)	-- Frame set 6
	wait(1) 
	turnccwise(1) 
	LurkerWalkingToIdle()
end

function LurkerLocal02()
	playfram(0x11)	-- Frame set 1
	wait(1) 
	turncwise(1) 
	playfram(0x22)	-- Frame set 2
	wait(1) 
	turncwise(1) 
	playfram(0x33)	-- Frame set 3
	wait(1) 
	turncwise(1) 
	playfram(0x44)	-- Frame set 4
	wait(1) 
	turncwise(1) 
	playfram(0x55)	-- Frame set 5
	wait(1) 
	turncwise(1) 
	playfram(0x66)	-- Frame set 6
	wait(1) 
	turncwise(1) 
	LurkerWalkingToIdle()
end

function LurkerDeath()
	playsnd(1080)	-- Zerg\LURKER\ZLuDth00.WAV
	setfldirect(0) 
	playfram(0x1a9)	-- Frame set 25
	wait(2) 
	playfram(0x1ba)	-- Frame set 26
	wait(2) 
	playfram(0x1cb)	-- Frame set 27
	wait(2) 
	playfram(0x1dc)	-- Frame set 28
	wait(2) 
	playfram(0x1ed)	-- Frame set 29
	wait(2) 
	lowsprul(484, 0, 0)	-- Lurker Remnants (zerg\zLurker.grp)
	wait(1) 
end

function LurkerGndAttkInit()
	nobrkcodestart()
	LurkerGndAttkRpt()
end

function LurkerGndAttkRpt()
	wait(1) 
	playsnd(64)	-- Bullet\SpoogHit.wav
	attack()
	wait(1) 
	nobrkcodeend()
	gotorepeatattk()
	ignorerest()
	LurkerGndAttkToIdle()
end

function LurkerGndAttkToIdle()
	ScourgeLocal00()
end

function LurkerWalking()
::LurkerWalking_label::
	move(4) 
	wait(1) 
	playfram(0x11)	-- Frame set 1
	move(4) 
	wait(1) 
	playfram(0x22)	-- Frame set 2
	move(4) 
	wait(1) 
	playfram(0x33)	-- Frame set 3
	move(4) 
	wait(1) 
	playfram(0x44)	-- Frame set 4
	move(4) 
	wait(1) 
	playfram(0x55)	-- Frame set 5
	move(4) 
	wait(1) 
	playfram(0x66)	-- Frame set 6
	move(4) 
	wait(1) 
	playfram(0x00)	-- Frame set 0
	goto LurkerWalking_label
end

function LurkerSpecialState2()
	playfram(0x198)	-- Frame set 24
	ScourgeLocal00()
end

function LurkerBurrow()
	imgol(423, 0, 0)	-- Burrowing Dust (thingy\bDust.grp)
	playsnd(1093)	-- Zerg\LURKER\ZLuBurrw.wav
	playfram(0xbb)	-- Frame set 11
	wait(1) 
	playfram(0xcc)	-- Frame set 12
	wait(1) 
	playfram(0xdd)	-- Frame set 13
	wait(1) 
	imgol(423, 0, 0)	-- Burrowing Dust (thingy\bDust.grp)
	playfram(0xee)	-- Frame set 14
	wait(1) 
	playfram(0xff)	-- Frame set 15
	wait(1) 
	playfram(0x110)	-- Frame set 16
	wait(1) 
	playfram(0x121)	-- Frame set 17
	wait(1) 
	playfram(0x132)	-- Frame set 18
	wait(1) 
	playfram(0x143)	-- Frame set 19
	wait(1) 
	imgol(423, 0, 0)	-- Burrowing Dust (thingy\bDust.grp)
	playfram(0xee)	-- Frame set 14
	wait(1) 
	playfram(0xff)	-- Frame set 15
	wait(1) 
	playfram(0x110)	-- Frame set 16
	wait(1) 
	playfram(0x121)	-- Frame set 17
	wait(1) 
	playfram(0x132)	-- Frame set 18
	wait(1) 
	playfram(0x143)	-- Frame set 19
	wait(1) 
	imgol(423, 0, 0)	-- Burrowing Dust (thingy\bDust.grp)
	playfram(0x154)	-- Frame set 20
	wait(1) 
	playfram(0x165)	-- Frame set 21
	wait(1) 
	playfram(0x176)	-- Frame set 22
	wait(1) 
	playfram(0x187)	-- Frame set 23
	wait(1) 
	playfram(0x198)	-- Frame set 24
	wait(1) 
	sigorder(4) 
	ScourgeLocal00()
end

function LurkerUnBurrow()
	waitrand(1, 5) 
	imgul(423, 0, 0)	-- Burrowing Dust (thingy\bDust.grp)
	playfram(0x77)	-- Frame set 7
	wait(1) 
	playfram(0x88)	-- Frame set 8
	wait(1) 
	playfram(0x99)	-- Frame set 9
	wait(1) 
	playfram(0xaa)	-- Frame set 10
	wait(1) 
	sigorder(4) 
	LurkerWalkingToIdle()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 920 Lurker Remnants (zerg\zLurker.grp)
iscript[356] = {
  IsId =          	356,
  Type =          	0,
  Init =          	LurkerRemnantsInit,
  Death =         	nil
}
-- ----------------------------------------------------------------------------- --

function LurkerRemnantsInit()
	playfram(0x1fe)	-- Frame set 30
	wait(50) 
	playfram(0x20f)	-- Frame set 31
	wait(50) 
	playfram(0x220)	-- Frame set 32
	wait(50) 
	playfram(0x231)	-- Frame set 33
	wait(50) 
	playfram(0x242)	-- Frame set 34
	wait(50) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 915 Devourer (zerg\devour.grp)
iscript[357] = {
  IsId =          	357,
  Type =          	12,
  Init =          	DevourerInit,
  Death =         	DevourerDeath,
  GndAttkInit =   	DevourerGndAttkInit,
  AirAttkInit =   	DevourerGndAttkInit,
  Unused1 =       	nil,
  GndAttkRpt =    	DevourerGndAttkInit,
  AirAttkRpt =    	DevourerGndAttkInit,
  CastSpell =     	nil,
  GndAttkToIdle = 	DevourerGndAttkToIdle,
  AirAttkToIdle = 	DevourerGndAttkToIdle,
  Unused2 =       	nil,
  Walking =       	DevourerWalking,
  WalkingToIdle = 	DevourerGndAttkToIdle,
  SpecialState1 = 	nil
}
-- ----------------------------------------------------------------------------- --

function DevourerInit()
	imgul(916, 0, 42)	-- Devourer Shadow (zerg\devour.grp)
	playfram(0x00)	-- Frame set 0
	waitrand(1, 4) 
	DevourerGndAttkToIdle()
end

function DevourerGndAttkToIdle()
::DevourerGndAttkToIdle_label::
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(0x11)	-- Frame set 1
	wait(2) 
	playfram(0x22)	-- Frame set 2
	wait(2) 
	playfram(0x33)	-- Frame set 3
	wait(2) 
	playfram(0x44)	-- Frame set 4
	wait(2) 
	playfram(0x55)	-- Frame set 5
	wait(2) 
	goto DevourerGndAttkToIdle_label
end

function DevourerDeath()
	playsnd(1097)	-- Zerg\Devourer\ZDvDth00.WAV
	sprol(483, 0, 0)	-- Devourer Death (zerg\zdvDeath.grp)
	wait(1) 
end

function DevourerGndAttkInit()
	playfram(0x66)	-- Frame set 6
	wait(1) 
	playfram(0x77)	-- Frame set 7
	wait(1) 
	playfram(0x88)	-- Frame set 8
	wait(1) 
	playfram(0x99)	-- Frame set 9
	wait(1) 
	playfram(0x88)	-- Frame set 8
	playsnd(1094)	-- Zerg\Devourer\firesuck.wav
	wait(2) 
	playfram(0x77)	-- Frame set 7
	wait(2) 
	playfram(0x66)	-- Frame set 6
	wait(2) 
	attackwith(2) 
	gotorepeatattk()
	DevourerGndAttkToIdle()
end

function DevourerWalking()
::DevourerWalking_label::
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(0x11)	-- Frame set 1
	wait(1) 
	playfram(0x22)	-- Frame set 2
	wait(1) 
	playfram(0x33)	-- Frame set 3
	wait(1) 
	playfram(0x44)	-- Frame set 4
	wait(1) 
	playfram(0x55)	-- Frame set 5
	wait(2) 
	goto DevourerWalking_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 917 Devourer Birth (thingy\zDvbirth.grp)
iscript[358] = {
  IsId =          	358,
  Type =          	13,
  Init =          	DevourerBirthInit,
  Death =         	DevourerBirthDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	nil,
  WalkingToIdle = 	nil,
  SpecialState1 = 	DevourerBirthSpecialState1
}
-- ----------------------------------------------------------------------------- --

function DevourerBirthInit()
	playfram(7)	-- Frame set 0,  direction 7
	wait(1) 
	waitrand(10, 15) 
	DevourerBirthLocal00()
end

function DevourerBirthLocal00()
::DevourerBirthLocal00_label::
	playfram(8)	-- Frame set 0,  direction 8
	wait(1) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(1) 
	playfram(10)	-- Frame set 0,  direction 10
	wait(1) 
	goto DevourerBirthLocal00_label
end

function DevourerBirthDeath()
	wait(1) 
end

function DevourerBirthSpecialState1()
	wait(1) 
	nobrkcodestart()
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(2) 
	sigorder(4) 
	nobrkcodeend()
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 918 Devourer Death (zerg\zdvDeath.grp)
iscript[359] = {
  IsId =          	359,
  Type =          	0,
  Init =          	DevourerDeathInit,
  Death =         	nil
}
-- ----------------------------------------------------------------------------- --

function DevourerDeathInit()
	playfram(0x00)	-- Frame set 0
	wait(2) 
	imgol(58, 0, 0)	-- Zerg Air Death Explosion (Large) (thingy\zAirDthL.grp)
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 944 Medic (terran\medic.grp)
iscript[360] = {
  IsId =          	360,
  Type =          	13,
  Init =          	MedicInit,
  Death =         	MedicDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	MedicCastSpell,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	MedicWalking,
  WalkingToIdle = 	MedicWalkingToIdle,
  SpecialState1 = 	MedicSpecialState1
}
-- ----------------------------------------------------------------------------- --

function MedicInit()
	imgul(945, 0, 0)	-- Medic Shadow (terran\tmeShad.grp)
	MedicLocal00()
end

function MedicLocal00()
	playfram(0x00)	-- Frame set 0
	MedicLocal01()
end

function MedicLocal01()
::MedicLocal01_label::
	waitrand(63, 75) 
	randcondjmp(128, MedicLocal02)
	goto MedicLocal01_label
end

function MedicLocal02()
	playfram(0x66)	-- Frame set 6
	wait(1) 
	playfram(0x77)	-- Frame set 7
	wait(1) 
	turnrand(3) 
	wait(1) 
	playfram(0x66)	-- Frame set 6
	wait(1) 
	MedicLocal00()
end

function MedicDeath()
	playsnd(1000)	-- Terran\Medic\TMdDth00.wav
	setfldirect(0) 
	playfram(0xdd)	-- Frame set 13
	wait(2) 
	playfram(222)	-- Frame set 13,  direction 1
	wait(2) 
	playfram(223)	-- Frame set 13,  direction 2
	wait(2) 
	playfram(224)	-- Frame set 13,  direction 3
	wait(2) 
	playfram(225)	-- Frame set 13,  direction 4
	wait(2) 
	playfram(226)	-- Frame set 13,  direction 5
	wait(2) 
	playfram(227)	-- Frame set 13,  direction 6
	wait(2) 
	playfram(228)	-- Frame set 13,  direction 7
	wait(4) 
	playfram(229)	-- Frame set 13,  direction 8
	wait(4) 
	lowsprul(490, 0, 0)	-- Medic Remnants (terran\tmeDeath.grp)
	wait(1) 
end

function MedicCastSpell()
	orderdone(1) 
	nobrkcodestart()
	playfram(0x11)	-- Frame set 1
	wait(3) 
	playfram(0x22)	-- Frame set 2
	castspell()
	sigorder(2) 
	wait(3) 
	playfram(0x11)	-- Frame set 1
	wait(3) 
	nobrkcodeend()
	gotorepeatattk()
	playfram(0x00)	-- Frame set 0
	ScourgeLocal00()
end

function MedicWalking()
::MedicWalking_label::
	orderdone(1) 
	move(4) 
	wait(1) 
	playfram(0x66)	-- Frame set 6
	move(4) 
	wait(1) 
	playfram(0x77)	-- Frame set 7
	move(4) 
	wait(1) 
	playfram(0x88)	-- Frame set 8
	move(4) 
	wait(1) 
	playfram(0x99)	-- Frame set 9
	move(4) 
	wait(1) 
	playfram(0xaa)	-- Frame set 10
	move(4) 
	wait(1) 
	playfram(0xbb)	-- Frame set 11
	move(4) 
	wait(1) 
	playfram(0xcc)	-- Frame set 12
	move(4) 
	wait(1) 
	playfram(0x00)	-- Frame set 0
	goto MedicWalking_label
end

function MedicWalkingToIdle()
	orderdone(1) 
	MedicLocal00()
end

function MedicSpecialState1()
	playfram(0x33)	-- Frame set 3
	wait(1) 
	MedicLocal03()
end

function MedicLocal03()
::MedicLocal03_label::
	sigorder(1) 
	playfram(0x44)	-- Frame set 4
	wait(1) 
	playfram(0x55)	-- Frame set 5
	wait(1) 
	playfram(0x44)	-- Frame set 4
	wait(1) 
	playfram(0x55)	-- Frame set 5
	wait(1) 
	playfram(0x44)	-- Frame set 4
	wait(1) 
	playfram(0x55)	-- Frame set 5
	wait(1) 
	playfram(0x44)	-- Frame set 4
	wait(1) 
	playfram(0x55)	-- Frame set 5
	wait(1) 
	playsnd(1018)	-- Terran\Medic\TMedHeal.wav
	goto MedicLocal03_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 946 Medic Remnants (terran\tmeDeath.grp)
iscript[361] = {
  IsId =          	361,
  Type =          	0,
  Init =          	MedicRemnantsInit,
  Death =         	nil
}
-- ----------------------------------------------------------------------------- --

function MedicRemnantsInit()
	playfram(0x00)	-- Frame set 0
	wait(50) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(50) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(50) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(50) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 939 Valkyrie (terran\bomber.grp)
iscript[362] = {
  IsId =          	362,
  Type =          	12,
  Init =          	ValkyrieInit,
  Death =         	ValkyrieDeath,
  GndAttkInit =   	BattlecruiserLocal00,
  AirAttkInit =   	ValkyrieAirAttkInit,
  Unused1 =       	nil,
  GndAttkRpt =    	BattlecruiserLocal00,
  AirAttkRpt =    	ValkyrieAirAttkInit,
  CastSpell =     	nil,
  GndAttkToIdle = 	OverlordLocal00,
  AirAttkToIdle = 	OverlordLocal00,
  Unused2 =       	nil,
  Walking =       	ValkyrieWalking,
  WalkingToIdle = 	ValkyrieWalkingToIdle,
  SpecialState1 = 	nil
}
-- ----------------------------------------------------------------------------- --

function ValkyrieInit()
	imgul(940, 0, 42)	-- Valkyrie Shadow (terran\bomber.grp)
	playfram(0x00)	-- Frame set 0
	OverlordLocal00()
end

function ValkyrieDeath()
	playsnd(1040)	-- Terran\FRIGATE\TVkDth00.WAV
	imgol(332, 0, 0)	-- Explosion2 (Small) (thingy\tBangS.grp)
	wait(3) 
end

function ValkyrieAirAttkInit()
	wait(1) 
	nobrkcodestart()
	attackwith(2) 
	wait(10) 
	attackwith(2) 
	wait(10) 
	attackwith(2) 
	wait(10) 
	attackwith(2) 
	wait(10) 
	nobrkcodeend()
	gotorepeatattk()
	OverlordLocal00()
end

function ValkyrieWalking()
	imgol(941, 0, 0)	-- Valkyrie Engines (thingy\tbmGlow.grp)
	sigorder(64) 
	setvertpos(0) 
	ScourgeLocal00()
end

function ValkyrieWalkingToIdle()
	orderdone(64) 
	OverlordLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 925 Dark Archon Energy (protoss\darchn.grp)
iscript[365] = {
  IsId =          	365,
  Type =          	13,
  Init =          	DarkArchonEnergyInit,
  Death =         	DarkArchonEnergyDeath,
  GndAttkInit =   	DarkArchonEnergyGndAttkInit,
  AirAttkInit =   	DarkArchonEnergyGndAttkInit,
  Unused1 =       	nil,
  GndAttkRpt =    	DarkArchonEnergyGndAttkInit,
  AirAttkRpt =    	DarkArchonEnergyGndAttkInit,
  CastSpell =     	DarkArchonEnergyCastSpell,
  GndAttkToIdle = 	DarkArchonEnergyGndAttkInit,
  AirAttkToIdle = 	DarkArchonEnergyGndAttkInit,
  Unused2 =       	nil,
  Walking =       	DarkArchonEnergyGndAttkInit,
  WalkingToIdle = 	DarkArchonEnergyGndAttkInit,
  SpecialState1 = 	DarkArchonEnergySpecialState1
}
-- ----------------------------------------------------------------------------- --

function DarkArchonEnergyInit()
	playfram(18)	-- Frame set 1,  direction 1
	wait(1) 
	nobrkcodestart()
	wait(1) 
	playfram(19)	-- Frame set 1,  direction 2
	wait(2) 
	playfram(20)	-- Frame set 1,  direction 3
	wait(2) 
	playfram(21)	-- Frame set 1,  direction 4
	wait(2) 
	playfram(22)	-- Frame set 1,  direction 5
	wait(2) 
	playfram(23)	-- Frame set 1,  direction 6
	wait(2) 
	playfram(24)	-- Frame set 1,  direction 7
	wait(2) 
	playfram(25)	-- Frame set 1,  direction 8
	wait(2) 
	playfram(26)	-- Frame set 1,  direction 9
	wait(2) 
	imgol(926, 0, 0)	-- Dark Archon Being (protoss\darchnT.grp)
	imgol(927, 0, 0)	-- Dark Archon Swirl (protoss\darchnT2.grp)
	sigorder(4) 
	nobrkcodeend()
	wait(2) 
	DarkArchonEnergyGndAttkInit()
end

function DarkArchonEnergyGndAttkInit()
::DarkArchonEnergyGndAttkInit_label::
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(1) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(1) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(1) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(1) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(1) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(1) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(1) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(1) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(1) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(1) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(1) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	goto DarkArchonEnergyGndAttkInit_label
end

function DarkArchonEnergyDeath()
	playsnd(7)	-- Misc\ExploLrg.wav
	imgol(928, 0, 0)	-- Dark Archon Death (protoss\PdaDeath.grp)
	wait(3) 
end

function DarkArchonEnergyCastSpell()
	nobrkcodestart()
	castspell()
	sigorder(2) 
	nobrkcodeend()
	gotorepeatattk()
	DarkArchonEnergyGndAttkInit()
end

function DarkArchonEnergySpecialState1()
	playsnd(617)	-- Protoss\TEMPLAR\PTeSum00.WAV
	playfram(10)	-- Frame set 0,  direction 10
	wait(2) 
	playfram(11)	-- Frame set 0,  direction 11
	wait(2) 
	DarkArchonEnergyLocal00()
end

function DarkArchonEnergyLocal00()
::DarkArchonEnergyLocal00_label::
	playfram(12)	-- Frame set 0,  direction 12
	wait(2) 
	playfram(13)	-- Frame set 0,  direction 13
	wait(2) 
	playfram(14)	-- Frame set 0,  direction 14
	wait(2) 
	playfram(15)	-- Frame set 0,  direction 15
	wait(2) 
	playfram(16)	-- Frame set 0,  direction 16
	wait(2) 
	playfram(0x11)	-- Frame set 1
	wait(2) 
	playfram(16)	-- Frame set 0,  direction 16
	wait(2) 
	playfram(15)	-- Frame set 0,  direction 15
	wait(2) 
	playfram(14)	-- Frame set 0,  direction 14
	wait(2) 
	playfram(13)	-- Frame set 0,  direction 13
	wait(2) 
	goto DarkArchonEnergyLocal00_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 926 Dark Archon Being (protoss\darchnT.grp)
iscript[366] = {
  IsId =          	366,
  Type =          	12,
  Init =          	DarkArchonBeingInit,
  Death =         	ScourgeExplosionDeath,
  GndAttkInit =   	DarkArchonBeingGndAttkInit,
  AirAttkInit =   	DarkArchonBeingGndAttkInit,
  Unused1 =       	nil,
  GndAttkRpt =    	DarkArchonBeingGndAttkInit,
  AirAttkRpt =    	DarkArchonBeingGndAttkInit,
  CastSpell =     	DarkArchonBeingCastSpell,
  GndAttkToIdle = 	DarkArchonBeingGndAttkToIdle,
  AirAttkToIdle = 	DarkArchonBeingGndAttkToIdle,
  Unused2 =       	nil,
  Walking =       	DarkArchonBeingGndAttkToIdle,
  WalkingToIdle = 	DarkArchonBeingGndAttkToIdle,
  SpecialState1 = 	nil
}
-- ----------------------------------------------------------------------------- --

function DarkArchonBeingInit()
	setfldirect(15) 
	DarkArchonBeingGndAttkToIdle()
end

function DarkArchonBeingGndAttkToIdle()
::DarkArchonBeingGndAttkToIdle_label::
	playfram(0x00)	-- Frame set 0
	wait(4) 
	playfram(0x11)	-- Frame set 1
	wait(4) 
	playfram(0x22)	-- Frame set 2
	wait(4) 
	playfram(0x33)	-- Frame set 3
	wait(4) 
	playfram(0x44)	-- Frame set 4
	wait(4) 
	playfram(0x55)	-- Frame set 5
	wait(4) 
	playfram(0x66)	-- Frame set 6
	wait(4) 
	playfram(0x77)	-- Frame set 7
	wait(4) 
	playfram(0x88)	-- Frame set 8
	wait(4) 
	playfram(0x99)	-- Frame set 9
	wait(4) 
	playfram(0x88)	-- Frame set 8
	wait(4) 
	playfram(0x77)	-- Frame set 7
	wait(4) 
	playfram(0x66)	-- Frame set 6
	wait(4) 
	playfram(0x55)	-- Frame set 5
	wait(4) 
	playfram(0x44)	-- Frame set 4
	wait(4) 
	playfram(0x33)	-- Frame set 3
	wait(4) 
	playfram(0x22)	-- Frame set 2
	wait(4) 
	playfram(0x11)	-- Frame set 1
	wait(4) 
	goto DarkArchonBeingGndAttkToIdle_label
end

function DarkArchonBeingGndAttkInit()
	playfram(0xaa)	-- Frame set 10
	wait(1) 
	nobrkcodestart()
	trgtrangecondjmp(48, DarkArchonBeingLocal00)
	imgoluselo(549, 0, 0)	-- Archon Beam (thingy\emsBeam.grp)
	playsnd(58)	-- Bullet\PArFir00.wav
	attack()
	wait(1) 
	nobrkcodeend()
	gotorepeatattk()
	DarkArchonBeingGndAttkToIdle()
end

function DarkArchonBeingLocal00()
	playsnd(58)	-- Bullet\PArFir00.wav
	attack()
	wait(1) 
	nobrkcodeend()
	gotorepeatattk()
	DarkArchonBeingGndAttkToIdle()
end

function DarkArchonBeingCastSpell()
	nobrkcodestart()
	castspell()
	sigorder(2) 
	nobrkcodeend()
	gotorepeatattk()
	DarkArchonBeingGndAttkToIdle()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 927 Dark Archon Swirl (protoss\darchnT2.grp)
iscript[367] = {
  IsId =          	367,
  Type =          	1,
  Init =          	DarkArchonSwirlInit,
  Death =         	ScourgeExplosionDeath
}
-- ----------------------------------------------------------------------------- --

function DarkArchonSwirlInit()
	tmprmgraphicstart()
	waitrand(1, 5) 
	tmprmgraphicend()
	DarkArchonSwirlLocal00()
end

function DarkArchonSwirlLocal00()
::DarkArchonSwirlLocal00_label::
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(1) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(1) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(1) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(1) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(1) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(1) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(1) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(1) 
	playfram(10)	-- Frame set 0,  direction 10
	wait(1) 
	playfram(11)	-- Frame set 0,  direction 11
	wait(1) 
	playfram(12)	-- Frame set 0,  direction 12
	wait(1) 
	playfram(13)	-- Frame set 0,  direction 13
	wait(1) 
	playfram(14)	-- Frame set 0,  direction 14
	wait(1) 
	goto DarkArchonSwirlLocal00_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 928 Dark Archon Death (protoss\PdaDeath.grp)
iscript[368] = {
  IsId =          	368,
  Type =          	0,
  Init =          	DarkArchonDeathInit,
  Death =         	nil
}
-- ----------------------------------------------------------------------------- --

function DarkArchonDeathInit()
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(1) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(1) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(1) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(1) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(1) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(1) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(1) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(1) 
	playfram(10)	-- Frame set 0,  direction 10
	wait(1) 
	playfram(11)	-- Frame set 0,  direction 11
	wait(1) 
	playfram(12)	-- Frame set 0,  direction 12
	wait(1) 
	playfram(13)	-- Frame set 0,  direction 13
	wait(1) 
	playfram(14)	-- Frame set 0,  direction 14
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 929 Corsair (protoss\corsair.grp)
iscript[369] = {
  IsId =          	369,
  Type =          	21,
  Init =          	CorsairInit,
  Death =         	CorsairDeath,
  GndAttkInit =   	CorsairGndAttkInit,
  AirAttkInit =   	CorsairAirAttkInit,
  Unused1 =       	nil,
  GndAttkRpt =    	CorsairGndAttkInit,
  AirAttkRpt =    	CorsairAirAttkInit,
  CastSpell =     	CorsairCastSpell,
  GndAttkToIdle = 	CorsairGndAttkToIdle,
  AirAttkToIdle = 	CorsairGndAttkToIdle,
  Unused2 =       	nil,
  Walking =       	CorsairWalking,
  WalkingToIdle = 	CorsairGndAttkToIdle,
  SpecialState1 = 	nil,
  SpecialState2 = 	nil,
  AlmostBuilt =   	nil,
  Built =         	nil,
  Landing =       	nil,
  LiftOff =       	nil,
  IsWorking =     	nil,
  WorkingToIdle = 	nil,
  WarpIn =        	CorsairWarpIn
}
-- ----------------------------------------------------------------------------- --

function CorsairInit()
	imgul(930, 0, 42)	-- Corsair Shadow (protoss\corsair.grp)
	CorsairGndAttkToIdle()
end

function CorsairGndAttkToIdle()
	playfram(0x00)	-- Frame set 0
	OverlordLocal00()
end

function CorsairDeath()
	playsnd(533)	-- Protoss\Scout\PScDth00.WAV
	imgol(213, 0, 0)	-- Explosion1 (Small) (thingy\tBangS.grp)
	wait(3) 
end

function CorsairGndAttkInit()
	nobrkcodestart()
	playfram(0x11)	-- Frame set 1
	wait(1) 
	attackwith(1) 
	playfram(0x22)	-- Frame set 2
	wait(1) 
	playfram(0x33)	-- Frame set 3
	wait(1) 
	playfram(0x44)	-- Frame set 4
	wait(1) 
	playfram(0x11)	-- Frame set 1
	wait(1) 
	playfram(0x22)	-- Frame set 2
	wait(1) 
	playfram(0x33)	-- Frame set 3
	wait(1) 
	playfram(0x44)	-- Frame set 4
	wait(1) 
	playfram(0x00)	-- Frame set 0
	wait(1) 
	nobrkcodeend()
	gotorepeatattk()
	CorsairGndAttkToIdle()
end

function CorsairAirAttkInit()
	nobrkcodestart()
	playfram(0x11)	-- Frame set 1
	wait(1) 
	attackwith(2) 
	playsnd(1060)	-- Protoss\Corsair\PCorlasr2.wav
	playfram(0x22)	-- Frame set 2
	wait(1) 
	playfram(0x33)	-- Frame set 3
	wait(1) 
	playfram(0x44)	-- Frame set 4
	wait(1) 
	playfram(0x11)	-- Frame set 1
	wait(1) 
	playfram(0x22)	-- Frame set 2
	wait(1) 
	playfram(0x33)	-- Frame set 3
	wait(1) 
	playfram(0x44)	-- Frame set 4
	wait(1) 
	playfram(0x00)	-- Frame set 0
	wait(1) 
	nobrkcodeend()
	gotorepeatattk()
	CorsairGndAttkToIdle()
end

function CorsairCastSpell()
	playfram(0x00)	-- Frame set 0
	nobrkcodestart()
	wait(1) 
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playsnd(1059)	-- Protoss\Corsair\PCorWeb1.wav
	castspell()
	nobrkcodeend()
	gotorepeatattk()
	sigorder(2) 
	CorsairGndAttkToIdle()
end

function CorsairWalking()
	imgol(931, 0, 0)	-- Corsair Engines (thingy\pcsGlow.grp)
	playfram(0x00)	-- Frame set 0
	setvertpos(0) 
	ScourgeLocal00()
end

function CorsairWarpIn()
	imgol(143, 0, 0)	-- Scout Warp Flash (protoss\scout.grp)
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 931 Corsair Engines (thingy\pcsGlow.grp)
iscript[370] = {
  IsId =          	370,
  Type =          	12,
  Init =          	CorsairEnginesInit,
  Death =         	ScourgeExplosionDeath,
  GndAttkInit =   	ScourgeExplosionDeath,
  AirAttkInit =   	ScourgeExplosionDeath,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	ScourgeExplosionDeath,
  GndAttkToIdle = 	ScourgeExplosionDeath,
  AirAttkToIdle = 	ScourgeExplosionDeath,
  Unused2 =       	nil,
  Walking =       	CorsairEnginesInit,
  WalkingToIdle = 	ScourgeExplosionDeath,
  SpecialState1 = 	nil
}
-- ----------------------------------------------------------------------------- --

function CorsairEnginesInit()
::CorsairEnginesInit_label::
	engframe(0) 
	wait(1) 
	engframe(17) 
	wait(1) 
	goto CorsairEnginesInit_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 933 Dark Templar (Unit) (protoss\dtemplar.grp)
iscript[372] = {
  IsId =          	372,
  Type =          	12,
  Init =          	DarkTemplar_Unit_Init,
  Death =         	DarkTemplar_Unit_Death,
  GndAttkInit =   	DarkTemplar_Unit_GndAttkInit,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	DarkTemplar_Unit_GndAttkInit,
  AirAttkRpt =    	nil,
  CastSpell =     	DarkTemplar_Unit_CastSpell,
  GndAttkToIdle = 	ScourgeLocal00,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	DarkTemplar_Unit_Walking,
  WalkingToIdle = 	DarkTemplar_Unit_Init,
  SpecialState1 = 	nil
}
-- ----------------------------------------------------------------------------- --

function DarkTemplar_Unit_Init()
	playfram(0xdd)	-- Frame set 13
	ScourgeLocal00()
end

function DarkTemplar_Unit_Death()
	playsnd(741)	-- Protoss\DARKTEMPLAR\PDTDth00.WAV
	imgol(153, 0, 0)	-- Zealot Death (protoss\zealot.grp)
	wait(1) 
end

function DarkTemplar_Unit_GndAttkInit()
	playfram(0x00)	-- Frame set 0
	wait(1) 
	nobrkcodestart()
	playfram(0x11)	-- Frame set 1
	wait(1) 
	playfram(0x22)	-- Frame set 2
	wait(1) 
	playfram(0x33)	-- Frame set 3
	wait(1) 
	playfram(0x44)	-- Frame set 4
	wait(1) 
	attackmelee(111)	-- Bullet\UZeFir00.wav
	playfram(0x55)	-- Frame set 5
	wait(1) 
	playfram(0x66)	-- Frame set 6
	wait(1) 
	playfram(0x77)	-- Frame set 7
	wait(1) 
	playfram(0x88)	-- Frame set 8
	wait(1) 
	playfram(0x99)	-- Frame set 9
	wait(1) 
	nobrkcodeend()
	gotorepeatattk()
	ignorerest()
	DarkTemplar_Unit_Init()
end

function DarkTemplar_Unit_CastSpell()
	castspell()
	sigorder(2) 
	gotorepeatattk()
	DarkTemplar_Unit_Init()
end

function DarkTemplar_Unit_Walking()
::DarkTemplar_Unit_Walking_label::
	move(5) 
	wait(1) 
	playfram(0xee)	-- Frame set 14
	move(5) 
	wait(1) 
	playfram(0xff)	-- Frame set 15
	move(5) 
	wait(1) 
	playfram(0x110)	-- Frame set 16
	move(5) 
	wait(1) 
	playfram(0x121)	-- Frame set 17
	move(5) 
	wait(1) 
	playfram(0xaa)	-- Frame set 10
	move(5) 
	wait(1) 
	playfram(0xbb)	-- Frame set 11
	move(5) 
	wait(1) 
	playfram(0xcc)	-- Frame set 12
	move(5) 
	wait(1) 
	playfram(0xdd)	-- Frame set 13
	goto DarkTemplar_Unit_Walking_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 964 Neutron Flare (thingy\PcsSplsh.grp)
iscript[373] = {
  IsId =          	373,
  Type =          	2,
  Init =          	NeutronFlareInit,
  Death =         	NeutronFlareDeath,
  GndAttkInit =   	NeutronFlareDeath,
  AirAttkInit =   	nil
}
-- ----------------------------------------------------------------------------- --

function NeutronFlareInit()
	wait(1) 
	sigorder(1) 
	wait(1) 
	NeutronFlareDeath()
end

function NeutronFlareDeath()
	playfram(0x00)	-- Frame set 0
	playsnd(95)	-- Bullet\SHOCKBMB.wav
	domissiledmg()
	wait(1) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(1) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(1) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(1) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(1) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 951 Disruption Web (thingy\Disrupt.grp)
iscript[374] = {
  IsId =          	374,
  Type =          	1,
  Init =          	DisruptionWebInit,
  Death =         	DisruptionWebDeath
}
-- ----------------------------------------------------------------------------- --

function DisruptionWebInit()
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(1) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(1) 
	playfram(4)	-- Frame set 0,  direction 4
	DisruptionWebLocal00()
end

function DisruptionWebLocal00()
::DisruptionWebLocal00_label::
	playfram(5)	-- Frame set 0,  direction 5
	wait(3) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(3) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(3) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(3) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(3) 
	goto DisruptionWebLocal00_label
end

function DisruptionWebDeath()
	playfram(4)	-- Frame set 0,  direction 4
	wait(1) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(1) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(1) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	playfram(0x00)	-- Frame set 0
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 952 Scantid (Desert) (neutral\Kcritter.grp)
iscript[375] = {
  IsId =          	375,
  Type =          	12,
  Init =          	Scantid_DesertCritter_Init,
  Death =         	Scantid_DesertCritter_Death,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	Scantid_DesertCritter_Walking,
  WalkingToIdle = 	Scantid_DesertCritter_WalkingToIdle,
  SpecialState1 = 	nil
}
-- ----------------------------------------------------------------------------- --

function Scantid_DesertCritter_Init()
	imgul(953, 0, 0)	-- Scantid (Desert) Shadow (neutral\nckShad.grp)
  Scantid_DesertCritter_WalkingToIdle()
end

function Scantid_DesertCritter_WalkingToIdle()
	playfram(0x66)	-- Frame set 6
	ScourgeLocal00()
end

function Scantid_DesertCritter_Death()
	playsnd(975)	-- Misc\CRITTERS\ScDeath01.wav
	setfldirect(0) 
	playfram(0xcc)	-- Frame set 12
	wait(2) 
	playfram(205)	-- Frame set 12,  direction 1
	wait(2) 
	playfram(206)	-- Frame set 12,  direction 2
	wait(2) 
	playfram(207)	-- Frame set 12,  direction 3
	wait(2) 
	playfram(208)	-- Frame set 12,  direction 4
	wait(2) 
	playfram(209)	-- Frame set 12,  direction 5
	wait(2) 
	playfram(210)	-- Frame set 12,  direction 6
	wait(2) 
	playfram(211)	-- Frame set 12,  direction 7
	wait(2) 
end

function Scantid_DesertCritter_Walking()
::Scantid_DesertCritter_Walking_label::
	move(4) 
	wait(1) 
	playfram(0x77)	-- Frame set 7
	move(4) 
	wait(1) 
	playfram(0x88)	-- Frame set 8
	move(4) 
	wait(1) 
	playfram(0x00)	-- Frame set 0
	move(4) 
	wait(1) 
	playfram(0x11)	-- Frame set 1
	move(4) 
	wait(1) 
	playfram(0x22)	-- Frame set 2
	move(4) 
	wait(1) 
	playfram(0x33)	-- Frame set 3
	move(4) 
	wait(1) 
	playfram(0x44)	-- Frame set 4
	move(4) 
	wait(1) 
	playfram(0x55)	-- Frame set 5
	move(4) 
	wait(1) 
	playfram(0x66)	-- Frame set 6
	move(4) 
	wait(1) 
	playfram(0x77)	-- Frame set 7
	move(4) 
	wait(1) 
	playfram(0x88)	-- Frame set 8
	move(4) 
	wait(1) 
	playfram(0x99)	-- Frame set 9
	move(4) 
	wait(1) 
	playfram(0xaa)	-- Frame set 10
	move(4) 
	wait(1) 
	playfram(0xbb)	-- Frame set 11
	goto Scantid_DesertCritter_Walking_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 954 Kakaru (Twilight) (neutral\Scritter.grp)
iscript[376] = {
  IsId =          	376,
  Type =          	12,
  Init =          	Kakaru_TwilightCritter_Init,
  Death =         	Kakaru_TwilightCritter_Death,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	Kakaru_TwilightCritter_Walking,
  WalkingToIdle = 	Kakaru_TwilightCritter_WalkingToIdle,
  SpecialState1 = 	nil
}
-- ----------------------------------------------------------------------------- --

function Kakaru_TwilightCritter_Init()
	imgul(955, 0, 42)	-- Kakaru (Twilight) Shadow (neutral\Scritter.grp)
  Kakaru_TwilightCritter_WalkingToIdle()
end

function Kakaru_TwilightCritter_WalkingToIdle()
::Kakaru_TwilightCritter_WalkingToIdle_label::
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(0x11)	-- Frame set 1
	wait(2) 
	playfram(0x22)	-- Frame set 2
	wait(2) 
	playfram(0x33)	-- Frame set 3
	wait(2) 
	playfram(0x44)	-- Frame set 4
	wait(2) 
	playfram(0x55)	-- Frame set 5
	wait(2) 
	playfram(0x66)	-- Frame set 6
	wait(2) 
	playfram(0x77)	-- Frame set 7
	wait(2) 
	playfram(0x88)	-- Frame set 8
	wait(2) 
	playfram(0x99)	-- Frame set 9
	wait(2) 
	playfram(0xaa)	-- Frame set 10
	wait(2) 
	playfram(0xbb)	-- Frame set 11
	wait(2) 
	goto Kakaru_TwilightCritter_WalkingToIdle_label
end

function Kakaru_TwilightCritter_Death()
	playsnd(979)	-- Misc\CRITTERS\TerDeath01.wav
	setfldirect(0) 
	playfram(0xcc)	-- Frame set 12
	wait(2) 
	playfram(205)	-- Frame set 12,  direction 1
	wait(2) 
	playfram(206)	-- Frame set 12,  direction 2
	wait(2) 
	playfram(207)	-- Frame set 12,  direction 3
	wait(2) 
	playfram(208)	-- Frame set 12,  direction 4
	wait(2) 
	playfram(209)	-- Frame set 12,  direction 5
	wait(2) 
	playfram(210)	-- Frame set 12,  direction 6
	wait(2) 
	playfram(211)	-- Frame set 12,  direction 7
	wait(2) 
	playfram(212)	-- Frame set 12,  direction 8
	wait(2) 
	playfram(213)	-- Frame set 12,  direction 9
	wait(2) 
end

function Kakaru_TwilightCritter_Walking()
::Kakaru_TwilightCritter_Walking_label::
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(0x11)	-- Frame set 1
	wait(1) 
	playfram(0x22)	-- Frame set 2
	wait(1) 
	playfram(0x33)	-- Frame set 3
	wait(1) 
	playfram(0x44)	-- Frame set 4
	wait(1) 
	playfram(0x55)	-- Frame set 5
	wait(1) 
	playfram(0x66)	-- Frame set 6
	wait(1) 
	playfram(0x77)	-- Frame set 7
	wait(1) 
	playfram(0x88)	-- Frame set 8
	wait(1) 
	playfram(0x99)	-- Frame set 9
	wait(1) 
	playfram(0xaa)	-- Frame set 10
	wait(1) 
	playfram(0xbb)	-- Frame set 11
	wait(1) 
	goto Kakaru_TwilightCritter_Walking_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 956 Ursadon (Ice) (neutral\Icritter.grp)
iscript[377] = {
  IsId =          	377,
  Type =          	12,
  Init =          	Ursadon_IceCritter_Init,
  Death =         	Ursadon_IceCritter_Death,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	Ursadon_IceCritter_Walking,
  WalkingToIdle = 	Ursadon_IceCritter_WalkingToIdle,
  SpecialState1 = 	nil
}
-- ----------------------------------------------------------------------------- --

function Ursadon_IceCritter_Init()
	imgul(957, 0, 0)	-- Ursadon (Ice) Shadow (neutral\ncicShad.grp)
  Ursadon_IceCritter_WalkingToIdle()
end

function Ursadon_IceCritter_WalkingToIdle()
	playfram(0x00)	-- Frame set 0
	ScourgeLocal00()
end

function Ursadon_IceCritter_Death()
	playsnd(971)	-- Misc\CRITTERS\PBDeath01.wav
	setfldirect(0) 
	playfram(0x88)	-- Frame set 8
	wait(2) 
	playfram(137)	-- Frame set 8,  direction 1
	wait(2) 
	playfram(138)	-- Frame set 8,  direction 2
	wait(2) 
	playfram(139)	-- Frame set 8,  direction 3
	wait(2) 
	playfram(140)	-- Frame set 8,  direction 4
	wait(50) 
	playfram(141)	-- Frame set 8,  direction 5
	wait(50) 
	playfram(142)	-- Frame set 8,  direction 6
	wait(50) 
	playfram(143)	-- Frame set 8,  direction 7
	wait(50) 
end

function Ursadon_IceCritter_Walking()
::Ursadon_IceCritter_Walking_label::
	move(4) 
	wait(1) 
	playfram(0x00)	-- Frame set 0
	move(4) 
	wait(1) 
	playfram(0x11)	-- Frame set 1
	move(4) 
	wait(1) 
	playfram(0x22)	-- Frame set 2
	move(4) 
	wait(1) 
	playfram(0x33)	-- Frame set 3
	move(4) 
	wait(1) 
	playfram(0x44)	-- Frame set 4
	move(4) 
	wait(1) 
	playfram(0x55)	-- Frame set 5
	move(4) 
	wait(1) 
	playfram(0x66)	-- Frame set 6
	move(4) 
	wait(1) 
	playfram(0x77)	-- Frame set 7
	goto Ursadon_IceCritter_Walking_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 965 Halo Rockets (bullet\SMmissle.grp)
iscript[378] = {
  IsId =          	378,
  Type =          	2,
  Init =          	HaloRocketInit,
  Death =         	HaloRocketDeath,
  GndAttkInit =   	HaloRocketGndAttkInit,
  AirAttkInit =   	nil
}
-- ----------------------------------------------------------------------------- --

function HaloRocketInit()
	playfram(0x00)	-- Frame set 0
	playsnd(1023)	-- Bullet\Tfrshoot.wav
	wait(1) 
	sigorder(1) 
	wait(1) 
	HaloRocketGndAttkInit()
end

function HaloRocketGndAttkInit()
::HaloRocketGndAttkInit_label::
	sprol(505, 0, 0)	-- Halo Rockets Trail (thingy\bsmoke.grp)
	wait(2) 
	goto HaloRocketGndAttkInit_label
end

function HaloRocketDeath()
	playsnd(1022)	-- Bullet\Tfrhit.wav
	imgol(530, 0, 0)	-- Gemini Missiles Explosion (thingy\ecaHit.grp)
	domissiledmg()
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 966 Optical Flare Grenade (bullet\grenade.grp)
iscript[379] = {
  IsId =          	379,
  Type =          	2,
  Init =          	OpticalFlareInit,
  Death =         	OpticalFlareDeath,
  GndAttkInit =   	OpticalFlareGndAttkInit,
  AirAttkInit =   	nil
}
-- ----------------------------------------------------------------------------- --

function OpticalFlareInit()
	playfram(0x00)	-- Frame set 0
	playsnd(1016)	-- Terran\Medic\TMedflsh.wav
	wait(1) 
	sigorder(1) 
	wait(1) 
	OpticalFlareGndAttkInit()
end

function OpticalFlareGndAttkInit()
	sprol(310, 0, 0)	-- Grenade Shot Smoke (thingy\GreSmoke.grp)
	wait(1) 
	OpticalFlareLocal00()
end

function OpticalFlareLocal00()
::OpticalFlareLocal00_label::
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	goto OpticalFlareLocal00_label
end

function OpticalFlareDeath()
	imgol(977, 0, 0)	-- Optical Flare Hit (Medium) (thingy\TmeFlshM.grp)
	domissiledmg()
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 961 Subterranean Spines (bullet\Spike.grp)
iscript[380] = {
  IsId =          	380,
  Type =          	1,
  Init =          	SubterraneanSpinesInit,
  Death =         	ScourgeExplosionDeath
}
-- ----------------------------------------------------------------------------- --

function SubterraneanSpinesInit()
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(1) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(1) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(1) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(1) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(1) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(1) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(1) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	playfram(0x00)	-- Frame set 0
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 962 Corrosive Acid Shot (thingy\ZDvPuke.grp)
iscript[381] = {
  IsId =          	381,
  Type =          	2,
  Init =          	CorrosiveAcidInit,
  Death =         	CorrosiveAcidDeath,
  GndAttkInit =   	CorrosiveAcidGndAttkInit,
  AirAttkInit =   	nil
}
-- ----------------------------------------------------------------------------- --

function CorrosiveAcidInit()
	tmprmgraphicstart()
	trgtrangecondjmp(40, CorrosiveAcidLocal00)
	tmprmgraphicend()
	playfram(0x00)	-- Frame set 0
	wait(1) 
	sigorder(1) 
	wait(1) 
	CorrosiveAcidGndAttkInit()
end

function CorrosiveAcidGndAttkInit()
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(0x11)	-- Frame set 1
	wait(2) 
	playfram(0x22)	-- Frame set 2
	wait(2) 
	playfram(0x33)	-- Frame set 3
	wait(2) 
	ScourgeLocal00()
end

function CorrosiveAcidLocal00()
	playfram(0x00)	-- Frame set 0
	wait(1) 
	sigorder(1) 
	wait(1) 
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(0x11)	-- Frame set 1
	wait(2) 
	playfram(0x22)	-- Frame set 2
	wait(2) 
	playfram(0x33)	-- Frame set 3
	wait(2) 
	ScourgeLocal00()
end

function CorrosiveAcidDeath()
	playsnd(72)	-- Bullet\ZGuHit00.wav
	imgol(963, 0, 0)	-- Corrosive Acid Hit (thingy\ZDvHit.grp)
	domissiledmg()
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 963 Corrosive Acid Hit (thingy\ZDvHit.grp)
iscript[382] = {
  IsId =          	382,
  Type =          	1,
  Init =          	CorrosiveAcidHitInit,
  Death =         	CorrosiveAcidHitDeath
}
-- ----------------------------------------------------------------------------- --

function CorrosiveAcidHitInit()
	playfram(0x00)	-- Frame set 0
	playsnd(1095)	-- Zerg\Devourer\goophit.wav
	wait(1) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(1) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(1) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(1) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(1) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(1) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(1) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(1) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(1) 
	CorrosiveAcidHitDeath()
end

function CorrosiveAcidHitDeath()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 986 Acid Spores (1) Overlay (Small) (thingy\ZdvGooS.grp)
-- 990 Acid Spores (1) Overlay (Medium) (thingy\ZdvGooM.grp)
-- 994 Acid Spores (1) Overlay (Large) (thingy\ZdvGooL.grp)
iscript[383] = {
  IsId =          	383,
  Type =          	1,
  Init =          	AcidSpores_1_OverlayInit,
  Death =         	ScourgeExplosionDeath
}
-- ----------------------------------------------------------------------------- --

function AcidSpores_1_OverlayInit()
	tmprmgraphicstart()
	waitrand(1, 3) 
	tmprmgraphicend()
  AcidSpores_1_OverlayLocal00()
end

function AcidSpores_1_OverlayLocal00()
::AcidSpores_1_OverlayLocal00_label::
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(0x11)	-- Frame set 1
	wait(2) 
	playfram(0x22)	-- Frame set 2
	wait(2) 
	playfram(0x33)	-- Frame set 3
	waitrand(2, 3) 
	goto AcidSpores_1_OverlayLocal00_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 987 Acid Spores (2-3) Overlay (Small) (thingy\ZdvGooS.grp)
-- 991 Acid Spores (2-3) Overlay (Medium) (thingy\ZdvGooM.grp)
-- 995 Acid Spores (2-3) Overlay (Large) (thingy\ZdvGooL.grp)
iscript[384] = {
  IsId =          	384,
  Type =          	1,
  Init =          	AcidSpores_2_3_OverlayInit,
  Death =         	ScourgeExplosionDeath
}
-- ----------------------------------------------------------------------------- --

function AcidSpores_2_3_OverlayInit()
	tmprmgraphicstart()
	waitrand(1, 3) 
	tmprmgraphicend()
  AcidSpores_2_3_OverlayLocal00()
end

function AcidSpores_2_3_OverlayLocal00()
::AcidSpores_2_3_OverlayLocal00_label::
	playfram(0x44)	-- Frame set 4
	wait(2) 
	playfram(0x55)	-- Frame set 5
	wait(2) 
	playfram(0x66)	-- Frame set 6
	wait(2) 
	playfram(0x77)	-- Frame set 7
	waitrand(2, 3) 
	goto AcidSpores_2_3_OverlayLocal00_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 988 Acid Spores (4-5) Overlay (Small) (thingy\ZdvGooS.grp)
-- 992 Acid Spores (4-5) Overlay (Medium) (thingy\ZdvGooM.grp)
-- 996 Acid Spores (4-5) Overlay (Large) (thingy\ZdvGooL.grp)
iscript[385] = {
  IsId =          	385,
  Type =          	1,
  Init =          	AcidSpores_4_5_OverlayInit,
  Death =         	ScourgeExplosionDeath
}
-- ----------------------------------------------------------------------------- --

function AcidSpores_4_5_OverlayInit()
	tmprmgraphicstart()
	waitrand(1, 3) 
	tmprmgraphicend()
  AcidSpores_4_5_OverlayLocal00()
end

function AcidSpores_4_5_OverlayLocal00()
::AcidSpores_4_5_OverlayLocal00_label::
	playfram(0x88)	-- Frame set 8
	wait(2) 
	playfram(0x99)	-- Frame set 9
	wait(2) 
	playfram(0xaa)	-- Frame set 10
	wait(2) 
	playfram(0xbb)	-- Frame set 11
	waitrand(2, 3) 
	goto AcidSpores_4_5_OverlayLocal00_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 989 Acid Spores (6-9) Overlay (Small) (thingy\ZdvGooS.grp)
-- 993 Acid Spores (6-9) Overlay (Medium) (thingy\ZdvGooM.grp)
-- 997 Acid Spores (6-9) Overlay (Large) (thingy\ZdvGooL.grp)
iscript[386] = {
  IsId =          	386,
  Type =          	1,
  Init =          	AcidSpores_6_9_OverlayInit,
  Death =         	ScourgeExplosionDeath
}
-- ----------------------------------------------------------------------------- --

function AcidSpores_6_9_OverlayInit()
	tmprmgraphicstart()
	waitrand(1, 3) 
	tmprmgraphicend()
  AcidSpores_6_9_OverlayLocal00()
end

function AcidSpores_6_9_OverlayLocal00()
::AcidSpores_6_9_OverlayLocal00_label::
	playfram(0xcc)	-- Frame set 12
	wait(2) 
	playfram(0xdd)	-- Frame set 13
	wait(2) 
	playfram(0xee)	-- Frame set 14
	wait(2) 
	playfram(0xff)	-- Frame set 15
	waitrand(2, 3) 
	goto AcidSpores_6_9_OverlayLocal00_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 832 12/30 Ice2 (thingy\tileset\ice\HDPipes.grp)
-- 836 12/24 Ice2 (thingy\tileset\ice\LDRck01.grp)
-- 838 12/25 Ice2 (thingy\tileset\ice\LDRck02.grp)
-- 904 6/13 Desert2 (thingy\tileset\desert\HDLbox01.grp)
-- 907 4/15 Desert2 (thingy\tileset\desert\LDLbox01.grp)
-- 909 8/23 Desert (thingy\tileset\desert\LDMachn1.grp)
iscript[387] = {
  IsId =          	387,
  Type =          	0,
  Init =          	IceDoodadInit,
  Death =         	nil
}
-- ----------------------------------------------------------------------------- --

function IceDoodadInit()
	playfram(0x00)	-- Frame set 0
	setflipstate(1) 
	imgulnextid(0, 0) 
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 833 12/30 Ice2 Shadow (thingy\tileset\ice\SHDPipes.grp)
-- 837 12/24 Ice2 Shadow (thingy\tileset\ice\SLDRck01.grp)
-- 839 12/25 Ice2 Shadow (thingy\tileset\ice\SLDRck02.grp)
-- 905 6/13 Desert2 Shadow (thingy\tileset\desert\SHDLbox1.grp)
-- 908 4/15 Desert2 Shadow (thingy\tileset\desert\SLDLbox1.grp)
-- 910 8/23 Desert Shadow (thingy\tileset\desert\SLDMchn1.grp)
iscript[388] = {
  IsId =          	388,
  Type =          	1,
  Init =          	DoodadShadowsHeader_BW_Init,
  Death =         	ScourgeExplosionDeath
}
-- ----------------------------------------------------------------------------- --

function DoodadShadowsHeader_BW_Init()
::DoodadShadowsHeader_BW_Init_label::
	wait(1) 
	followmaingraphic()
	goto DoodadShadowsHeader_BW_Init_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 967 Restoration Hit (Small) (thingy\tCureSml.grp)
-- 968 Restoration Hit (Medium) (thingy\tCureMed.grp)
-- 969 Restoration Hit (Large) (thingy\tCureLrg.grp)
iscript[389] = {
  IsId =          	389,
  Type =          	1,
  Init =          	RestorationHitInit,
  Death =         	ScourgeExplosionDeath
}
-- ----------------------------------------------------------------------------- --

function RestorationHitInit()
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(1) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(1) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(1) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(1) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(1) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(1) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(1) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(1) 
	playfram(10)	-- Frame set 0,  direction 10
	wait(1) 
	playfram(11)	-- Frame set 0,  direction 11
	wait(1) 
	playfram(12)	-- Frame set 0,  direction 12
	wait(1) 
	playfram(13)	-- Frame set 0,  direction 13
	wait(1) 
	playfram(14)	-- Frame set 0,  direction 14
	wait(1) 
	playfram(15)	-- Frame set 0,  direction 15
	wait(1) 
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(1) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(1) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(1) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(1) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(1) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(1) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(1) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(1) 
	playfram(10)	-- Frame set 0,  direction 10
	wait(1) 
	playfram(11)	-- Frame set 0,  direction 11
	wait(1) 
	playfram(12)	-- Frame set 0,  direction 12
	wait(1) 
	playfram(13)	-- Frame set 0,  direction 13
	wait(1) 
	playfram(14)	-- Frame set 0,  direction 14
	wait(1) 
	playfram(15)	-- Frame set 0,  direction 15
	wait(1) 
	ScourgeExplosionDeath()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 973 Mind Control Hit (Small) (thingy\PDaMyoSm.grp)
-- 974 Mind Control Hit (Medium) (thingy\PDaMyoMd.grp)
-- 975 Mind Control Hit (Large) (thingy\PDaMyoLg.grp)
iscript[390] = {
  IsId =          	390,
  Type =          	1,
  Init =          	MindControlHitInit,
  Death =         	ScourgeExplosionDeath
}
-- ----------------------------------------------------------------------------- --

function MindControlHitInit()
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(1) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(1) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(1) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(1) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(1) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(1) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(1) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(1) 
	playfram(10)	-- Frame set 0,  direction 10
	wait(1) 
	playfram(11)	-- Frame set 0,  direction 11
	wait(1) 
	playfram(12)	-- Frame set 0,  direction 12
	wait(1) 
	playfram(13)	-- Frame set 0,  direction 13
	wait(1) 
	playfram(14)	-- Frame set 0,  direction 14
	wait(1) 
	playfram(15)	-- Frame set 0,  direction 15
	wait(1) 
	playfram(16)	-- Frame set 0,  direction 16
	wait(1) 
	playfram(0x11)	-- Frame set 1
	wait(1) 
	playfram(18)	-- Frame set 1,  direction 1
	wait(1) 
	ScourgeExplosionDeath()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 976 Optical Flare Hit (Small) (thingy\TmeFlshS.grp)
-- 977 Optical Flare Hit (Medium) (thingy\TmeFlshM.grp)
-- 978 Optical Flare Hit (Large) (thingy\TmeFlshL.grp)
iscript[391] = {
  IsId =          	391,
  Type =          	1,
  Init =          	OpticalFlareHitInit,
  Death =         	ScourgeExplosionDeath
}
-- ----------------------------------------------------------------------------- --

function OpticalFlareHitInit()
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(1) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(1) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(1) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(1) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(1) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(1) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(1) 
	ScourgeExplosionDeath()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 979 Feedback (Small) (thingy\PDaPsySm.grp)
-- 980 Feedback (Medium) (thingy\PDaPsyMd.grp)
-- 981 Feedback Hit (Large) (thingy\PDaPsyLg.grp)
iscript[392] = {
  IsId =          	392,
  Type =          	1,
  Init =          	FeedbackInit,
  Death =         	ScourgeExplosionDeath
}
-- ----------------------------------------------------------------------------- --

function FeedbackInit()
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(1) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(1) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(1) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(1) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(1) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(1) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(1) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(1) 
	playfram(10)	-- Frame set 0,  direction 10
	wait(1) 
	playfram(11)	-- Frame set 0,  direction 11
	wait(1) 
	playfram(12)	-- Frame set 0,  direction 12
	wait(1) 
	playfram(13)	-- Frame set 0,  direction 13
	wait(1) 
	playfram(14)	-- Frame set 0,  direction 14
	wait(1) 
	playfram(15)	-- Frame set 0,  direction 15
	wait(1) 
	playfram(16)	-- Frame set 0,  direction 16
	wait(1) 
	playfram(0x11)	-- Frame set 1
	wait(1) 
	playfram(18)	-- Frame set 1,  direction 1
	wait(1) 
	playfram(19)	-- Frame set 1,  direction 2
	wait(1) 
	playfram(20)	-- Frame set 1,  direction 3
	ScourgeExplosionDeath()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 982 Maelstorm Overlay (Small) (thingy\PDaParSm.grp)
-- 983 Maelstorm Overlay (Medium) (thingy\PDaParMd.grp)
-- 984 Maelstorm Overlay (Large) (thingy\PDaParLg.grp)
iscript[393] = {
  IsId =          	393,
  Type =          	1,
  Init =          	MaelstormOverlayInit,
  Death =         	ScourgeExplosionDeath
}
-- ----------------------------------------------------------------------------- --

function MaelstormOverlayInit()
::MaelstormOverlayInit_label::
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(2) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(2) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(2) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(2) 
	playfram(10)	-- Frame set 0,  direction 10
	wait(2) 
	playfram(11)	-- Frame set 0,  direction 11
	wait(2) 
	playfram(12)	-- Frame set 0,  direction 12
	wait(2) 
	playfram(13)	-- Frame set 0,  direction 13
	wait(2) 
	playfram(14)	-- Frame set 0,  direction 14
	wait(2) 
	playfram(15)	-- Frame set 0,  direction 15
	wait(2) 
	playfram(16)	-- Frame set 0,  direction 16
	wait(2) 
	playfram(0x11)	-- Frame set 1
	wait(2) 
	playfram(18)	-- Frame set 1,  direction 1
	wait(2) 
	playfram(19)	-- Frame set 1,  direction 2
	wait(2) 
	playfram(20)	-- Frame set 1,  direction 3
	wait(2) 
	playfram(21)	-- Frame set 1,  direction 4
	wait(2) 
	playfram(22)	-- Frame set 1,  direction 5
	wait(2) 
	playfram(23)	-- Frame set 1,  direction 6
	wait(2) 
	goto MaelstormOverlayInit_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 985 Subterranean Spines Hit (zerg\zmarker.grp)
iscript[395] = {
  IsId =          	395,
  Type =          	2,
  Init =          	Unknown395Init,
  Death =         	Unknown395Death,
  GndAttkInit =   	Unknown395GndAttkInit,
  AirAttkInit =   	nil
}
-- ----------------------------------------------------------------------------- --

function Unknown395Init()
	playsnd(1108)	-- Bullet\ZLrkFir1.wav
	wait(1) 
	sigorder(1) 
	wait(1) 
	Unknown395GndAttkInit()
end

function Unknown395GndAttkInit()
::Unknown395GndAttkInit_label::
	grdsprol(511, 0, 0)	-- Subterranean Spines (bullet\Spike.grp)
	dogrddamage()
	wait(2) 
	goto Unknown395GndAttkInit_label
end

function Unknown395Death()
	playsnd(1110)	-- Bullet\ZLrkHit1.wav
	imgol(530, 0, 0)	-- Gemini Missiles Explosion (thingy\ecaHit.grp)
	dogrddamage()
	wait(1) 
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 851 10/10 Desert1 (thingy\tileset\desert\HDBANT.grp)
iscript[396] = {
  IsId =          	396,
  Type =          	0,
  Init =          	DesertDoodadInit,
  Death =         	nil
}
-- ----------------------------------------------------------------------------- --

function DesertDoodadInit()
	playfram(0x00)	-- Frame set 0
	DesertDoodadLocal00()
end

function DesertDoodadLocal00()
::DesertDoodadLocal00_label::
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(1) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(1) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(1) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(1) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(1) 
	goto DesertDoodadLocal00_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 889 4/9 Desert (thingy\tileset\desert\LDBNEON.grp)
iscript[397] = {
  IsId =          	397,
  Type =          	0,
  Init =          	DesertDoodad2Init,
  Death =         	nil
}
-- ----------------------------------------------------------------------------- --

function DesertDoodad2Init()
	playfram(0x00)	-- Frame set 0
	DesertDoodad2Local00()
end

function DesertDoodad2Local00()
::DesertDoodad2Local00_label::
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(1) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(1) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	playfram(0x00)	-- Frame set 0
	wait(1) 
	goto DesertDoodad2Local00_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 894 4/8 Desert (thingy\tileset\desert\Ldneon.grp)
-- 913 Unknown913 (protoss\scout.grp)
iscript[398] = {
  IsId =          	398,
  Type =          	0,
  Init =          	DesertDoodad3Init,
  Death =         	nil
}
-- ----------------------------------------------------------------------------- --

function DesertDoodad3Init()
	playfram(0x00)	-- Frame set 0
	DesertDoodad3Local00()
end

function DesertDoodad3Local00()
::DesertDoodad3Local00_label::
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(1) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(1) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	playfram(0x00)	-- Frame set 0
	wait(1) 
	goto DesertDoodad3Local00_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 911 12/1 Desert Overlay (thingy\tileset\desert\Tgas.grp)
iscript[399] = {
  IsId =          	399,
  Type =          	0,
  Init =          	DesertDoodadOverlayInit,
  Death =         	nil
}
-- ----------------------------------------------------------------------------- --

function DesertDoodadOverlayInit()
	playfram(0x00)	-- Frame set 0
	DesertDoodadOverlayLocal00()
end

function DesertDoodadOverlayLocal00()
::DesertDoodadOverlayLocal00_label::
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(1) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(1) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(1) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(1) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(1) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(1) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(1) 
	playfram(9)	-- Frame set 0,  direction 9
	wait(1) 
	playfram(10)	-- Frame set 0,  direction 10
	waitrand(63, 75) 
	goto DesertDoodadOverlayLocal00_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 912 11/3 Desert (thingy\tileset\desert\sarlacc.grp)
iscript[400] = {
  IsId =          	400,
  Type =          	0,
  Init =          	DesertDoodadInit,
  Death =         	nil
}
-- ----------------------------------------------------------------------------- --

function DesertDoodadInit()
	playfram(0x00)	-- Frame set 0
	DesertDoodadLocal00()
end

function DesertDoodadLocal00()
::DesertDoodadLocal00_label::
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(2) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(2) 
	goto DesertDoodadLocal00_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 756 Unknown Twilight (thingy\tileset\twilight\Lddrill.grp)
iscript[401] = {
  IsId =          	401,
  Type =          	0,
  Init =          	TwilightDoodadInit,
  Death =         	nil
}
-- ----------------------------------------------------------------------------- --

function TwilightDoodadInit()
	playfram(0x00)	-- Frame set 0
	TwilightDoodadLocal00()
end

function TwilightDoodadLocal00()
::TwilightDoodadLocal00_label::
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(1) 
	goto TwilightDoodadLocal00_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 757 7/13 Twilight (thingy\tileset\twilight\Ldxel01.grp)
iscript[402] = {
  IsId =          	402,
  Type =          	0,
  Init =          	TwilightDoodadInit,
  Death =         	nil
}
-- ----------------------------------------------------------------------------- --

function TwilightDoodadInit()
	playfram(0x00)	-- Frame set 0
	TwilightDoodadLocal00()
end

function TwilightDoodadLocal00()
::TwilightDoodadLocal00_label::
	playfram(0x00)	-- Frame set 0
	wait(1) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(1) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(1) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(1) 
	playfram(0x00)	-- Frame set 0
	wait(1) 
	goto TwilightDoodadLocal00_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 758 7/14 Twilight (thingy\tileset\twilight\Ldxel02.grp)
iscript[403] = {
  IsId =          	403,
  Type =          	0,
  Init =          	TwilightDoodadInit,
  Death =         	nil
}
-- ----------------------------------------------------------------------------- --

function TwilightDoodadInit()
	playfram(0x00)	-- Frame set 0
	TwilightDoodadLocal00()
end

function TwilightDoodadLocal00()
::TwilightDoodadLocal00_label::
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	goto TwilightDoodadLocal00_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 763 7/17 Twilight (thingy\tileset\twilight\Ldxeltur.grp)
iscript[404] = {
  IsId =          	404,
  Type =          	0,
  Init =          	TwilightDoodadInit,
  Death =         	nil
}
-- ----------------------------------------------------------------------------- --

function TwilightDoodadInit()
	playfram(0x00)	-- Frame set 0
	TwilightDoodadLocal00()
end

function TwilightDoodadLocal00()
::TwilightDoodadLocal00_label::
	playfram(0x00)	-- Frame set 0
	setflipstate(0) 
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(2) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(2) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(2) 
	setflipstate(1) 
	sethorpos(-3)
	playfram(7)	-- Frame set 0,  direction 7
	wait(2) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	goto TwilightDoodadLocal00_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 947 Psi Disrupter (neutral\PsiDisr.grp)
iscript[407] = {
  IsId =          	407,
  Type =          	20,
  Init =          	PsiDisrupterInit,
  Death =         	AcademyDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	nil,
  WalkingToIdle = 	nil,
  SpecialState1 = 	nil,
  SpecialState2 = 	nil,
  AlmostBuilt =   	nil,
  Built =         	PsiDisrupterBuilt,
  Landing =       	nil,
  LiftOff =       	nil,
  IsWorking =     	ScourgeLocal00,
  WorkingToIdle = 	ScourgeLocal00,
  WarpIn =        	nil
}
-- ----------------------------------------------------------------------------- --

function PsiDisrupterInit()
	imgul(948, 0, 0)	-- Psi Disrupter Shadow (neutral\tpdShad.grp)
	PsiDisrupterBuilt()
end

function PsiDisrupterBuilt()
	playfram(0x00)	-- Frame set 0
	ScourgeLocal00()
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 949 Power Generator (neutral\Generate.grp)
iscript[408] = {
  IsId =          	408,
  Type =          	20,
  Init =          	PowerGeneratorInit,
  Death =         	AcademyDeath,
  GndAttkInit =   	nil,
  AirAttkInit =   	nil,
  Unused1 =       	nil,
  GndAttkRpt =    	nil,
  AirAttkRpt =    	nil,
  CastSpell =     	nil,
  GndAttkToIdle = 	nil,
  AirAttkToIdle = 	nil,
  Unused2 =       	nil,
  Walking =       	nil,
  WalkingToIdle = 	nil,
  SpecialState1 = 	nil,
  SpecialState2 = 	nil,
  AlmostBuilt =   	nil,
  Built =         	PowerGeneratorBuilt,
  Landing =       	nil,
  LiftOff =       	nil,
  IsWorking =     	ScourgeLocal00,
  WorkingToIdle = 	ScourgeLocal00,
  WarpIn =        	nil
}
-- ----------------------------------------------------------------------------- --

function PowerGeneratorInit()
	imgul(950, 0, 0)	-- Power Generator Shadow (neutral\tgnShad.grp)
	PowerGeneratorBuilt()
end

function PowerGeneratorBuilt()
::PowerGeneratorBuilt_label::
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(2) 
	goto PowerGeneratorBuilt_label
end

-- ----------------------------------------------------------------------------- --
-- This header is used by images.dat function entries()
-- 998 Maelstorm Hit (thingy\MaelHit.grp)
iscript[411] = {
  IsId =          	411,
  Type =          	1,
  Init =          	MaelstromHitInit,
  Death =         	ScourgeExplosionDeath
}
-- ----------------------------------------------------------------------------- --

function MaelstromHitInit()
	playfram(0x00)	-- Frame set 0
	wait(2) 
	playfram(1)	-- Frame set 0,  direction 1
	wait(2) 
	playfram(2)	-- Frame set 0,  direction 2
	wait(2) 
	playfram(3)	-- Frame set 0,  direction 3
	wait(2) 
	playfram(4)	-- Frame set 0,  direction 4
	wait(2) 
	playfram(5)	-- Frame set 0,  direction 5
	wait(2) 
	playfram(6)	-- Frame set 0,  direction 6
	wait(2) 
	playfram(7)	-- Frame set 0,  direction 7
	wait(2) 
	playfram(8)	-- Frame set 0,  direction 8
	wait(2) 
end

-- ----------------------------------------------------------------------------- --
-- ----------------------------------------------------------------------------- --
-- ----------------------------------------------------------------------------- --
