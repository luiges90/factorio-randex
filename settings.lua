data:extend(
{
   {
    type = "int-setting",
    name = "pw-rand-seed",
    setting_type = "startup",
    default_value = 3274598,
    minimum_value = 1,
    maximum_value = 4294867295,
    order = "a",
   },
   {
    type = "double-setting",
    name = "pw-rand-scale-min",
    setting_type = "startup",
    default_value = 0.5,
    minimum_value = 0.1,
    order = "b",
   },
   {
    type = "double-setting",
    name = "pw-rand-scale-max",
    setting_type = "startup",
    default_value = 1.5,
    minimum_value = 0.1,
    order = "c",
   },
   {
    type = "double-setting",
    name = "pw-rand-recipe-difficulty",
    setting_type = "startup",
    default_value = 1,
    minimum_value = 0.1,
    order = "d1",
   },
   {
    type = "double-setting",
    name = "pw-rand-enemy-health",
    setting_type = "startup",
    default_value = 1,
    minimum_value = 0.1,
    order = "d2",
   },
   {
    type = "double-setting",
    name = "pw-rand-recipe-prescale",
    setting_type = "startup",
    default_value = 1.5,
    minimum_value = 0.1,
    order = "e",
   },
}
)