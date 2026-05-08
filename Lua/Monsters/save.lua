-- A basic monster script skeleton you can copy and modify for your own creations.
comments = {"He keeps checking his phone while he waits..", "Save seemed to have dropped his vocaloid merchandise.", "Save is on that good kush and alcohol."}
commands = {"Dap", "Insult", "Compliment"}
randomdialogue = {"All this for fifty bucks and a lighter", "Grown ass man by the way.", "This is gay as fuck."}

sprite = "goku" --Always PNG. Extension is added automatically.
name = "Save"
hp = 100
atk = 1
def = 9999999999999999999999999999
voice = "savior"
HitCount = 0
check = "He shields his body as he mutters something about you being a perv."
dialogbubble = "rightwide" -- See documentation for what bubbles you have available.
canspare = false
cancheck = true

function LaunchMusic()

Audio.Play()

end



-- Happens after the slash animation but before 
function HandleAttack(attackstatus)
    if attackstatus == 0 then
        -- player pressed fight but didn't press Z afterwards
    else
	HitCount = HitCount + 1
	moveSprite(30, 0)
        -- player did actually attack
    end
end
 
-- This handles the commands; all-caps versions of the commands list you have above.
function HandleCustomCommand(command)
    if command == "DAP" then
        currentdialogue = {"Clean shit my brother."}
    elseif command == "INSULT" then
        currentdialogue = {"Are you fucking mad bruv?"}
    elseif command == "COMPLIMENT" then
        currentdialogue = {"This is top tier glaze."}
    end
    BattleDialog({"You selected " .. command .. "."})
		if command == "DAP" then BattleDialog ({"You walk up and dap each other. Children cry."})
		elseif command == "INSULT" then
		   BattleDialog ({"He looks at you and sneers"})
		   elseif command == "COMPLIMENT" then
		    BattleDialog ({"He turns his back and points at you. A small laugh is heard"})
		end
end

function HandleAttack(attackstatus)
	SetGlobal("waitfordodge", false)
    if attackstatus == -1 then
        currentdialogue = {"You missed"}
    else
		currentdialogue = {"Owie"}
    end
	 if HitCount == 4 then
	 SetGlobal("dodge", false) 
	 hp = 0 
	 elseif Input.Confirm == 4 then
	 SetGlobal ("dodge", false)
	 hp = 0
	 end
end

function EncounterStarting()
	
end

function MonsterStarting()
    require "Animations/saveanim"
    monstersprite.alpha = 0
    drone.SetParent(monstersprite)
    DEBUG(1)
end