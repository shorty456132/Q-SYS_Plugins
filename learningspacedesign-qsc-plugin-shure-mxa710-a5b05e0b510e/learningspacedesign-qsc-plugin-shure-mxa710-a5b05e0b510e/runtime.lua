--Requirment Librarys
-------------------------------------------------
json = require("rapidjson")
require("LuaXML")

--TCP Socket Defined
------------------------------------------------------------
gsIPAddress = Controls["IPAddress"].String
gsPort = 2202

TCPClient = TcpSocket.New() --Define Socket
TCPClient.ReadTimeout = 0
TCPClient.WriteTimeout = 0
TCPClient.ReconnectTimeout = 5

--Debug Function
---------------------------------------------------------
function DebugFormat(string) -- Format strings containing non-printable characters so we can see what they are
  local visual = ""
  for i=1,#string do
    local byte = string:sub(i,i)
    if string.byte(byte) >= 32 and string.byte(byte) <= 126 then
      visual = visual..byte
    else
      visual = visual..string.format("[%02xh]",string.byte(byte))
    end
  end
  return visual
end

DebugTx = false
DebugRx = false
DebugFunction = false
DebugSVGImageGen = false
DebugPrint = Properties["Debug Print"].Value

-- A function to determine common print statement scenarios for troubleshooting
function SetupDebugPrint()
  if DebugPrint=="Tx/Rx" then
    DebugTx,DebugRx=true,true
  elseif DebugPrint=="Tx" then
    DebugTx=true
  elseif DebugPrint=="Rx" then
    DebugRx=true
  elseif DebugPrint=="Function Calls" then
    DebugFunction=true
  elseif DebugPrint=="SVG Image Generation"then
    DebugSVGImageGen = true
  elseif DebugPrint=="All" then
    DebugTx,DebugRx,DebugFunction,DebugSVGImageGen=true,true,true,true
  end
end

SetupDebugPrint()

--Global Variables
-----------------------------------------------------------
gsSVGFooter = "</svg>"
gaColorChoices = {["Red"] = "#990000", ["Blue"] = "#006298", ["Purple"] = "#66435A", ["Green"] = "#009933", ["Brown"] = "#4A3C31", ["Yellow"] = "#F5BB17", ["Orange"] = "#F25B19", ["Black"] = "#191919", ["White"] = "#EDEBEB", ["LtBlue"] ="#6EC6F1" }
gaColor = {gaColorChoices.Red,gaColorChoices.Blue,gaColorChoices.Purple,gaColorChoices.Green,gaColorChoices.Yellow,gaColorChoices.Brown,gaColorChoices.Orange,gaColorChoices.Black}
gsMainLineOpacity = "1.0"
gsSecLineOpacity = "0.5"
giNumofActiveMics = 0

--Scaling Math Function
-----------------------------------------------------------
function scaleBetween(unscaledNum, minAllowed, maxAllowed, min, max)
  local liVal = (maxAllowed - minAllowed) * (unscaledNum - min) / (max - min) + minAllowed
  return liVal
end

--Value Constants
-----------------------------------------------------------
gsModel = "MODEL"
gsSerialNum = "SERIAL_NUM"
gsFWVersion = "FW_VER"
gsAudioIPAdd = "IP_ADDR_NET_AUDIO_PRIMARY"
gsAudioIPSubnet = "IP_SUBNET_NET_AUDIO_PRIMARY"
gsAudioIPGateway = "IP_GATEWAY_NET_AUDIO_PRIMARY"
gsCtrlMacAddress = "CONTROL_MAC_ADDR"
gsDeviceID = "DEVICE_ID"
gsNADeviceName = "NA_DEVICE_NAME"
gsChannelName = "CHAN_NAME"
gsNAChannelName = "NA_CHAN_NAME"
gsFlash = "FLASH"
gsAudioClipIndicator = "AUDIO_OUT_CLIP_INDICATOR" 
gsDigAudioGain = "AUDIO_GAIN_HI_RES"
gsDigAudioGainPostGate = "AUDIO_GAIN_POSTGATE"
gsAudioLvlRMS = "AUDIO_IN_RMS_LVL"
gsAudioLvlPeak = "AUDIO_IN_PEAK_LVL"
gsDeviceAudioMute = "DEVICE_AUDIO_MUTE"
gsChAudioMute = "AUDIO_MUTE"
gsPresetName = "PRESET_NAME"
gsEncryption = "ENCRYPTION"
gsPEQ1 = "PEQ 1"
gsPEQ2 = "PEQ 2"
gsPEQ3 = "PEQ 3"
gsPEQ4 = "PEQ 4"
gsNumofActiveMics = "NUM_ACTIVE_MICS"
gsMuteStatusLEDState = "DEV_MUTE_STATUS_LED_STATE"
gsSoloAutomixCh = "CHAN_AUTOMIX_SOLO_EN"
gsLEDBrightness = "LED_BRIGHTNESS"
gsLEDUnmuteColor = "LED_COLOR_UNMUTED"
gsLEDMuteColor = "LED_COLOR_MUTED"
gsLEDMutedState = "LED_STATE_MUTED"
gsLEDUnmutedState = "LED_STATE_UNMUTED"
gsLEDInState = "DEV_LED_IN_STATE"
gsBypassEQ = "BYPASS_ALL_EQ"
gsBypassINTX = "BYPASS_IMX"
gsEQContour = "EQ_CONTOUR"
gsAutomixGateStatus = "AUTOMIX_GATE_OUT_EXT_SIG"
gsDevInstallType ="DEVICE_INSTALLATION"
gsLobeBeamAngle = "BEAM_ANGLE"
gsLobeBeamWidth = "BEAM_W"
gsPresets = "PRESET"
gsLastError = "LAST_ERROR_EVENT"
gsArray = { gsModel,gsSerialNum,gsFWVersion,gsAudioIPAdd,gsAudioIPSubnet,gsAudioIPGateway,gsCtrlMacAddress,gsDeviceID,gsNADeviceName,gsChannelName,
            gsNAChannelName,gsFlash,gsAudioClipIndicator,gsDigAudioGain,gsDigAudioGainPostGate,gsAudioLvlRMS,gsAudioLvlPeak,gsDeviceAudioMute,
            gsChAudioMute,gsPresetName,gsEncryption,gsPEQ1,gsPEQ2,gsPEQ3,gsPEQ4,gsNumofActiveMics,gsMuteStatusLEDState,gsSoloAutomixCh,gsLEDBrightness,gsLEDUnmuteColor,
            gsLEDMuteColor,gsLEDMutedState,gsLEDUnmutedState,gsLEDInState,gsBypassEQ,gsBypassINTX,gsEQContour,gsAutomixGateStatus,gsDevInstallType,gsLobeBeamAngle,gsLobeBeamWidth,gsPresets,gsLastError}

