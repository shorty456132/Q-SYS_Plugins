-- Aliases --------
RS232_Baud = {"9600", "38400", "115200"}
RS232_Parity = {"N","E","O"}
RS232_DataBits = {"8", "7"}

Controls["Baud"].Choices = RS232_Baud
Controls["Parity"].Choices = RS232_Parity
Controls["DataBits"].Choices = RS232_DataBits

Baud = ""
DataBits = ""
Parity = ""
DataReceived = Controls.DataReceived

-- Constants -----------------------------
Sony_PowerOn = "\x8C\x00\x00\x02\x01\x8F"
Sony_PowerOff = "\x8C\x00\x00\x02\x00\x8E"
Samsung_PowerOn = "\xAA\x11\xFE\x01\x01\x11"
Samsung_PowerOff = "\xAA\x11\xFE\x01\x00\x10"

-- variables -----------------------------
DisplayType = ""


-- Serial Port Setup ---------------------
SerialPort = SerialPorts[1]
buffer = ""

-- Functions ------------------------------
function OpenSerialPort()
  --If already open, close and reopen
  if SerialPort.IsOpen then
    print("Serial Port is already open. Closing, then reopening")
    Disconnect()
  end
  GetDisplayType()
end


function Disconnect()
  SerialPort:Close()
end

function SendCommand(msg)
  print("sending: " .. msg)

  if SerialPort.IsOpen then
    SerialPort:Write(msg)
  end
end

function GetDisplayType()
  if Properties["DisplayMake"].Value == "Sony" then
    DisplayType = "Sony"
  elseif Properties["DisplayMake"].Value == "Samsung-UDC" then
    DisplayType = "Samsung"
  end
end

function CheckConnectionSettings()
  if (Baud == nil) and (DataBits == nil) and (Parity == nil) then
    print("Settings not ready...")
    return
  end
  print("Settings entered successfully...\n Opening Serial Port...\n")
  OpenSerialPort()
end

-- TODO: Implement ParseResponse() data based on DisplayType. trigger Fb to output pins
function ParseResponse()
  -- local rx = SerialPort:ReadLine(SerialPort.BufferLength)
  -- buffer = buffer .. rx

  -- -- Send Fb depending on the display make
  -- if DisplayType == "Sony" then
  --   if string.Find(buffer,"\x83\x00\x00") 
  -- elseif DisplayType == "Samsung" then

  -- end
end

-- EventHandlers ------------------------

Controls.Baud.EventHandler = function(e)
  Baud = tonumber(e.String)
  CheckConnectionSettings()
end
Controls.DataBits.EventHandler = function(e)
  DataBits = tonumber(e.String)
  CheckConnectionSettings()
end
Controls.Parity.EventHandler = function(e)
  Parity = e.String
  CheckConnectionSettings()
end

Controls.PowerOn.EventHandler = function()
  Controls.PowerToggle.Value = 1
  if DisplayType == "Sony" then
    SendCommand(Sony_PowerOn)
  elseif DisplayType == "Samsung" then
    SendCommand(Samsung_PowerOn)
  end
end
Controls.PowerOff.EventHandler = function()
  Controls.PowerToggle.Value = 0
  if DisplayType == "Sony" then
    SendCommand(Sony_PowerOff)
  elseif DisplayType == "Samsung" then
    SendCommand(Samsung_PowerOff)
  end
end

Controls.PowerToggle.EventHandler = function(e)
  print(e.Value)
  if e.Value == 1 then 
    if DisplayType == "Sony" then
      SendCommand(Sony_PowerOn)
    elseif DisplayType == "Samsung" then
      SendCommand(Samsung_PowerOn)
    end
  elseif e.Value == 0 then 
    if DisplayType == "Sony" then
      SendCommand(Sony_PowerOff)
    elseif DisplayType == "Samsung" then
      SendCommand(Samsung_PowerOff)
    end
  end
end



SerialPort.Data = ParseResponse       -- Calls ParseResponse() when the serial port recieves data

-- Run At Start --------------------------
CheckConnectionSettings()