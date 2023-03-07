-- table.insert(ctrls, {
--   Name = "SendButton",
--   ControlType = "Button",
--   ButtonType = "Momentary",
--   Count = 1,
--   UserPin = true,
--   PinStyle = "Input",
--   Icon = "Power"
-- })

table.insert(ctrls, {
  Name = "Baud",
  ControlType = "Text",
  Count = 1,
  DefaultValue = "9600"
})
table.insert(ctrls, {
  Name = "DataBits",
  ControlType = "Text",
  Count = 1,
  DefaultValue = "8"
})
table.insert(ctrls, {
  Name = "Parity", 
  ControlType = "Text",
  Count = 1,
  DefaultValue = "N"  
})

-- Power Commands ----------------------------------------
table.insert(ctrls, {
  Name = "PowerOn",
  ControlType = "Button",
  ButtonType = "Momentary",
  Count = 1,
  UserPin = true,
  PinStyle = "Input"
})
table.insert(ctrls, {
  Name = "PowerOff",
  ControlType = "Button",
  ButtonProperty = "Momentary",
  Count = 1,
  UserPin = true,
  PinStyle = "Input"
})

table.insert(ctrls, {
  Name = "PowerToggle",
  ControlType = "Button",
  ButtonType = "Toggle",
  Count = 1,
  UserPin = true,
  PinStyle = "Input"
})

table.insert(ctrls, {
  Name = "PowerOnFb",
  ControlType = "Button",
  ButtonType = "Toggle",
  Count = 1,
  UserPin = true,
  PinStyle = "Output"
})
table.insert(ctrls, {
  Name = "PowerOffFb",
  ControlType = "Button",
  ButtonType = "Toggle",
  Count = 1,
  UserPin = true,
  PinStyle = "Output"
})
table.insert(ctrls, {
  Name = "DataReceived",
  ControlType = "Text",
  Count = 1
})