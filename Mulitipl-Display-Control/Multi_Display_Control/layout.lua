local CurrentPage = PageNames[props["page_index"].Value]

local h1 = 20                 --Height of text elements
local h2 = 32                 --Height of control buttons
local GroupBoxHeight = 155    --Height od group boxes
local w1 = 280                --Width of group boxes
local fs1 = 12                --FontSize of text elements
local _keySize = {80, 25}     --Size of the description keys in Key/Value pair



if CurrentPage == "Settings" then
-- Logo ---------------------------------------------------
  table.insert(graphics,{
    Type = "Text",
    Text = "Build Info",
    FontSize = fs1,
    HTextAlign = "Left",
    Position =  {0,0},
    Size = {62,h1}
  })
  table.insert(graphics,{
    Type = "Text",
    Text = "v" .. PluginInfo.BuildVersion,
    FontSize = fs1,
    HTextAlign = "Left",
    Position = {0, h1},
    Size = {62, h1}
   })
   table.insert(graphics,{
    Type = "Image",
    Image = DGI_Logo,
    Position = {112,0},
    Size = {168, 35}
   })


   -- GroupBoxes ----------------------------------------------
   table.insert(graphics,{
    Type = "GroupBox",
    Text = "Connection",
    FontSize = fs1,
    HTextAlign = "Left",
    Fill = Palette.DT_blue,
    StrokeColor = Palette.DT_Yellow,
    StrokeWidth = 1,
    CornerRadius = 8,
    Position = {0, 50},
    Size = {w1, GroupBoxHeight}
  })

  table.insert(graphics,{
    Type = "GroupBox",
    Text = "Display Info",
    FontSize = fs1,
    HTextAlign = "Left",
    Fill = Palette.DT_blue,
    StrokeColor = Palette.DT_Yellow,
    StrokeWidth = 1,
    CornerRadius = 8,
    Position = {0, GroupBoxHeight + 55},
    Size = {w1, GroupBoxHeight }
  })

-- Control Setup  ---------------------------------------------------------------------------------
--RS232 Layout ---------------------------------------
 if props["Control_Type"].Value == "RS-232" then  
  table.insert(graphics, {
    Type = "Text",
    Text = "RS-232 Settings",
    Position = {90, 52},
    Size = {150,30},
    VTextAlign = "Top",
    Color = {255,255,255},
    FontSize = h1
  })
  table.insert(graphics, {
    Type       = "Text",
    Text       = "Baud Rate:",
    Position   = {10, 80},
    Size       = _keySize,
    Color      = {255, 255, 255},
    FontSize   = fs1,
    HTextAlign = "Left"
  })
  layout["BaudRate"] = {
    PrettyName = "_BaudRate",
    Style = "ComboBox",
    Position = {90, 80},
    Size = {90, 25}
  }
  table.insert(graphics, {
    Type       = "Text",
    Text       = "Data Bits:",
    Position   = {10, 110},
    Size       = _keySize,
    Color      = {255, 255, 255},
    FontSize   = fs1,
    HTextAlign = "Left"
  })
  layout["DataBits"] = {
    PrettyName = "_DataBits",
    Style = "ComboBox",
    Position = {90, 110},
    Size = {50, 25}
  }
  table.insert(graphics, {
    Type       = "Text",
    Text       = "Stop Bits:",
    Position   = {10, 140},
    Size       = _keySize,
    Color      = {255, 255, 255},
    FontSize   = fs1,
    HTextAlign = "Left"
  })
  layout["StopBits"] = {
    PrettyName = "_StopBits",
    Style = "ComboBox",
    Position = {90, 140},
    Size = {50, 25}
  }
  table.insert(graphics, {
    Type       = "Text",
    Text       = "Parity:",
    Position   = {10, 170},
    Size       = _keySize,
    Color      = {255, 255, 255},
    FontSize   = fs1,
    HTextAlign = "Left"
  })
  layout["Parity"] = {
    PrettyName = "_Parity",
    Style = "ComboBox",
    Position = {90, 170},
    Size = {70, 25},
    Fill = Palette.White
  }

