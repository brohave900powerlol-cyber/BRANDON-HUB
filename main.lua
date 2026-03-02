local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/Library.lua"))()

-- 1. MAIN WINDOW (PURPLE & COMPACT)
local Window = Library:CreateWindow({ 
    Title = 'BRANDON BOOSTER', 
    Center = true, 
    AutoShow = true 
})

-- 2. THE MINI TOGGLE BUTTON (FLOATING 'B')
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local ToggleBtn = Instance.new("TextButton", ScreenGui)
local UICorner = Instance.new("UICorner", ToggleBtn)

ToggleBtn.Name = "BrandonToggle"
ToggleBtn.Size = UDim2.new(0, 45, 0, 45)
ToggleBtn.Position = UDim2.new(0, 20, 0.5, -22)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 255) -- Purple
ToggleBtn.Text = "B"
ToggleBtn.TextColor3 = Color3.new(1, 1, 1)
ToggleBtn.TextSize = 24
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.Draggable = true
ToggleBtn.Active = true
UICorner.CornerRadius = UDim.new(1, 0)

ToggleBtn.MouseButton1Click:Connect(function() Library:Toggle() end)

-- 3. THE SETTINGS (LIKE THE VIDEO)
local Tab = Window:AddTab('Main')
local Group = Tab:AddLeftGroupbox('Booster Settings')

-- PLAYER ESP
Group:AddToggle('PlayerESP', { Text = 'Player ESP', Default = false, Callback = function(v)
    getgenv().ESP = v
    while getgenv().ESP do
        for _, p in pairs(game.Players:GetPlayers()) do
            if p.Character and p ~= game.Players.LocalPlayer then
                if not p.Character:FindFirstChild("BHighlight") then
                    local h = Instance.new("Highlight", p.Character)
                    h.Name = "BHighlight"
                    h.FillColor = Color3.fromRGB(255, 0, 255)
                end
            end
        end
        task.wait(1)
        if not getgenv().ESP then
            for _, p in pairs(game.Players:GetPlayers()) do
                if p.Character and p.Character:FindFirstChild("BHighlight") then p.Character.BHighlight:Destroy() end
            end
        end
    end
end})

-- TIMER ESP (Placeholder for your specific game)
Group:AddToggle('TimerESP', { Text = 'Timer ESP', Default = false, Callback = function(v)
    Library:Notify("Timer ESP " .. (v and "EINGESCHALTET" or "AUS"))
end})

-- STEAL SPEED (INSTA-GRAB)
Group:AddToggle('StealSpeed', { Text = 'Steal Speed', Default = true, Callback = function(v)
    getgenv().Steal = v
end})

game:GetService("ProximityPromptService").PromptButtonHoldBegan:Connect(function(p)
    if getgenv().Steal then fireproximityprompt(p) end
end)

-- SPEED SLIDER (FOR CHROMEBOOK BYPASS)
Group:AddSlider('Speed', { Text = 'Speed Boost', Default = 1.5, Min = 0, Max = 4, Rounding = 1, Callback = function(v)
    getgenv().Spd = v
end})

task.spawn(function()
    while task.wait() do
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") and getgenv().Spd and getgenv().Spd > 0 then
            local hum = char.Humanoid
            if hum.MoveDirection.Magnitude > 0 then
                char:TranslateBy(hum.MoveDirection * getgenv().Spd)
            end
        end
    end
end)

Library:Notify("BRANDON BOOSTER LOADED", 3)
