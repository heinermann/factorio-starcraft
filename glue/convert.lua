local factorio_to_unit = {}
local unit_to_factorio = {}

local factorio_to_image = {}
local image_to_factorio = {}
local image_to_entity_type = {}

local function register_image_map(id, name, entity_type)
  image_to_factorio[id] = name
  factorio_to_image[name] = id
  image_to_entity_type[id] = entity_type
end

local function register_unit_map(id, name)
  unit_to_factorio[id] = name
  factorio_to_unit[name] = id
end

------------------------------------------------------------------------------------
------- Map unit types <-> Factorio entity names
------------------------------------------------------------------------------------
register_unit_map(176, "starcraft-mineral-field")
register_unit_map(188, "starcraft-vespene-geyser")

------------------------------------------------------------------------------------
------- Map image types <-> Factorio names, types vary
------------------------------------------------------------------------------------
register_image_map(344, "starcraft-vespene-geyser", "resource")
register_image_map(347, "starcraft-mineral-field", "resource")
register_image_map(430, "starcraft-vespene-smoke-1", "trivial-smoke")
register_image_map(431, "starcraft-vespene-smoke-2", "trivial-smoke")
register_image_map(432, "starcraft-vespene-smoke-3", "trivial-smoke")
register_image_map(433, "starcraft-vespene-smoke-4", "trivial-smoke")
register_image_map(434, "starcraft-vespene-smoke-5", "trivial-smoke")
register_image_map(435, "starcraft-vespene-smoke-depleted", "trivial-smoke")

------------------------------------------------------------------------------------
------- Access functions
------------------------------------------------------------------------------------
local function image_to_name(id)
  return image_to_factorio[id]
end

local function image_to_type(id)
  return image_to_entity_type[id]
end

local function name_to_image(name)
  return factorio_to_image[name]
end

local function name_to_unit(name)
  return factorio_to_unit[name]
end

local function unit_to_name(id)
  return unit_to_factorio[id]
end

------------------------------------------------------------------------------------
------- Interface
------------------------------------------------------------------------------------
return {
  image = {
    to_name = image_to_name,
    to_type = image_to_type,
    from_name = name_to_image,
  },
  unit = {
    to_name = unit_to_name,
    from_name = name_to_unit,
  },
}