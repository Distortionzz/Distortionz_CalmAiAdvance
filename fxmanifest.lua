fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Distortionz'
description 'Distortionz CalmAI Advanced — disables worldwide AI ped aggression, animal hostility, gang shootouts, and road rage for a calmer roleplay environment.'
version '1.0.2'
repository 'https://github.com/Distortionzz/Distortionz_CalmAiAdvance'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    'version_check.lua',
    'server.lua'
}

dependencies {
    'qbx_core',
    'ox_lib'
}
