-- FIXED START SCANNING LOGIC
function startScanning()
    task.spawn(function()
        task.wait(SCAN_DELAY)
        
        if not isRunning then return end
        
        local foundRare = false
        for _, obj in pairs(workspace:GetDescendants()) do
            -- Checks for names or rarities in Steal a Brainrot
            if obj.Name:find("Strawberry") or obj.Name:find("Elephant") or obj.Name:find("Secret") or obj.Name:find("OG") then
                foundRare = true
                break
            end
        end

        if foundRare then
            Status.Text = "✅ RARE FOUND! Staying."
            Status.TextColor3 = Color3.fromRGB(0, 255, 100)
            Stroke.Color = Color3.fromRGB(0, 255, 100)
            isRunning = false 
            ToggleBtn.Text = "RESTART SCAN"
        else
            if isRunning then
                Status.Text = "❌ No Rares. Hopping..."
                Status.TextColor3 = Color3.fromRGB(255, 50, 50)
                task.wait(1)
                
                -- NEW 2026 SERVER HOPPER METHOD
                local Http = game:GetService("HttpService")
                local Api = "https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Desc&limit=100"
                local Success, Result = pcall(function() return game:HttpGet(Api) end)
                
                if Success then
                    local Servers = Http:JSONDecode(Result).data
                    for _, s in pairs(Servers) do
                        -- Only join if it's NOT our current server and has space
                        if s.id ~= game.JobId and s.playing < s.maxPlayers then
                            Status.Text = "🚀 Joining: " .. s.playing .. "/" .. s.maxPlayers
                            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, s.id, Players.LocalPlayer)
                            break
                        end
                    end
                else
                    -- Fallback if API fails
                    game:GetService("TeleportService"):Teleport(game.PlaceId, Players.LocalPlayer)
                end
            end
        end
    end)
end
