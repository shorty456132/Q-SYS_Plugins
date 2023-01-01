local CurrentPage = PageNames[props["page_index"].Value]

--********** Control Page *************
if CurrentPage == "Control" then
  table.insert(graphics,{
    Type = "GroupBox",
    Text = "Control",
    Fill = {200,200,200},
    StrokeWidth = 1,
    Position = {5,5},
    Size = {300,200},
    HTextAlign = "Left"
  })
  table.insert(graphics,{
    Type = "Text",
    Text = "Say Hello:",
    Position = {10,42},
    Size = {90,16},
    FontSize = 14,
    HTextAlign = "Right"
  })
  layout["SendButton"] = {
    PrettyName = "Send The Command",
    Style = "Button",
    Position = {105,42},
    Size = {50,50},
    Color = {0,0,0},
    CornerRadius = 90
  }
  

-- ************ Serial Page **************
elseif CurrentPage == "Serial" then
  table.insert(graphics,{
    Type = "Text",
    Text = "User Name: ",
    HTextAlign = "Right",
    CornerRadius = 8,
    Position = {5,5},
    Color = {40,40,40},
    Size = {95,16},
    FontSize = 14
  })
  table.insert(graphics,{
    Type = "Text",
    Text = "Password: ",
    HTextAlign = "Right",
    Position = {205,5},
    Size = {95,16},
    FontSize = 14
  })
  layout["Username"] = {
    PrettyName = "Username",
    Style = "Text",
    Position = {100,5},
    Size = {100,16}
  }
  layout["Password"] = {
    PrettyName = "Password",
    Style = "Text",
    Position = {305,5},
    Size = {100,16}
  }
  -- Data and Response Controls
  layout["Status"] = {
    PrettyName = "Connection Status",
    Position = {115,30},
    Size = {180,20}
  }
  layout["SendBtn"] = {
    PrettyName = "Send Request",
    Legend = "Send",
    FontSize = 12,
    Style = "Button",
    Position = {150, 80},
    Size = {360,20}
  }
  layout["ResponseText"] = {
    PrettyName = "Data",
    Position = {15,105},
    Size = {360,20}
  }
end