wifi.setmode(wifi.STATION)
print('set mode=STATION (mode='..wifi.getmode()..')')
print('MAC: ',wifi.sta.getmac())
-- wifi config start, change AP and pass to your 
wifi.sta.config("Your AP name","pass")
-- wifi config end
FileToExecute="main.lua"
l = file.list()
for k,v in pairs(l) do
  if k == FileToExecute then
    print("*** You've got 10 sec to stop timer 0 ***")
    tmr.alarm(0, 10000, 0, function()
      print("Executing ".. FileToExecute)
      dofile(FileToExecute)
    end)
  end
end
