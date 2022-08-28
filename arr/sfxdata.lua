local sounds = {
  nil, {
    type = "sound",
    filename = "sound/zerg/drone/zdrerr00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_z_error"
  }, {
    type = "sound",
    filename = "sound/misc/buzz.wav",
    category = "alert",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_t_error"
  }, {
    type = "sound",
    filename = "sound/misc/perror.wav",
    category = "alert",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_p_error"
  }, {
    type = "sound",
    filename = "sound/misc/zbldgplc.wav",
    category = "gui-effect",
    preload = true,
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_z_thunk"
  }, {
    type = "sound",
    filename = "sound/misc/tbldgplc.wav",
    category = "gui-effect",
    preload = true,
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_t_thunk"
  }, {
    type = "sound",
    filename = "sound/misc/pbldgplc.wav",
    category = "gui-effect",
    preload = true,
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_p_thunk"
  }, {
    type = "sound",
    filename = "sound/misc/explolrg.wav",
    --audible_distance_modifier = 40.0,
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_explode_big"
  }, {
    type = "sound",
    filename = "sound/misc/explomed.wav",
    --audible_distance_modifier = 30.0,
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_explode_med"
  }, {
    type = "sound",
    filename = "sound/misc/explosm.wav",
    --audible_distance_modifier = 20.0,
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_explode_sm"
  }, {
    type = "sound",
    filename = "sound/misc/explo1.wav",
    --audible_distance_modifier = 10.0,
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_explode1"
  }, {
    type = "sound",
    filename = "sound/misc/explo2.wav",
    --audible_distance_modifier = 10.0,
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_explode2"
  }, {
    type = "sound",
    filename = "sound/misc/explo3.wav",
    --audible_distance_modifier = 10.0,
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_explode3"
  }, {
    type = "sound",
    filename = "sound/misc/explo4.wav",
    --audible_distance_modifier = 10.0,
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_explode4"
  }, {
    type = "sound",
    filename = "sound/misc/explo5.wav",
    --audible_distance_modifier = 10.0,
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_explode5"
  }, {
    type = "sound",
    filename = "sound/misc/button.wav",
    category = "gui-effect",
    preload = true,
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_button"
  }, {
    type = "sound",
    filename = "sound/misc/burrowdn.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_burrow"
  }, {
    type = "sound",
    filename = "sound/misc/burrowup.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_deburrow"
  }, {
    type = "sound",
    filename = "sound/misc/onfirsml.wav",
    category = "gui-effect",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_on_fire_small"
  }, {
    type = "sound",
    filename = "sound/misc/intonydus.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_nydus_in"
  }, {
    type = "sound",
    filename = "sound/misc/outofgas.wav",
    category = "alert",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_gas_depleted"
  }, {
    type = "sound",
    filename = "sound/misc/youwin.wav",
    category = "alert",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_victory"
  }, {
    type = "sound",
    filename = "sound/misc/youlose.wav",
    category = "alert",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_defeat"
  }, {
    type = "sound",
    filename = "sound/misc/transmission.wav",
    category = "gui-effect",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_transmission"
  }, {
    type = "sound",
    filename = "sound/misc/door/door1opn.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_door1_open"
  }, {
    type = "sound",
    filename = "sound/misc/door/door1cls.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_door1_close"
  }, {
    type = "sound",
    filename = "sound/misc/door/door2opn.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_door2_open"
  }, {
    type = "sound",
    filename = "sound/misc/door/door2cls.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_door2_close"
  }, {
    type = "sound",
    filename = "sound/misc/door/door3opn.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_door3_open"
  }, {
    type = "sound",
    filename = "sound/misc/door/door3cls.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_door3_close"
  }, {
    type = "sound",
    filename = "sound/misc/door/door4opn.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_door4_open"
  }, {
    type = "sound",
    filename = "sound/misc/door/door4cls.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_door4_close"
  }, {
    type = "sound",
    filename = "sound/misc/zrescue.wav",
    category = "alert",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_zerg_rescue"
  }, {
    type = "sound",
    filename = "sound/misc/trescue.wav",
    category = "alert",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_terran_rescue"
  }, {
    type = "sound",
    filename = "sound/misc/prescue.wav",
    category = "alert",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_protoss_rescue"
  }, {
    type = "sound",
    variations = {
      { filename = "sound/terran/scv/edrrep00.wav" },
      { filename = "sound/terran/scv/edrrep01.wav" },
      { filename = "sound/terran/scv/edrrep02.wav" },
      { filename = "sound/terran/scv/edrrep03.wav" },
      { filename = "sound/terran/scv/edrrep04.wav" }
    },
    aggregation = {
      max_count = 1,
      remove = false
    },
    name = "sc_snd_first_repair"
  }, 
  nil, 
  nil, 
  nil, 
  nil, {
    type = "sound",
    filename = "sound/misc/zovtra00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_overlord_load"
  }, {
    type = "sound",
    filename = "sound/misc/tdrtra00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_dropship_load"
  }, {
    type = "sound",
    filename = "sound/misc/pshtra00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_shuttle_load"
  }, {
    type = "sound",
    filename = "sound/misc/zovtra01.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_overlord_unload"
  }, {
    type = "sound",
    filename = "sound/misc/tdrtra01.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_dropship_unload"
  }, {
    type = "sound",
    filename = "sound/misc/pshtra01.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_shuttle_unload"
  }, 
  nil, 
  nil, 
  nil, {
    type = "sound",
    filename = "sound/misc/critters/jcrdth00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_jungle_critter_death"
  }, 
  nil, 
  nil, 
  nil, {
    type = "sound",
    filename = "sound/misc/critters/lcrdth00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_lava_critter_death"
  }, 
  nil, 
  nil, 
  nil, {
    type = "sound",
    filename = "sound/misc/critters/bcrdth00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_badlands_critter_death"
  }, {
    type = "sound",
    filename = "sound/bullet/parfir00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_archon_attack"
  }, {
    type = "sound",
    filename = "sound/bullet/zhyfir00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_spine_attack"
  }, {
    type = "sound",
    filename = "sound/bullet/zhyhit00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_spine_hit"
  }, {
    type = "sound",
    filename = "sound/bullet/zdrhit00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_drone_hit"
  }, {
    type = "sound",
    filename = "sound/bullet/laserhit.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_laser_hit"
  }, {
    type = "sound",
    filename = "sound/bullet/pshield.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_pshield"
  }, {
    type = "sound",
    filename = "sound/bullet/spooghit.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_spooge_hit"
  }, {
    type = "sound",
    filename = "sound/bullet/blastcan.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_blastcannon"
  }, {
    type = "sound",
    filename = "sound/bullet/blastgn2.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_blastgun"
  }, {
    type = "sound",
    filename = "sound/bullet/zbghit00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_bugguy_hit"
  }, {
    type = "sound",
    filename = "sound/bullet/ttafir00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_cannon"
  }, {
    type = "sound",
    filename = "sound/bullet/tmafir00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_chaingun_marine"
  }, {
    type = "sound",
    filename = "sound/bullet/tgofir00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_chaingun_goliath"
  }, {
    type = "sound",
    filename = "sound/bullet/zgufir00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_guardian_attack"
  }, {
    type = "sound",
    filename = "sound/bullet/zguhit00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_guardian_hit"
  }, {
    type = "sound",
    filename = "sound/bullet/laserb.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_laserbeam"
  }, {
    type = "sound",
    filename = "sound/bullet/tphfi100.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_laserbolt"
  }, {
    type = "sound",
    filename = "sound/bullet/lasrhit1.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_laserhit_sm"
  }, {
    type = "sound",
    filename = "sound/bullet/lasrhit2.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_laserhit_med"
  }, {
    type = "sound",
    filename = "sound/bullet/lasrhit3.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_laserhit_lg"
  }, {
    type = "sound",
    filename = "sound/bullet/zlufir00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_lurker_attack"
  }, {
    type = "sound",
    filename = "sound/bullet/zluhit00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_lurker_hit"
  }, {
    type = "sound",
    filename = "sound/bullet/hkmissle.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_missile_hk"
  }, {
    type = "sound",
    filename = "sound/bullet/tgofi200.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_missile_goliath"
  }, {
    type = "sound",
    filename = "sound/bullet/tphfi200.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_first_missile_gemini"
  }, 
  nil, {
    type = "sound",
    filename = "sound/bullet/tnsfir00.wav",
    --audible_distance_modifier = 20.0,
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_nuke_launch"
  }, {
    type = "sound",
    filename = "sound/bullet/tnshit00.wav",
    --audible_distance_modifier = 50.0,
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_nuke_hit"
  }, {
    type = "sound",
    filename = "sound/bullet/phoatt00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_photon_battery_attack"
  }, {
    type = "sound",
    filename = "sound/bullet/phohit00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_photon_battery_hit"
  }, {
    type = "sound",
    filename = "sound/bullet/psiblade.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_psi_blade"
  }, {
    type = "sound",
    filename = "sound/bullet/psibolt.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_psi_bolt"
  }, {
    type = "sound",
    filename = "sound/bullet/zqufir00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_queen_attack"
  }, {
    type = "sound",
    variations = {
      { filename = "sound/bullet/zquhit00.wav" },
      { filename = "sound/bullet/zquhit01.wav" }
    },
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_queen_hit1"
  }, 
  nil, {
    type = "sound",
    filename = "sound/bullet/zquhit02.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_queen_hit3"
  }, {
    type = "sound",
    filename = "sound/bullet/tscfir00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_scv_zap"
  }, {
    type = "sound",
    filename = "sound/bullet/shockbmb.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_shock_bomb"
  }, {
    type = "sound",
    filename = "sound/bullet/ttafi200.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_shock_cannon"
  }, {
    type = "sound",
    filename = "sound/bullet/shcklnch.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_shock_launch"
  }, {
    type = "sound",
    filename = "sound/bullet/tghfir00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_ghost_attack"
  }, {
    type = "sound",
    filename = "sound/bullet/dragbull.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_dragoon_bullet"
  }, {
    type = "sound",
    filename = "sound/bullet/psahit00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_trilobyter_hit"
  }, {
    type = "sound",
    filename = "sound/bullet/laserb.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_templar_attack"
  }, {
    type = "sound",
    variations = {
      { filename = "sound/bullet/ptrfir00.wav" },
      { filename = "sound/bullet/ptrfir01.wav" }
    },
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_first_trilobyte_attack"
  }, 
  nil, {
    type = "sound",
    filename = "sound/bullet/pzefir00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_zealot_attack"
  }, {
    type = "sound",
    filename = "sound/bullet/tbafir00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_battleship_attack"
  }, {
    type = "sound",
    filename = "sound/bullet/tvufir00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_vulture_attack"
  }, {
    type = "sound",
    variations = {
      { filename = "sound/bullet/tvuhit00.wav" },
      { filename = "sound/bullet/tvuhit01.wav" },
      { filename = "sound/bullet/tvuhit02.wav" }
    },
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_first_grenade_hit"
  }, 
  nil, 
  nil, {
    type = "sound",
    filename = "sound/bullet/zdeatt00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_defiler_attack"
  }, {
    type = "sound",
    filename = "sound/bullet/uzefir00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_dark_templar_attack"
  }, {
    type = "sound",
    filename = "sound/bullet/ukifir00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_infested_kerri_attack"
  }, {
    type = "sound",
    filename = "sound/bullet/zmufir00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_mutalisk_attack"
  }, {
    type = "sound",
    filename = "sound/misc/zpwrdown.wav",
    category = "gui-effect",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_z_disabled"
  }, {
    type = "sound",
    filename = "sound/misc/tpwrdown.wav",
    category = "gui-effect",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_t_disabled"
  }, {
    type = "sound",
    filename = "sound/misc/ppwrdown.wav",
    category = "gui-effect",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_p_disabled"
  }, {
    type = "sound",
    filename = "sound/zerg/advisor/zadupd00.wav",
    category = "alert",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_z_bldg_help"
  }, {
    type = "sound",
    filename = "sound/terran/advisor/tadupd00.wav",
    category = "alert",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_t_bldg_help"
  }, {
    type = "sound",
    filename = "sound/protoss/advisor/padupd00.wav",
    category = "alert",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_p_bldg_help"
  }, {
    type = "sound",
    filename = "sound/zerg/advisor/zadupd01.wav",
    category = "alert",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_z_enemy_near"
  }, {
    type = "sound",
    filename = "sound/terran/advisor/tadupd01.wav",
    category = "alert",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_t_enemy_near"
  }, {
    type = "sound",
    filename = "sound/protoss/advisor/padupd01.wav",
    category = "alert",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_p_enemy_near"
  }, {
    type = "sound",
    filename = "sound/zerg/advisor/zadupd02.wav",
    category = "alert",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_z_research_complete"
  }, {
    type = "sound",
    filename = "sound/terran/advisor/tadupd02.wav",
    category = "alert",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_t_research_complete"
  }, {
    type = "sound",
    filename = "sound/protoss/advisor/padupd02.wav",
    category = "alert",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_p_research_complete"
  }, {
    type = "sound",
    filename = "sound/terran/advisor/tadupd03.wav",
    category = "alert",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_t_addon_complete"
  }, {
    type = "sound",
    filename = "sound/zerg/advisor/zadupd04.wav",
    category = "alert",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_z_nuke_detected"
  }, {
    type = "sound",
    filename = "sound/terran/advisor/tadupd04.wav",
    category = "alert",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_t_nuke_detected"
  }, {
    type = "sound",
    filename = "sound/protoss/advisor/padupd04.wav",
    category = "alert",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_p_nuke_detected"
  }, {
    type = "sound",
    filename = "sound/terran/advisor/tadupd05.wav",
    category = "alert",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_t_detach_addon"
  }, {
    type = "sound",
    filename = "sound/zerg/advisor/zadupd02.wav",
    category = "alert",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_z_upgrade_complete"
  }, {
    type = "sound",
    filename = "sound/terran/advisor/tadupd06.wav",
    category = "alert",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_t_upgrade_complete"
  }, {
    type = "sound",
    filename = "sound/protoss/advisor/padupd06.wav",
    category = "alert",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_p_upgrade_complete"
  }, {
    type = "sound",
    filename = "sound/terran/advisor/tadupd07.wav",
    category = "alert",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_t_nuke_ready"
  }, 
  nil, {
    type = "sound",
    filename = "sound/terran/scv/tscupd00.wav",
    category = "alert",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_t_work_done"
  }, {
    type = "sound",
    filename = "sound/terran/scv/tscupd00.wav",
    category = "alert",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_p_work_done"
  }, {
    type = "sound",
    filename = "sound/zerg/drone/zdrerr00.wav",
    category = "alert",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_z_cant_attack"
  }, {
    type = "sound",
    filename = "sound/misc/buzz.wav",
    category = "alert",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_t_cant_attack"
  }, {
    type = "sound",
    filename = "sound/misc/perror.wav",
    category = "alert",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_p_cant_attack"
  }, {
    type = "sound",
    filename = "sound/zerg/drone/zdrerr00.wav",
    category = "alert",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_z_cant_land_there"
  }, {
    type = "sound",
    filename = "sound/terran/advisor/taderr04.wav",
    category = "alert",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_t_cant_land_there"
  }, {
    type = "sound",
    filename = "sound/terran/advisor/taderr04.wav",
    category = "alert",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_p_cant_land_there"
  }, {
    type = "sound",
    filename = "sound/zerg/drone/zdrerr00.wav",
    category = "alert",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_z_landing_interrupted"
  }, {
    type = "sound",
    filename = "sound/terran/advisor/taderr03.wav",
    category = "alert",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_t_landing_interrupted"
  }, {
    type = "sound",
    filename = "sound/terran/advisor/taderr03.wav",
    category = "alert",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_p_landing_interrupted"
  }, {
    type = "sound",
    filename = "sound/zerg/advisor/zaderr00.wav",
    category = "alert",
    aggregation = {
      max_count = 1,
      remove = false
    },
    name = "sc_snd_z_need_minerals"
  }, {
    type = "sound",
    filename = "sound/terran/advisor/taderr00.wav",
    category = "alert",
    aggregation = {
      max_count = 1,
      remove = false
    },
    name = "sc_snd_t_need_minerals"
  }, {
    type = "sound",
    filename = "sound/protoss/advisor/paderr00.wav",
    category = "alert",
    aggregation = {
      max_count = 1,
      remove = false
    },
    name = "sc_snd_p_need_minerals"
  }, {
    type = "sound",
    filename = "sound/zerg/advisor/zaderr01.wav",
    category = "alert",
    aggregation = {
      max_count = 1,
      remove = false
    },
    name = "sc_snd_z_need_gas"
  }, {
    type = "sound",
    filename = "sound/terran/advisor/taderr01.wav",
    category = "alert",
    aggregation = {
      max_count = 1,
      remove = false
    },
    name = "sc_snd_t_need_gas"
  }, {
    type = "sound",
    filename = "sound/protoss/advisor/paderr01.wav",
    category = "alert",
    aggregation = {
      max_count = 1,
      remove = false
    },
    name = "sc_snd_p_need_gas"
  }, {
    type = "sound",
    filename = "sound/zerg/advisor/zaderr02.wav",
    category = "alert",
    aggregation = {
      max_count = 1,
      remove = false
    },
    name = "sc_snd_z_need_power"
  }, {
    type = "sound",
    filename = "sound/terran/advisor/taderr02.wav",
    category = "alert",
    aggregation = {
      max_count = 1,
      remove = false
    },
    name = "sc_snd_t_need_power"
  }, {
    type = "sound",
    filename = "sound/protoss/advisor/paderr02.wav",
    category = "alert",
    aggregation = {
      max_count = 1,
      remove = false
    },
    name = "sc_snd_p_need_power"
  }, {
    type = "sound",
    filename = "sound/zerg/advisor/zaderr06.wav",
    category = "alert",
    aggregation = {
      max_count = 1,
      remove = false
    },
    name = "sc_snd_z_need_mana"
  }, {
    type = "sound",
    filename = "sound/terran/advisor/taderr06.wav",
    category = "alert",
    aggregation = {
      max_count = 1,
      remove = false
    },
    name = "sc_snd_t_need_mana"
  }, {
    type = "sound",
    filename = "sound/protoss/advisor/paderr06.wav",
    category = "alert",
    aggregation = {
      max_count = 1,
      remove = false
    },
    name = "sc_snd_p_need_mana"
  }, {
    type = "sound",
    filename = "sound/zerg/drone/zdrerr00.wav",
    category = "alert",
    aggregation = {
      max_count = 1,
      remove = false
    },
    name = "sc_snd_z_build_interrupted"
  }, {
    type = "sound",
    filename = "sound/terran/scv/tscerr01.wav",
    category = "alert",
    aggregation = {
      max_count = 1,
      remove = false
    },
    name = "sc_snd_t_build_interrupted"
  }, {
    type = "sound",
    filename = "sound/protoss/probe/pprerr00.wav",
    category = "alert",
    aggregation = {
      max_count = 1,
      remove = false
    },
    name = "sc_snd_p_build_interrupted"
  }, {
    type = "sound",
    filename = "sound/zerg/drone/zdrerr00.wav",
    category = "alert",
    aggregation = {
      max_count = 1,
      remove = false
    },
    name = "sc_snd_z_cant_build_there"
  }, {
    type = "sound",
    filename = "sound/terran/scv/tscerr00.wav",
    category = "alert",
    aggregation = {
      max_count = 1,
      remove = false
    },
    name = "sc_snd_t_cant_build_there"
  }, {
    type = "sound",
    filename = "sound/protoss/probe/pprerr01.wav",
    category = "alert",
    aggregation = {
      max_count = 1,
      remove = false
    },
    name = "sc_snd_p_cant_build_there"
  }, {
    type = "sound",
    filename = "sound/glue/mousedown2.wav",
    category = "gui-effect",
    preload = true,
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_glusnd_mouse_down"
  }, {
    type = "sound",
    filename = "sound/glue/mouseover.wav",
    category = "gui-effect",
    preload = true,
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_glusnd_mouse_over"
  }, {
    type = "sound",
    filename = "sound/glue/bnetclick.wav",
    category = "gui-effect",
    preload = true,
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_glusnd_bnet_click"
  }, {
    type = "sound",
    filename = "sound/glue/scorefill.wav",
    category = "gui-effect",
    preload = true,
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_glusnd_score_fill"
  }, {
    type = "sound",
    filename = "sound/glue/scorefillend.wav",
    category = "gui-effect",
    preload = true,
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_glusnd_score_fillend"
  }, {
    type = "sound",
    filename = "sound/glue/countdown.wav",
    category = "gui-effect",
    preload = true,
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_glusnd_chat_countdown"
  }, {
    type = "sound",
    filename = "sound/glue/swishlock.wav",
    category = "gui-effect",
    preload = true,
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_glusnd_swish_lock"
  }, {
    type = "sound",
    filename = "sound/glue/swishin.wav",
    category = "gui-effect",
    preload = true,
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_glusnd_swish_in"
  }, {
    type = "sound",
    filename = "sound/glue/swishout.wav",
    category = "gui-effect",
    preload = true,
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_glusnd_swish_out"
  }, {
    type = "sound",
    filename = "sound/terran/scv/tscmin00.wav",
    aggregation = {
      max_count = 1,
      remove = false
    },
    name = "sc_snd_harvest"
  }, {
    type = "sound",
    filename = "sound/terran/scv/tscmin01.wav",
    aggregation = {
      max_count = 1,
      remove = false
    },
    name = "sc_snd_harvest1"
  }, 
  nil, {
    type = "sound",
    filename = "sound/terran/battle/tbadth00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_battle_dead"
  }, {
    type = "sound",
    filename = "sound/terran/battle/tbayam01.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_yamato_charge"
  }, {
    type = "sound",
    filename = "sound/terran/battle/tbayam02.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_yamato_blast"
  }, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, {
    type = "sound",
    filename = "sound/terran/civilian/tcvdth00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_civilian_death"
  }, 
  nil, 
  nil, {
    type = "sound",
    filename = "sound/terran/dropship/tdrdth00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_dropship_dead"
  }, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, {
    type = "sound",
    filename = "sound/terran/ghost/tghdth00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_ghost_dead"
  }, {
    type = "sound",
    filename = "sound/terran/ghost/tghlas00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_ghost_nuke_beam"
  }, {
    type = "sound",
    filename = "sound/terran/ghost/tghlkd00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_ghost_lock_down"
  }, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, {
    type = "sound",
    filename = "sound/terran/phoenix/tphdth00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_phoenix_dead"
  }, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, {
    type = "sound",
    filename = "sound/terran/phoenix/tphclo00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_phoenix_cloaking"
  }, {
    type = "sound",
    filename = "sound/terran/phoenix/tphclo01.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_phoenix_decloaking"
  }, 
  nil, {
    type = "sound",
    variations = {
      { filename = "sound/terran/marine/tmadth00.wav" },
      { filename = "sound/terran/marine/tmadth01.wav" }
    },
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_first_marine_dead"
  }, 
  nil, {
    type = "sound",
    filename = "sound/terran/marine/tmasti00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_first_marine_stimpack"
  }, {
    type = "sound",
    filename = "sound/terran/marine/tmasti01.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_last_marine_stimpack"
  }, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, {
    type = "sound",
    variations = {
      { filename = "sound/terran/firebat/tfbdth00.wav" },
      { filename = "sound/terran/firebat/tfbdth01.wav" },
      { filename = "sound/terran/firebat/tfbdth02.wav" }
    },
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_first_firebat_dead"
  }, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, {
    type = "sound",
    variations = {
      { filename = "sound/terran/firebat/tfbfir00.wav" },
      { filename = "sound/terran/firebat/tfbfir01.wav" }
    },
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_firebat_attack_1"
  }, 
  nil, 
  nil, {
    type = "sound",
    filename = "sound/terran/tank/ttadth00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_tank_dead"
  }, {
    type = "sound",
    filename = "sound/terran/tank/ttatra00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_tank_mode_on"
  }, {
    type = "sound",
    filename = "sound/terran/tank/ttatra01.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_tank_mode_off"
  }, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, {
    type = "sound",
    filename = "sound/terran/vessel/tvedth00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_vessel_dead"
  }, {
    type = "sound",
    filename = "sound/terran/vessel/tvedef00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_defense_matrix"
  }, {
    type = "sound",
    filename = "sound/terran/vessel/tveemp00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_emp_blast"
  }, {
    type = "sound",
    filename = "sound/terran/vessel/tveirr00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_irradiate"
  }, 
  nil, {
    type = "sound",
    filename = "sound/terran/vulture/tvudth00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_vulture_dead"
  }, {
    type = "sound",
    filename = "sound/terran/vulture/tvumin01.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_vulture_mine_dig"
  }, {
    type = "sound",
    filename = "sound/terran/vulture/tvumin00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_vulture_mine_move"
  }, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, {
    type = "sound",
    filename = "sound/terran/scv/tscdth00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_scv_dead"
  }, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, {
    type = "sound",
    filename = "sound/terran/bldg/tcssca00.wav",
    --audible_distance_modifier = 50.0,
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_comsat_work"
  }, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil,
  nil, 
  nil, 
  nil, 
  nil, {
    type = "sound",
    filename = "sound/terran/bldg/onfirlrg.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_big_on_fire"
  }, {
    type = "sound",
    filename = "sound/terran/scv/tsctra00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_transform"
  }, {
    type = "sound",
    filename = "sound/terran/raynorm/uradth00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_first_raynor_mar_dead"
  }, {
    type = "sound",
    filename = "sound/terran/raynorm/uradth01.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_last_raynor_mar_dead"
  }, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, {
    type = "sound",
    filename = "sound/terran/kerrigan/ukedth00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_kerri_ghost_dead"
  }, {
    type = "sound",
    filename = "sound/misc/liftoff.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_lift_off"
  }, {
    type = "sound",
    filename = "sound/misc/land.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_land"
  }, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, {
    type = "sound",
    filename = "sound/protoss/bldg/pbaact00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_recharge_shields"
  },
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, {
    type = "sound",
    filename = "sound/protoss/dragoon/pdrdth00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_dragoon_dead"
  }, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, {
    type = "sound",
    filename = "sound/protoss/shuttle/pshdth00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_shuttle_dead"
  }, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, {
    type = "sound",
    filename = "sound/protoss/shuttle/pshbld00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_shuttle_build_start"
  }, {
    type = "sound",
    filename = "sound/protoss/shuttle/pshbld03.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_shuttle_build_complete"
  }, {
    type = "sound",
    filename = "sound/protoss/shuttle/pshbld01.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_first_shuttle_build_what"
  }, {
    type = "sound",
    filename = "sound/protoss/shuttle/pshbld02.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_last_shuttle_build_what"
  }, {
    type = "sound",
    filename = "sound/protoss/shuttle/pshbld04.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_shuttle_build_loop"
  }, {
    type = "sound",
    filename = "sound/protoss/scout/pscdth00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_scout_dead"
  }, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, {
    type = "sound",
    filename = "sound/protoss/arbiter/pabcag00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_stasis_field"
  }, 
  nil, {
    type = "sound",
    filename = "sound/protoss/arbiter/pabfol00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_arbiter_first_recall_start"
  }, {
    type = "sound",
    filename = "sound/protoss/arbiter/pabfol01.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_arbiter_last_recall_start"
  }, {
    type = "sound",
    filename = "sound/protoss/arbiter/pabfol02.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_arbiter_first_warpin"
  }, {
    type = "sound",
    filename = "sound/protoss/arbiter/pabfol03.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_arbiter_last_warpin"
  }, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, {
    type = "sound",
    filename = "sound/protoss/arbiter/pabdth00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_arbiter_dead"
  }, 
  nil, {
    type = "sound",
    filename = "sound/protoss/archon/parmin00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_mind_control"
  }, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, {
    type = "sound",
    filename = "sound/protoss/archon/pardth00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_archon_dead"
  }, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, {
    type = "sound",
    variations = {
      { filename = "sound/protoss/carrier/pcadth00.wav" },
      { filename = "sound/protoss/carrier/pcadth01.wav" }
    },
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_first_carrier_dead"
  }, 
  nil, 
  nil, {
    type = "sound",
    filename = "sound/protoss/probe/pprdth00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_probe_dead"
  }, {
    type = "sound",
    filename = "sound/protoss/probe/ppratt00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_first_probe_attack"
  }, {
    type = "sound",
    filename = "sound/protoss/probe/ppratt01.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_last_probe_attack"
  }, {
    type = "sound",
    filename = "sound/protoss/probe/pprmin00.wav",
    aggregation = {
      max_count = 1,
      remove = false
    },
    name = "sc_snd_probe_mine"
  }, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, {
    type = "sound",
    filename = "sound/protoss/probe/pprmin00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_probe_harvest"
  }, {
    type = "sound",
    filename = "sound/protoss/intercep/pinlau00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_inter_ready"
  }, {
    type = "sound",
    filename = "sound/protoss/intercep/pinlau00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_inter_launch"
  }, {
    type = "sound",
    filename = "sound/protoss/templar/ptesum00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_templar_summon"
  }, {
    type = "sound",
    filename = "sound/protoss/templar/ptehal00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_hallucination_on"
  }, {
    type = "sound",
    filename = "sound/protoss/templar/ptehal01.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_hallucination_off"
  }, {
    type = "sound",
    filename = "sound/protoss/templar/ptesto00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_psionic_storm_activate"
  }, {
    type = "sound",
    filename = "sound/protoss/templar/ptesto01.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_psionic_storm_loop"
  }, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, {
    type = "sound",
    filename = "sound/protoss/templar/ptedth00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_templar_dead"
  }, {
    type = "sound",
    filename = "sound/protoss/templar/ptemov00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_templar_move"
  }, 
  nil, {
    type = "sound",
    filename = "sound/protoss/trilobyte/ptrdth00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_trilobyte_dead"
  }, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, {
    type = "sound",
    variations = {
      { filename = "sound/protoss/witness/pwidth00.wav" },
      { filename = "sound/protoss/witness/pwidth01.wav" }
    },
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_first_witness_dead"
  }, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, {
    type = "sound",
    variations = {
      { filename = "sound/protoss/zealot/pzeatt00.wav" },
      { filename = "sound/protoss/zealot/pzeatt01.wav" }
    },
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_zealot_attack1"
  }, 
  nil, {
    type = "sound",
    filename = "sound/protoss/zealot/pzehit00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_zealot_hit"
  }, {
    type = "sound",
    filename = "sound/protoss/zealot/pzerag00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_zealot_spell_1"
  }, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, {
    type = "sound",
    filename = "sound/protoss/zealot/pzedth00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_zealot_dead"
  }, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, {
    type = "sound",
    filename = "sound/protoss/tassadar/utadth00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_tass_templar_dead"
  }, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, {
    type = "sound",
    filename = "sound/protoss/darktemplar/pdtdth00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_dark_templar_dead"
  }, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, {
    type = "sound",
    filename = "sound/protoss/zeratul/uzedth00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_zeratul_tem_dead"
  },
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil,
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, {
    type = "sound",
    filename = "sound/zerg/bldg/zbldgdth.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_zerg_bldg_death"
  }, 
  nil, {
    type = "sound",
    filename = "sound/zerg/avenger/zavdth00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_avenger_dead"
  }, {
    type = "sound",
    filename = "sound/zerg/avenger/zavatt00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_avenger_attack"
  }, {
    type = "sound",
    filename = "sound/zerg/avenger/zavhit00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_avenger_hit"
  }, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, {
    type = "sound",
    filename = "sound/zerg/broodling/zbrdth00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_broodling_dead"
  }, {
    type = "sound",
    filename = "sound/zerg/broodling/zbratt00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_broodling_attack"
  }, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, {
    type = "sound",
    filename = "sound/zerg/defiler/zdecon00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_consume"
  }, 
  nil, {
    type = "sound",
    filename = "sound/zerg/defiler/zdedth00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_defiler_dead"
  }, {
    type = "sound",
    filename = "sound/zerg/defiler/zdeblo00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_first_defiler_bloodboil"
  }, {
    type = "sound",
    filename = "sound/zerg/defiler/zdeblo01.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_last_defiler_bloodboil"
  }, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, {
    type = "sound",
    filename = "sound/zerg/egg/zegdth00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_egg_dead"
  }, 
  nil, 
  nil, {
    type = "sound",
    filename = "sound/zerg/drone/zdrdth00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_drone_dead"
  }, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, {
    type = "sound",
    filename = "sound/zerg/drone/zdrmin00.wav",
    aggregation = {
      max_count = 1,
      remove = false
    },
    name = "sc_snd_first_drone_harvest"
  }, {
    type = "sound",
    filename = "sound/zerg/drone/zdrerr00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_drone_error"
  }, {
    type = "sound",
    filename = "sound/zerg/larva/zladth00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_larva_dead"
  }, 
  nil, 
  nil, {
    type = "sound",
    filename = "sound/zerg/guardian/zgudth00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_guardian_dead"
  }, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, {
    type = "sound",
    filename = "sound/zerg/hydra/zhydth00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_hydra_dead"
  }, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, {
    type = "sound",
    filename = "sound/zerg/ultra/zulror00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_ultra_roar"
  }, {
    type = "sound",
    filename = "sound/zerg/ultra/zuldth00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_ultra_dead"
  }, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, {
    type = "sound",
    variations = {
      { filename = "sound/zerg/ultra/zulatt00.wav" },
      { filename = "sound/zerg/ultra/zulatt01.wav" },
      { filename = "sound/zerg/ultra/zulatt02.wav" }
    },
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_ultra_attack1"
  }, 
  nil, 
  nil, {
    type = "sound",
    variations = {
      { filename = "sound/zerg/ultra/zulhit00.wav" },
      { filename = "sound/zerg/ultra/zulhit01.wav" }
    },
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_ultra_hit1"
  }, 
  nil, {
    type = "sound",
    filename = "sound/zerg/zergling/zzedth00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_zergling_dead"
  }, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, {
    type = "sound",
    filename = "sound/zerg/overlord/zovdth00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_overlord_dead"
  }, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, {
    type = "sound",
    filename = "sound/zerg/queen/zqutag00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_queen_spell_1"
  }, {
    type = "sound",
    filename = "sound/zerg/queen/zqutag01.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_queen_spell_2"
  }, {
    type = "sound",
    filename = "sound/zerg/queen/zquswm00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_dark_swarm_activate"
  }, {
    type = "sound",
    filename = "sound/zerg/queen/zquswm01.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_dark_swarm_loop"
  }, {
    type = "sound",
    filename = "sound/zerg/queen/zquens00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_ensnare_activate"
  }, {
    type = "sound",
    variations = {
      { filename = "sound/zerg/queen/zqudth00.wav" },
      { filename = "sound/zerg/queen/zqudth01.wav" },
      { filename = "sound/zerg/queen/zqudth02.wav" }
    },
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_first_queen_dead"
  },
  nil,
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, {
    type = "sound",
    filename = "sound/zerg/mutalid/zmudth00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_mutalid_dead"
  }, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, {
    type = "sound",
    filename = "sound/zerg/zergkerri/ukidth00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_kerri_zerg_dead"
  }, 
  nil, 
  nil, 
  nil, {
    type = "sound",
    filename = "sound/misc/critters/pbdeath01.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_ice_critter_death"
  }, 
  nil, 
  nil, 
  nil, {
    type = "sound",
    filename = "sound/misc/critters/scdeath01.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_desert_critter_death"
  }, 
  nil, 
  nil, 
  nil, {
    type = "sound",
    filename = "sound/misc/critters/terdeath01.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_twilight_critter_death"
  }, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, {
    type = "sound",
    filename = "sound/terran/duran/tdndth00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_duran_dead"
  }, {
    type = "sound",
    filename = "sound/terran/medic/tmedcure.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_medic_cure"
  }, 
  nil, {
    type = "sound",
    filename = "sound/terran/medic/tmddth00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_medic_dead"
  }, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, {
    type = "sound",
    filename = "sound/terran/medic/tmedflsh.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_medic_flashgrenade"
  }, {
    type = "sound",
    filename = "sound/terran/medic/tmedrest.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_medic_restore"
  }, {
    type = "sound",
    filename = "sound/terran/medic/tmedheal.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_medic_heal"
  }, {
    type = "sound",
    filename = "sound/terran/medic/miopia1.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_medic_miopia"
  }, {
    type = "sound",
    filename = "sound/terran/frigate/afteron.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_frigate_afterburneron"
  }, {
    type = "sound",
    filename = "sound/terran/frigate/afteroff.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_frigate_afterburneroff"
  }, {
    type = "sound",
    filename = "sound/bullet/tfrhit.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_frigate_hit"
  }, {
    type = "sound",
    filename = "sound/bullet/tfrshoot.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_frigate_shoot"
  }, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, {
    type = "sound",
    filename = "sound/terran/frigate/tvkdth00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_frigate_dead"
  }, 
  nil, {
    type = "sound",
    filename = "sound/protoss/corsair/pcorhit1.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_first_corsair_dead"
  }, {
    type = "sound",
    filename = "sound/protoss/corsair/pcorhit2.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_last_corsair_dead"
  }, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, {
    type = "sound",
    filename = "sound/protoss/corsair/pcorweb1.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_corsair_disruptor"
  }, {
    type = "sound",
    filename = "sound/protoss/corsair/pcorlasr2.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_corsair_laser"
  }, {
    type = "sound",
    filename = "sound/protoss/darchon/feedback.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_darchon_feedback"
  }, {
    type = "sound",
    filename = "sound/protoss/darchon/mind.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_darchon_mindcontrol"
  }, {
    type = "sound",
    filename = "sound/protoss/darchon/paraattk.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_darchon_paralize"
  }, {
    type = "sound",
    filename = "sound/protoss/darchon/parahit.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_darchon_paralizehit"
  }, 
  nil, {
    type = "sound",
    filename = "sound/protoss/darchon/pdrdth00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_darchon_dead"
  }, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, {
    type = "sound",
    filename = "sound/zerg/lurker/zludth00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_lurker_dead"
  }, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, {
    type = "sound",
    filename = "sound/zerg/lurker/zluburrw.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_lurker_burrow"
  }, {
    type = "sound",
    filename = "sound/zerg/devourer/firesuck.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_devourer_fire"
  }, {
    type = "sound",
    filename = "sound/zerg/devourer/goophit.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_devourer_fire_hit"
  }, 
  nil, {
    type = "sound",
    filename = "sound/zerg/devourer/zdvdth00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_devourer_dead"
  }, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, {
    type = "sound",
    filename = "sound/bullet/zlrkfir1.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_lurker_fire1"
  }, {
    type = "sound",
    filename = "sound/bullet/zlrkfir2.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_lurker_fire2"
  }, {
    type = "sound",
    filename = "sound/bullet/zlrkhit1.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_lurker_impale1"
  }, {
    type = "sound",
    filename = "sound/bullet/zlrkhit2.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_lurker_impale2"
  }, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, {
    type = "sound",
    filename = "sound/zerg/zergduran/zdndth00.wav",
    aggregation = {
      max_count = 4,
      remove = false
    },
    name = "sc_snd_zduran_dead"
  }, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil, 
  nil
}
