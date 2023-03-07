-- Connection Setup -------------------------------------
table.insert(ctrls, {
  Name = "RS232",
  ControlType = "Button",
  ButtonType = "Momentary",
  Count = 1,
  UserPin = true,
  PinStyle = "Input"
})
table.insert(ctrls, {
  Name = "TCP_Conn",
  ControlType = "Button",
  ButtonType = "Momentary",
  Count = 1,
  UserPin = true,
  PinStyle = "Input"
})

-- RS232 Settings ----
table.insert(ctrls, {
  Name = "BaudRate",
  ControlType = "Text",
  DefaultValue = "9600",
  UserPin = true,
  PinStyle = "Input",
  Count = 1
})
table.insert(ctrls, {
  Name = "DataBits",
  ControlType = "Text",
  DefaultValue = "8",
  UserPin = true,
  PinStyle = "Input",
  Count = 1
})
table.insert(ctrls, {
  Name = "StopBits",
  ControlType = "Text",
  UserPin = true,
  PinStyle = "Input"
})
table.insert(ctrls, {
  Name = "Parity",
  ControlType = "Text",
  -- ControlType = "enum",
  -- Choices = {"None","Even", "Odd"},
  DefaultValue = "None",
  UserPin = true,
  PinStyle = "Input"
})

-- TCP/IP Settings ------
table.insert(ctrls, {
  Name = "IPAddress",
  ControlType = "Text",
  DefaultValue = "127.0.0.1"
})
table.insert(ctrls, {
  Name = "Port",
  ControlType = "Text",
  DefaultValue = "50000",
})
table.insert(ctrls, {
  Name = "Authentication",
  ControlType = "Button",
  ButtonType = "Toggle",
  Count = 1
})
table.insert(ctrls, {
  Name = "UserName",
  ControlType = "Text",
  DefaultValue = "admin"
})
table.insert(ctrls, {
  Name = "Password",
  ControlType = "Text",
  DefaultValue = "admin"
})

-- Display Controls -------------------------------------
table.insert(ctrls, {
  Name = "PowerOn",
  ControlType = "Button",
  ButtonType = "Momentary",
  Count = 1,
  UserPin = true,
  PinStyle = "Input",
  Icon = "Power"
})
table.insert(ctrls, {
  Name = "PowerOff",
  ControlType = "Button",
  ButtonType = "Momentary",
  Count = 1,
  UserPin = true,
  PinStyle = "Input",
  Icon = "Power"
})
table.insert(ctrls, {
  Name = "Volume",
  ControlType = "Button",
  ButtonType = "Momentary",
  Count = 1,
  UserPin = true,
  PinStyle = "Input",
  Icon = ""
})
table.insert(ctrls, {
  Name = "HMDI1",
  ControlType = "Button",
  ButtonType = "Momentary",
  Count = 1,
  UserPin = true,
  PinStyle = "Input",
  Icon = ""
})
table.insert(ctrls, {
  Name = "HMDI2",
  ControlType = "Button",
  ButtonType = "Momentary",
  Count = 1,
  UserPin = true,
  PinStyle = "Input",
  Icon = ""
})
table.insert(ctrls, {
  Name = "HMDI3",
  ControlType = "Button",
  ButtonType = "Momentary",
  Count = 1,
  UserPin = true,
  PinStyle = "Input",
  Icon = ""
})


