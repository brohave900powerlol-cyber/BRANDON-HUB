local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/760084/LinoriaLib/main/Library.lua"))()
local Window = Library:CreateWindow({ Title = 'BRANDON HUB V5', Center = true, AutoShow = true })

-- TABS
local Tabs = {
    Main = Window:AddTab('Player'),
    Trade = Window:AddTab('Trade Machine'),
    Misc = Window:AddTab('Misc')
}

-- PLAYER TAB (Anti-Kick Speed)
local PlayerBox = Tabs.Main:AddLeftGroupbox('Movement')

PlayerBox:AddSlider('SpeedBypass', { Text = 'Bypass Speed', Default = 16, Min = 16, Max = 100, Rounding = 0, Callback = function(Value)
    game.Players.LocalPlayer.Character.Humanoid.RootPriority = 1
    task.spawn(function()
        while task.wait() do
            local char = game.Players.LocalPlayer.Character
            local hum = char and char:FindFirstChild("Humanoid")
            if hum and hum.MoveDirection.Magnitude > 0 then
                char:TranslateBy(hum.MoveDirection * (Value/50))
            end
        end
    end)
end})

PlayerBox:AddToggle('InfJump', { Text = 'Infinite Jump', Default = false, Callback = function(State)
    _G.InfJump = State
    game:GetService("UserInputService").JumpRequest:Connect(function()
        if _G.InfJump then
            game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Jumping")
        end
    end)
end})

-- TRADE TAB (Steal a Brainrot Specials)
local TradeBox = Tabs.Trade:AddLeftGroupbox('Machine Exploits')

TradeBox:AddButton({ Text = 'Freeze Trade (Lag Method)', Func = function()
    settings().Network.IncomingReplicationLag = 10
    Library:Notify("Trade Window Frozen! (10s)", 5)
    task.wait(10)
    settings().Network.IncomingReplicationLag = 0
end})

TradeBox:AddButton({ Text = 'Force Accept (Experimental)', Func = function()
    local remote = game:GetService("ReplicatedStorage"):FindFirstChild("AcceptTrade", true)
    if remote then 
        remote:FireServer(true) 
        Library:Notify("Sent Force Accept Signal", 3)
    else
        Library:Notify("Remote Not Found - Patched?", 3)
    end
end})

-- MISC TAB
local MiscBox = Tabs.Misc:AddLeftGroupbox('Extra Features')
MiscBox:AddButton({ Text = 'Server Hop', Func = function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
end})

MiscBox:AddButton({ Text = 'Unload Hub', Func = function() Library:Unload() end})

Library:Notify("Brandon Hub V5 Loaded!", 5)
