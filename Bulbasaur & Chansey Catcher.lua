name = "Bulbasaur and Chansey Catcher"
author = "Privacy"
description = [[Catches Bulbasaur and Chansey at the Kanto Safari Zone using Bold Sync, False Swipe & Hypnosis Support]]


function onPathAction()

	if isPokemonUsable(1) 
	and (getRemainingPowerPoints(3, "Spore") == 0) -- you can change "Hypnosis" to "Sleep Powder"
	then
		if getMapName() == "Safari Area 2" then
			moveToMap("Safari Area 1")
		elseif getMapName() == "Safari Area 1" then
			moveToMap("Safari Entrance")
		elseif getMapName() == "Safari Entrance" then
			moveToMap("Safari Stop")
		elseif getMapName() == "Safari Stop" then
			moveToMap("Fuchsia City")
		elseif getMapName() == "Fuchsia City" then
			if not isMounted() then
			        useItem("Bicycle")
                        elseif isMounted() then
				moveToMap("Pokecenter Fuchsia")
			end	
		elseif getMapName() == "Pokecenter Fuchsia" then
			usePokecenter()	
	end	

	elseif isPokemonUsable(1) then
	
		if getMapName() == "Pokecenter Fuchsia" then
			moveToMap("Fuchsia City")
		elseif getMapName() == "Fuchsia City" then
			if not isMounted() then
			        useItem("Bicycle")
                        elseif isMounted() then
		        moveToMap("Safari Stop")
			end
		elseif getMapName() == "Safari Stop" then
                        talkToNpcOnCell(6, 4)
		elseif getMapName() == "Safari Entrance" then
			if not isMounted() then
			        useItem("Bicycle")
                        elseif isMounted() then
				 moveToMap("Safari Area 1")
			end
		elseif getMapName() == "Safari Area 1" then
                        moveToMap("Safari Area 2")
		elseif getMapName() == "Safari Area 2" then
                        moveToRectangle(12, 11, 18, 11)

		end

	else
		if getMapName() == "Safari Area 2" then
			moveToMap("Safari Area 1")
		elseif getMapName() == "Safari Area 1" then
			moveToMap("Safari Entrance")
		elseif getMapName() == "Safari Entrance" then
			moveToMap("Safari Stop")
		elseif getMapName() == "Safari Stop" then
			moveToMap("Fuchsia City")
		elseif getMapName() == "Fuchsia City" then
			if not isMounted() then
			        useItem("Bicycle")
                        elseif isMounted() then
				moveToMap("Pokecenter Fuchsia")
			end	
		elseif getMapName() == "Pokecenter Fuchsia" then
			usePokecenter()
		end
	end
end

function onBattleAction()

	if isWildBattle() and ( isOpponentShiny() or getOpponentName() == "Bulbasaur" or getOpponentName() == "Chansey") then
		if getActivePokemonNumber() == 1 then
			return sendPokemon(3) or run()
		elseif ( getActivePokemonNumber() == 3 ) and ( getOpponentStatus() ~= "SLEEP" ) then
			-- If you want to use Sleep Powder, then replace Hypnosis with Sleep Powder 
			return useMove("Spore") or useItem("Pokeball") or run()
		elseif ( getActivePokemonNumber() == 3 ) and ( getOpponentStatus() == "SLEEP" ) then
			return useItem("Pokeball") or useItem("Great Ball") or useItem("Ultra Ball")
		end	
	end	
	if getActivePokemonNumber() >= 1 then
		return run() or sendUsablePokemon()		
	end	
end