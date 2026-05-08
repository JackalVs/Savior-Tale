-- The bouncing bullets attack from the documentation example.
blasters = require("gaster_blasters")
time = 0

spawntimer = 0
bullets = {}

function Update()
    spawntimer = spawntimer + 4
    if spawntimer%30 == 0 then
        local posx = 30 - math.random(60)
        local posy = Arena.height/2
        local bullet = CreateProjectile('bullet', posx, posy)
        bullet.SetVar('velx', 1 - 2*math.random())
        bullet.SetVar('vely', 0)
        table.insert(bullets, bullet)
    end
    
    for i=1,#bullets do
        local bullet = bullets[i]
        local velx = bullet.GetVar('velx')
        local vely = bullet.GetVar('vely')
        local newposx = bullet.x + velx
        local newposy = bullet.y + vely
        if(bullet.x > -Arena.width/2 and bullet.x < Arena.width/2) then
            if(bullet.y < -Arena.height/2 + 8) then 
                newposy = -Arena.height/2 + 8
                vely = 4
            end
        end
        vely = vely - 0.04
        bullet.MoveTo(newposx, newposy)
        bullet.SetVar('vely', vely)
    end
	  if time == 30 then
    local direction = math.random(-90, 90) -- -90 = pointing left, 90 = pointing right, 0 = pointing down
    local endX = math.sin(-direction * math.pi / 180) * (Arena.width / 2 + 100)
    local endY = math.cos(-direction * math.pi / 180) * (Arena.height / 2 + 100)
    local xOffset = 320 -- Offsets to add, so endX & endY = 0 position blaster in the center of the arena (easier for debugging)
    local yOffset = 160

    local directionOffset = math.random(-10, 10) -- Add some random rotation after calculating position, so blasters don't fire to the dead center of the arena
    local coolBlaster = blasters.New(endX + xOffset, -100, endX + xOffset, endY + yOffset, direction + directionOffset)

    function coolBlaster.OnBeam(bullet)
     
    end
    time = 0
  end

  time = time + 1
  blasters.Update()
end

function OnHit(bullet)
  Player.Hurt(9)
end