gcModel = Controls["MODEL"]
gcSerialNum = Controls["SERIAL_NUM"]
gcFWVersion = Controls["FW_VER"]
gcAudioIPAdd = Controls["IP_ADDR_NET_AUDIO_PRIMARY"]
gcAudioIPSubnet = Controls["IP_SUBNET_NET_AUDIO_PRIMARY"]
gcAudioIPGateway = Controls["IP_GATEWAY_NET_AUDIO_PRIMARY"]
gcCtrlMacAddress = Controls["CONTROL_MAC_ADDR"]
gcDeviceID = Controls["DEVICE_ID"]
gcNADeviceName = Controls["NA_DEVICE_NAME"]
gcChannelName = Controls["CHAN_NAME"]
gcNAChannelName = Controls["NA_CHAN_NAME"]
gcFlash = Controls["FLASH"]
gcAudioClipIndicator = Controls["AUDIO_OUT_CLIP_INDICATOR"]
gcDigAudioGain = Controls["AUDIO_GAIN_HI_RES"]
gcDigAudioGainPostGate = Controls["AUDIO_GAIN_POSTGATE"]
gcAudioLvlRMS = Controls["AUDIO_IN_RMS_LVL"]
gcAudioLvlPeak = Controls["AUDIO_IN_PEAK_LVL"]
gcDeviceAudioMute = Controls["DEVICE_AUDIO_MUTE"]
gcChAudioMute = Controls["AUDIO_MUTE"]
gcPresetName = Controls["PRESET_NAME"]
gcEncryption = Controls["ENCRYPTION"]
gcPEQ1 = Controls["PEQ_1"]
gcPEQ2 = Controls["PEQ_2"]
gcPEQ3 = Controls["PEQ_3"]
gcPEQ4 = Controls["PEQ_4"]
gcNumofActiveMics = Controls["NUM_ACTIVE_MICS"]
gcMuteStatusLEDState = Controls["DEV_MUTE_STATUS_LED_STATE"]
gcSoloAutomixCh = Controls["CHAN_AUTOMIX_SOLO_EN"]
gcLEDBrightness = Controls["LED_BRIGHTNESS"]
gcLEDUnmuteColor = Controls["LED_COLOR_UNMUTED"]
gcLEDMuteColor = Controls["LED_COLOR_MUTED"]
gcLEDMutedState = Controls["LED_STATE_MUTED"]
gcLEDUnmutedState = Controls["LED_STATE_UNMUTED"]
gcLEDInState = Controls["DEV_LED_IN_STATE"]
gcBypassEQ = Controls["BYPASS_ALL_EQ"]
gcBypassINTX = Controls["BYPASS_IMX"]
gcEQContour = Controls["EQ_CONTOUR"]
gcAutomixGateStatus = Controls["AUTOMIX_GATE_OUT_EXT_SIG"]
gcDevInstallType = Controls["DEVICE_INSTALLATION"]
gcLobeBeamAngle = Controls["BEAM_ANGLE"]
gcLobeBeamWidth = Controls["BEAM_W"]
gcPresets = Controls["PRESET"]
gcLastError = Controls["LAST_ERROR_EVENT"]
gcArray = { gcModel,gcSerialNum,gcFWVersion,gcAudioIPAdd,gcAudioIPSubnet,gcAudioIPGateway,gcCtrlMacAddress,gcDeviceID,gcNADeviceName,gcChannelName,
            gcNAChannelName,gcFlash,gcAudioClipIndicator,gcDigAudioGain,gcDigAudioGainPostGate,gcAudioLvlRMS,gcAudioLvlPeak,gcDeviceAudioMute,
            gcChAudioMute,gcPresetName,gcEncryption,gcPEQ1,gcPEQ2,gcPEQ3,gcPEQ4,gcNumofActiveMics,gcMuteStatusLEDState,gcSoloAutomixCh,gcLEDBrightness,gcLEDUnmuteColor,
            gcLEDMuteColor,gcLEDMutedState,gcLEDUnmutedState,gcLEDInState,gcBypassEQ,gcBypassINTX,gcEQContour,gcAutomixGateStatus,gcDevInstallType,gcLobeBeamAngle,gcLobeBeamWidth,gcPresets,gcLastError}

--Combo Box Choices
------------------------------------------------------------
gaBeamWidth = {"NARROW", "MEDIUM", "WIDE"}
gaInstallType = {"CEILING", "WALL_HORIZONTAL", "WALL_VERTICAL", "TABLE"}
gaLEDColor = { "RED", "ORANGE", "GOLD", "YELLOW", "YELLOWGREEN", "GREEN", "TURQUOISE", "POWDERBLUE", "CYAN", "SKYBLUE", "BLUE", "PURPLE", "LIGHTPURPLE", 
                "VIOLET", "ORCHID", "PINK", "WHITE"}
gaLEDBrightness = {"0: Off", "1: 20%", "2: 40%", "3: 60%", "4: 80%", "5: 100%"}

for x, lobes in pairs (gcLobeBeamWidth)do
  lobes.Choices = gaBeamWidth
end
gsPresetChoices = {}
gcDevInstallType.Choices = gaInstallType
gcLEDUnmuteColor.Choices = gaLEDColor
gcLEDMuteColor.Choices = gaLEDColor
gcLEDBrightness.Choices = gaLEDBrightness

