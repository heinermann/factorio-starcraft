data:extend({
  --{
  --  type = "autoplace-control",
  --  name = "starcraft-minerals",
  --  category = "resource",
  --  localised_name = {"", "[entity=starcraft-mineral-field] ", {"entity-name.starcraft-mineral-field"}},
  --  richness = true,
  --  order = "c-sc-a"
  --},
  --{
  --  type = "autoplace-control",
  --  name = "starcraft-vespene",
  --  category = "resource",
  --  localised_name = {"", "[entity=starcraft-vespene-geyser] ", {"entity-name.starcraft-vespene-geyser"}},
  --  richness = true,
  --  order = "c-sc-b"
  --},
  {
    type = "autoplace-control",
    name = "starcraft-resources",
    category = "resource",
    localised_name = {"", "[entity=starcraft-mineral-field][entity=starcraft-vespene-geyser] ", {"starcraft-gluall.scoreRESOURCES"}},
    richness = true,
    order = "c-sc-c"
  }
})
