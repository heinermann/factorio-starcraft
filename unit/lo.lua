-- Attack overlay
local lo_attack_data = {
  [18] = {  -- Drone attack overlay
    {0, -10},
    {0, -10},
    {4, -8},
    {4, -8},
    {7, -5},
    {7, -5},
    {8, -5},
    {8, -5},
    {10, -1},
    {10, -1},
    {9, 1},
    {9, 1},
    {7, 4},
    {7, 4},
    {3, 5},
    {3, 5},
    {0, 6}
  },
  [26] = {  -- Guardian attack
    {1, -18},
    {1, -18},
    {5, -17},
    {5, -17},
    {10, -16},
    {10, -16},
    {13, -12},
    {13, -12},
    {15, -8},
    {15, -8},
    {16, -3},
    {16, -3},
    {12, 2},
    {12, 2},
    {7, 4},
    {7, 4},
    {0, 5}
  },
  [30] = {  -- Hydralisk attack
    {0, -14},
    {0, -14},
    {0, -13},
    {0, -13},
    {1, -12},
    {1, -12},
    {2, -11},
    {2, -11},
    {5, -11},
    {5, -11},
    {7, -6},
    {7, -6},
    {5, -5},
    {5, -5},
    {2, -4},
    {2, -4},
    {-1, -5}
  },
  [39] = { -- mutalisk attack
    {-3, -5},
    {-3, -5},
    {-1, -4},
    {-1, -4},
    {-2, -1},
    {-2, -1},
    {7, -3},
    {7, -3},
    {5, -1},
    {5, -1},
    {7, 0},
    {7, 0},
    {2, 3},
    {2, 3},
    {-1, 5},
    {-1, 5},
    {-5, 6}
  },
  [136] = { -- Archon attack
    {-2, -27},
    {-2, -27},
    {8, -31},
    {8, -31},
    {12, -25},
    {12, -25},
    {16, -19},
    {16, -19},
    {20, -19},
    {20, -19},
    {20, -10},
    {20, -10},
    {14, -5},
    {14, -5},
    {2, -2},
    {2, -2},
    {-10, 4},
  },
  [219] = { -- Battlecruiser attack overlays
    {
      {36, 3},
      {-27, 9},
      {-3, -22},
      {5, 18},
      {6, 8},
      {-27, 1},
      {25, 4}
    }, {
      {32, 14},
      {-29, 0},
      {0, -21},
      {-2, 18},
      {-2, 8},
      {-27, -7},
      {23, 9}
    }, {
      {29, 18},
      {-28, -4},
      {6, -22},
      {-9, 18},
      {-6, 7},
      {-23, -11},
      {19, 11}
    }, {
      {25, 22},
      {-28, -6},
      {10, -20},
      {-18, 18},
      {-12, 7},
      {-18, -13},
      {14, 14}
    }, {
      {18, 25},
      {-27, -10},
      {12, -19},
      {-24, 14},
      {-16, 5},
      {-12, -15},
      {9, 16}
    }, {
      {11, 27},
      {-25, -12},
      {15, -18},
      {-31, 12},
      {-20, 3},
      {-7, -17},
      {5, 16}
    }, {
      {3, 27},
      {-23, -16},
      {16, -15},
      {-34, 5},
      {-23, 2},
      {-11, -18},
      {-3, 18}
    }, {
      {-6, 26},
      {-18, -19},
      {18, -12},
      {-37, 1},
      {-26, -1},
      {-7, -19},
      {-8, 18}
    }, {
      {-14, 24},
      {-13, -20},
      {21, -8},
      {-36, -6},
      {-26, -4},
      {-3, -20},
      {-14, 17}
    }, {
      {-20, 22},
      {-8, -21},
      {21, -6},
      {-36, -11},
      {-27, -10},
      {1, -19},
      {-20, 14}
    }, {
      {-27, 18},
      {-4, -22},
      {20, -4},
      {-35, -17},
      {-26, -15},
      {5, -18},
      {-24, 9}
    }, {
      {-31, 14},
      {3, -22},
      {19, -2},
      {-32, -22},
      {-25, -17},
      {10, -16},
      {-27, 7}
    }, {
      {-35, 7},
      {1, -22},
      {15, -1},
      {-27, -24},
      {-21, -22},
      {7, -17},
      {-29, 2}
    }, {
      {-36, 3},
      {8, -22},
      {13, 0},
      {-23, -27},
      {-18, -25},
      {14, -16},
      {-30, -2}
    }, {
      {-37, -2},
      {14, -20},
      {10, 3},
      {-19, -31},
      {-15, -27},
      {18, -13},
      {-29, -5}
    }, {
      {-36, -7},
      {20, -18},
      {6, 5},
      {-13, -34},
      {-11, -28},
      {22, -10},
      {-30, -9}
    }, {
      {-35, -11},
      {25, -15},
      {2, 7},
      {-6, -35},
      {-8, -27},
      {26, -6},
      {-28, -13}
    }
  },
  [244] = { -- Wraith attack
    {-1, -19},
    {3, -19},
    {6, -17},
    {10, -15},
    {13, -15},
    {17, -12},
    {20, -8},
    {20, -5},
    {21, -2},
    {22, 1},
    {21, 3},
    {18, 7},
    {16, 9},
    {12, 12},
    {9, 14},
    {3, 14},
    {-1, 14},
  },
  [255] = { -- Siege mode turret attack
    {-1, -39},
    {-1, -39},
    {13, -38},
    {13, -38},
    {22, -31},
    {22, -31},
    {28, -23},
    {28, -23},
    {30, -14},
    {30, -14},
    {30, -4},
    {30, -4},
    {24, 6},
    {24, 6},
    {13, 10},
    {13, 10},
    {-2, 9},
  },
  [305] = { -- Bunker attack overlay
    {-1, -27},
    {12, -23},
    {19, -14},
    {17, -9},
    {0, -7},
    {-17, -9},
    {-21, -13},
    {-15, -22},
  },
  [741] = {   -- Left wall flame trap
    {0, 2}
  },
  [742] = {   -- Right wall flame trap
    {0, 2}
  },
  [916] = { -- Devourer attack
    {1, -18},
    {1, -18},
    {5, -17},
    {5, -17},
    {10, -16},
    {10, -16},
    {13, -12},
    {13, -12},
    {15, -8},
    {15, -8},
    {16, -3},
    {16, -3},
    {12, 2},
    {12, 2},
    {7, 4},
    {7, 4},
    {0, 5},
  },
  [922] = { -- Lurker attack
    {0, -14},
    {0, -14},
    {0, -13},
    {0, -13},
    {1, -12},
    {1, -12},
    {2, -11},
    {2, -11},
    {5, -11},
    {5, -11},
    {7, -6},
    {7, -6},
    {5, -5},
    {5, -5},
    {2, -4},
    {2, -4},
    {-1, -5},
  }
}