--SVG Generation Functions
----------------------------------------------------------
--Calc Angle on Radius
function CalcAngleForSVG(lsAngle,lsRadius)
  lsAngle = math.rad(lsAngle) --Convert Angle to Radians
  
  local x1 = math.cos(lsAngle)*lsRadius + 200 --Figure Out x Coordinate and add Center of Circle
  local y1 = math.sin(lsAngle)*lsRadius + 200 --Figure Out y Coordinate and add Center of Circle
  
  return math.floor(x1),math.floor(y1)      --Round Up and Return Values
  end
  
  --Generate SVG Header
  function GenSVGHeader(lsWid, lsHght, lsViewBox) 
    return(string.format("<svg width=\"%s\" height=\"%s\" viewbox=\"%s\" xmlns=\"%s\" version=\"%s\">",lsWid, lsHght, lsViewBox,"http://www.w3.org/2000/svg","1.1"))
  end
  
  --Generate SVG Circle
  function GenCircleSVG(lsXVal, lsYVal, lsRadius, lsFillColor,lsFillOpacity,lsStrokeColor,lsStrokeWidth)
    return(string.format("<circle cx=\"%s\" cy=\"%s\" r=\"%s\" fill=\"%s\" fill-opacity=\"%s\" stroke=\"%s\" stroke-width=\"%s\" />",lsXVal, lsYVal, lsRadius, lsFillColor,lsFillOpacity,lsStrokeColor,lsStrokeWidth))
  end
  
  --Generate SVG Ellipse
  function GenEllipseSVG(lsTranslate,lsRotate,lsRX,lsRY,lsFillColor,lsStrokeColor,lsStrokeWidth)
    return(string.format("<ellipse transform=\"translate(%s) rotate(%s)\" rx=\"%s\" ry=\"%s\" fill=\"%s\" stroke=\"%s\" stroke-width=\"%s\" />",lsTranslate,lsRotate,lsRX,lsRY,lsFillColor,lsStrokeColor,lsStrokeWidth))
  end
  --Generate SVG Rectangle
  function GenRectSVG(lsXVal, lsYVal, lsWidth, lsHeight,lsFillColor,lsStrokeColor,lsStrokeWidth)
    return(string.format("<rect x=\"%s\" y=\"%s\" width=\"%s\" height=\"%s\" fill=\"%s\" stroke=\"%s\" stroke-width=\"%s\" />",lsXVal, lsYVal, lsWidth, lsHeight,lsFillColor,lsStrokeColor,lsStrokeWidth))
  end
  --Generate SVG Line
  function GenLineSVG(lsXStart,lsYStart,lsXEnd,lsYEnd,lsStrokeColor,lsOpacity,lsStrokeWidth)
    return(string.format("<line x1=\"%s\" y1=\"%s\" x2=\"%s\" y2=\"%s\" stroke=\"%s\" stroke-opacity=\"%s\" stroke-width=\"%s\" stroke-linecap=\"%s\" />",lsXStart,lsYStart,lsXEnd,lsYEnd,lsStrokeColor,lsOpacity,lsStrokeWidth,"round"))
  end
  
  --Generate SVG Text
  function GenTextSVG(lsXVal,lsYVal,lsRotation,lsFontSize,lsColor,lsText)
  return(string.format("<text x=\"%s\" y=\"%s\" dx=\"%s\" dy=\"%s\" rotate=\"%s\" font-family=\"%s\" font-size=\"%s\" font-weight=\"%s\" fill=\"%s\" > %s </text>",lsXVal,lsYVal,"-5","6",lsRotation,"Roboto",lsFontSize,"bold",lsColor,lsText))
  end
  
  --Generate SVG Polygon
  function GenPolygonSVG(lsFillColor,lsStrokeColor,lsStrokeWidth,lsPoints)
    return(string.format("<polygon fill=\"%s\" stroke=\"%s\" stroke-width=\"%s\" points=\"%s\" />",lsFillColor,lsStrokeColor,lsStrokeWidth,lsPoints))
  end
  
  --Generate SVG Polyline
  function GenPolylineSVG(lsFillColor,lsStrokeColor,lsStrokeWidth,lsPoints)
    return(string.format("<polyline fill=\"%s\" stroke=\"%s\" stroke-width=\"%s\" points=\"%s\" />",lsFillColor,lsStrokeColor,lsStrokeWidth,lsPoints))
  end
  
  --Assemble String Together and Convert to XML
  function generateSVGFormat()
  
    local x,x1,x2,xInv,x1Inv,x2Inv = {},{},{},{},{},{}
    local y,y1,y2,yInv,y1Inv,y2Inv = {},{},{},{},{},{}
    local lsSVG = ""
    local lsBeamWidth = {}                                      --for Shure MXA 710 Widths --30 Degree for Narrow Width, 40 Degree for Medium Width, 74 Degree for Wide

    for x,chs in pairs(gcLobeBeamWidth) do
      if(chs.String == "NARROW")then
        lsBeamWidth[x] = 15
      elseif(chs.String == "MEDIUM")then
        lsBeamWidth[x] = 20
      elseif(chs.String == "WIDE")then
        lsBeamWidth[x] = 37
      else
        lsBeamWidth[x] = 20
      end
    end
  
    lsSVG = string.format(GenSVGHeader("400", "400", "0 0 400 400")..GenCircleSVG("200","200","147",gaColorChoices.LtBlue,"0.3",gaColorChoices.LtBlue,"3"))   

  for i=1, giNumofActiveMics do
    x[i],y[i] = CalcAngleForSVG((Controls["BEAM_ANGLE"][i].Value+270),"147")
    x1[i],y1[i] = CalcAngleForSVG((Controls["BEAM_ANGLE"][i].Value+270)-lsBeamWidth[i],"147")
    x2[i],y2[i] = CalcAngleForSVG((Controls["BEAM_ANGLE"][i].Value+270)+lsBeamWidth[i],"147")
    xInv[i],yInv[i] = CalcAngleForSVG(math.abs(Controls["BEAM_ANGLE"][i].Value+270)*-1,"147")
    x1Inv[i],y1Inv[i] = CalcAngleForSVG(math.abs(Controls["BEAM_ANGLE"][i].Value+270)*-1-lsBeamWidth[i],"147")
    x2Inv[i],y2Inv[i] = CalcAngleForSVG(math.abs(Controls["BEAM_ANGLE"][i].Value+270)*-1+lsBeamWidth[i],"147")
    
    lsSVG = lsSVG..string.format(GenLineSVG(x[i],y[i],"200","200",gaColor[i],gsMainLineOpacity,"5")..GenCircleSVG(x[i],y[i],"10",gaColor[i],"1.0",gaColor[i],"3")..GenTextSVG(x[i],y[i],0,"16",gaColorChoices.White,i)
                        ..GenLineSVG(x1[i],y1[i],"200","200",gaColor[i],gsSecLineOpacity,"2")..GenLineSVG(x2[i],y2[i],"200","200",gaColor[i],gsSecLineOpacity,"2")..GenLineSVG(xInv[i],yInv[i],"200","200",gaColor[i],gsMainLineOpacity,"5")
                        ..GenCircleSVG(xInv[i],yInv[i],"10",gaColor[i],"1.0",gaColor[i],"3")..GenTextSVG(xInv[i],yInv[i],0,"16",gaColorChoices.White,i)..GenLineSVG(x1Inv[i],y1Inv[i],"200","200",gaColor[i],gsSecLineOpacity,"2")..GenLineSVG(x2Inv[i],y2Inv[i],"200","200",gaColor[i],gsSecLineOpacity,"2"))    
  end
  lsSvg = lsSVG..string.format(gsSVGFooter)   
  
  SVGXML = xml.eval(lsSVG)
  return(SVGXML)   
  end 
  
  --Function to Generate Image and assign to .legend on Button
  function generate()
    local luaSVG = generateSVGFormat()
    
    legend = {
      DrawChrome = false,
      IconData = Crypto.Base64Encode(tostring(luaSVG))
    }
    if(DebugSVGImageGen)then print(DebugFormat("Raw SVG XML String: "..tostring(luaSVG)))end
    Controls["Coverage_Map"].Legend = json.encode(legend)
  end
  
