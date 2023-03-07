-- Aliases
Username = Controls.Username
Password = Controls.Password
Status = Controls.Status
SendButton = Controls.SendButton
ResponseText = Controls.ResponseText

-- Constants
EOL = "\r\n"                         -- End of line character as defined in device's API
EOLCharacter = ..EOL..CrLf  -- EOL Character constant from Serial Ports usage table
LoginPrompt = "Login: "              -- Match user prompt string as defined in the API
PasswordPrompt = "Password: "        -- Match password prompt as defined in the API
LoginMatch = "Login successful"      -- Match sucessful login string as defined in the API
StatusState = {OK = 0, COMPROMISED = 1, FAULT = 2, NOTPRESENT = 3, MISSING = 4, INITIALIZING = 5}  -- Status states in designer

-- Timers
PollTimer = Timer.New()  -- Timer for polling commands

-- Serial Port
SerialPort = SerialPorts[1]  -- Array of Serial Ports connected to the plugin, bind to the first one
baud = 9600                  -- Baud rate of the device
databits = 8                 -- Number of data bits
parity = "N"                 -- Type of parity used 
--Buffer = ""                -- If no EOL is used, the plugin will need a buffer for incoming data

-- Variables
PollTime = 3  -- Time between polls in secondsSerialPorts

--Debug level
DebugTx,DebugRx,DebugFunction = false, false, false
DebugPrint = Properties["Debug Print"].Value
if DebugPrint=="Tx/Rx" then
  DebugTx,DebugRx=true,true
elseif DebugPrint=="Tx" then
  DebugTx=true
elseif DebugPrint=="Rx" then
  DebugRx=true
elseif DebugPrint=="Function Calls" then
  DebugFunction=true
elseif DebugPrint=="All" then
  DebugTx,DebugRx,DebugFunction=true,true,true
end


-- ***   Functions   ***

-- Function that sets device connection status
function ReportStatus(state, msg)
  if DebugFunction then print("ReportStatus() called") end
  local msg = msg or ""
  Status.Value = StatusState[state]  -- Sets status state
  Status.String = msg  -- Sets status message
end

-- Open the Serial Port connection
function OpenSerialPort()
  if DebugFunction then print("OpenSerialPort() called") end
  if SerialPort.IsOpen then  -- If already open, close and restart
    Disconnect()
  end
  SerialPort:Open(baud, databits, parity)  -- Opens the serial port
end

-- Disconnect and stop communication on the serial port
function Disconnect()
  if DebugFunction then print("Disconnect() called") end
  PollTimer:Stop()  -- Stops the poll timer
  SerialPort:Close()
end

-- Operations to be performed when the serial port connects
function Connected()
  if DebugFunction then print("Connected() called") end
  ReportStatus("OK")
  PollTimer:Start(PollTime)  -- Starts the poll timer
end

-- Send a string to the remote device
function Send(cmd)
  if DebugFunction then print("Send() called") end
  print(cmd)  -- Print the command to be sent
  if SerialPort.IsOpen then  -- If the serial port is open write the passed through cmd with the EOL to the socket
    -- Add data formatting here
    if DebugTx then print("Sending: " .. cmd) end
    SerialPort:Write(cmd .. EOL)
  end
end

-- Function sends polling command
function PollDevice()
  if DebugFunction then print("PollDevice() called") end
  Send("PING")  -- Sends command defined by the target device api for poll functionality
end

-- ***   Parsers   ***

-- Get Data from the serial port and act on it
-- Example uses a search for login exchange with remote device
function ParseResponse()
  if DebugFunction then print("ParseResponse() called") end
  -- Search the serial port buffer for a waiting username or password prompt and send the correct response
  if SerialPort:Search(LoginPrompt) then
    Send(Username.String)
    local rx = SerialPort:Read(SerialPort.BufferLength)  -- Read the data in the buffer
    if DebugRx then print("Received Data with login prompt: " .. rx) end

  elseif SerialPort:Search(PasswordPrompt) then
    Send(Password.String)
    local rx = SerialPort:Read(SerialPort.BufferLength)  -- Read the data in the buffer
    if DebugRx then print("Received Data with password prompt: " .. rx) end

  elseif SerialPort:Search(LoginMatch) then
    local rx = SerialPort:Read(SerialPort.BufferLength)  -- Read the data in the buffer
    if DebugRx then print("Received Data with login success: " .. rx) end

  else
    -- If the interface has an EOL character, read the data until EOL is found
    local rx = SerialPort:ReadLine(EOLCharacter) or ""
    if DebugRx then print("Received Data: " .. rx) end
    
    -- If the interface does not use EOL characters, read the entire buffer
    -- The plugin will need a buffer for data to handle partial messages.  
    -- Add Buffer to the variables defined at the start of runtime
    --local rx = SerialPort:Read(SerialPort.BufferLength)
    --Buffer = Buffer .. rx
       
    -- Add incoming data handling here
    ResponseText.String = rx
  end
end

-- Other errors than timeout will return a message
function ConnectionError(port, message)
  if DebugFunction then print("ConnectionError() called") end
  local msg = message or "Timeout"
  ReportStatus("MISSING", "Serial Port error: " .. msg)
  PollTimer:Stop()  -- Stops the poll timer
end

SerialPort.Data = ParseResponse       -- Calls ParseResponse() when the serial port recieves data
SerialPort.Connected = Connected      -- Calls Connected() when the serial port connects
SerialPort.Error = ConnectionError    -- Calls ConnectionError() when the serial port encounters an error
SerialPort.Closed = ConnectionError   -- Calls ConnectionError() when the serial port encounters an unexpected closure
SerialPort.Timeout = ConnectionError  -- Calls ConnectionError() when the serial port encounters an timeout
SerialPort.Reconnect = function()     -- Handles functionality when the SerialPort reconnects
  if DebugFunction then print("SerialPort Reconnect event handler called") end
  -- Added any needed functionality on reconnect, such as data resetting
end

-- ***   Event Handlers   ***
-- Call PollDevice when the PollTimer eventhandler  is called
PollTimer.EventHandler = PollDevice 

-- Send an api request when the user presses the send button
SendButton.EventHandler = function()
  if DebugFunction then print("SendButton event handler called") end
  if SendButton.Value == 1 then  -- Momentary button event occurs on both press and release;  Only activate on press
    Send("Hello, World!")
  end
end

-- Run at start
OpenSerialPort()  -- Calls OpenSerialPort on start of runtime