ESX = nil
local shopItems = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

MySQL.ready(function()

	MySQL.Async.fetchAll('SELECT a.* FROM ammoshops a', {}, function(result)
		for i=1, #result, 1 do
			if shopItems[result[i].zone] == nil then
				shopItems[result[i].zone] = {}
			end

			table.insert(shopItems[result[i].zone], {
				item  = result[i].item,
				price = result[i].price,
				amount = result[i].amount,
				label = ESX.GetWeaponLabel(result[i].item)
			})
		end
		TriggerClientEvent('esx_ammoshop:sendShop', -1, shopItems)
	end)

end)

ESX.RegisterServerCallback('esx_ammoshop:getShop', function(source, cb)
	cb(shopItems)
end)

ESX.RegisterServerCallback('esx_ammoshop:buyAmmo', function(source, cb, weaponName, zone)
	local xPlayer = ESX.GetPlayerFromId(source)
    local ammoDetails = GetAmmoDetails(weaponName, zone)[1]
    local ammoPrice = ammoDetails.price
    local ammoAmount = ammoDetails.amount
	if ammoPrice == 0 then
		print(('esx_ammoshop: %s attempted to buy a unknown weapon!'):format(xPlayer.identifier))
		cb(false)
	else
		if xPlayer.hasWeapon(weaponName) then
			local canShop = false
			if zone == 'AmmoShop' and xPlayer.getMoney() >= ammoPrice then 
				canShop = true
            else
				if zone == 'BlackAmmoShop' and xPlayer.getAccount('black_money').money >= ammoPrice then 
					canShop = true 
				else 
					canShop = false
				end 
        	end
            if canShop then
                if zone == 'AmmoShop' then    
                    xPlayer.removeMoney(ammoPrice)
                else 
                    xPlayer.removeAccountMoney('black_money', ammoPrice)
				end
                xPlayer.addWeaponAmmo(weaponName, ammoAmount)
                cb(true)
            else
                if zone == 'AmmoShop' 
                    then xPlayer.showNotification(_U('not_enough'))
                    else xPlayer.showNotification(_U('not_enough_black'))
                end
                cb(false)
            end
		else
			xPlayer.showNotification(_U("weapon_not_owned"))
			cb(false)
		end
	end
end)

function GetAmmoDetails(weaponName, zone)
	local price = MySQL.Sync.fetchAll('SELECT ashp.amount , ashp.price FROM ammoshops ashp WHERE ashp.zone = @zone AND ashp.item = @item', {
		['@zone'] = zone,
		['@item'] = weaponName
	})

	if price then
		return price
	else
		return 0
	end
end