-- Damage overlay
local lo_damage_data = {
  [62] = {  -- Cerebrate bleeding overlays
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {19, -14},
    {-19, -13},
    {-15, -23},
    {127, 127},
    {-10, 7},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127}
  },
  [64] = { -- Infested Command center fire
    {-44, -30},
    {26, -18},
    {-7, -24},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127}
  },
  [65] = { -- Spawning pool blood
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {-15, -24},
    {127, 127},
    {22, -3},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127}
  },
  [67] = { -- Evolution Chamber blood
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {-31, -4},
    {-14, -14},
    {40, -30},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127}
  },
  [69] = {  -- Creep Colony blood
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {-13, -9},
    {25, -22},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127}
  },
  [71] = {  -- Hatchery blood
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {25, -9},
    {-13, -19},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
  },
  [73] = {  -- Hive blood
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {1, -31},
    {28, 2},
    {-64, -31},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
  },
  [75] = { -- Lair blood
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {-58, -32},
    {127, 127},
    {5, -7},
    {22, -31},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
  },
  [77] = {  -- Sunken colony blood
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {-22, -21},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {-18, 9},
    {-4, -23},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
  },
  [81] = { -- Greater Spire blood
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {-6, -58},
    {-21, 1},
    {31, -43},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
  },
  [83] = {  -- Defiler Mound blood
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {-20, -14},
    {127, 127},
    {127, 127},
    {36, -9},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
  },
  [85] = {  -- Queen's Nest
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {21, 8},
    {127, 127},
    {127, 127},
    {-20, -5},
    {127, 127},
    {26, -28},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
  },
  [87] = {  -- Nedus Canal blood
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {-6, -25},
    {127, 127},
    {33, -12},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
  },
  [92] = {  -- Ultralisk Cavern Blood
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {-23, -10},
    {127, 127},
    {-15, -52},
    {1, -16},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
  },
  [94] = {  -- Extractor blood
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {-6, -48},
    {127, 127},
    {20, -50},
    {127, 127},
    {127, 127},
    {2, 1},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
  },
  [96] = {  -- Hydralisk Den blood
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {-16, -25},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {18, -16},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
  },
  [98] = {  -- Spire blood
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {13, -55},
    {-8, -54},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
  },
  [100] = { -- Spore Colony blood
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {-7, -16},
    {2, 11},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
  },
  [156] = {   -- Templar Archives fire
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {-4, -34},
    {13, -3},
    {33, 7},
    {127, 127},
    {127, 127},
    {127, 127},
  },
  [159] = { -- Assimilator fire
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {-10, -46},
    {18, -47},
    {38, -20},
    {127, 127},
    {127, 127},
    {127, 127},
  },
  [162] = { -- Observatory fire
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {33, -15},
    {-10, 2},
    {-9, -20},
    {127, 127},
    {127, 127},
    {127, 127},
  },
  [165] = { -- Citadel fire
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {-1, -35},
    {127, 127},
    {29, -30},
    {127, 127},
    {127, 127},
    {127, 127},
  },
  [168] = { -- Forge fire
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {23, -48},
    {18, -5},
    {-19, 9},
    {127, 127},
    {127, 127},
    {127, 127},
  },
  [172] = { -- Gateway fire
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {-4, -56},
    {34, 10},
    {-39, -23},
    {127, 127},
    {127, 127},
    {127, 127},
  },
  [175] = { -- Cybernetics Core fire
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {0, -42},
    {127, 127},
    {22, 4},
    {127, 127},
    {127, 127},
    {127, 127},
  },
  [179] = { -- Khaydarin Crystal Formation fire
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {-24, -12},
    {15, -20},
    {3, 5},
    {127, 127},
    {127, 127},
    {127, 127},
  },
  [180] = { -- Nexus fire
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {-4, -36},
    {40, 22},
    {-3, 38},
    {127, 127},
    {127, 127},
    {127, 127},
  },
  [184] = { -- Photon Cannon fire
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {-7, -20},
    {127, 127},
    {10, -2},
    {127, 127},
    {127, 127},
    {127, 127},
  },
  [187] = { -- Arbiter Tribunal fire
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {-25, 3},
    {19, -3},
    {1, -14},
    {127, 127},
    {127, 127},
    {127, 127},
  },
  [190] = { -- Pylon fire
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {12, 3},
    {127, 127},
    {-2, -9},
    {127, 127},
    {127, 127},
    {127, 127},
  },
  [193] = { -- Robotics Facility fire
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {-21, -19},
    {15, -14},
    {8, 8},
    {127, 127},
    {127, 127},
    {127, 127},
  },
  [196] = { -- Shield battery fire
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {-6, -23},
    {127, 127},
    {3, -8},
    {127, 127},
    {127, 127},
    {127, 127},
  },
  [200] = { -- Stargate fire
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {6, -71},
    {-7, -54},
    {34, 3},
    {127, 127},
    {127, 127},
    {127, 127},
  },
  [205] = { -- Robotics support bay
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {-24, -12},
    {15, -20},
    {3, 5},
    {127, 127},
    {127, 127},
    {127, 127},
  },
  [209] = { -- Fleet Beacon fire
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {1, -54},
    {-24, -13},
    {38, -36},
    {127, 127},
    {127, 127},
    {127, 127},
  },
  [264] = { -- Academy fire
    {-22, -37},
    {5, -2},
    {30, -51},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
  },
  [267] = { -- Barracks fire
    {-27, -48},
    {-4, -9},
    {25, 3},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
  },
  [269] = { -- Armory fire
    {-17, -10},
    {28, -26},
    {-5, -28},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
  },
  [272] = { -- Comsat fire
    {-5, -20},
    {127, 127},
    {9, 2},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
  },
  [276] = { -- Command center fire
    {-44, -30},
    {26, -18},
    {-7, -24},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
  },
  [279] = { -- Supply depot fire
    {-23, -26},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
  },
  [282] = { -- Control Tower fire
    {-13, -26},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
  },
  [286] = { -- Factory fire
    {-38, -45},
    {3, -45},
    {41, -24},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
  },
  [289] = { -- Covert Ops fire
    {-10, -17},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
  },
  [294] = { -- Machine Shop fire
    {-12, -28},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
  },
  [297] = { -- Missile Turret fire
    {127, 127},
    {-3, -6},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
  },
  [300] = { -- Crashed battlecruiser fire
    {-12, -20},
    {127, 127},
    {13, 1},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
  },
  [302] = { -- Physics Lab fire
    {-12, -20},
    {127, 127},
    {13, 1},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
  },
  [305] = { -- Bunker fire
    {8, -23},
    {-21, -21},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
  },
  [308] = { -- Refinery fire
    {-21, -23},
    {39, -9},
    {-4, 3},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
  },
  [310] = { -- Science Facility fire
    {127, 127},
    {-20, -6},
    {24, -30},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
  },
  [313] = { -- Nuke silo fire
    {127, 127},
    {-7, -25},
    {15, -13},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
  },
  [320] = { -- Starport fire
    {-24, -11},
    {25, -46},
    {6, 1},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
  },
  [323] = { -- Engineering Bay fire
    {-34, -25},
    {4, -43},
    {11, 3},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
  }
}

