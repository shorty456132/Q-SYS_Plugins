local gaTextControls = {
  Name = {"MODEL","SERIAL_NUM","FW_VER","IP_ADDR_NET_AUDIO_PRIMARY","IP_SUBNET_NET_AUDIO_PRIMARY","IP_GATEWAY_NET_AUDIO_PRIMARY",
        "CONTROL_MAC_ADDR","DEVICE_ID","NA_DEVICE_NAME","CHAN_NAME","NA_CHAN_NAME","AUDIO_IN_RMS_LVL","AUDIO_IN_PEAK_LVL",
        "PRESET","PRESET_NAME","NUM_ACTIVE_MICS","LAST_ERROR_EVENT"},
  Count = {1,1,1,1,1,1,1,1,1,9,9,9,9,1,1,1,1}
}
local gaButtonControls = {
  Name = {"FLASH","DEVICE_AUDIO_MUTE","AUDIO_MUTE","ENCRYPTION","PEQ_1","PEQ_2","PEQ_3","PEQ_4","CHAN_AUTOMIX_SOLO_EN",
          "LED_STATE_MUTED","LED_STATE_UNMUTED","BYPASS_ALL_EQ","BYPASS_IMX","EQ_CONTOUR","ENABLE_METERING"},
  Count = {1,1,9,1,9,9,9,9,8,1,1,1,1,1,1}
}
local gaIndicatorControls = {
  Name = {"AUDIO_OUT_CLIP_INDICATOR","DEV_MUTE_STATUS_LED_STATE","DEV_LED_IN_STATE","AUTOMIX_GATE_OUT_EXT_SIG"},
  Count = {9,1,1,8}
}
local gaKnobControls = {
  Name = {"AUDIO_GAIN_HI_RES","AUDIO_GAIN_POSTGATE","BEAM_ANGLE","METER_RATE","POSTGATE_METER_RATE","AUTOMIXER_METER_RATE","AEC_REF_METER_RATE"},
  Count = {9,8,8,9,8,8,1},
  MinVal = {-110,-110,-90,-60,-60,-60,-60},
  MaxVal = {20,20,90,0,0,0,0},
  PinStyle = {"Output","Output","Both","Output","Output","Output","Output"}
}
local gaComboBoxControls = {
  Name = {"LED_BRIGHTNESS","LED_COLOR_UNMUTED","LED_COLOR_MUTED","DEVICE_INSTALLATION","BEAM_W"},
  Count = {1,1,1,1,8}
}
--Arrays of Controls
for i=1,#gaTextControls.Name do
  table.insert(ctrls, {
    Name = gaTextControls.Name[i],
    ControlType = "Text",
    Count = gaTextControls.Count[i],
    UserPin = true,
    PinStyle = "Output",
  })
end
for i=1,#gaButtonControls.Name do
  table.insert(ctrls, {
    Name = gaButtonControls.Name[i],
    ControlType = "Button",
    ButtonType = "Toggle",
    Count = gaButtonControls.Count[i],
    UserPin = true,
    PinStyle = "Both",
  })
end
for i=1,#gaIndicatorControls.Name do
  table.insert(ctrls, {
    Name = gaIndicatorControls.Name[i],
    ControlType = "Indicator",
    IndicatorType = "Led",
    Count = gaIndicatorControls.Count[i],
    UserPin = true,
    PinStyle = "Output",
  })
end
for i=1,#gaKnobControls.Name do
  table.insert(ctrls, {
    Name = gaKnobControls.Name[i],
    ControlType = "Knob",
    ControlUnit = "Integer",
    Min = gaKnobControls.MinVal[i],
    Max = gaKnobControls.MaxVal[i],
    Count = gaKnobControls.Count[i],
    UserPin = true,
    PinStyle = gaKnobControls.PinStyle[i],
  })
end
for i=1,#gaComboBoxControls.Name do
  table.insert(ctrls, {
    Name = gaComboBoxControls.Name[i],
    ControlType = "Text",
    Count = gaComboBoxControls.Count[i],
    UserPin = true,
    PinStyle = "Both",
  })
end

--One off Controls
table.insert(ctrls, {
  Name = "IPAddress",
  ControlType = "Text",
  Count = 1,
  UserPin = true,
  PinStyle = "Both",
})
table.insert(ctrls, {
  Name = "Status",
  ControlType = "Indicator",
  IndicatorType = "Status",
  Count = 1,
  UserPin = true,
  PinStyle = "Output",
})
table.insert(ctrls, {
  Name = "PRESET",
  ControlType = "Text",
  Count = 1,
  UserPin = true,
  PinStyle = "Both",
})
table.insert(ctrls, {
  Name = "Coverage_Map",
  ControlType = "Button",
  ButtonType = "Trigger",
  Count = 1,
  UserPin = false,
  PinStyle = "None",
})