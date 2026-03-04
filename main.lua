-- BRANDON SPEED (SAFE VERSION)
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

if PlayerGui:FindFirstChild("BHubMini") then PlayerGui.BHubMini:Destroy() end

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "BHubMini"
ScreenGui.ResetOnSpawn = false

local SpeedBtn = Instance.new("TextButton", ScreenGui)
local Corner = Instance.new("UICorner", SpeedBtn)

SpeedBtn.Size = UDim2.new(0, 35, 0, 35)
SpeedBtn.Position = UDim2.new(0, 20, 0.4, 0)
SpeedBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 255)
SpeedBtn.Text = "S"
SpeedBtn.TextColor3 = Color3.new(1, 1, 1)
SpeedBtn.Draggable = true
SpeedBtn.Active = true
Corner.CornerRadius = UDim.new(1, 0)

-- SAFE SPEED SETTINGS
local NormalSpeed = 16
local BoostSpeed = 50 -- You can change this (don't go over 100 or you might die)

getgenv().SpeedEnabled = false

SpeedBtn.MouseButton1Click:Connect(function()
    getgenv().SpeedEnabled = not getgenv().SpeedEnabled
    SpeedBtn.BackgroundColor3 = getgenv().SpeedEnabled and Color3.fromRGB(0, 255, 120) or Color3.fromRGB(150, 0, 255)
    
    local char = Player.Character
    local hum = char and char:FindFirstChild("Humanoid")
    if hum then
        hum.WalkSpeed = getgenv().SpeedEnabled and BoostSpeed or NormalSpeed
    end
end)

-- AUTO-FIX ON RESPAWN
Player.CharacterAdded:Connect(function(char)
    local hum = char:WaitForChild("Humanoid")
    if getgenv().SpeedEnabled then
        hum.WalkSpeed = BoostSpeed
    end
end)
