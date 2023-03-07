-- Connection Controls
table.insert(graphics, {
  Type = "Text",
  Text = "User Name:",
  Position = {5, 5},
  Size = {95, 16},
  FontSize = 14,
  HTextAlign = "Right"
})
table.insert(graphics, {
  Type = "Text",
  Text = "Password:",
  Position = {205, 5},
  Size = {95, 16},
  FontSize = 14,
  HTextAlign = "Right"
})
layout["Username"] = {
  PrettyName = "Username",
  Style = "Text",
  Position = {100, 5},
  Size = {100, 16}
}
layout["Password"] = {
  PrettyName = "Password",
  Style = "Text",
  Position = {300, 5},
  Size = {100, 16}
}

-- Data and Response Controls
layout["Status"] = {
  PrettyName = "Connection Status", 
  Position = {115, 30}, 
  Size = {180, 20}
}
layout["SendButton"] = {
  PrettyName = "Send Request",
  Legend = "Send",
  FontSize = 12,
  Style = "Button",
  Position = {150, 80},
  Size = {100, 24}
}
layout["ResponseText"] = {
  PrettyName = "Data",
  Position = {15, 105}, 
  Size = {360, 20}
}