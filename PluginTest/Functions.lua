if Controls then
  -- Aliases
  Username = Controls.Username
  Password = Controls.Password
  Status   = Controls.Status
  SendBtn  = Controls.SendBtn
  ResponseText = Controls.ResponseText

  --Constants
  EOL = "\r\n"
  EOLCharacter = SerialPorts.EOL.CrLf
  LoginPrompt = "Login: "
  PasswordPrompt = "Password: "
  LoginMatch = "Login Successful!"
  StatusStates = {OK = 0, COMPROMIZED = 1, FAULT = 2, NOTPRESENT = 3, MISSING = 4, INITALIZING = 5}

  --Timers
  PollTimer = Timer.New()

  --Serial Port info
  SerialPort = SerialPorts[1]
  baud = 9600
  databits = 8
  parity = "N"
  --buffer = ""    -- IF no EOL is used, the plugin will need a buffer for incoming data

  --Variables
  PollTime = 3

  --functions
  function ReportStatus(state, msg) 
    local msg = msg or ""
    Status.Value = StatusState[state] --Sets the status state
    Status.String = msg --Sets the status message
  end

  function OpenSerialPort()
    if SerialPort.IsOpen then
      Disconnect()
    end
    SerialPort:Open(baud, databits, parity)
  end

  function Disconnect()
    pollTimer.Stop()
    SerialPort:Close()
  end

  --Operations that will be performed when the serial port connects
  function Connected()
    ReportStatus("OK" .. EOL)
    pollTimer:Start(PollTime)
  end
  
  function Send(cmd)
    if SerialPort.IsOpen then
      SerialPort:Write(cmd)
    end
  end

  function PollDevice ()
    Send("Ping")
  end
end