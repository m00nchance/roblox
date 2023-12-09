local game = game
local select, pcall, loadstring , warn = select, pcall, loadstring, warn

local Success, ESP = pcall(select(2, pcall(loadstring, game:HttpGet("https://raw.githubusercontent.com/m00nchance/roblox/main/src/Modules/Original.lua"))))

if not Success then
    Success, ESP = pcall(select(2, pcall(loadstring, game:HttpGet("https://raw.githubusercontent.com/m00nchance/roblox/main/src/Modules/UWP%20Support.lua"))))

    if not Success then
        return warn("MOON_ESP > Loader - Your script execution software does not support this module.")
    end
end

return ESP

-- Moon <3
