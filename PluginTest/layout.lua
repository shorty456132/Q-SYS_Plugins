local CurrentPage = PageNames[props["page_index"].Value]
if CurrentPage == "Control" then
  table.insert(graphics,{
    Type = "GroupBox",
    Text = "Control",
    Fill = {200,200,200},
    StrokeWidth = 1,
    Position = {5,5},
    Size = {200,100},
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
    PrettyName = "Buttons~Send The Command",
    Style = "Button",
    Position = {105,42},
    Size = {50,16},
    Color = {0,0,0},
    CornerRadius = 90
  }
elseif CurrentPage == "Setup" then
  -- TBD
  table.insert(graphics,{
    Type = "GroupBox",
    Text = "Setup",
    HTextAlign = "Left",
    CornerRadius = 8,
    Position = {1,1},
    Color = {40,40,40},
    Fill = {50,50,50,255},
    StrokeWidth = 1,
    Size = {200,300}
  })
  table.insert(graphics,{
    Type = "Text",
    Text = "Some Setup Information Goes Here",
    Color = {150,150,150},
    StrokeWidth = 1,
    Position = {10,42},
    Size = {90,auto},
    FontSize = 14
  })
end