-- Special overlay
local lo_special_data = {
  [18] = {  -- Drone powerup overlay
    {0, -21},
    {0, -21},
    {9, -19},
    {9, -19},
    {15, -14},
    {15, -14},
    {18, -8},
    {18, -8},
    {20, -2},
    {20, -2},
    {18, 5},
    {18, 5},
    {14, 9},
    {14, 9},
    {7, 12},
    {7, 12},
    {-1, 15}
  },
  [94] = {  -- Extractor gas overlays
    {16, -45},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
  },
  [138] = { -- Probe powerup overlay
    {0, -21},
    {0, -21},
    {9, -19},
    {9, -19},
    {15, -14},
    {15, -14},
    {18, -8},
    {18, -8},
    {20, -2},
    {20, -2},
    {18, 5},
    {18, 5},
    {14, 9},
    {14, 9},
    {7, 12},
    {7, 12},
    {-1, 15}
  },
  [159] = { -- Assimilator gas overlays
    {26, -58},
    {127, 127},
    {39, -18},
    {-42, -51},
    {127, 127},
  },
  [235] = { -- Goliath turret overlay
    {0,0},
    {0,0},
    {0,0},
    {0,0},
    {0,0},
    {0,0},
    {0,0},
    {0,0},
    {0,0},
    {0,0},
    {0,0},
    {0,0},
    {0,0},
    {0,0},
    {0,0},
    {0,0},
    {0,0},
  },
  [248] = { -- SCV powerup overlay
    {1, -18},
    {1, -18},
    {5, -16},
    {5, -16},
    {11, -14},
    {11, -14},
    {14, -12},
    {14, -12},
    {16, -8},
    {16, -8},
    {14, -3},
    {14, -3},
    {12, 2},
    {12, 2},
    {6, 5},
    {6, 5},
    {0, 6},
  },
  [251] = { -- Siege tank turret overlay
    {-1, -1},
    {-1, -1},
    {-5, -2},
    {-5, -2},
    {-9, -3},
    {-9, -3},
    {-12, -6},
    {-12, -6},
    {-13, -10},
    {-13, -10},
    {-12, -13},
    {-12, -13},
    {-9, -16},
    {-9, -16},
    {-5, -18},
    {-5, -18},
    {0, -19},
  },
  [254] = { -- Siege mode turret overlay
    {-9, -16}
  },
  [261] = { -- Scienve Vessel turret overlay
    {0,0}
  },
  [308] = { -- Refinery gas overlays
    {
      {7, -53},
      {127, 127},
      {127, 127},
      {127, 127},
      {127, 127},
    }, {
      {7, -16},
      {-41, -18},
      {41, -3},
      {127, 127},
      {127, 127},
    }, {
      {7, -16},
      {-41, -18},
      {2, 3},
      {127, 127},
      {127, 127},
    }, {
      {7, -36},
      {-41, -18},
      {2, 3},
      {127, 127},
      {127, 127},
    }, {
      {7, -45},
      {-41, -18},
      {2, 3},
      {127, 127},
      {127, 127},
    }
  },
  [345] = { -- vespene geyser overlays
    {11, -19},
    {-40, -13},
    {34, 2},
    {127, 127},
    {127, 127}
  }
}

