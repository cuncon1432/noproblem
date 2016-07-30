name = "Dratini (Blackthorn)"
author = "edit from dratini code by redskhie"

function onPathAction()


	if isPokemonUsable(1) and isPokemonUsable(2) then
	
		if getMapName() == "Pokecenter Blackthorn" then
			moveToMap("Blackthorn City")
	
		elseif getMapName() == "Blackthorn City" then
				moveToMap("Dragons Den Entrance")
						
		elseif getMapName() == "Dragons Den Entrance" then
			moveToCell(14, 13)
		
		elseif getMapName() == "Dragons Den" then
		
			if (getPlayerX() == 36 and getPlayerY() == 32) then			
				return useItem("Super Rod")
				
			else	
				moveToCell(36, 32)
				
			end	
			
		end
		
	else
		
		if getMapName() == "Dragons Den" then
			moveToMap("Dragons Den Entrance")
			
		elseif getMapName() == "Dragons Den Entrance" then
			moveToMap("Blackthorn City")
			
		elseif getMapName() == "Blackthorn City" then	
			moveToMap("Pokecenter Blackthorn")		
			
	    elseif getMapName() == "Pokecenter Blackthorn" then
			usePokecenter()
			
		end
		
	end
	
end

function onBattleAction()
	
	if isWildBattle() and (isOpponentShiny() or getOpponentName() == "Dratini" or getOpponentName() == "Dragonair") then
		if getActivePokemonNumber() == 1 then
			return sendPokemon(2) or run() or sendAnyPokemon()
		elseif ( getActivePokemonNumber() == 2 ) and ( getOpponentHealth() > 1 ) then
			return weakAttack() or sendAnyPokemon() or run()
		elseif ( getActivePokemonNumber() == 2 ) and ( getOpponentHealth() == 1 ) then
			return sendPokemon(3) or run()
		elseif ( getActivePokemonNumber() == 3 ) and ( getOpponentStatus() ~= "SLEEP" ) then
			-- If you want to use Sleep Powder, then replace Hypnosis with Sleep Powder 
			return useMove("Hypnosis") or useItem("Pokeball") or run()
		elseif ( getActivePokemonNumber() == 3 ) and ( getOpponentStatus() == "SLEEP" ) then
			return useItem("Pokeball") or attack() or run()
        
		end
	end
	
	return run() or sendUsablePokemon() or attack() or senAnyPokemon()

end 