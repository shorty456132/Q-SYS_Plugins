table.insert(props, {
  Name = "Debug Print",
  Type = "enum",
  Choices = {"None", "Tx/Rx", "Tx", "Rx", "Function Calls", "All"},
  Value = "None"
})
table.insert(props, {
  Name = "Control_Type",
  Type = "enum",
  Choices = {"RS-232", "TCP/IP", "CEC"},
  Value = "RS-232"
})
table.insert(props, {
  Name = "Display_Make",
  Type = "enum",
  Choices = {"Sharp","Samsung","Sony","Panasonic"}
})


