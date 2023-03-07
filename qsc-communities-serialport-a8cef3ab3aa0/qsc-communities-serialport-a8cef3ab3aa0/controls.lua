table.insert(ctrls, {
  Name = "Status",
  ControlType = "Indicator",
  IndicatorType = "Status",
  PinStyle = "Output",
  UserPin = true,
  Count = 1
})
table.insert(ctrls, {
  Name = "Username",
  ControlType = "Text",
  UserPin = true,
  PinStyle = "Both",
  Count = 1
})
table.insert(ctrls, {
  Name = "Password",
  ControlType = "Text",
  UserPin = true,
  PinStyle = "Both",
  Count = 1
})
table.insert(ctrls, {
  Name = "SendButton",
  ControlType = "Button",
  ButtonType = "Momentary",
  Count = 1,
  UserPin = true,
  PinStyle = "Input"
})
table.insert(ctrls, {
  Name = "ResponseText",
  ControlType = "Text",
  Count = 1,
  UserPin = true,
  PinStyle = "Output"
})