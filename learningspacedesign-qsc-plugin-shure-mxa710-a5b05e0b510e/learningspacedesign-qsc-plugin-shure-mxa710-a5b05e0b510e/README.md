# Shure MXA-710

This plugin uses the Shure Command Strings and only supports functions detailed in the Shure documentation.  Shure Designer is still required to perform many functions of control and setup of the MXA-710 array

See [Shure MXA 710 Command Strings Documentation](https://pubs.shure.com/command-strings/MXA710/en-US?_gl=1*1mpu5z*_ga*NjQwMjIyMTI5LjE2MjAyNDA0NDQ.*_ga_DB3CR9SF0C*MTYyNTY2MTg3My4yNy4xLjE2MjU2NjE5MzUuNTg.&_ga=2.90722072.36207664.1625661874-640222129.1620240444)

## Plugin Information

This version was tested against a 4ft Shure MXA-710 running Shure firmware 1.2.1 and was the basis for inital development.

## Overview

### Coverage Page
![Coverage Page](./Help%20File/Shure%20MXA-710%20Coverage%20Page.png)

**Function Description**
- Connection Status LED (Show Current Connection Status Of Plugin)
  - **Read Only**
- Beam Width (Narrow, Medium, Wide)
  - **Read,Write**
- Beam Angle (-90 Degrees To 90 Degrees)
  - **Read,Write**
- Coverage Map (Shows Realtime Drawing Of Beam Angle And Width Graphically)
  > Graphical Representation Of Beam Width Is Approximate As Shure Does Not State The Exact Angle Of Each Beam Width
- Device Mute & LED (Allowing The Muting Of Entire Array And Shows True Feedback Of Mute Status)
  - **Read,Write** (Button) | **Read Only** (LED)
- Current Preset Loaded (Shows Current Preset Recalled On Array)
  - **Read Only**
- Recall Preset (Drop Down Of All Available Presets To Recall)
  - **Read,Write**
  > Shure Does Not Provide A Way Currently In The Command Strings To Save A Preset And That Must Be Done In The Designer software


### Channels Page
![Channel Page](./Help%20File/Shure%20MXA-710%20Channels%20Page.png)

**Function Description**
- Connection Status LED (Show Current Connection Status Of Plugin)
  - **Read Only**
- EQ Contour (Bypasses Or Enables EQ Contour)
  - **Read,Write**
- Channel Name (Currently Set Channel Name From Shure Designer Software)
  - **Read Only**
- Dante Channel Name (Currently Set Dante Channel Name From Shure Designer Software Or Dante Controller)
  - **Read Only**
- RMS Level (Shows RMS Level Numerically Sampled Every 15s)
  - **Read Only**
- Peak Level (Shows Peak Level Numerically Sampled Every 15s)
  - **Read Only**
- Clip Indicator (Indicates If A Audio Clip Has Occurred)
  - **Read Only**
- Audio Gain (Adjusts Audio Gain Pre Gate Of Each Lobe Or AutoMix Output | -110 To 20)
  - **Read,Write**
- Audio Levels (Shows Realtime Feedback Of Lobe Levels Or AutoMix Level From -60 To 0 DBFS Sampled Every 300ms)
  - **Read Only**
  > Enable Metering Must Be Enabled On Setup Page For Meters To Display Activity
- Channel Mute (Mutes Each Individual Channel Lobe Or AutoMix Output)
  - **Read,Write**
- Device Mute & LED (Allowing The Muting Of Entire Array And Shows True Feedback Of Mute Status)
  - **Read,Write** (Button) | **Read Only** (LED)

### IntelliMix Page
![IntelliMix Page](./Help%20File/Shure%20MXA-710%20Intellimix%20Page.png)

**Function Description**
- Connection Status LED (Show Current Connection Status Of Plugin)
  - **Read Only**
- Bypass IntelliMix (Bypasses Or Enables IntelliMix Processing)
  - **Read,Write**
- Bypass All EQ (Bypasses Or Enables All EQ)
  - **Read,Write**
- Channel Name (Currently Set Channel Name From Shure Designer Software)
  - **Read Only**
- AutoMix Gate Ind (Indicates If The Channel Is Making It Through The AutoMixer)
  - **Read Only**
- Post Gate Gain (Adjusts Audio Gain Post Gate of Each Lobe | -110 To 20)
  - **Read,Write**
- Post Gate Levels (Shows Realtime Feedback Of Lobe Levels Or AutoMix Level From -60 to 0 DBFS Sampled Every 300ms)
  - **Read Only**
  > Enable Metering Must Be Enabled On Setup Page For Meters To Display Activity
  
  > ***This Function Currently Does Not Work as Expected and Shows Post Gate Gain Instead of Metering Data When the Command String is Called (Opened Case with Shure Support)***
- Channel Mute (Mutes Each Individual Channel Lobe Or AutoMix Output)
  - **Read,Write**
- PEQ Filter 1-4 (Toggle On Or Off Selected EQ Filter For Each Lobe)
  - **Read,Write**
- Device Mute & LED (Allowing The Muting Of Entire Array And Shows True Feedback Of Mute Status)
  - **Read,Write** (Button) | **Read Only** (LED)

### Information Page
![Information Page](./Help%20File/Shure%20MXA-710%20Information%20Page.png)

**Function Description**
- Connection Status LED (Show Current Connection Status Of Plugin)
  - **Read Only**
- Model (Shows Current Model Info)
  - **Read Only**
- Serial Number (Shows Current Serial Number)
  - **Read Only**
- Firmware Version (Shows Current Firmware Version)
  - **Read Only**
- Dante IP (Shows Current Dante IP Address)
  - **Read Only**
- Dante Subnet (Shows Current Dante Subnet Mask)
  - **Read Only**
- Dante Gateway (Shows Current Default Gateway Address)
  - **Read Only**
- Control MAC Address (Shows Current Control Port MAC Address)
  - **Read Only**
- Device ID (Shows Current Shure Device ID)
  - **Read Only**
- Dante Device Name (Shows Current Dante Device Name)
  - **Read Only**
- Last Error (Shows Last Error Reported On The Shure Array Microphone)
  - **Read Only**
- Device Mute & LED (Allowing The Muting Of Entire Array And Shows True Feedback Of Mute Status)
  - **Read,Write** (Button) | **Read Only** (LED)

### Setup Page
![Setup Page](./Help%20File/Shure%20MXA-710%20Setup%20Page.png)

**Function Description**
- IP Address (Set IP Address Of Shure MXA-710 Array Control Port For Plugin To Connect)
  - **Read,Write**
- Connection Status (Show Current Connection Status Of Plugin)
  - **Read Only**
- Installation Type (Choose How the Shure Array Is Installed | Ceiling, Wall_Horizontal, Wall_Vertical, Table)
  - **Read,Write**
- LED Brightness (Choose Brightness Levels Of LED Indicators On Shure Array | 0: 0%, 1: 20%, 2: 40%, 3: 60%, 4: 80%, 5: 100%)
  - **Read,Write**
- LED Color When Muted (Choose Color When In A Muted State | RED, ORANGE, GOLD, YELLOW, YELLOWGREEN, GREEN, TURQUOISE, POWDERBLUE, CYAN, SKYBLUE, BLUE, PURPLE, LIGHTPURPLE, VIOLET, ORCHID, PINK, WHITE)
  - **Read,Write**
- LED Enabled When Muted (Bypass Or Enable LED To Show Any Selected Color When Muted)
  - **Read,Write**
- LED Color When Unmuted (Choose Color When In A Unmuted State | RED, ORANGE, GOLD, YELLOW, YELLOWGREEN, GREEN, TURQUOISE, POWDERBLUE, CYAN, SKYBLUE, BLUE, PURPLE, LIGHTPURPLE, VIOLET, ORCHID, PINK, WHITE)
  - **Read,Write**
- LED Enabled When Unmuted (Bypass Or Enable LED To Show Any Selected Color When Unmuted)
  - **Read,Write**
- ID Mode (Flash LEDS) (Flashes LEDs On Array To Identify Which Unit You Are Controlling)
  - **Read,Write**
- Encryption (Bypasses Or Enables Encryption On the Dante Channels)
  - **Read,Write**
  > This Only Functions When Sending Dante To Shure DSPs Which Most Likely Is Not the Case If You Are Using This Plugin
- Enable Metering (Enables Realtime Metering Of All Audio Levels And Post Gate Levels For Each Lobe and AutoMix Every 300ms)
  - **Read,Write**
- Device Mute & LED (Allowing The Muting Of Entire Array And Shows True Feedback Of Mute Status)
  - **Read,Write** (Button) | **Read Only** (LED)
