local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/Library.lua"))()
local Window = Library:CreateWindow({ Title = 'BRANDON HUB V7', Center = true, AutoShow = true })

-- 1. THE FLOATING CIRCLE TOGGLE
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local ToggleButton = Instance.new("TextButton", ScreenGui)
local UICorner = Instance.new("UICorner", ToggleButton)

ToggleButton.Name = "BrandonToggle"
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Position = UDim2.new(0, 10, 0.5, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(150, 0, 255) -- Purple
ToggleButton.Text = "BH"
ToggleButton.TextColor3 = Color3.new(1, 1, 1)
ToggleButton.TextSize = 20
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.Active = true
ToggleButton.Draggable = true -- You can move it!
UICorner.CornerRadius = UDim.new(1, 0) -- Makes it a circle

ToggleButton.MouseButton1Click:Connect(function()
    Library:Toggle()
end)

-- 2. THE TABS & HACKS
local Tabs = { Main = Window:AddTab('Cheats') }
local Group = Tabs.Main:AddLeftGroupbox('Player Hacks')

-- SPEED BOOST (BYPASS)
Group:AddSlider('Speed', { Text = 'Speed Boost', Default = 0, Min = 0, Max = 3, Rounding = 1, Callback = function(v)
    getgenv().Speed = v
end})

task.spawn(function()
    while task.wait() do
        if getgenv().Speed and getgenv().Speed > 0 then
            local lp = game.Players.LocalPlayer
            if lp.Character and lp.Character:FindFirstChild("Humanoid") then
                local hum = lp.Character.Humanoid
                if hum.MoveDirection.Magnitude > 0 then
                    lp.Character:TranslateBy(hum.MoveDirection * getgenv().Speed)
                end
            end
        end
    end
end)

-- INF JUMP
Group:AddToggle('InfJump', { Text = 'Infinite Jump', Default = false, Callback = function(s)
    _G.InfJump = s
    game:GetService("UserInputService").JumpRequest:Connect(function()
        if _G.InfJump then game.Players.LocalPlayer.Character.Humanoid:ChangeState("Jumping") end
    end)
end})

-- ESP
Group:AddToggle('ESP', { Text = 'Highlight ESP', Default = false, Callback = function(s)
    getgenv().ESP = s
    while getgenv().ESP do
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("Model") and game.Players:GetPlayerFromCharacter(v) and not v:FindFirstChild("BHighlight") then
                local h = Instance.new("Highlight", v)
                h.Name = "BHighlight"
                h.FillColor = Color3.new(1, 0, 1)
            end
        end
        task.wait(2)
        if not getgenv().ESP then
            for _, v in pairs(workspace:GetDescendants()) do
                if v.Name == "BHighlight" then v:Destroy() end
            end
        end
    end
end})

-- ANTI-RAGDOLL
Group:AddToggle('AntiRagdoll', { Text = 'Anti-Ragdoll', Default = false, Callback = function(s)
    game.Players.LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, not s)
    game.Players.LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, not s)
end})

Library:Notify("Brandon Hub V7: Click the purple circle to open/close!", 5)
