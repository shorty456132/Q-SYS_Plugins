table.insert(props, {
  Name = "Debug Print",
  Type = "enum",
  Choices = {"None", "Tx/Rx", "Tx", "Rx", "Function Calls", "All"},
  Value = "None"
})

-- Choose a display type. 
-- this will build out power on/off controls and associate Fb strings based on model
table.insert(props, {
  Name = "DisplayMake",
  Type = "enum",
  Choices ={"Sony", "Samsung-UDC"},
  Value = "Sony"  
})