https://lua-api.factorio.com/latest/Concepts.html#RenderLayer

## Ground Units and Structures
Default 4 in BW.

```
0 Beacons
1 Floor Hatch
2 Larva
2 Spawning Pool
3 Bunker
19 Disruption Web
19 Dark Swarm
```

Factorio conversion:
```
0, 1 = "floor" (113)
2 = "lower-object" (124)
3 = "lower-object-above-shadow" (127)
4 = "object" (129)
19 = "137"
```

## Air Units and Abilities
Default 16 in BW

```
18 Wraith
18 Nuke
18 Scanner Sweep
18 Mutalisk
18 Guardian
18 Queen
18 Scourge
18 Cocoon
18 Corsair
18 Devourer
18 Shuttle
18 Scout
18 Interceptor
18 Observer
18 Kakaru
```

Factorio conversion:
```
16 = "air-object" (145)
18 = "146"
```
