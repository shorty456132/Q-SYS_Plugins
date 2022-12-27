table.insert(ctrls, {
  Name = "SendButton",
  ControlType = "Button",
  ButtonType = "Momentary",
  Count = 1,
  UserPin = true,
  PinStyle = "Input",
  Icon = "Power",
  Text = "Press Me",
  Size = {50,50}
})
table.insert(ctrls, {
  Name = "SerialSend",
  ControlType = "Text",
  ButtonType = "Momentary",
  Count = 1,
  UserPin = true,
  PinStyle = "Input"
})

--****** Serial Ctrls ************

table.insert(ctrls, {
  Name = "Status",
  ControlType = "Indicator",
  IndicatorType =  "Status",
  PinStyle = "Output",
  UserPin = true,
  Count = 1
})
table.insert(ctrls, {
  Name = "Username",
  ControlType = "Text",
  UeserPin = true,
  PinStyle = "Both",
  Count = 1
})
table.insert(ctrls, {
  Name = "Password",
  ControlType = "Text",
  UeserPin = true,
  PinStyle = "Both",
  Count = 1
})
table.insert(ctrls, {
  Name = "SendBtn",
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