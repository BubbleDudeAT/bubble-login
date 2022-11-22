fx_version "adamant"

game "gta5"

author "BubbleDude"

lua54 'yes'

client_scripts {
    'client/client.lua'
}

server_scripts {
    'server/server.lua',
    '@mysql-async/lib/MySQL.lua'
}

ui_page 'client/html/index.html'

files({
    'client/html/index.html',
    'client/html/script.js',
    'client/html/style.css'
})