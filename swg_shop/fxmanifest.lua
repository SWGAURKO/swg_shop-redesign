fx_version 'cerulean'
game 'gta5'

author 'SWG'
description 'swg_shop redesign (https://discord.gg/TF65NAEkqC)'
version '1.1.0'

lua54 'yes'


shared_scripts {
    'config.lua'
}

client_scripts {
    'client.lua'
}


server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}


ui_page 'nui/index.html'

files {
    'nui/index.html',
    'nui/style.css',
    'nui/app.js',
    'locales/en.json',
    'locales/sr.json'
}


dependencies {
    'qb-core',
    'qb-target',
    'qb-inventory',
    'oxmysql'
}