--TCP/IP Layout ---------------------------------------
  elseif props["Control_Type"].Value == "TCP/IP" then
    table.insert(graphics, {
      Type = "Text",
      Text = "TCP/IP Settings",
      Position = {90, 52},
      Size = {150,30},
      VTextAlign = "Top",
      Color = {255,255,255},
      FontSize = h1
    })
    table.insert(graphics, {
      Type       = "Text",
      Text       = "IP Address:",
      Position   = {10, 80},
      Size       = _keySize,
      Color      = {255, 255, 255},
      FontSize   = fs1,
      HTextAlign = "Left"
    })
    layout["IPAddress"] = {
      PrettyName = "_IPAddr",
      Style = "Text",
      Position = {80, 80},
      Size = {90, 25},
      Fill = Palette.White
    }
    table.insert(graphics, {
      Type       = "Text",
      Text       = "Port:",
      Position   = {10, 110},
      Size       = _keySize,
      Color      = {255, 255, 255},
      FontSize   = fs1,
      HTextAlign = "Left"
    })
    layout["Port"] = {
      PrettyName = "_Port",
      Style = "Text",
      Position = {80, 110},
      Size = {60, 25}
    }
    table.insert(graphics, {
      Type = "Text",
      Text = "Authentication:",
      Position = {150, 110},
      Size = {88, 25},
      Color = {255,255,255},
      FontSize = fs1,
      HTextAlign = "Left"
    })
    layout["Authentication"] = {
      PrettyName = "Auth",
      Style = "Button",
      Position = {240, 110},
      Size = {25, 25}
    }

    table.insert(graphics, {
      Type = "Text",
      Text = "Username:",
      Position = {10, 140},
      Size = {80, 25},

    })
    layout["UserName"] = {
      PrettyName = "User",
      Style = "Text",
      Position = {80, 140},
      Size = {80, 25}
    }
    layout["Password"] = {
      PrettyName = "Password",
      Style = "Text",
      Position = {80, 170},
      Size = {80, 25}
    }
    table.insert(graphics, {
      Type = "Text",
      Text = "Password:",
      Position = {10, 140},
      Size = {80, 25}
    })
  end


  -- Display Setup ------------------------------------------------
  table.insert(graphics, {
    Type       = "Text",
    Text       = "Display Make:",
    Position   = {10, GroupBoxHeight + 70},
    Size       = _keySize,
    Color      = {255, 255, 255},
    FontSize   = fs1,
    HTextAlign = "Left"
  })
  layout["DisplayMake"] = {
    PrettyName = "_DisplayMake",
    Style = "ComboBox",
    Position = {90, GroupBoxHeight + 70},
    Size = {90, 25}
  }



elseif CurrentPage == "Controls" then
  -- Logo ---------------------------------------------------
  table.insert(graphics,{
    Type = "Text",
    Text = "Build Info",
    FontSize = fs1,
    HTextAlign = "Left",
    Position =  {0,0},
    Size = {62,h1}
  })
  table.insert(graphics,{
    Type = "Text",
    Text = "v" .. PluginInfo.BuildVersion,
    FontSize = fs1,
    HTextAlign = "Left",
    Position = {0, h1},
    Size = {62, h1}
   })
   table.insert(graphics,{
    Type = "Image",
    Image = DGI_Logo,
    Position = {112,0},
    Size = {168, 35}
   })

   -- GroupBoxes ----------------------------------------------
   table.insert(graphics,{
    Type = "GroupBox",
    Text = "Display Controls",
    FontSize = fs1,
    HTextAlign = "Left",
    Fill = Palette.DT_blue,
    StrokeColor = Palette.DT_Yellow,
    StrokeWidth = 1,
    CornerRadius = 8,
    Position = {0, 50},
    Size = {w1, GroupBoxHeight}
  })


   -- Display Control  -----------------------------------------------------------
  layout["PowerOn"] = {
    PrettyName = "PowerOn",
    Style = "Button",
    Legend = "Power On",
    Position = {110,55},
    Size = {75, 30},
    OffColor = Palette.Green
  }
  layout["PowerOff"] = {
    PrettyName = "PowerOff",
    Style = "Button",
    Legend = "Power Off",
    Position = {190,55},
    Size = {75, 30},
    OffColor = Palette.Green
  }
end








--*********** Base Code ***************--
-- if CurrentPage == "Control" then
--   table.insert(graphics,{
--     Type = "GroupBox",
--     Text = "Control",
--     Fill = {200,200,200},
--     StrokeWidth = 1,
--     Position = {5,5},
--     Size = {200,100}
--   })
--   table.insert(graphics,{
--     Type = "Text",
--     Text = "Say Hello:",
--     Position = {10,42},
--     Size = {90,16},
--     FontSize = 14,
--     HTextAlign = "Right"
--   })
--   layout["SendButton"] = {
--     PrettyName = "Buttons~Send The Command",
--     Style = "Button",
--     Position = {105,42},
--     Size = {50,16},
--     Color = {0,0,0}
--   }
-- elseif CurrentPage == "Setup" then
--   -- TBD
-- end