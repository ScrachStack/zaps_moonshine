games { 'rdr3' }
lua54 'yes'
fx_version 'adamant'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
version '1.5'
client_scripts {
    'client/framework.lua',
'client/*'
}

server_scripts {
    'server/framework.lua',
'server/*'
}
shared_script 'config.lua'
escrow_ignore  {
    'config.lua',
    'client/framework.lua',
    'server/framework.lua'
}