--Parse Data
-----------------------------------------------------------
function CheckForOnOff(lsVar)
  if(lsVar == " OFF" or lsVar == " DISABLE")then
    return(0)
  elseif(lsVar == " ON" or lsVar == " ENABLE")then
    return(1)
  else
    return(lsVar)
  end
end

function CalDB(lsVar)
  local liDbVal = math.floor(scaleBetween(lsVar,-110,30,0,1400))
  return(liDbVal)
end

function rxDataParse(lsRXData)
  
  lsCommandReturn = string.sub(lsRXData,3,5)
  
  if(DebugFunction)then print(DebugFormat("Command Type: "..lsCommandReturn))end  

  if(lsCommandReturn == "REP")then  --Report Returned    
    for x,reports in pairs(gsArray)do       --Search through All Reported Values
        if(string.find(lsRXData, gsArray[x]) ~= nil)then --If you find the value match and its at least one succesfully matach found  
          if(DebugFunction)then print(DebugFormat("Found Command: "..gsArray[x].."Array Position: "..x))end        
          lsIndexVal = tonumber(string.sub(lsRXData, 7,8)) --Pull Out Index

          if(lsIndexVal ~= nil)then         --IF there is a index value then send to array
            lsStart, lsEnd = string.find(lsRXData,gsArray[x]) --Find start and end position of Match
            lsLen = string.len(lsRXData) -- Find total length of string
            lsFilteredString = string.sub(lsRXData, (lsEnd+1), (lsLen - 1)) --Pull out just raw value and send it to controls
        
            if(string.find(lsFilteredString, "{") or string.find(lsFilteredString, "}") ~= nil)then  --If you find brackets Cleanup
                lsFilteredString = string.gsub(lsFilteredString, "{", "")--Remove Bracket
                lsFilteredString = string.gsub(lsFilteredString, "}", "")--Remove Bracket          
                gcArray[x][lsIndexVal].String = CheckForOnOff(lsFilteredString)
            else     --No Brackets Found
                if(x == 14 or x == 15)then --For Audio Gain and Gain Post Gate to convert to db
                  gcArray[x][lsIndexVal].String = CalDB(lsFilteredString)  --Send Recieved String to Field
                elseif(x == 40)then -- For Angle to Convert Scaled Value                                
                  gcArray[x][lsIndexVal].String = scaleBetween(lsFilteredString,-90,90,0,180)
                else
                  gcArray[x][lsIndexVal].String = CheckForOnOff(lsFilteredString)  --Send Recieved String to Field
                end
            end
            
          else
              lsStart, lsEnd = string.find(lsRXData,gsArray[x]) --Find start and end position of Match
              lsLen = string.len(lsRXData) -- Find total length of string
            if(x == 20)then --If Preset Name Array
              lsFilteredString = string.sub(lsRXData, (lsEnd+5), (lsLen - 1)) --Pull out just raw value and send it to controls
              lsPresetArray = tonumber(string.sub(lsRXData, (lsEnd+1), (lsEnd+3))) --Convert Text to Number for Array
              if(string.find(lsFilteredString, "{") or string.find(lsFilteredString, "}") ~= nil)then  --If you find brackets Cleanup
                  lsFilteredString = string.gsub(lsFilteredString, "{", "")--Remove Bracket
                  lsFilteredString = string.gsub(lsFilteredString, "}", "") --Remove Bracket             
                  gsPresetChoices[lsPresetArray] = CheckForOnOff(lsFilteredString)
                  gcArray[x].Choices = gsPresetChoices
              else    --No Brackets Found
                  gsPresetChoices[lsPresetArray] = CheckForOnOff(lsFilteredString)
                  gcArray[x].Choices = gsPresetChoices
              end
            elseif(x == 42)then --Has word Preset In it
              if(string.find(lsRXData,"PRESET_NAME"))then -- If find preset name then ignore
              else
                lsFilteredString = string.sub(lsRXData, (lsEnd+1), (lsLen - 1)) --Pull out just raw value and send it to controls
                gcArray[x].String = lsFilteredString
              end
            elseif(x == 26)then --Num of Active Mics to Disable Other Controls 
                lsFilteredString = string.sub(lsRXData, (lsEnd+1), (lsLen - 1)) --Pull out just raw value and send it to controls
                giNumofActiveMics = tonumber(lsFilteredString)
                for x=1, tonumber(lsFilteredString) do
                  gcChannelName[x].IsDisabled = false
                  gcNAChannelName[x].IsDisabled = false
                  gcAudioClipIndicator[x].IsDisabled = false
                  gcDigAudioGain[x].IsDisabled = false
                  gcDigAudioGainPostGate[x].IsDisabled = false
                  gcAudioLvlRMS[x].IsDisabled = false
                  gcAudioLvlPeak[x].IsDisabled = false
                  gcChAudioMute[x].IsDisabled = false
                  gcPEQ1[x].IsDisabled = false
                  gcPEQ2[x].IsDisabled = false
                  gcPEQ3[x].IsDisabled = false
                  gcPEQ4[x].IsDisabled = false
                  gcSoloAutomixCh[x].IsDisabled = false
                  gcAutomixGateStatus[x].IsDisabled = false
                  gcLobeBeamAngle[x].IsDisabled = false
                  gcLobeBeamWidth[x].IsDisabled = false
                  Controls["METER_RATE"][x].IsDisabled = false
                  Controls["AUTOMIXER_METER_RATE"][x].IsDisabled = false
                  Controls["POSTGATE_METER_RATE"][x].IsDisabled = false
                end
                for x=(tonumber(lsFilteredString)+1),8 do
                  gcChannelName[x].IsDisabled = true
                  gcNAChannelName[x].IsDisabled = true
                  gcAudioClipIndicator[x].IsDisabled = true
                  gcDigAudioGain[x].IsDisabled = true
                  gcDigAudioGainPostGate[x].IsDisabled = true
                  gcAudioLvlRMS[x].IsDisabled = true
                  gcAudioLvlPeak[x].IsDisabled = true
                  gcChAudioMute[x].IsDisabled = true
                  gcPEQ1[x].IsDisabled = true
                  gcPEQ2[x].IsDisabled = true
                  gcPEQ3[x].IsDisabled = true
                  gcPEQ4[x].IsDisabled = true
                  gcSoloAutomixCh[x].IsDisabled = true
                  gcAutomixGateStatus[x].IsDisabled = true
                  gcLobeBeamAngle[x].IsDisabled = true
                  gcLobeBeamWidth[x].IsDisabled = true
                  Controls["METER_RATE"][x].IsDisabled = true
                  Controls["AUTOMIXER_METER_RATE"][x].IsDisabled = true
                  Controls["POSTGATE_METER_RATE"][x].IsDisabled = true
              end
                generate()
                gcArray[x].String = lsFilteredString         
            else --All Other Arrays
                lsFilteredString = string.sub(lsRXData, (lsEnd+1), (lsLen - 1)) --Pull out just raw value and send it to controls
              
              if(string.find(lsFilteredString, "{") or string.find(lsFilteredString, "}") ~= nil)then  --If you find brackets Cleanup
                lsFilteredString = string.gsub(lsFilteredString, "{", "")--Remove Bracket
                lsFilteredString = string.gsub(lsFilteredString, "}", "")--Remove Bracket            
                gcArray[x].String = CheckForOnOff(lsFilteredString)
              else    --No Brackets Found
                if(x == 29)then   --LED Brightness Show Pretty Format
                  gcArray[x].String = gaLEDBrightness[tonumber(lsFilteredString)+1]
                else
                  gcArray[x].String = CheckForOnOff(lsFilteredString)
                end
              end
            end
        end
      end
    end
  elseif(lsCommandReturn == "SAM")then  --Sample Levels Returned
    if(string.find(lsRXData, "SAMPLE_POSTGATE"))then
      local laPostGateMeter = {}
      laPostGateMeter[1] = string.sub(lsRXData, 19, 21)
      laPostGateMeter[2] = string.sub(lsRXData, 23, 25)
      laPostGateMeter[3] = string.sub(lsRXData, 27, 29)
      laPostGateMeter[4] = string.sub(lsRXData, 31, 33)
      laPostGateMeter[5] = string.sub(lsRXData, 35, 37)
      laPostGateMeter[6] = string.sub(lsRXData, 39, 41)
      laPostGateMeter[7] = string.sub(lsRXData, 43, 45)
      laPostGateMeter[8] = string.sub(lsRXData, 47, 49)
      
      for x, chs in pairs(laPostGateMeter)do
        Controls["POSTGATE_METER_RATE"][x].String = math.floor(scaleBetween(laPostGateMeter[x],-60,0,0,60))  --Lobe Audio Levels for Main Channels
      end
    elseif(string.find(lsRXData, "SAMPLE_AECREF"))then
      Controls["AEC_REF_METER_RATE"].String = math.floor(scaleBetween(string.sub(lsRXData, 17, 19),-60,0,0,60))
    elseif(string.find(lsRXData, "SAMPLE_MXR_GAIN"))then
      local laMixGainMeter = {}
      laMixGainMeter[1] = string.sub(lsRXData, 20, 22)
      laMixGainMeter[2] = string.sub(lsRXData, 24, 26)
      laMixGainMeter[3] = string.sub(lsRXData, 28, 30)
      laMixGainMeter[4] = string.sub(lsRXData, 32, 34)
      laMixGainMeter[5] = string.sub(lsRXData, 36, 38)
      laMixGainMeter[6] = string.sub(lsRXData, 40, 42)
      laMixGainMeter[7] = string.sub(lsRXData, 44, 46)
      laMixGainMeter[8] = string.sub(lsRXData, 48, 50)
      
      for x, chs in pairs(laMixGainMeter)do
        Controls["AUTOMIXER_METER_RATE"][x].String = math.floor(scaleBetween(laMixGainMeter[x],-60,0,0,60))  --Lobe Audio Levels for Main Channels
      end
    else
      local laMeter = {}
      laMeter[1] = string.sub(lsRXData, 14, 16)
      laMeter[2] = string.sub(lsRXData, 18, 20)
      laMeter[3] = string.sub(lsRXData, 22, 24)
      laMeter[4] = string.sub(lsRXData, 26, 28)
      laMeter[5] = string.sub(lsRXData, 30, 32)
      laMeter[6] = string.sub(lsRXData, 34, 36)
      laMeter[7] = string.sub(lsRXData, 38, 40)
      laMeter[8] = string.sub(lsRXData, 42, 44)
      laMeter[9] = string.sub(lsRXData, 10, 12)
      
      for x, chs in pairs(laMeter)do
        Controls["METER_RATE"][x].String = math.floor(scaleBetween(laMeter[x],-60,0,0,60))  --Lobe Audio Levels for Main Channels
      end
    end
  end
