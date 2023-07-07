fx_version 'cerulean'
game 'gta5'

client_scripts {
    'client/utils.lua',
    'client/presets.lua',
    'client/client.lua',
    'client/bigScreen.lua',
    'client/screens/*.lua',
	'@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
	'@PolyZone/EntityZone.lua',
	'@PolyZone/CircleZone.lua',
	'@PolyZone/ComboZone.lua',
}

server_scripts {
    'server/server.lua'
}