-- A basic encounter script skeleton you can copy and modify for your own creations.

music = "Altered" --Either OGG or WAV. Extension is added automatically. Uncomment for custom music.

encountertext = "He seems to be muttering about scientology" --Modify as necessary. It will only be read out in the action select screen.
nextwaves = {"blasterbeam.lua"}
wavetimer = 4.0
arenasize = {155, 130}

autolinebreak = true

enemies = {
"save"
}

enemypositions = {
{0, 0}
}

deathtext = {
"[voice:savior][waitall:3]Man that was embarrassing...",
"[voice:savior][waitall:4]Want another go around?"
}

-- A custom list with attacks to choose from. Actual selection happens in EnemyDialogueEnding(). Put here in case you want to use it.
possible_attacks = {"blasterbeam", "bullettest_touhou", "bullettest_bouncy"}

function EncounterStarting()
    Audio.Stop()
    require "Animations/saveanim"
	State("ENEMYDIALOGUE")
end
	
function Update()
	if waitfordodge then
		if Input.Confirm == 1 then
			SetGlobal("dodge", true)
			waitfordodge = false
			elseif CounterName == 2 then
			SetGlobal("dodge", false) 
		end
	end
	
	Animate()
end

function Update()
  AnimateSave()
end

SetGlobal("intro", true)

HitCount = 0

function EnemyDialogueStarting()
    -- Good location for setting monster dialogue depending on how the battle is going.
    -- Example: enemies[1].SetVar('currentdialogue', {"Check it\nout!"})   See documentation for details.
    local intro = GetGlobal("intro") --updates the variable "intro" everytime the EnemyDialogueStarting() function is triggered
    if intro == true then
      enemies[1].SetVar('currentdialogue', {"[noskip]Listen kid. Listen nice and closely.", "[noskip]You walk up here,[w:20] [color:ff0000] Threaten [color:000000] me...", "[noskip]Acting like some [color:fca600] tough guy,[w:20] [color:000000] ...Well", "[noskip][effect:none][novoice][waitall:2]Let's see how tough you are, six feet [color:ff0000]under.[w:9][func:LaunchMusic][next]"})
      SetGlobal("intro", false) -- sets the variable "intro" to false so that this line of dialogue only plays once
    end
	
end



function EnemyDialogueEnding()
    -- Good location to fill the 'nextwaves' table with the attacks you want to have simultaneously.
	if enemies[1].GetVar("HitCount") == 1 then
	  nextwaves = {"blasterbeam"}
	  elseif  Input.Confirm == 1 then
	  nextwaves = {"bullettest_bouncy"}
	  elseif  CounterName == 1 then
	  nextwaves = {"bullettest_bouncy"}
	elseif enemies[1].GetVar("HitCount") == 2 then
	  nextwaves = {"bullettest_touhou"}
	  elseif  CounterName == 2 then
	  nextwaves = {"bullettest_touhou"}
	  elseif  Input.Confirm == 2 then
	  nextwaves = {"bullettest_touhou"}
	  elseif Input.Confirm == 3 then
	  nextwaves = {"blasterbeam"}
	  elseif  CounterName == 3 then
	  nextwaves = {"blasterbeam"}
	  elseif enemies[1].GetVar("HitCount") == 3 then
	  nextwaves = {"blasterbeam"} 
	  elseif Input.Confirm == 3 then
	  nextwaves = {"blasterbeam"}
	end
end

function DefenseEnding() --This built-in function fires after the defense round ends.
    encountertext = RandomEncounterText() --This built-in function gets a random encounter text from a random enemy.
end


function HandleAttack(attackstatus)
    if attackstatus == 0 then
	
	else
	HitCount = HitCount + 1
	 CounterName = CounterName + 1
	 Input.Confirm = Input.Confirm + 1
		end
end

function HandleSpare()
    State("ENEMYDIALOGUE")
end

function HandleItem(ItemID, ItemIndex, IsSilent)
    if not IsSilent then
        BattleDialog({"Selected item " .. ItemID .. "."})
    end
end

deathmusic = "Funhouse"