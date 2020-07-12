fx_version 'adamant'
games { 'gta5' };

server_script "@mysql-async/lib/MySQL.lua"
server_scripts {
	'sv_oblackSoin.lua'
}

client_scripts {
    "cl_pmenu.lua",
	"cl_oblackSoin.lua"
}