

-- GroupBoxes ----------------------------------------------
table.insert(graphics,{
  Type = "GroupBox",
  Text = "Connection",
  FontSize = fs1,
  HTextAlign = "Left",
  StrokeWidth = 1,
  CornerRadius = 8,
  Position = {0, 50},
  Size = {280, 300} --[[ Make this a variable ]]
})

-- Baud Rate 
table.insert(graphics, {
  Type = "Text",
  Text = "Baud Rate",
  Position = {10, 70},
  Size = {60, 25}
})
layout["Baud"] = {
  PrettyName = "BaudRate",
  Style = "ComboBox",
  Position = {70, 70},
  Size = {60, 25} --[[ Make this a variable ]]
}

-- DataBits
table.insert(graphics, {
  Type = "Text",
  Text = "Data Bits",
  Position = {10, 100},
  Size = {60, 25}
})
layout["DataBits"] = {
  PrettyName = "DataBits",
  Style = "ComboBox",
  Position = {70, 100},
  Size = {60, 25}
}

-- Parity
table.insert(graphics, {
  Type = "Text",
  Text = "Parity",
  Position = {10, 130},
  Size = {60, 25}
})
layout["Parity"] = {
  PrettyName = "Parity",
  Style = "ComboBox",
  Position = {70, 130},
  Size = {60, 25}
}

-- -- Display Model
-- table.insert(graphics, {
--   Type = "Text",
--   Text = "Display",
--   Position = {10, 160},
--   Size = {60, 25}
-- })
-- layout["DisplayMake"] = {
--   PrettyName = "DisplayMake",
--   Style = "ComboBox",
--   Position = {70, 160},
--   Size = {60, 25}
-- }

-- Display Controls ---------------------------------------------

-- Power On
table.insert(graphics, {
Type = "Button",
Text = "Power On",
Position = {10, 200},
Size = {60, 25}
})
layout["PowerOn"] = {
PrettyName = "PowerOn",
Style = "Button",
Position = {70, 200},
Size = {60, 25}
}

-- Power Off
table.insert(graphics, {
  Type = "Text",
  Text = "Power Off",
  Position = {10, 230},
  Size = {60, 25}
  })
  layout["PowerOff"] = {
  PrettyName = "PowerOff",
  Style = "Button",
  Position = {70, 230},
  Size = {60, 25}
  }

  -- Power Toggle
table.insert(graphics, {
  Type = "Text",
  Text = "Power Toggle",
  Position = {10, 260},
  Size = {60, 25}
})
layout["PowerToggle"] = {
  PrettyName = "Power Toggle",
  Style = "Button",
  Position = {70, 260},
  Size = {60, 25}
}
