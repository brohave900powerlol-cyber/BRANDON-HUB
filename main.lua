local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/Library.lua"))()
local Window = Library:CreateWindow({ Title = 'BRANDON HUB V10 | STEALER', Center = true, AutoShow = true })

-- 1. THE FLOATING TOGGLE CIRCLE
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local ToggleButton = Instance.new("TextButton", ScreenGui)
local UICorner = Instance.new("UICorner", ToggleButton)

ToggleButton.Name = "BrandonToggle"
ToggleButton.Size = UDim2.new(0, 55, 0, 55)
ToggleButton.Position = UDim2.new(0, 15, 0.5, -27)
ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 80) -- Red/Pink
ToggleButton.Text = "STEAL"
ToggleButton.TextColor3 = Color3.new(1, 1, 1)
ToggleButton.TextSize = 18
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.Active = true
ToggleButton.Draggable = true 
UICorner.CornerRadius = UDim.new(1, 0)

ToggleButton.MouseButton1Click:Connect(function()
    Library:Toggle()
end)

-- 2. TABS
local Tabs = { Main = Window:AddTab('Stealing'), Mods = Window:AddTab('Movement') }
local StealGroup = Tabs.Main:AddLeftGroupbox('Grabber Settings')

-- INSTA-GRAB (NO HOLD DURATION)
StealGroup:AddToggle('InstaGrab', { Text = 'Instant Grab (No Hold)', Default = false, Callback = function(v)
    getgenv().InstaGrab = v
end})

-- This part detects the "Hold E" and finishes it instantly
game:GetService("ProximityPromptService").PromptButtonHoldBegan:Connect(function(prompt)
    if getgenv().InstaGrab then
        fireproximityprompt(prompt)
    end
end)

-- 3. SPEED WHILE CARRYING
local MoveGroup = Tabs.Mods:AddLeftGroupbox('Bypass Settings')

MoveGroup:AddSlider('CarrySpeed', { Text = 'Speed While Holding', Default = 0, Min = 0, Max = 4, Rounding = 1, Callback = function(v)
    getgenv().CarrySpeed = v
end})

task.spawn(function()
    while task.wait() do
        local lp = game.Players.LocalPlayer
        local char = lp.Character
        -- Check if player is holding a Brainrot (Tool in character)
        if char and char:FindFirstChildOfClass("Tool") and getgenv().CarrySpeed and getgenv().CarrySpeed > 0 then
            local hum = char:FindFirstChild("Humanoid")
            if hum and hum.MoveDirection.Magnitude > 0 then
                char:TranslateBy(hum.MoveDirection * getgenv().CarrySpeed)
            end
        end
    end
end)

-- ANTI-RAGDOLL (MUST HAVE FOR STEALING)
MoveGroup:AddToggle('AntiRagdoll', { Text = 'Anti-Ragdoll', Default = true, Callback = function(v)
    game.Players.LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, not v)
end})

Library:Notify("Brandon Hub V10: Ready to steal!", 5)
