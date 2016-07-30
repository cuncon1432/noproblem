 
name = "Shellsey"
author = "redskhie"
description = [[Chansey and Shellder Catcher]]


function onPathAction()


	if getRemainingPowerPoints(2, "Hypnosis") >= 1 then
		
		if not isNight() and getPokemonNature(1) ~= "Bold" then
			return swapPokemon(3, 1)
		elseif not isNight() and getPokemonNature(1) == "Bold" then

			if getMapName() == "Pokecenter Vermilion" or getMapName() == "Route 6" then	
				moveToMap("Vermilion City")
			elseif getMapName() == "Vermilion City" then
				if not isMounted() then
					useItem("Arcanine Mount")
				elseif isMounted() then
					moveToMap("Route 11")
				end
			elseif getMapName() == "Route 11" then
				moveToMap("Route 11 Stop House")
			elseif getMapName() == "Route 11 Stop House" then
				moveToMap("Route 12")
			elseif getMapName() == "Route 12" then
				moveToCell(24, 92)
			elseif getMapName() == "Route 13" then
				moveToGrass()
			end

		end

		if isNight() and getPokemonNature(1) ~= "Adamant" then
			return swapPokemon(3, 1)
		elseif isNight() and getPokemonNature(1) == "Adamant" then

			if getMapName() == "Route 13" then
				if not isMounted() then
					useItem("Arcanine Mount")
				elseif isMounted() then
					return moveToMap("Route 12")
				end
			elseif getMapName() == "Pokecenter Vermilion" then
				moveToMap("Vermilion City")
			elseif getMapName() == "Route 12" then
				moveToMap("Route 11 Stop House")
			elseif getMapName() == "Route 11 Stop House" then
				moveToMap("Route 11")
			elseif getMapName() == "Route 11" then
				if not isMounted() then
					useItem("Arcanine Mount")
				elseif isMounted() then
					moveToCell(0, 13)
				end
			elseif getMapName() == "Vermilion City" then
				if not isMounted() then
					useItem("Arcanine Mount")
				elseif isMounted() then
					moveToMap("Route 6")	
				end
			elseif getMapName() == "Route 6" then
      				if ( getPlayerX() == 23 and getPlayerY() == 43 ) then
					useItem("Super Rod")
				else
					moveToCell(23, 43)
				end
			end

		end
	
	else
		
		if getMapName() == "Route 13" then
			if not isMounted() then
				useItem("Arcanine Mount")
			elseif isMounted() then
				moveToMap("Route 12")	
			end
		elseif getMapName() == "Route 6" then
			moveToMap("Vermilion City")
		elseif getMapName() == "Route 12" then
			moveToMap("Route 11 Stop House")
		elseif getMapName() == "Route 11 Stop House" then
			moveToMap("Route 11")	
		elseif getMapName() == "Route 11" then
			if not isMounted() then
				useItem("Arcanine Mount")
			elseif isMounted() then
				moveToCell(0, 13)
			end
			
		elseif getMapName() == "Vermilion City" then	
			if not isMounted() then
				useItem("Arcanine Mount")
			elseif isMounted() then
				moveToMap("Pokecenter Vermilion")	
			end
	    elseif getMapName() == "Pokecenter Vermilion" then
			usePokecenter()
		end
	end
end

function onBattleAction()
	if isWildBattle() and ( isOpponentShiny() or getOpponentName() == "Chansey" or getOpponentName() == "Shellder") then
		if getActivePokemonNumber() == 1 then
			return sendPokemon(2) or run()
		elseif ( getActivePokemonNumber() == 2 ) and ( getOpponentStatus() ~= "SLEEP" ) then
			-- If you want to use Sleep Powder, then replace Hypnosis with Sleep Powder 
			return useMove("Hypnosis") or useItem("Pokeball") or run()
		elseif ( getActivePokemonNumber() == 2 ) and ( getOpponentStatus() == "SLEEP" ) then
			return useItem("Pokeball") or attack() or run()
        
		end
	end
	
	return run() or sendUsablePokemon() or attack() or senAnyPokemon()

end 