-- Landing dust
local lo_landing_data = {
  [64] = {  -- Infested Command Center landing
    {16, 49},
    {-16, 44},
    {127, 127},
    {127, 127},
    {59, 29},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {-58, 22},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127}
  },
  [267] = { -- Barracks landing
    {33, 49},
    {5, 34},
    {127, 127},
    {59, -3},
    {43, 26},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {-56, -3},
    {127, 127},
    {-38, 24},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
  },
  [276] = {  -- Command Center landing
    {16, 49},
    {-16, 44},
    {127, 127},
    {127, 127},
    {59, 29},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {-58, 22},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127}
  },
  [286] = { -- Factory landing
    {127, 127},
    {2, 46},
    {127, 127},
    {127, 127},
    {51, 19},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {-40, 30},
    {127, 127},
    {127, 127},
    {-55, 8},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
  },
  [310] = { -- Science Facility landing
    {51, 29},
    {127, 127},
    {127, 127},
    {127, 127},
    {16, 38},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {-40, 32},
    {127, 127},
    {127, 127},
    {127, 127},
    {-58, 15},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
  },
  [320] = { -- Starport landing
    {127, 127},
    {127, 127},
    {54, -4},
    {127, 127},
    {43, 18},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {-29, 28},
    {9, 28},
    {-42, -7},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
  },
  [323] = { -- Engineering bay landing
    {33, 28},
    {-48, 13},
    {57, 0},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {-53, -15},
    {127, 127},
    {-16, 37},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
  }
}

