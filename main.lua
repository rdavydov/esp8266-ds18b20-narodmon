require("ds18b20")
gpio2 = 4

ds18b20.setup(gpio2)
addres=ds18b20.addrs()
sensors = table.getn(addres)

function sendNarod()
    local sensors = sensors
    local tm
    print(sensors)
    local dataN
    dataN = "#XXXXXXXXXXX\n" - change to your MAC
--for sensor = sensors, 1, -1 do

tm = ds18b20.read(addres[sensors])
tm = ds18b20.read(addres[sensors])

local tm2 = tm % 10000
local tm1 = (tm - (tm % 10000))/10000
--local i =1 
--while i < 6 or tonumber(tm1) == 85 do 
--    print ('Error to read temp. Try '..i)
--    print ('tem= '..tm1)
--    tm = ds18b20.read(addres[sensors])
--    tm1 = (tm - (tm % 10000))/10000
--    i = i+1 
--end

dataN = dataN.."#T1#"..tm1.."."..tm2.."\n"
--end
dataN = dataN.."##\n"
print(dataN)
if tonumber(tm1) ~= 85 then 
conn=net.createConnection(net.TCP, 0)
conn:on("connection",function(conn, payload)
            conn:send(dataN)
            end)
conn:on("receive",function(conn, payload)
    print('\nRetrieved in '..((tmr.now()-t)/1000)..' milliseconds.')
    print('Narodmon says '..payload)
    conn:close()
    end)
t = tmr.now()
conn:connect(8283,'narodmon.ru')
else 
print ('Fail to get temp')
end
end

function sleep()
print("SLEEP")
node.dsleep(900*1000*1000 , 0) -- 30 секунд
--node.dsleep(6*60*1000*1000,0) -- час (на самом деле ~35 минут)
print("WAKE")
end

sendNarod()

tmr.alarm(0, 10000, 1, function()
   if wifi.sta.getip() == nil then
     print("Connecting to AP...")
   else
      print('IP: ',wifi.sta.getip())
--      sendNarod()
     sleep() 
   end
end)
