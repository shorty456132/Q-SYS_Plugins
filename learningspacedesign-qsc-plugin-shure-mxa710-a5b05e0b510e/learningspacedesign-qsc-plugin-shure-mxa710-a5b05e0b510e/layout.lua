local CurrentPage = PageNames[props["page_index"].Value]
local gaColor = {
  Black = {0,0,0}, --Black
  White = {255,255,255}, --White
  Green = {178,255,51}, --Shure Green
  LtGray = {204,204,204}, --Light Gray
  LtBlue = {110,198,241}, --Light Blue
  Red = {255,0,0}, -- Red
  Yellow = {252,246,76}, --Yellow
  Purple = {72,72,183}  --Purple
}
local gsCat1 = "Unit Information~"
local gsCat2 = "Coverage~"
local gsCat3 = "Channels~"
local gsCat4 = "Intellimix~"
local gsCat5 = "Setup~"
if CurrentPage == "Coverage" then
    --All Basic Background and Header Graphics
    table.insert(graphics,{
      Type = "GroupBox",
      Fill = gaColor.Black,
      CornerRadius = 5,
      StrokeWidth = 1,
      Position = {5,5},
      Size = {590,440}
    })
    Logo = "--[[ #encode "logo.svg" ]]"
    table.insert(graphics,{
      Type = "Svg",
      Image = Logo,
      Position = {20,5},
      Size = {300,64},
      ZOrder = 1000
    })
    table.insert(graphics,{
      Type = "Text",
      Text = "MXA-710",
      Position = {320, 5},
      Color = gaColor.Green,
      Size = {185,64},
      FontSize = 40,
      Font = "Open Sans",
      FontStyle = "Extrabold",
      HTextAlign = "Left"
    })
    table.insert(graphics,{
      Type = "Text",
      Text = "©",
      Position = {500, 20},
      Color = gaColor.Green,
      Size = {20,20},
      FontSize = 16,
      Font = "Open Sans",
      FontStyle = "Extrabold",
      HTextAlign = "Left"
    })
    table.insert(graphics,{
      Type = "Header",
      Text = "Coverage",
      Position = {15,70},
      Size = {570,11},
      Color = gaColor.Green,
      FontSize = 16,
      Font = "Roboto",
      FontStyle = "Bold",
      HTextAlign = "Center",
    })
    local gaLabels = {
      Pos = {X={15,149,385,10,500},Y={90,90,90,424,424}},
      Text = {"Beam Width","Beam Angle","Coverage Map","Device Mute","Version "..PluginInfo.Version,}
    }
    local gaLayouts = {
      KnobPos = {X={110,110,110,110,110,110,110,110},Y={120,156,192,228,264,300,336,372}},
      ComboPos = {X={20,20,20,20,20,20,20,20},Y={130,166,202,238,274,310,346,382}},
      KnobText = {"BEAM_ANGLE "},
      ComboText = {"BEAM_W "},
      KnobPrettyName = {"Beam Angle "},
      ComboPrettyName = {"Beam Width "}
    }
        --Basic Labels
    for i=1,#gaLabels.Pos.X do
      table.insert(graphics,{
        Type = "Text",
        Text = gaLabels.Text[i],
        Position = { gaLabels.Pos.X[i], gaLabels.Pos.Y[i]},
        Color = gaColor.White,
        Size = {90,16},
        FontSize = 12,
        HTextAlign = "Center"
      })
    end
    for j=1,#gaLayouts.ComboPos.X do
      table.insert(graphics,{
        Type = "Text",
        Text = tostring(j),
        Position = { 7 , gaLayouts.ComboPos.Y[j]},
        Color = gaColor.White,
        Size = {10,16},
        FontSize = 10,
        HTextAlign = "Center"
      })
    end
    for k=1,#gaLayouts.ComboPos.X do
      layout[gaLayouts.ComboText[1]..k] = {
        PrettyName = "Channel "..k.."~"..gaLayouts.ComboPrettyName[1],
        Style = "ComboBox",
        Position = { gaLayouts.ComboPos.X[k], gaLayouts.ComboPos.Y[k]},
        Size = {80,16},
        Color = gaColor.White,
        FontSize = 14,
        HTextAlign = "Center",
        IsReadOnly = false
      }
    end
    for j=1,#gaLayouts.KnobPos.X do 
      layout[gaLayouts.KnobText[1]..j] = {
        PrettyName = "Channel "..j.."~"..gaLayouts.KnobPrettyName[1],
        Style = "Fader",
        ShowTextbox = true,
        Position = {gaLayouts.KnobPos.X[j],gaLayouts.KnobPos.Y[j]},
        Size = {168,36},
        Color = gaColor.Green,
      }
    end
    layout["Coverage_Map"] = {
      PrettyName = "Coverage Map",
      Style = "Button",
      ButtonStyle = "Trigger",
      ButtonVisualStyle = "Flat",
      CornerRadius = 0,
      Margin = 1,
      Position = { 280, 120},
      Size = {300,300},
      DrawChrome = false,
      UnlinkOffColor = true,
      Color = "#00000000",
      OffColor = "#00000000",
      StrokeWidth = 0,
      IsReadOnly=true
    }
    ShureArraySVG = "--[[ #encode "shuremxa710.svg" ]]"
    table.insert(graphics,{
      Type = "Svg",
      Image = ShureArraySVG,
      Position = {375,263},
      Size = {110,15},
      ZOrder = 1001
    })
    layout["DEVICE_AUDIO_MUTE"] = {
      PrettyName = "Device Audio Mute",
      Style = "Button",
      ButtonStyle = "Toggle",
      ButtonVisualStyle = "Flat",
      CornerRadius = 5,
      Margin = 1,
      Position = {100,424},
      Size = {50,16},
      Color = gaColor.Red,
      OffColor = gaColor.LtGray,
      UnlinkOffColor = true,
    }    
    layout["DEV_MUTE_STATUS_LED_STATE"] = {
      PrettyName = "Device Muted State",
      Style = "Led",
      Position = {155,424},
      Size = {16,16},
      Color = gaColor.Red,
      OffColor = gaColor.Green,
      UnlinkOffColor = true,
      Margin = 3,
      IsReadOnly = true,
    }      
    table.insert(graphics,{
      Type = "Text",
      Text = "Current Preset Loaded",
      Position = {180,424 },
      Color = gaColor.White,
      Size = {125,16},
      FontSize = 12,
      HTextAlign = "Right"
    })
    table.insert(graphics,{
      Type = "Text",
      Text = "Recall Preset",
      Position = {335,424 },
      Color = gaColor.White,
      Size = {80,16},
      FontSize = 12,
      HTextAlign = "Right"
    })
    layout["PRESET"] = {
      PrettyName = "Current Preset Loaded",
      Style = "Indicator",
      Position = {305,424},
      Size = {25,16},
      Color = gaColor.LtGray,
      FontSize = 14,
      HTextAlign = "Center",
      IsReadOnly = true
    }
    layout["PRESET_NAME"] = {
      PrettyName = "Recall Preset",
      Style = "ComboBox",
      Position = {415,424},
      Size = {90,16},
      Color = gaColor.White,
      FontSize = 14,
      HTextAlign = "Center",
      IsReadOnly = false
    }
    layout["Status"] = {
      PrettyName = "Connection Info~Connection Status",
      Style = "Led",
      Position = {10,10},
      Size = {16,16},
      Margin = 3,
      IsReadOnly = true,
    }