end


--Timers
-----------------------------------------------------------
QueryTimer = Timer.New()

QueryTimer.EventHandler = function()
  TCPClient:Write("< GET ALL >")            ---Get All Data
          if(DebugFunction)then print(DebugFormat("Found Command: "..gsArray[x].."Array Position: "..x))end        
  if(DebugTx)then print(DebugFormat("TX: ".."< GET ALL >"))end
end

--Check to See if Metering is enabled on connection to device
function CheckForMetering()
  if(Controls["ENABLE_METERING"].Value == 1)then
      TCPClient:Write("< SET METER_RATE 300 >")            ---Set RMS Meter Rate
      if(DebugTx)then print(DebugFormat("TX: ".."< SET METER_RATE 300 >"))end
      TCPClient:Write("< SET METER_RATE_POSTGATE 300 >")   ---Set POST GATE RMS Meter Rate
      if(DebugTx)then print(DebugFormat("TX: ".."< SET METER_RATE_POSTGATE 300 >"))end
      --TCPClient:Write("< SET METER_RATE_MXR_GAIN 300 >")   ---Set AutoMixer RMS Meter Rate
      --TCPClient:Write("< SET METER_RATE_AECREF 300 >")     ---Set AEC REF RMS Meter Rate
  else
      TCPClient:Write("< SET METER_RATE 0 >")            ---Set RMS Meter Rate
      if(DebugTx)then print(DebugFormat("TX: ".."< SET METER_RATE 0 >"))end
      TCPClient:Write("< SET METER_RATE_POSTGATE 0 >")   ---Set POST GATE RMS Meter Rate
      if(DebugTx)then print(DebugFormat("TX: ".."< SET METER_RATE_POSTGATE 0 >"))end
      --TCPClient:Write("< SET METER_RATE_MXR_GAIN 0 >")   ---Set AutoMixer RMS Meter Rate
      --TCPClient:Write("< SET METER_RATE_AECREF 0 >")     ---Set AEC REF RMS Meter Rate
  end
