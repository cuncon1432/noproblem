function onPathAction()
	if isPokemonUsable(1) then
		
		if getMapName() == "Hoenn Safari Zone Lobby" then
                        talkToNpcOnCell(21 , 6)
		elseif getMapName() == "Safari Entrance" then
			if not isMounted() then
			        useItem("Bicycle")
            else
                    moveToMap("Hoenn Safari Zone Area 1")
			end
		elseif getMapName() == "Hoenn Safari Zone Area 1" then
                        moveToMap("Hoenn Safari Zone Area 2")
		elseif getMapName() == "Hoenn Safari Zone Area 3" then
                        moveToMap("Hoenn Safari Zone Area 2")
		elseif getMapName() == "Hoenn Safari Zone Area 2" then
						if not isMounted() and hasItem("Bicycle") then
	                        return useItem("Bicycle")
                        else
	                        moveToGrass()
                        end
						

		end
	end
end

function onBattleAction()

	if isWildBattle() and ( isOpponentShiny()  or getOpponentName() == "Beldum") then
		if getActivePokemonNumber() == 1 then
			return sendPokemon(2) or run()
		elseif ( getActivePokemonNumber() == 2 ) and ( getOpponentHealthPercent() > 50 ) then
			return useMove("Super Fang")
		elseif ( getActivePokemonNumber() == 2 ) and ( getOpponentHealthPercent() < 51 ) then
			return sendPokemon(3) or run()
		elseif ( getActivePokemonNumber() == 3 ) and ( getOpponentStatus() ~= "SLEEP" ) then
			-- If you want to use Sleep Powder, then replace Hypnosis with Sleep Powder 
			return useMove("Hypnosis") or useItem("Pokeball") or run()
		elseif ( getActivePokemonNumber() == 3 ) and ( getOpponentStatus() == "SLEEP" ) then
			return useItem("Pokeball") or useItem("Great Ball") or useItem("Ultra Ball")
		end	
	end
	
	return run() or sendUsablePokemon() or sendAnyPokemon()

end