elseif CurrentPage == "Channels" then
    --All Basic Background and Header Graphics
    table.insert(graphics,{
      Type = "GroupBox",
      Fill = gaColor.Black,
      CornerRadius = 5,
      StrokeWidth = 1,
      Position = {5,5},
      Size = {1100,430}
    })
    Logo = "--[[ #encode "logo.svg" ]]"
    table.insert(graphics,{
      Type = "Svg",
      Image = Logo,
      Position = {280,5},
      Size = {300,64},
      ZOrder = 1000
    })
    table.insert(graphics,{
      Type = "Text",
      Text = "MXA-710",
      Position = {580, 5},
      Color = gaColor.Green,
      Size = {185,64},
      FontSize = 40,
      Font = "Open Sans",
      FontStyle = "Extrabold",
      HTextAlign = "Left"
    })
    table.insert(graphics,{
      Type = "Text",
      Text = "©",
      Position = {760, 20},
      Color = gaColor.Green,
      Size = {20,20},
      FontSize = 16,
      Font = "Open Sans",
      FontStyle = "Extrabold",
      HTextAlign = "Left"
    })
    table.insert(graphics,{
      Type = "Header",
      Text = "Channels",
      Position = {15,70},
      Size = {1080,11},
      Color = gaColor.Green,
      FontSize = 16,
      Font = "Roboto",
      FontStyle = "Bold",
      HTextAlign = "Center",
    })
    local gaLabels = {
      Pos = {X={10,10,10,10,10,10,10,10,10,1000},Y={90,110,130,150,170,250,270,378,410,410}},
      Text = {"Channel Name","Dante Ch Name","RMS Level","Peak Level","Clip Indicator","Audio Gain","Audio Levels",
              "Channel Mute","Device Mute","Version "..PluginInfo.Version,}
    }
    local gaLegend = {
      Text = {"0","-12","-24","-36","-48","-60"},
      Pos = {X={193,303,413,523,633,743,853,963,1073},Y={186,219,253,284,319,351}}
    }
    local gaLayouts = {
      Pos = {X={110,220,330,440,550,660,770,880,990}},
      LabelText = {"CHAN_NAME ","NA_CHAN_NAME ","AUDIO_IN_RMS_LVL ","AUDIO_IN_PEAK_LVL "},
      ButtonText = {"AUDIO_MUTE "},
      IndicText = {"AUDIO_OUT_CLIP_INDICATOR "},
      KnobText = {"AUDIO_GAIN_HI_RES ","METER_RATE "},
      KnobStyle = {"Fader","Meter"},
      KnobSize = {X={36,18},Y={168,168}},
      KnobTextBox = {true,false},
      LabelPrettyName = {"Channel Name ","Dante Channel Name ","Audio In RMS Level ","Audio In Peak Level "},
      ButtonPrettyName = {"Channel Mute "},
      IndicPrettyName = {"Channel Clip Indicator "},
      KnobPrettyName = {"Channel Gain ","Channel Meter Level "}
    }
    --Basic Labels
    for i=1,#gaLabels.Pos.X do
      table.insert(graphics,{
        Type = "Text",
        Text = gaLabels.Text[i],
        Position = { gaLabels.Pos.X[i], gaLabels.Pos.Y[i]},
        Color = gaColor.White,
        Size = {100,16},
        FontSize = 12,
        HTextAlign = "Right"
      })
    end
    --Level Legend
    for i=1,#gaLayouts.Pos.X do
      for p=1,#gaLegend.Text do
        table.insert(graphics,{
          Type = "Text",
          Text = gaLegend.Text[p],
          Position = { gaLegend.Pos.X[i], gaLegend.Pos.Y[p]},
          Color = gaColor.White,
          Size = {20,10},
          FontSize = 9.5,
          HTextAlign = "Left"
        })
      end
    end
    --Named Text Components Layouts
    for i=1,#gaLayouts.Pos.X do
      for k=1,#gaLayouts.LabelText do 
        layout[gaLayouts.LabelText[k]..i] = {
          PrettyName = "Channel "..i.."~"..gaLayouts.LabelPrettyName[k],
          Style = "Indicator",
          Position = { gaLayouts.Pos.X[i], 70+(k*20)},
          Size = {100,16},
          Color = gaColor.LtGray,
          FontSize = 14,
          HTextAlign = "Center",
          IsReadOnly = true
        }
      end
      for j=1,#gaLayouts.KnobText do 
        layout[gaLayouts.KnobText[j]..i] = {
          PrettyName = "Channel "..i.."~"..gaLayouts.KnobPrettyName[j],
          Style = gaLayouts.KnobStyle[j],
          ShowTextbox = gaLayouts.KnobTextBox[j],
          TextBoxHeight = 16,
          Position = {gaLayouts.Pos.X[i]+50*(j-1)+15,190},
          Size = {gaLayouts.KnobSize.X[j],gaLayouts.KnobSize.Y[j]},
          Color = gaColor.Green,
        }
      end
      layout[gaLayouts.ButtonText[1]..i] = {
        PrettyName = "Channel "..i.."~"..gaLayouts.ButtonPrettyName[1],
        Style = "Button",
        ButtonStyle = "Toggle",
        ButtonVisualStyle = "Flat",
        CornerRadius = 5,
        Margin = 1,
        Position = { gaLayouts.Pos.X[i], 370},
        Size = {100,32},
        Color = gaColor.Red,
        OffColor = gaColor.LtBlue,
        UnlinkOffColor = true,
        Legend = "MUTE",
        TextFontSize = 20,
        IsBold = true
      }
      layout[gaLayouts.IndicText[1]..i] = {
        PrettyName = "Channel "..i.."~"..gaLayouts.IndicPrettyName[1],
        Style = "Led",
        Position = { gaLayouts.Pos.X[i]+66, 170},
        Size = {16,16},
        Color = gaColor.Red,
        UnlinkOffColor = false,
        Margin = 3,
        IsReadOnly = true,
      }
    end
    layout["EQ_CONTOUR"] = {
      PrettyName = gsCat5.."EQ CONTOUR",
      Style = "Button",
      ButtonStyle = "Toggle",
      ButtonVisualStyle = "Flat",
      CornerRadius = 5,
      Margin = 1,
      Position = { 10, 30},
      Size = {100,32},
      Color = gaColor.Purple,
      OffColor = gaColor.LtGray,
      UnlinkOffColor = true,
      Legend = "EQ CONTOUR",
      TextFontSize = 14,
      IsBold = false
    }
    layout["DEVICE_AUDIO_MUTE"] = {
      PrettyName = "Device Audio Mute",
      Style = "Button",
      ButtonStyle = "Toggle",
      ButtonVisualStyle = "Flat",
      CornerRadius = 5,
      Margin = 1,
      Position = {110,410},
      Size = {50,16},
      Color = gaColor.Red,
      OffColor = gaColor.LtGray,
      UnlinkOffColor = true,
    }    
    layout["DEV_MUTE_STATUS_LED_STATE"] = {
      PrettyName = "Device Muted State",
      Style = "Led",
      Position = {165,410},
      Size = {16,16},
      Color = gaColor.Red,
      OffColor = gaColor.Green,
      UnlinkOffColor = true,
      Margin = 3,
      IsReadOnly = true,
    }
    layout["Status"] = {
      PrettyName = "Connection Info~Connection Status",
      Style = "Led",
      Position = {10,10},
      Size = {16,16},
      Margin = 3,
      IsReadOnly = true,
    }