end

--TCP Socket Event Handlers
-----------------------------------------------------------
TCPClient.Connected = function(TCPClient)     --Is Connected
  if(DebugFunction)then print(DebugFormat("TCP socket is connected"))end
  Controls["Status"].Value = 0
  Controls["Status"].String = '' 
  
  QueryTimer:Start(15)
  TCPClient:Write("< GET ALL >")            ---Get All Data Initially
  if(DebugTx)then print(DebugFormat("TX: ".."< GET ALL >"))end
  CheckForMetering()                        --Check to See if Metering is Enabled
end
TCPClient.Reconnect = function(TCPClient)     --Reconnecting
  if(DebugFunction)then print(DebugFormat("TCP socket is reconnecting"))end
  Controls["Status"].Value = 5
  Controls["Status"].String = 'Reconnecting'
end


TCPClient.Data = function(TCPClient)          --RX Data
 if(DebugFunction)then print(DebugFormat("TCP socket has data:"))end
   repeat
      msg = TCPClient:ReadLine(TcpSocket.EOL.Custom, ">")
      if(msg ~= nil)then
        rxDataParse(msg)
        if(DebugRx)then print(DebugFormat("Raw Received Message: "..msg))end
      else
        break
      end
   until(TCPClient.BufferLength == 0)
end
TCPClient.Closed = function(TCPClient)        --Socket Closed
  if(DebugFunction)then print(DebugFormat("TCP socket was closed by the remote end"))end
  Controls["Status"].Value = 2 
  Controls["Status"].String = 'Closed'
  QueryTimer:Stop()
end
TCPClient.Error = function(TCPClient, Err)    --Error On Socket
  if(DebugFunction)then print(DebugFormat("TCP socket had an error:", Err))end
  Controls["Status"].Value = 2
  Controls["Status"].String = Err
  QueryTimer:Stop()
end
TCPClient.Timeout = function(TCPClient, Err)   --Timeout Occured
  if(DebugFunction)then print(DebugFormat("TCP socket timed out", Err))end
  Controls["Status"].Value = 2
  Controls["Status"].String = 'TimeOut'
  QueryTimer:Stop()
end
 
 
--Connect Events
---------------------------------------------------------- 
if(gsIPAddress ~= "" and gsPort ~= "")then      --Connect on Startup
  TCPClient:Connect(gsIPAddress, gsPort)
else
  Controls["Status"].Value = 2 
  Controls["Status"].String = 'Invalid IP Address'
end

Controls["IPAddress"].EventHandler = function()
    gsIPAddress = Controls["IPAddress"].String
    TCPClient:Disconnect()
    if(gsIPAddress ~= "" and gsPort ~= "")then 
      TCPClient:Connect(gsIPAddress, gsPort)
    else
      Controls["Status"].Value = 2 
      Controls["Status"].String = 'Invalid IP Address'
    end  
end


--Set Events
---------------------------------------------------------
for x, lobes in pairs(gcLobeBeamWidth) do
  lobes.EventHandler = function()
    TCPClient:Write("< SET "..tostring(x).." BEAM_W "..lobes.String.." >")                         --Change Lobe Width
    if(DebugTx)then print(DebugFormat("TX: ".."< SET "..tostring(x).." BEAM_W "..lobes.String.." >"))end
  end
end

gcDevInstallType.EventHandler = function()                                              --Install Type
  TCPClient:Write("< SET DEVICE_INSTALLATION "..gcDevInstallType.String.." >")          --Change Install Type
  if(DebugTx)then print(DebugFormat("TX: ".."< SET DEVICE_INSTALLATION "..gcDevInstallType.String.." >"))end
end

gcLEDUnmuteColor.EventHandler = function()
  TCPClient:Write("< SET LED_COLOR_UNMUTED "..gcLEDUnmuteColor.String.." >")           --Set unmute color
  if(DebugTx)then print(DebugFormat("TX: ".."< SET LED_COLOR_UNMUTED "..gcLEDUnmuteColor.String.." >"))end
end

gcLEDMuteColor.EventHandler = function()
  TCPClient:Write("< SET LED_COLOR_MUTED "..gcLEDMuteColor.String.." >")           --Set mute color
  if(DebugTx)then print(DebugFormat("TX: ".."< SET LED_COLOR_MUTED "..gcLEDMuteColor.String.." >"))end
end

gcLEDBrightness.EventHandler = function()
  TCPClient:Write("< SET LED_BRIGHTNESS "..string.sub(gcLEDBrightness.String,1,1).." >")           --Set LED Brightness
  if(DebugTx)then print(DebugFormat("TX: ".."< SET LED_BRIGHTNESS "..string.sub(gcLEDBrightness.String,1,1).." >"))end
end

gcDeviceAudioMute.EventHandler = function(lbCtrl) -- Device Audio Mute
  if(lbCtrl.Value == 1)then
      TCPClient:Write("< SET DEVICE_AUDIO_MUTE ON >")           --Turn Mute On
      if(DebugTx)then print(DebugFormat("TX: ".."< SET DEVICE_AUDIO_MUTE ON >"))end
  else
      TCPClient:Write("< SET DEVICE_AUDIO_MUTE OFF >")           --Turn Mute Off
      if(DebugTx)then print(DebugFormat("TX: ".."< SET DEVICE_AUDIO_MUTE OFF >"))end
  end
end

