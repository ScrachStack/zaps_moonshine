if GetResourceState('vorp_core') ~= 'missing' then
    vorp = false 
else 
    vorp = true
end
if vorp then 
local VORPcore = {}

TriggerEvent("getCore", function(core)
    VORPcore = core
end)
else 
    
end
