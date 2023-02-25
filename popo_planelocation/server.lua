ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('popo_loca:plane')
AddEventHandler('popo_loca:plane', function(prix)
	local xPlayer = ESX.GetPlayerFromId(source)
	local playerMoney = xPlayer.getMoney()
	xPlayer.removeMoney(prix)
	TriggerClientEvent('esx:showNotification', source, "~g~Avion de location sortie.~z~ ~r~Bon vol !")
	TriggerClientEvent('esx:showNotification', source, "Il te reste ~r~1 heure~s~ avant de rendre l'avion de location !")

end)

RegisterNetEvent('popo_planeloca:retard')
AddEventHandler('popo_planeloca:retard', function(prix)
	local xPlayer = ESX.GetPlayerFromId(source)
	local playerMoney = xPlayer.getMoney()
	xPlayer.removeMoney(prix)
	TriggerClientEvent('esx:showNotification', source, "~r~Tu es en retard, 1000$ ont été retiré de ton compte pour compensation !")
end)