for x, chs in pairs(gcChAudioMute)do            --Channel Audio Mute
  chs.EventHandler = function(lbCtrl)
    if(lbCtrl.Value == 1)then
      TCPClient:Write("< SET 0"..tostring(x).." AUDIO_MUTE ON >")           --Turn Mute On
      if(DebugTx)then print(DebugFormat("TX: ".."< SET 0"..tostring(x).." AUDIO_MUTE ON >"))end
    else
      TCPClient:Write("< SET 0"..tostring(x).." AUDIO_MUTE OFF >")           --Turn Mute Off
      if(DebugTx)then print(DebugFormat("TX: ".."< SET 0"..tostring(x).." AUDIO_MUTE OFF >"))end
    end  
  end
end

gcFlash.EventHandler = function(lbCtrl)   --LED Flash
  if(lbCtrl.Value == 1)then
      TCPClient:Write("< SET FLASH ON >")           --Turn Flash On
      if(DebugTx)then print(DebugFormat("TX: ".."< SET FLASH ON >"))end
  else
      TCPClient:Write("< SET FLASH OFF >")           --Turn Flash Off
      if(DebugTx)then print(DebugFormat("TX: ".."< SET FLASH OFF >"))end
  end
end

gcEncryption.EventHandler = function(lbCtrl)   --Encryption
  if(lbCtrl.Value == 1)then
      TCPClient:Write("< SET ENCRYPTION ON >")           --Turn Encryption On
      if(DebugTx)then print(DebugFormat("TX: ".."< SET ENCRYPTION ON >"))end
  else
      TCPClient:Write("< SET ENCRYPTION OFF >")           --Turn Encryption Off
      if(DebugTx)then print(DebugFormat("TX: ".."< SET ENCRYPTION OFF >"))end
  end
end

for x, chs in pairs(gcSoloAutomixCh)do            --Channel Audio Mute
  chs.EventHandler = function(lbCtrl)
    if(lbCtrl.Value == 1)then
        TCPClient:Write("< SET "..tostring(x).." CHAN_AUTOMIX_SOLO_EN ENABLE >")  --Turn Solo the Automix Channel On
        if(DebugTx)then print(DebugFormat("TX: ".."< SET "..tostring(x).." CHAN_AUTOMIX_SOLO_EN ENABLE >"))end
    else
        TCPClient:Write("< SET "..tostring(x).." CHAN_AUTOMIX_SOLO_EN DISABLE >")  --Turn Solo the Automix Channel OFF
        if(DebugTx)then print(DebugFormat("TX: ".."< SET "..tostring(x).." CHAN_AUTOMIX_SOLO_EN DISABLE >"))end
    end
  end
end

gcLEDMutedState.EventHandler = function(lbCtrl)   --LED Enabled In Mute State
  if(lbCtrl.Value == 1)then
      TCPClient:Write("< SET LED_STATE_MUTED ON >")           --Turn LED On in Mute State
      if(DebugTx)then print(DebugFormat("TX: ".."< SET LED_STATE_MUTED ON >"))end
  else
      TCPClient:Write("< SET LED_STATE_MUTED OFF >")           --Turn LED Off in Mute State
      if(DebugTx)then print(DebugFormat("TX: ".."< SET LED_STATE_MUTED OFF >"))end
  end
end

gcLEDUnmutedState.EventHandler = function(lbCtrl)   --LED Enabled In Mute State
  if(lbCtrl.Value == 1)then
      TCPClient:Write("< SET LED_STATE_UNMUTED ON >")           --Turn LED On in UNMute State
      if(DebugTx)then print(DebugFormat("TX: ".."< SET LED_STATE_UNMUTED ON >"))end
  else
      TCPClient:Write("< SET LED_STATE_UNMUTED OFF >")           --Turn LED Off in UNMute State
      if(DebugTx)then print(DebugFormat("TX: ".."< SET LED_STATE_UNMUTED OFF >"))end
  end
end

gcBypassEQ.EventHandler = function(lbCtrl)   --Bypass EQ
  if(lbCtrl.Value == 1)then
      TCPClient:Write("< SET BYPASS_ALL_EQ ON >")           --Turn ALL EQ On
      if(DebugTx)then print(DebugFormat("TX: ".."< SET BYPASS_ALL_EQ ON >"))end
  else
      TCPClient:Write("< SET BYPASS_ALL_EQ OFF >")           --Turn ALL EQ Off
      if(DebugTx)then print(DebugFormat("TX: ".."< SET BYPASS_ALL_EQ OFF >"))end
  end
end

gcBypassINTX.EventHandler = function(lbCtrl)   --Bypass Intellmix DSP Blocks
  if(lbCtrl.Value == 1)then
      TCPClient:Write("< SET BYPASS_IMX ON >")           --Turn Intellmix DSP Blocks On
      if(DebugTx)then print(DebugFormat("TX: ".."< SET BYPASS_IMX ON >"))end
  else
      TCPClient:Write("< SET BYPASS_IMX OFF >")           --Turn Intellmix DSP Blocks Off
      if(DebugTx)then print(DebugFormat("TX: ".."< SET BYPASS_IMX OFF >"))end
  end
end

gcEQContour.EventHandler = function(lbCtrl)   --Bypass EQ Contour
  if(lbCtrl.Value == 1)then
      TCPClient:Write("< SET EQ_CONTOUR LOWSHELF >")           --Turn EQ Contour On Lowshelf
      if(DebugTx)then print(DebugFormat("TX: ".."< SET EQ_CONTOUR LOWSHELF >"))end
  else
      TCPClient:Write("< SET EQ_CONTOUR OFF >")           --Turn EQ Contour Off
      if(DebugTx)then print(DebugFormat("TX: ".."< SET EQ_CONTOUR OFF >"))end
  end
end

for x, chs in pairs(gcDigAudioGain)do            --Channel Digital Audio Gain
  chs.EventHandler = function(lbCtrl)
        local liDbVal = math.floor(scaleBetween(lbCtrl.Value,0,1400,-110,30))
        TCPClient:Write("< SET 0"..tostring(x).." AUDIO_GAIN_HI_RES "..liDbVal.." >")  --Send Gain Level
        if(DebugTx)then print(DebugFormat("TX: ".."< SET 0"..tostring(x).." AUDIO_GAIN_HI_RES "..liDbVal.." >"))end
  end
end