-- Liftoff dust
local lo_liftoff_data = {
  [64] = {  -- Infested Command Center liftoff
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {-12, 39},
    {13, 42},
    {-38, 31},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {47, 32},
    {127, 127},
    {127, 127},
    {-60, 18}
  },
  [267] = { -- Barracks liftoff
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {-3, 29},
    {28, 42},
    {-56, 16},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {50, 20},
    {127, 127},
    {127, 127},
    {-29, 34},
  },
  [276] = {  -- Command Center liftoff
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {-12, 39},
    {13, 42},
    {-38, 31},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {47, 32},
    {127, 127},
    {127, 127},
    {-60, 18}
  },
  [286] = { -- Factory liftoff
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {-22, 37},
    {10, 48},
    {127, 127},
    {44, 31},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {-43, 26},
    {127, 127},
    {127, 127},
  },
  [310] = { -- Science Facility liftoff
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {-25, 43},
    {18, 28},
    {127, 127},
    {48, 26},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {-49, 20},
    {127, 127},
    {127, 127},
  },
  [320] = { -- Starport liftoff
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {-47, 22},
    {37, 35},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {49, 12},
    {8, 26},
    {127, 127},
    {-26, 26},
  },
  [323] = { -- Engineering bay liftoff
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {-26, 18},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {127, 127},
    {6, 47},
    {-58, 11},
    {127, 127},
    {127, 127},
  }
}

