-- Config
usingLogs = true 
buyingPokeballs = true
itemName = "Pokeball" 
-- How many do you would like to buy?
quantity = 50 
-- Set the minimum number of Pokeballs what you would like to have (after you have less than you entered the bot will buy new Pokeballs)
atLeast = 100   
-- Attack config
attack_pokemon = true
-- Special catch: False Swipe + Sleep
usingSpecialCatch = true
-- Config theses lines only if you use Special Catch
indexOfFalseSwiper = 2
indexOfSleep = 3
sleepAttack = "Hypnosis"
--[[
Below this line is the script. 
Don't touch anything if you don't know what you're doing.
]]

name = "Ecruteak Gotharita Farmer"
author = "SMF (This is almost verbatim Royal's Squirtle Catcher)"
description = [[You can start this script in Ecruteak City, inside the Pokecenter there and inside the Pokemart or on Route 37.
If any Gotharita or Shiny appears the script will try to catch this.]]

function onStart() 
	-- Counters, don't change the lines below
	wildCounter = 0
	shinyCounter = 0
	gotharitaCounter = 0
	pokecenterCounter = 0
	startingMoney = getMoney()
	pokeballCounter = 0
	if usingLogs == true then
		log("Info | Index of False Swiper: " .. indexOfFalseSwiper)
		log("Info | Index of Sleeper: " ..  indexOfSleep)
		log("Info | Sleep Attack: " .. sleepAttack)
	end
	if usingLogs == true then
		if usingSpecialCatch then
			log("Info | Using special catch is activated!")
		else
			log("Info | Using special catch is deactivated!")
		end
	end
end

function useLogs()
	if usingLogs == true then
        log("Info | Pokemons encountered: " .. wildCounter)
        log("Info | Shinies encountered: " .. shinyCounter) 
        log("Info | Gothita ecountered: " .. gothitaCounter)
	end
end

function onDialogMessage(pokecenter)
    if stringContains(pokecenter, "Would you like me to heal your Pokemon?") then
        pokecenterCounter = pokecenterCounter + 1
    end
end

function onBattleMessage(wild)
    if stringContains(wild, "A Wild SHINY ") then
        shinyCounter = shinyCounter + 1
		wildCounter = wildCounter + 1
		useLogs()
	elseif wild == "A Wild [FF9900]Gothita[-] Attacks!" then
		gotharitaCounter = gotharitaCounter + 1
		wildCounter = wildCounter + 1
		useLogs()
    elseif stringContains(wild, "A Wild ") then
        wildCounter = wildCounter + 1
		useLogs()
	elseif stringContains(wild, "Pokedollar(s)") then
		if usingLogs == true then
			log("Info | Pokedollars earned: "..tostring(getMoney() - startingMoney).." (" ..tostring((getMoney() - startingMoney)/wildCounter).." average)")
		end
	elseif stringContains(wild, "You throw") then
		pokeballCounter = pokeballCounter + 1
    end
end

function onPause()
	if usingLogs == true then
		log("Times in Pokecenter: " .. pokecenterCounter)
		log("Pokemons encountered: " .. wildCounter)
		log("Shinies encountered: " .. shinyCounter .. " (" .. 100 * (shinyCounter/wildCounter) .. "%)")
		log("Gotharita encountered: " .. gotharitaCounter .. " (" .. 100 * (gotharitaCounter/wildCounter) .. "%)")
		log("Pokedollars earned: "..tostring(getMoney() - startingMoney).." (" ..tostring((getMoney() - startingMoney)/wildCounter).." average)")
		log("Pokeballs used: " .. pokeballCounter)
	end
end

