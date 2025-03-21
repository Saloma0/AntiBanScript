--[[
    Desenvolvido por Salomao129
    Versão: 1.0
]]--
local X
X = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    if method == "Ban" then
        local eval1 = {false}
        local eval2 = {false}
        if debug and debug.traceback and self.Parent == nil then
            local stack = debug.traceback("", 3)
            local counter = 0
            local expected = 0
            for v in string.gmatch(stack, "[^\n]+") do
                if v:find(game.Players.LocalPlayer.Name) or v:find("Ban") or v:find("Packet") or v:find("Network") then
                    counter = counter + 1
                elseif tonumber(v) then
                    expected = expected + tonumber(v)
                end
            end
            if counter == expected then
                eval1 = {true, counter + 5}
            end
        end
        if eval1[1] then
            if #args == eval1[2] then
                local counter = 0
                local outgoingkey
                for i, v in pairs(args) do
                    if v == game.Players.LocalPlayer.Name or v == "Ban" or v == "Packet" or v == "Network" then
                        counter = counter + 1
                    elseif tostring(i) == "userdata: 0x000000001bdfb8ea" then
                        outgoingkey = v
                    end
                end
                if counter == eval1[2] then
                    eval2 = {true, outgoingkey}
                end
            end
            if eval2[1] then
                game:GetService("NetworkClient"):SetOutgoingKBPSLimit(0, eval2[2])
                game.Players.LocalPlayer:Kick("Game attempted to ban you but was blocked")
                return wait(9e9)
            end
        end
    end
    return X(self, ...)
end)
warn("🟢Bypass Byfron Activate🟢")
