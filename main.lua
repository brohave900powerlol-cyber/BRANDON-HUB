local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/Library.lua"))()
local Window = Library:CreateWindow({ Title = 'BRANDON HUB V10 | STEALER', Center = true, AutoShow = true })

-- 1. THE TOGGLE CIRCLE
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local ToggleButton = Instance.new("TextButton", ScreenGui)
local UICorner = Instance.new("UICorner", ToggleButton)
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Position = UDim2.new(0, 20, 0.5, -25)
ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 100)
ToggleButton.Text = "STEAL"
ToggleButton.TextColor3 = Color3.new(1, 1, 1)
ToggleButton.Draggable = true
UICorner.CornerRadius = UDim.new(1, 0)
ToggleButton.MouseButton1Click:Connect(function() Library:Toggle() end)

-- 2. TABS
local Tabs = { Main = Window:AddTab('Auto-Steal'), Mods = Window:AddTab('Bypass') }
local StealGroup = Tabs.Main:AddLeftGroupbox('Grabber Settings')

-- INSTA-GRAB (BYPASS HOLD DURATION)
StealGroup:AddToggle('InstaGrab', { Text = 'Instant Grab (No Hold)', Default = false, Callback = function(state)
    getgenv().InstaGrab = state
end})

game:GetService("ProximityPromptService").PromptButtonHoldBegan:Connect(function(prompt)
    if getgenv().InstaGrab then
        fireproximityprompt(prompt) -- Fires the prompt immediately
    end
end)

-- AUTO-SPEED WHEN HOLDING
StealGroup:AddSlider('GrabSpeed', { Text = 'Speed While Carrying', Default = 0, Min = 0, Max = 4, Rounding = 1, Callback = function(v)
    getgenv().CarrySpeed = v
end})

task.spawn(function()
    while task.wait() do
        local lp = game.Players.LocalPlayer
        local char = lp.Character
        -- Check if you are holding a Brainrot (Tool in character)
        if char and char:FindFirstChildOfClass("Tool") and getgenv().CarrySpeed then
            local hum = char:FindFirstChild("Humanoid")
            if hum and hum.MoveDirection.Magnitude > 0 then
                char:TranslateBy(hum.MoveDirection * getgenv().CarrySpeed)
            end
        end
    end
end)

-- 3. EXTRA MODS
local ModGroup = Tabs.Mods:AddLeftGroupbox('Player Mods')
ModGroup:AddToggle('AntiRagdoll', { Text = 'Anti-Ragdoll', Default = true, Callback = function(s)
    game.Players.LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, not s)
end})

Library:Notify("V10 Stealer Loaded! Turn on Insta Grab to steal in 0 seconds.", 5)
