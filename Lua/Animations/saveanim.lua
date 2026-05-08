torso = CreateSprite("torso")
torso.Move(0, 111)

legs = CreateSprite("legs")
legs.Move(0, 111)

head = CreateSprite ("head")
head.Move(0, 111)


function AnimateSave()
      
	  torso.MoveTo(math.sin(Time.time) * 4 + 320, legs.y)
	  
	  head.MoveTo(math.sin(Time.time) *  6 + 320, legs.y)
	 
end