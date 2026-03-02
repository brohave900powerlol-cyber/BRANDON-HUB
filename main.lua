local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/Library.lua"))()
local Window = Library:CreateWindow({ Title = 'BRANDON HUB V8', Center = true, AutoShow = true })

-- 1. THE FLOATING TOGGLE CIRCLE (OPEN/CLOSE)
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local ToggleButton = Instance.new("TextButton", ScreenGui)
local UICorner = Instance.new("UICorner", ToggleButton)

ToggleButton.Name = "BrandonToggle"
ToggleButton.Size = UDim2.new(0, 55, 0, 55)
ToggleButton.Position = UDim2.new(0, 15, 0.5, -27)
ToggleButton.BackgroundColor3 = Color3.fromRGB(170, 0, 255) -- Bright Purple
ToggleButton.Text = "BH"
ToggleButton.TextColor3 = Color3.new(1, 1, 1)
ToggleButton.TextSize = 22
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.Active = true
ToggleButton.Draggable = true -- Move it anywhere on your Chromebook screen

ToggleButton.MouseButton1Click:Connect(function()
    Library:Toggle()
end)

-- 2. THE TABS
local Tabs = { Main = Window:AddTab('Cheats'), Visuals = Window:AddTab('Visuals') }
local Group = Tabs.Main:AddLeftGroupbox('Player Hacks')

-- SPEED BOOST (BYPASS VERSION)
Group:AddSlider('Speed', { Text = 'Bypass Speed', Default = 0, Min = 0, Max = 4, Rounding = 1, Callback = function(v)
    getgenv().SpeedVal = v
end})

task.spawn(function()
    while task.wait() do
        if getgenv().SpeedVal and getgenv().SpeedVal > 0 then
            local lp = game.Players.LocalPlayer
            local hum = lp.Character and lp.Character:FindFirstChild("Humanoid")
            if hum and hum.MoveDirection.Magnitude > 0 then
                lp.Character:TranslateBy(hum.MoveDirection * getgenv().SpeedVal)
            end
        end
    end
end)

-- INFINITE JUMP
Group:AddToggle('InfJump', { Text = 'Infinite Jump', Default = false, Callback = function(s)
    _G.InfJump = s
    game:GetService("UserInputService").JumpRequest:Connect(function()
        if _G.InfJump then game.Players.LocalPlayer.Character.Humanoid:ChangeState("Jumping") end
    end)
end})

-- ANTI-RAGDOLL
Group:AddToggle('AntiRagdoll', { Text = 'Anti-Ragdoll', Default = false, Callback = function(s)
    local hum = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
    if hum then
        hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, not s)
        hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, not s)
    end
end})

-- ESP (HIGHLIGHTS)
local VisGroup = Tabs.Visuals:AddLeftGroupbox('ESP Settings')
VisGroup:AddToggle('PlayerESP', { Text = 'Show Players', Default = false, Callback = function(s)
    getgenv().ESP = s
    while getgenv().ESP do
        for _, v in pairs(game.Players:GetPlayers()) do
            if v.Character and not v.Character:FindFirstChild("BHighlight") then
                local h = Instance.new("Highlight", v.Character)
                h.Name = "BHighlight"
                h.FillColor = Color3.fromRGB(255, 0, 255)
            end
        end
        task.wait(1)
        if not getgenv().ESP then
            for _, v in pairs(game.Players:GetPlayers()) do
                if v.Character and v.Character:FindFirstChild("BHighlight") then v.Character.BHighlight:Destroy() end
            end
        end
    end
end})

Library:Notify("Brandon Hub V8 Loaded! Use the BH circle to toggle.", 5)
