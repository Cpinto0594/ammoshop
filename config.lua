Config               = {}

Config.DrawDistance  = 100
Config.Size          = { x = 1.5, y = 1.5, z = 0.5 }
Config.Type          = 1

Config.Locale        = 'es'

Config.LicenseEnable = false -- only turn this on if you are using esx_license

Config.Zones = {
	BlackAmmoShop = {
		Legal = false,
		Items = {},
		ShowBlip = false,
		MarkerColors =  {r = 255, g = 0, b = 0 },
		Locations = {
			vector3(-1305.48, -392.2, 35.6)
		}
	},
	AmmoShop = {
		Legal = true,
		Items = {},
		ShowBlip = false,
		MarkerColors =  { r = 0, g = 255, b = 128 },
		Locations = {
			vector3(-664.5, -935.3, 20.8), 
			vector3(809.2, -2155.3, 28.6), 
			vector3(1696.25, 3758.8, 33.7), 
			vector3(-331.6, 6082.2, 30.4), 
			vector3(252.98, -47.5, 68.9), 
			vector3(20, -1106.4, 28.8),   
			vector3(2570, 294.3, 107.7), 
			vector3(-1119.3, 2696.9, 17.5), 
			vector3(841.4, -1031.4, 27.1) 
		}
	}
}