elseif CurrentPage == "IntelliMix" then
    --All Basic Background and Header Graphics
    table.insert(graphics,{
      Type = "GroupBox",
      Fill = gaColor.Black,
      CornerRadius = 5,
      StrokeWidth = 1,
      Position = {5,5},
      Size = {1100,550}
    })
    Logo = "--[[ #encode "logo.svg" ]]"
    table.insert(graphics,{
      Type = "Svg",
      Image = Logo,
      Position = {280,5},
      Size = {300,64},
      ZOrder = 1000
    })
    table.insert(graphics,{
      Type = "Text",
      Text = "MXA-710",
      Position = {580, 5},
      Color = gaColor.Green,
      Size = {185,64},
      FontSize = 40,
      Font = "Open Sans",
      FontStyle = "Extrabold",
      HTextAlign = "Left"
    })
    table.insert(graphics,{
      Type = "Text",
      Text = "©",
      Position = {760, 20},
      Color = gaColor.Green,
      Size = {20,20},
      FontSize = 16,
      Font = "Open Sans",
      FontStyle = "Extrabold",
      HTextAlign = "Left"
    })
    table.insert(graphics,{
      Type = "Header",
      Text = "Channels",
      Position = {15,70},
      Size = {1080,11},
      Color = gaColor.Green,
      FontSize = 16,
      Font = "Roboto",
      FontStyle = "Bold",
      HTextAlign = "Center",
    })
    local gaLabels = {
      Pos = {X={10,10,10,10,10,10,10,10,10,10,10,1000},Y={90,143,170,250,270,378,410,442,474,506,536,536}},
      Text = {"Channel Name","AutoMix Solo","AutoMix Gate Ind","Post Gate Gain","Post Gate Levels","Channel Mute","PEQ Filter 1",
              "PEQ Filter 2","PEQ Filter 3","PEQ Filter 4","Device Mute","Version "..PluginInfo.Version,}
    }
    local gaLegend = {
      Text = {"0","-12","-24","-36","-48","-60"},
      Pos = {X={193,303,413,523,633,743,853,963,1073},Y={186,219,253,284,319,351}}
    }
    local gaLayouts = {
      Pos = {X={110,220,330,440,550,660,770,880,990}},
      LabelText = {"CHAN_NAME "},
      ButtonText = {"AUDIO_MUTE ","PEQ_1 ","PEQ_2 ","PEQ_3 ","PEQ_4 ","CHAN_AUTOMIX_SOLO_EN "},
      ButtonOnColor = {gaColor.Red,gaColor.Purple,gaColor.Purple,gaColor.Purple,gaColor.Purple,gaColor.Yellow},
      ButtonOffColor = {gaColor.LtBlue,gaColor.LtGray,gaColor.LtGray,gaColor.LtGray,gaColor.LtGray,gaColor.LtGray},
      ButtonLegend = {"MUTE", "ENABLE","ENABLE","ENABLE","ENABLE","SOLO"},
      ButtonPos = {Y={370,402,434,466,498,135}},
      IndicText = {"AUTOMIX_GATE_OUT_EXT_SIG "},
      KnobText = {"AUDIO_GAIN_POSTGATE ","POSTGATE_METER_RATE "},
      KnobStyle = {"Fader","Meter"},
      KnobSize = {X={36,18},Y={168,168}},
      KnobTextBox = {true,false},
      LabelPrettyName = {"Channel Name "},
      ButtonPrettyName = {"Channel Mute ","1st PEQ Filter ","2nd PEQ Filter ","3rd PEQ Filter ","4th PEQ Filter ", "Automix Solo "},
      KnobPrettyName = {"Post Gate Gain ","Post Gate Meter Level "},
      IndicPrettyName = {"AutoMixer Gate Indicator "}
    }
    --Basic Labels
    for i=1,#gaLabels.Pos.X do
      table.insert(graphics,{
        Type = "Text",
        Text = gaLabels.Text[i],
        Position = { gaLabels.Pos.X[i], gaLabels.Pos.Y[i]},
        Color = gaColor.White,
        Size = {100,16},
        FontSize = 12,
        HTextAlign = "Right"
      })
    end
      --Level Legend
      for i=1,#gaLayouts.Pos.X do
        for p=1,#gaLegend.Text do
          table.insert(graphics,{
            Type = "Text",
            Text = gaLegend.Text[p],
            Position = { gaLegend.Pos.X[i], gaLegend.Pos.Y[p]},
            Color = gaColor.White,
            Size = {20,10},
            FontSize = 9.5,
            HTextAlign = "Left"
          })
        end
      end
    --Named Text Components Layouts
    for i=1,#gaLayouts.Pos.X do
        layout[gaLayouts.LabelText[1]..i] = {
          PrettyName = "Channel "..i.."~"..gaLayouts.LabelPrettyName[1],
          Style = "Indicator",
          Position = { gaLayouts.Pos.X[i], 90},
          Size = {100,16},
          Color = gaColor.LtGray,
          FontSize = 14,
          HTextAlign = "Center",
          IsReadOnly = true
        }
      for j=1,#gaLayouts.KnobText do 
        layout[gaLayouts.KnobText[j]..i] = {
          PrettyName = "Channel "..i.."~"..gaLayouts.KnobPrettyName[j],
          Style = gaLayouts.KnobStyle[j],
          ShowTextbox = gaLayouts.KnobTextBox[j],
          Position = {gaLayouts.Pos.X[i]+50*(j-1)+15,190},
          Size = {gaLayouts.KnobSize.X[j],gaLayouts.KnobSize.Y[j]},
          Color = gaColor.Green,
        }
      end
      for x=1,#gaLayouts.ButtonText do
        layout[gaLayouts.ButtonText[x]..i] = {
          PrettyName = "Channel "..i.."~"..gaLayouts.ButtonPrettyName[x],
          Style = "Button",
          ButtonStyle = "Toggle",
          ButtonVisualStyle = "Flat",
          CornerRadius = 5,
          Margin = 1,
          Position = { gaLayouts.Pos.X[i], gaLayouts.ButtonPos.Y[x]},
          Size = {100,32},
          Color = gaLayouts.ButtonOnColor[x],
          OffColor = gaLayouts.ButtonOffColor[x],
          UnlinkOffColor = true,
          Legend = gaLayouts.ButtonLegend[x],
          TextFontSize = 20,
          IsBold = true
        }
        layout[gaLayouts.IndicText[1]..i] = {
          PrettyName = "Channel "..i.."~"..gaLayouts.IndicPrettyName[1],
          Style = "Led",
          Position = { gaLayouts.Pos.X[i]+66, 170},
          Size = {16,16},
          Color = gaColor.Red,
          UnlinkOffColor = false,
          Margin = 3,
          IsReadOnly = true,
        }
      end
      layout["METER_RATE 9"] = {
        PrettyName = "Channel 9~Channel Meter Level",
        Style = "Meter",
        ShowTextbox = false,
        Position = {1055,190},
        Size = {18,168},
        Color = gaColor.Green,
      }
    end
    layout["BYPASS_IMX"] = {
      PrettyName = gsCat5.."Bypass IntelliMix",
      Style = "Button",
      ButtonStyle = "Toggle",
      ButtonVisualStyle = "Flat",
      CornerRadius = 5,
      Margin = 1,
      Position = { 10, 30},
      Size = {100,32},
      Color = gaColor.Purple,
      OffColor = gaColor.LtGray,
      UnlinkOffColor = true,
      Legend = "Bypass IntelliMix",
      TextFontSize = 14,
      IsBold = false
    }
    layout["BYPASS_ALL_EQ"] = {
      PrettyName = gsCat5.."Bypass All EQ",
      Style = "Button",
      ButtonStyle = "Toggle",
      ButtonVisualStyle = "Flat",
      CornerRadius = 5,
      Margin = 1,
      Position = { 990, 30},
      Size = {100,32},
      Color = gaColor.Purple,
      OffColor = gaColor.LtGray,
      UnlinkOffColor = true,
      Legend = "Bypass \rAll EQ",
      TextFontSize = 14,
      IsBold = false
    }
    layout["DEVICE_AUDIO_MUTE"] = {
      PrettyName = "Device Audio Mute",
      Style = "Button",
      ButtonStyle = "Toggle",
      ButtonVisualStyle = "Flat",
      CornerRadius = 5,
      Margin = 1,
      Position = {110,536},
      Size = {50,16},
      Color = gaColor.Red,
      OffColor = gaColor.LtGray,
      UnlinkOffColor = true,
    }    
    layout["DEV_MUTE_STATUS_LED_STATE"] = {
      PrettyName = "Device Muted State",
      Style = "Led",
      Position = {165,536},
      Size = {16,16},
      Color = gaColor.Red,
      OffColor = gaColor.Green,
      UnlinkOffColor = true,
      Margin = 3,
      IsReadOnly = true,
    }
    layout["Status"] = {
      PrettyName = "Connection Info~Connection Status",
      Style = "Led",
      Position = {10,10},
      Size = {16,16},
      Margin = 3,
      IsReadOnly = true,
    }
