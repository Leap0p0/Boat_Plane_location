ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('popo_loca:boat')
AddEventHandler('popo_loca:boat', function(prix)
	local xPlayer = ESX.GetPlayerFromId(source)
	local playerMoney = xPlayer.getMoney()
	xPlayer.removeMoney(prix)
	TriggerClientEvent('esx:showNotification', source, "~g~Bateau de location sortie.~z~ ~r~Bonne pêche !")
	TriggerClientEvent('esx:showNotification', source, "Il te reste ~r~1 heure~s~ avant de rendre le bateau de location !")

end)

RegisterNetEvent('popo_boatloca:retard')
AddEventHandler('popo_boatloca:retard', function(prix)
	local xPlayer = ESX.GetPlayerFromId(source)
	local playerMoney = xPlayer.getMoney()
	xPlayer.removeMoney(prix)
	TriggerClientEvent('esx:showNotification', source, "~r~Tu es en retard, 1000$ ont été retiré de ton compte pour compensation !")
end)