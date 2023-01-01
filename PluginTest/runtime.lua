Controls.SendButton.EventHandler = function()
  print("Hello, World!")
end
PollTimer.EventHandler = PollDevice
SendBtn.EventHandler = function()
  if SendBtn.Value == 1 then  
    Send("Hello World")
  end
end