function onPathAction()
	if getItemQuantity(itemName) < atLeast and buyingPokeballs == true then
		if getMapName() == "Route 37" then
			moveToMap("Ecruteak City")
		elseif getMapName() == "Ecruteak City" then
			moveToMap("Ecruteak Pokemart")
		elseif getMapName() == "Ecruteak Pokemart" and not isShopOpen() then
			talkToNpcOnCell(3, 5)
		elseif isShopOpen() then
			buyItem(itemName, quantity)
		end
	elseif (usingSpecialCatch == true and isPokemonUsable(1) and isPokemonUsable(indexOfFalseSwiper) and isPokemonUsable(indexOfSleep) and getRemainingPowerPoints(indexOfFalseSwiper, "False Swipe") >= 1 and getRemainingPowerPoints(indexOfSleep, sleepAttack) >= 1) then
		if getMapName() == "Pokecenter Ecruteak" then
			moveToMap("Ecruteak City")
		elseif getMapName() == "Ecruteak Pokemart" then
			moveToMap("Ecruteak City")
		elseif getMapName() == "Ecruteak City" then
			moveToMap("Route 37")
		elseif getMapName() == "Route 37" then
			moveToGrass()
		end
	elseif isPokemonUsable(1) then
		if getMapName() == "Pokecenter Ecruteak" then
			moveToMap("Ecruteak City")
		elseif getMapName() == "Ecruteak Pokemart" then
			moveToMap("Ecruteak City")
		elseif getMapName() == "Ecruteak City" then
			moveToMap("Route 37")
		elseif getMapName() == "Route 37" then
			moveToGrass()
		end
	elseif not isPokemonUsable(1) and usingSpecialCatch == false then
		if getMapName() == "Route 37" then
			moveToMap("Ecruteak City")
		elseif getMapName() == "Ecruteak City" then
			moveToMap("Pokecenter Ecruteak")
		elseif getMapName() == "Ecruteak Pokemart" then
			moveToMap("Ecruteak City")
		elseif getMapName() == "Pokecenter Ecruteak" then
			usePokecenter()
		end
	elseif not isPokemonUsable(1) or (usingSpecialCatch and (getRemainingPowerPoints(indexOfFalseSwiper, "False Swipe") < 1 or getRemainingPowerPoints(indexOfSleep, sleepAttack) < 1)) then
		if getMapName() == "Route 37" then
			moveToMap("Ecruteak City")
		elseif getMapName() == "Ecruteak City" then
			moveToMap("Pokecenter Ecruteak")
		elseif getMapName() == "Ecruteak Pokemart" then
			moveToMap("Ecruteak City")
		elseif getMapName() == "Pokecenter Ecruteak" then
			usePokecenter()
		end
	end
end

function onBattleAction()
	if usingSpecialCatch == true and (isWildBattle() and (isOpponentShiny() or getOpponentName() == "Gothita")) then
		if getActivePokemonNumber() == 1 then
			if usingLogs == true then
				log("Info | Sending False Swiper")
			end
			return sendPokemon(indexOfFalseSwiper) or run()
		elseif ( getActivePokemonNumber() == indexOfFalseSwiper ) and ( getOpponentHealth() > 1 ) then
			if usingLogs == true then
				log("Info | Using False Swipe")
			end
			return useMove("False Swipe") or run() 
		elseif ( getActivePokemonNumber() == indexOfFalseSwiper ) and ( getOpponentHealth() == 1 ) then
			if usingLogs == true then
				log("Info | Sending Sleeper")
			end
			return sendPokemon(indexOfSleep) or run()
		elseif ( getActivePokemonNumber() == indexOfSleep ) and ( getOpponentStatus() ~= "SLEEP" ) then
			if usingLogs == true then
				log("Info | Using a Sleep Attack")
			end
			return useMove(sleepAttack) or run()
		elseif ( getActivePokemonNumber() == indexOfSleep ) and ( getOpponentStatus() == "SLEEP" ) then
			if usingLogs == true then
				log("Info | Using Pokeballs")
			end
			return useItem("Pokeball") or useItem("Great Ball") or useItem("Ultra Ball")
		end
	elseif not usingSpecialCatch and isWildBattle() and (isOpponentShiny() or getOpponentName() == "Gothita") then
		return useItem("Pokeball") or useItem("Great Ball") or useItem("Ultra Ball") or sendUsablePokemon() or attack() or run()
	elseif attack_pokemon == false and isWildBattle() and not isOpponentShiny() or not getOpponentName() == "Gothita" then
		return run() or sendUsablePokemon() or attack()
	elseif attack_pokemon == true and isWildBattle() and not isOpponentShiny() or not getOpponentName() == "Gothita" then
		return attack() or run() or sendUsablePokemon()
	end
end