elseif CurrentPage == "Information" then
    --All Basic Background and Header Graphics
    table.insert(graphics,{
      Type = "GroupBox",
      Fill = gaColor.Black,
      CornerRadius = 5,
      StrokeWidth = 1,
      Position = {5,5},
      Size = {550,370}
    })
    Logo = "--[[ #encode "logo.svg" ]]"
    table.insert(graphics,{
      Type = "Svg",
      Image = Logo,
      Position = {0,5},
      Size = {300,64},
      ZOrder = 1000
    })
    table.insert(graphics,{
      Type = "Text",
      Text = "MXA-710",
      Position = {300, 5},
      Color = gaColor.Green,
      Size = {185,64},
      FontSize = 40,
      Font = "Open Sans",
      FontStyle = "Extrabold",
      HTextAlign = "Left"
    })
    table.insert(graphics,{
      Type = "Text",
      Text = "©",
      Position = {480, 20},
      Color = gaColor.Green,
      Size = {20,20},
      FontSize = 16,
      Font = "Open Sans",
      FontStyle = "Extrabold",
      HTextAlign = "Left"
    })
    table.insert(graphics,{
      Type = "Header",
      Text = "Information",
      Position = {15,70},
      Size = {530,11},
      Color = gaColor.Green,
      FontSize = 16,
      Font = "Roboto",
      FontStyle = "Bold",
      HTextAlign = "Center",
    })
    local gaLabels = {
      Pos = {X={35,35,35,35,35,35,35,35,35,35,400},Y={110,130,150,170,190,210,230,250,270,290,354}},
      Text = {"Model:","Serial Number:","Firmware Version:","Dante IP:","Dante Subnet:","Dante Gateway:","Control MAC Address:",
              "Device ID:","Dante Device Name:","Last Error:","Version "..PluginInfo.Version,}
    }
    local gaLayouts = {
      Pos = {X={190,190,190,190,190,190,190,190,190,190},Y={110,130,150,170,190,210,230,250,270,290}},
      Text = {"MODEL","SERIAL_NUM","FW_VER","IP_ADDR_NET_AUDIO_PRIMARY","IP_SUBNET_NET_AUDIO_PRIMARY","IP_GATEWAY_NET_AUDIO_PRIMARY",
              "CONTROL_MAC_ADDR","DEVICE_ID","NA_DEVICE_NAME","LAST_ERROR_EVENT"},
      PrettyName = {gsCat1.."Model",gsCat1.."Serial Number",gsCat1.."Firmware Version",gsCat1.."Dante IP",gsCat1.."Dante Subnet",gsCat1.."Dante Gateway",gsCat1.."Control MAC Address",gsCat1.."Device ID",
                    gsCat1.."Dante Device Name",gsCat1.."Last Error"}
    }
    --Basic Labels
    for i=1,#gaLabels.Pos.X do
      table.insert(graphics,{
        Type = "Text",
        Text = gaLabels.Text[i],
        Position = { gaLabels.Pos.X[i], gaLabels.Pos.Y[i]},
        Color = gaColor.White,
        Size = {150,16},
        FontSize = 12,
        HTextAlign = "Right"
      })
    end
    --Named Text Components Layouts
    for i=1,#gaLayouts.Pos.X do
      layout[gaLayouts.Text[i]] = {
        PrettyName = gaLayouts.PrettyName[i],
        Style = "Indicator",
        Position = { gaLayouts.Pos.X[i], gaLayouts.Pos.Y[i]},
        Size = {180,16},
        Color = gaColor.LtGray,
        FontSize = 14,
        HTextAlign = "Center",
        IsReadOnly = true
      }
    end
    layout["DEVICE_AUDIO_MUTE"] = {
      PrettyName = "Device Audio Mute",
      Style = "Button",
      ButtonStyle = "Toggle",
      ButtonVisualStyle = "Flat",
      CornerRadius = 5,
      Margin = 1,
      Position = {100,354},
      Size = {50,16},
      Color = gaColor.Red,
      OffColor = gaColor.LtGray,
      UnlinkOffColor = true,
    }    
    layout["DEV_MUTE_STATUS_LED_STATE"] = {
      PrettyName = "Device Muted State",
      Style = "Led",
      Position = {155,354},
      Size = {16,16},
      Color = gaColor.Red,
      OffColor = gaColor.Green,
      UnlinkOffColor = true,
      Margin = 3,
      IsReadOnly = true,
    }
    table.insert(graphics,{
      Type = "Text",
      Text = "Device Mute",
      Position = { 10,354 },
      Color = gaColor.White,
      Size = {90,16},
      FontSize = 12,
      HTextAlign = "Center"
    })
    layout["Status"] = {
      PrettyName = "Connection Info~Connection Status",
      Style = "Led",
      Position = {10,10},
      Size = {16,16},
      Margin = 3,
      IsReadOnly = true,
    }
