wifi.setmode(wifi.STATION)
wifi.sta.config("SSID","PASSWORD")
led1 = 3
led2 = 4
fan = 6
garage = 8
gpio.mode(led1, gpio.OUTPUT)
gpio.mode(led2, gpio.OUTPUT)
gpio.mode(fan, gpio.OUTPUT)
gpio.mode(garage, gpio.OUTPUT)
srv=net.createServer(net.TCP,1)
srv:listen(80,function(conn)
    conn:on("receive", function(client,request)
        local buf = "";
        local lol = "";
        local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP");
        if(method == nil)then
            _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP");
        end
        local _GET = {}
        if (vars ~= nil)then
            for k, v in string.gmatch(vars, "(%w+)=(%w+)&*") do
                _GET[k] = v
            end
        end
        buf = buf.."<body style=\"background:radial-gradient(black 15%, transparent 16%) 0 0,radial-gradient(black 15%, transparent 16%) 8px 8px,radial-gradient(rgba(255,255,255,.1) 15%, transparent 20%) 0 1px,";
        buf = buf.."radial-gradient(rgba(255,255,255,.1) 15%, transparent 20%) 8px 9px;background-color:#282828;background-size:16px 16px;\">";
        buf = buf.."<div style=\"background:linear-gradient(90deg, #C9FFBF 10%, #FFAFBD 90%);text-align:center;margin:auto;margin-top:20px;width:75%;border:4px solid E3DEDB;border-radius:20px;padding:10px;\">";
        buf = buf.."<h1 style=\"\" > Selv's HomeControl </h1>";
        buf = buf.."<p style=\"font-weight:bold; font-size:26px;\">Fan ";
        buf = buf.."<a href=\"?pin=ON1\"><button style=\"margin-left:6em;border-radius:28px;padding: 10px 20px 10px 20px;color:#ffffff;font-size:20px;background:#3498db;text-decoration: none;\" >ON</button></a>";
        buf = buf.."&nbsp;<a href=\"?pin=OFF1\"><button style=\"font-family:Arial;border-radius:28px;padding: 10px 20px 10px 20px;color:#ffffff;font-size:20px;background:#3498db;text-decoration: none;\">OFF</button></a></p>";
        buf = buf.."<p style=\"font-weight:bold;font-size:26px;\">Light1";
        buf = buf.."<a href=\"?pin=ON2\"><button style=\"margin-left:5em;border-radius:28px;padding: 10px 20px 10px 20px;color:#ffffff;font-size:20px;background:#3498db;text-decoration: none;\">ON</button></a>";
        buf = buf.."&nbsp;<a href=\"?pin=OFF2\"><button style=\"border-radius:28px;padding: 10px 20px 10px 20px;color:#ffffff;font-size:20px;background:#3498db;text-decoration: none;\">OFF</button></a></p>";
        lol = lol.."<p style=\"font-weight:bold;font-size:26px;\">Light2";
        lol = lol.."<a href=\"?pin=ON3\"><button style=\"margin-left:5em;border-radius:28px;padding: 10px 20px 10px 20px;color:#ffffff;font-size:20px;background:#3498db;text-decoration: none;\">ON</button></a>";
        lol = lol.."&nbsp;<a href=\"?pin=OFF3\"><button style=\"border-radius:28px;padding: 10px 20px 10px 20px;color:#ffffff;font-size:20px;background:#3498db;text-decoration: none;\">OFF</button></a></p>";
        lol = lol.."<p style=\"font-weight:bold;font-size:26px;\">Garage";
        lol = lol.."<a href=\"?pin=ON4\"><button style=\"margin-left:2em;border-radius:28px;padding: 10px 20px 10px 20px;color:#ffffff;font-size:20px;background:#3498db;text-decoration: none;\">OPEN</button></a>";
        lol = lol.."&nbsp;<a href=\"?pin=OFF4\"><button style=\"border-radius:28px;padding: 10px 20px 10px 20px;color:#ffffff;font-size:20px;background:#3498db;text-decoration: none;\">CLOSE</button></a></p>";
        lol = lol.."</div>";
        lol = lol.."</body>";
        local _on,_off = "",""
        if(_GET.pin == "ON1")then
              gpio.write(led1, gpio.HIGH);
        elseif(_GET.pin == "OFF1")then
              gpio.write(led1, gpio.LOW);
        elseif(_GET.pin == "ON2")then
              gpio.write(led2, gpio.HIGH);
        elseif(_GET.pin == "OFF2")then
              gpio.write(led2, gpio.LOW);
        elseif(_GET.pin == "ON3")then
              gpio.write(fan, gpio.HIGH);
        elseif(_GET.pin == "OFF3")then
              gpio.write(fan, gpio.LOW);
        elseif(_GET.pin == "ON4")then
              gpio.write(garage, gpio.HIGH);
        elseif(_GET.pin == "OFF4")then
              gpio.write(garage, gpio.LOW);
        end
        client:send(buf);
        client:send(lol);
        client:close();
        collectgarbage();
    end)
end)

print(wifi.sta.getip())


  