for x, chs in pairs(gcDigAudioGainPostGate)do            --Channel Digital Audio Gain Post Gate
  chs.EventHandler = function(lbCtrl)
        local liDbVal = math.floor(scaleBetween(lbCtrl.Value,0,1400,-110,30))
        TCPClient:Write("< SET 0"..tostring(x).." AUDIO_GAIN_POSTGATE "..liDbVal.." >")  --Send Gain Level
        if(DebugTx)then print(DebugFormat("TX: ".."< SET 0"..tostring(x).." AUDIO_GAIN_POSTGATE "..liDbVal.." >"))end
  end
end

for x, chs in pairs(gcLobeBeamAngle)do            --Channel Beam Angle
  chs.EventHandler = function(lbCtrl)
        local liAngleVal = math.floor(scaleBetween(lbCtrl.Value,0,180,-90,90))
        TCPClient:Write("< SET 0"..tostring(x).." BEAM_ANGLE "..liAngleVal.." >")  --Send Angle
        if(DebugTx)then print(DebugFormat("TX: ".."< SET 0"..tostring(x).." BEAM_ANGLE "..liAngleVal.." >"))end
  end
end

for x, chs in pairs(gcPEQ1)do            --PEQ Filter 1 On Channels
  chs.EventHandler = function(lbCtrl)
    if(lbCtrl.Value == 1)then
        TCPClient:Write("< SET 0"..tostring(x).." PEQ 1 ON >")           --Turn EQ ON
        if(DebugTx)then print(DebugFormat("TX: ".."< SET 0"..tostring(x).." PEQ 1 ON >"))end
    else
        TCPClient:Write("< SET 0"..tostring(x).." PEQ 1 OFF >")           --Turn EQ OFF
        if(DebugTx)then print(DebugFormat("TX: ".."< SET 0"..tostring(x).." PEQ 1 OFF >"))end
    end
  end
end

for x, chs in pairs(gcPEQ2)do            --PEQ Filter 2 On Channels
  chs.EventHandler = function(lbCtrl)
    if(lbCtrl.Value == 1)then
        TCPClient:Write("< SET 0"..tostring(x).." PEQ 2 ON >")           --Turn EQ ON
        if(DebugTx)then print(DebugFormat("TX: ".."< SET 0"..tostring(x).." PEQ 2 ON >"))end
    else
        TCPClient:Write("< SET 0"..tostring(x).." PEQ 2 OFF >")           --Turn EQ OFF
        if(DebugTx)then print(DebugFormat("TX: ".."< SET 0"..tostring(x).." PEQ 2 OFF >"))end
    end
  end
end

for x, chs in pairs(gcPEQ3)do            --PEQ Filter 3 On Channels
  chs.EventHandler = function(lbCtrl)
    if(lbCtrl.Value == 1)then
        TCPClient:Write("< SET 0"..tostring(x).." PEQ 3 ON >")           --Turn EQ ON
        if(DebugTx)then print(DebugFormat("TX: ".."< SET 0"..tostring(x).." PEQ 3 ON >"))end
    else
        TCPClient:Write("< SET 0"..tostring(x).." PEQ 3 OFF >")           --Turn EQ OFF
        if(DebugTx)then print(DebugFormat("TX: ".."< SET 0"..tostring(x).." PEQ 3 OFF >"))end
    end
  end
end

for x, chs in pairs(gcPEQ4)do            --PEQ Filter 4 On Channels
  chs.EventHandler = function(lbCtrl)
    if(lbCtrl.Value == 1)then
        TCPClient:Write("< SET 0"..tostring(x).." PEQ 4 ON >")           --Turn EQ ON
        if(DebugTx)then print(DebugFormat("TX: ".."< SET 0"..tostring(x).." PEQ 4 ON >"))end
    else
        TCPClient:Write("< SET 0"..tostring(x).." PEQ 4 OFF >")           --Turn EQ OFF
        if(DebugTx)then print(DebugFormat("TX: ".."< SET 0"..tostring(x).." PEQ 4 OFF >"))end
    end
  end
end

--[[gcPresets.EventHandler = function(lbCtrl) --Set New Preset
        TCPClient:Write("< SET PRESET "..lbCtrl.String.." >")           --Go to Preset Num
        print(DebugFormat("< SET PRESET "..lbCtrl.String.." >")
end]]--

gcPresetName.EventHandler = function(lbCtrl)  --Preset Name Change
  for x,preset in pairs(gsPresetChoices)do
    if(preset==lbCtrl.String)then
      TCPClient:Write("< SET PRESET "..tostring(x).." >")           --Go to Preset Num
      if(DebugTx)then print(DebugFormat("TX: ".."< SET PRESET "..tostring(x).." >"))end
    end
  end
end

--Enable Metering
Controls["ENABLE_METERING"].EventHandler = function(lbCtrl) --Enable Metering 
  if(lbCtrl.Value == 1)then
    if(TCPClient.IsConnected == true)then
      TCPClient:Write("< SET METER_RATE 300 >")            ---Set RMS Meter Rate
      if(DebugTx)then print(DebugFormat("TX: ".."< SET METER_RATE 300 >"))end
      TCPClient:Write("< SET METER_RATE_POSTGATE 300 >")   ---Set POST GATE RMS Meter Rate
      if(DebugTx)then print(DebugFormat("TX: ".."< SET METER_RATE_POSTGATE 300 >"))end
      --TCPClient:Write("< SET METER_RATE_MXR_GAIN 300 >")   ---Set AutoMixer RMS Meter Rate
      --TCPClient:Write("< SET METER_RATE_AECREF 300 >")     ---Set AEC REF RMS Meter Rate
    end
  else
    if(TCPClient.IsConnected == true)then
      TCPClient:Write("< SET METER_RATE 0 >")            ---Set RMS Meter Rate
      if(DebugTx)then print(DebugFormat("TX: ".."< SET METER_RATE 0 >"))end
      TCPClient:Write("< SET METER_RATE_POSTGATE 0 >")   ---Set POST GATE RMS Meter Rate
      if(DebugTx)then print(DebugFormat("TX: ".."< SET METER_RATE_POSTGATE 0 >"))end
      --TCPClient:Write("< SET METER_RATE_MXR_GAIN 0 >")   ---Set AutoMixer RMS Meter Rate
      --TCPClient:Write("< SET METER_RATE_AECREF 0 >")     ---Set AEC REF RMS Meter Rate
    end    
  end
end

--Slider for Adjusting Angle on SVG
for i, chs in pairs(gcLobeBeamWidth)do
  chs.EventHandler = function()
    generate()
  end
end

for i, chs in pairs(gcLobeBeamAngle)do
  chs.EventHandler = function()
    generate()
  end
end