elseif CurrentPage == "Setup"then
  --All Basic Background and Header Graphics
  table.insert(graphics,{
    Type = "GroupBox",
    Fill = gaColor.Black,
    CornerRadius = 5,
    StrokeWidth = 1,
    Position = {5,5},
    Size = {550,446}
  })
  Logo = "--[[ #encode "logo.svg" ]]"
  table.insert(graphics,{
    Type = "Svg",
    Image = Logo,
    Position = {0,5},
    Size = {300,64},
    ZOrder = 1000
  })
  table.insert(graphics,{
    Type = "Text",
    Text = "MXA-710",
    Position = {300, 5},
    Color = gaColor.Green,
    Size = {185,64},
    FontSize = 40,
    Font = "Open Sans",
    FontStyle = "Extrabold",
    HTextAlign = "Left"
  })
  table.insert(graphics,{
    Type = "Text",
    Text = "©",
    Position = {480, 20},
    Color = gaColor.Green,
    Size = {20,20},
    FontSize = 16,
    Font = "Open Sans",
    FontStyle = "Extrabold",
    HTextAlign = "Left"
  })
  table.insert(graphics,{
    Type = "Header",
    Text = "Setup",
    Position = {15,70},
    Size = {530,11},
    Color = gaColor.Green,
    FontSize = 16,
    Font = "Roboto",
    FontStyle = "Bold",
    HTextAlign = "Center",
  })
  local gaLabels = {
    Pos = {X={20,20,20,20,20,20,20,20,20,20,20,390},Y={110,130,250,270,290,310,330,350,370,390,410,430}},
    Text = {"IP Address:","Connection Status:","Installation Type:","LED Brightness:","LED Color When Muted:","LED Enabled When Muted:","LED Color When Unmuted:","LED Enabled When Unmuted:",
            "ID Mode (Flash LEDS):","Encryption:","Enable Metering:","Version "..PluginInfo.Version,}
  }
  local gaComboLayouts = {
    Pos = {X={185,185,185,185},Y={250,270,290,330,}},
    Text = {"DEVICE_INSTALLATION","LED_BRIGHTNESS","LED_COLOR_MUTED","LED_COLOR_UNMUTED"},
    PrettyName = {gsCat5.."Installation Type",gsCat5.."LED Brightness",gsCat5.."LED Color (Muted)",gsCat5.."LED Color (Unmuted)"}
  }
  local gaBtnLayouts = {
    Pos = {X={285,285,285,285,285},Y={310,350,370,390,410}},
    Text = {"LED_STATE_MUTED","LED_STATE_UNMUTED","FLASH","ENCRYPTION","ENABLE_METERING"},
    PrettyName = {gsCat5.."LED Enabled (Muted)",gsCat5.."LED Enabled (Unmuted)",gsCat5.."ID Mode (Flash LEDS)",gsCat5.."Encryption",gsCat5.."Enable Metering"}
  }
  --Basic Labels
  for i=1,#gaLabels.Pos.X do
    table.insert(graphics,{
      Type = "Text",
      Text = gaLabels.Text[i],
      Position = { gaLabels.Pos.X[i], gaLabels.Pos.Y[i]},
      Color = gaColor.White,
      Size = {160,16},
      FontSize = 12,
      HTextAlign = "Right"
    })
  end
  --Named Text Components Layouts
  for i=1,#gaComboLayouts.Pos.X do
    layout[gaComboLayouts.Text[i]] = {
      PrettyName = gaComboLayouts.PrettyName[i],
      Style = "ComboBox",
      Position = { gaComboLayouts.Pos.X[i], gaComboLayouts.Pos.Y[i]},
      Size = {250,16},
      Color = gaColor.White,
      FontSize = 14,
      HTextAlign = "Center",
      IsReadOnly = false
    }
  end
  for j=1,#gaBtnLayouts.Pos.X do
    layout[gaBtnLayouts.Text[j]] = {
      PrettyName = gaBtnLayouts.PrettyName[j],
      Style = "Button",
      ButtonStyle = "Toggle",
      ButtonVisualStyle = "Flat",
      CornerRadius = 5,
      Margin = 1,
      Position = { gaBtnLayouts.Pos.X[j], gaBtnLayouts.Pos.Y[j]},
      Size = {50,16},
      Color = gaColor.Purple,
      OffColor = gaColor.LtGray,
      UnlinkOffColor = true,
    }
  end
  layout["IPAddress"] = {
    PrettyName = "Connection Info~Unit IP Address",
    Style = "Indicator",
    Position = {185,110},
    Size = {250,16},
    Color = gaColor.White,
    FontSize = 14,
    HTextAlign = "Center",
    IsReadOnly = false
  }
  layout["Status"] = {
    PrettyName = "Connection Info~Connection Status",
    Style = "Indicator",
    Position = {185,130},
    Size = {250,100},
    Color = {255,255,255},
    FontSize = 16,
    HTextAlign = "Center",
    IsReadOnly = true
  }
  layout["DEVICE_AUDIO_MUTE"] = {
    PrettyName = "Device Audio Mute",
    Style = "Button",
    ButtonStyle = "Toggle",
    ButtonVisualStyle = "Flat",
    CornerRadius = 5,
    Margin = 1,
    Position = {100,430},
    Size = {50,16},
    Color = gaColor.Red,
    OffColor = gaColor.LtGray,
    UnlinkOffColor = true,
  }    
  layout["DEV_MUTE_STATUS_LED_STATE"] = {
    PrettyName = "Device Muted State",
    Style = "Led",
    Position = {155,430},
    Size = {16,16},
    Color = gaColor.Red,
    OffColor = gaColor.Green,
    UnlinkOffColor = true,
    Margin = 3,
    IsReadOnly = true,
  }
  table.insert(graphics,{
    Type = "Text",
    Text = "Device Mute",
    Position = { 10,430 },
    Color = gaColor.White,
    Size = {90,16},
    FontSize = 12,
    HTextAlign = "Center"
  })
end