--[[
    Desenvolvido por Salomao129
    Versão: 1.1 (Protegido contra erros)
]]--

local originalNamecall

if hookmetamethod and getnamecallmethod then
    originalNamecall = hookmetamethod(game, "__namecall", function(self, ...)
        local method = getnamecallmethod and getnamecallmethod()
        local args = {...}

        if method == "Ban" and (not checkcaller or not checkcaller()) then
            if debug and debug.traceback and not self.Parent then
                local stack = debug.traceback("", 3)
                local counter, expected = 0, 0

                for line in stack:gmatch("[^\n]+") do
                    if line:find(game.Players.LocalPlayer.Name) or line:find("Ban") or line:find("Packet") or line:find("Network") then
                        counter = counter + 1
                    elseif tonumber(line) then
                        expected = expected + tonumber(line)
                    end
                end

                if counter == expected then
                    local matches, outgoingKey = 0, nil

                    for i, v in pairs(args) do
                        if v == game.Players.LocalPlayer.Name or v == "Ban" or v == "Packet" or v == "Network" then
                            matches = matches + 1
                        elseif typeof(i) == "Instance" or typeof(i) == "userdata" then
                            outgoingKey = v
                        end
                    end

                    if matches == counter + 5 and outgoingKey then
                        if game:GetService("NetworkClient") and game:GetService("NetworkClient").SetOutgoingKBPSLimit then
                            pcall(function()
                                game:GetService("NetworkClient"):SetOutgoingKBPSLimit(0, outgoingKey)
                            end)
                        end
                        game.Players.LocalPlayer:Kick("Tentativa de ban detectada e bloqueada.")
                        return wait(9e9)
                    end
                end
            end
        end

        return originalNamecall(self, ...)
    end)

    warn("🟢 Bypass Byfron/Hyperion Ativado com Proteção 🟢")
else
    warn("❌ Seu executor não suporta hookmetamethod ou getnamecallmethod!")
end
