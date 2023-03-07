-- Controls.SendButton.EventHandler = function()
--   print("Hello, World!")
-- end

-- dofile should import lua scripts. I could not get this to work in emulation mode
-- the dofile function expects a file path as its argument, 
-- so the external script file must be located in a directory accessible by the Q-SYS processor. 
-- You can use a relative or absolute file path depending on the location of the external script file.
-- example
-- dofile("myScript.lua")
-- Controls.PowerOn.EventHandler = myFunction()


RS232_ConnTypes = Controls["BaudRate"]
RS232_BaudRates = {"9600", "42800", "115200"}
RS232_DataBits = {"7", "8"}
RS232_StopBits = {"1", "2"}
RS232_Parity   = {"None","Even","Odd"}


RS232_ConnTypes.Choices = RS232_BaudRates
Controls["DataBits"].Choices = RS232_DataBits
Controls["StopBits"].Choices = RS232_StopBits
Controls["Parity"].Choices   = RS232_Parity


-- EventHandlers --------------------------------------------------------------------------------------


Controls.Authentication.EventHandler = function (e)
  for i,v in pairs (table) do
    print(i..", "..v)
  end

  if e.Boolean == true then
    Controls['UserName'].IsInvisible = false
    Controls['Password'].IsInvisible = false
  else
    Controls['UserName'].IsInvisible = true
    Controls['Password'].IsInvisible = true
  end

end


-- RS232 Control --------------------------------------------------------------------------------------
if Properties["Control_Type"].Value == "RS-232" then
  
elseif Properties["Control_Type"].Value == "TCP/IP" then
  print("Control Type is TCP/IP")
end