-- Unit birth
local lo_unitbirth_data = {
  [3] = { -- Scourge two-unit birth offsets
    {-12, -42},
    {9, -41}
  },
  [57] = {  -- Zergling birth
    {13, -7},
    {-7, 3}
  }
}

-- Shield overlay
local lo_shield_data = {
  { -- small unit
    {0, -10},
    {3, -10},
    {6, -9},
    {8, -8},
    {10, -7},
    {12, -5},
    {14, -3},
    {14, -1},
    {14, 1},
    {13, 3},
    {12, 5},
    {10, 6},
    {7, 7},
    {5, 8},
    {2, 9},
    {-1, 9},
    {-3, 9},
    {-6, 9},
    {-8, 8},
    {-10, 7},
    {-12, 6},
    {-14, 5},
    {-15, 3},
    {-15, 0},
    {-15, -2},
    {-14, -4},
    {-12, -6},
    {-10, -8},
    {-8, -9},
    {-6, -10},
    {-4, -10},
    {-2, -10}
  },
  { -- medium unit
    {0, -18},
    {3, -18},
    {7, -18},
    {13, -16},
    {16, -15},
    {19, -13},
    {22, -10},
    {26, -6},
    {28, -1},
    {26, 4},
    {22, 9},
    {18, 12},
    {14, 14},
    {10, 15},
    {6, 16},
    {3, 16},
    {-1, 16},
    {-6, 16},
    {-13, 15},
    {-17, 13},
    {-21, 12},
    {-24, 10},
    {-26, 7},
    {-28, 3},
    {-29, -1},
    {-27, -6},
    {-23, -10},
    {-18, -14},
    {-14, -16},
    {-11, -17},
    {-7, -18},
    {-4, -18}
  },
  { -- large unit
    {-24, -42},
    {-21, -42},
    {-17, -42},
    {-11, -40},
    {-8, -39},
    {-5, -37},
    {-2, -34},
    {2, -30},
    {4, -25},
    {2, -20},
    {-2, -15},
    {-6, -12},
    {-10, -10},
    {-14, -9},
    {-18, -8},
    {-21, -8},
    {-25, -8},
    {-30, -8},
    {-37, -9},
    {-41, -11},
    {-45, -12},
    {-48, -14},
    {-50, -17},
    {-52, -21},
    {-53, -25},
    {-51, -30},
    {-47, -34},
    {-42, -38},
    {-38, -40},
    {-35, -41},
    {-31, -42},
    {-28, -42}
  }
}

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
local function get_shield_offset(size, table)
  local direction = 0
  if table.direction ~= nil then
    direction = math.floor(32 / ((table.direction - 1) / 8)) + 1
  elseif table.orientation ~= nil then
    direction = table.orientation
  end

  if direction > 32 then direction = 32 end
  if direction < 1 then direction = 1 end

  return lo_shield_data[size][direction]
end

local function get_birth_offsets(type)
  return lo_unitbirth_data[type]
end

local function get_gas_overlays(type, state)
  type = type + 1
  state = state or 1

  if type == 308 then  -- Terran refinery build stages
    return lo_special_data[type][state]
  else
    return lo_special_data[type]
  end
end

return {
  get_shield_offset = get_shield_offset,
  get_birth_offsets = get_birth_offsets,
  get_gas_overlays = get_gas_overlays,
}
