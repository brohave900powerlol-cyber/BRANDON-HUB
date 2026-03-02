-- BRANDON-HUB: Fix Edition + ESP
local Players = game:GetService("Players")
local RS = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local lp = Players.LocalPlayer

-- Variables
local speedEnabled = false
local grabEnabled = false
local espEnabled = false
local currentSpeed = 50

-- 1. THE GUI SETUP
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BrandonHubV3"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false -- FIX: GUI stays after you die

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 250, 0, 450)
Main.Position = UDim2.new(0.5, -125, 0.5, -225)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.Parent = ScreenGui

-- LOGO
local Logo = Instance.new("ImageLabel")
Logo.Size = UDim2.new(0.9, 0, 0, 150)
Logo.Position = UDim2.new(0.05, 0, 0, 5)
Logo.Image = "rbxassetid://17355005862"
Logo.BackgroundTransparency = 1
Logo.Parent = Main

-- SPEED INPUT
local SpeedInput = Instance.new("TextBox")
SpeedInput.Size = UDim2.new(0.9, 0, 0, 35)
SpeedInput.Position = UDim2.new(0.05, 0, 0, 160)
SpeedInput.PlaceholderText = "Set Speed (Enter)"
SpeedInput.Text = ""
SpeedInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
SpeedInput.TextColor3 = Color3.new(1, 1, 1)
SpeedInput.Parent = Main
SpeedInput.FocusLost:Connect(function() currentSpeed = tonumber(SpeedInput.Text) or 50 end)

-- BUTTON CREATOR
local function makeBtn(text, pos, color, callback)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0.9, 0, 0, 40)
    b.Position = pos
    b.Text = text
    b.BackgroundColor3 = color
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Parent = Main
    b.MouseButton1Click:Connect(callback)
    return b
end

-- 2. THE FEATURES
local sBtn = makeBtn("Speed: OFF", UDim2.new(0.05, 0, 0, 210), Color3.fromRGB(150, 50, 50), function()
    speedEnabled = not speedEnabled
    Main.SpeedBtn.Text = speedEnabled and "Speed: ON" or "Speed: OFF"
    Main.SpeedBtn.BackgroundColor3 = speedEnabled and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(150, 50, 50)
end)
sBtn.Name = "SpeedBtn"

local gBtn = makeBtn("Insta-Grab: OFF", UDim2.new(0.05, 0, 0, 260), Color3.fromRGB(150, 50, 50), function()
    grabEnabled = not grabEnabled
    Main.GrabBtn.Text = grabEnabled and "Insta-Grab: ON" or "Insta-Grab: OFF"
    Main.GrabBtn.BackgroundColor3 = grabEnabled and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(150, 50, 50)
end)
gBtn.Name = "GrabBtn"

local eBtn = makeBtn("Player ESP: OFF", UDim2.new(0.05, 0, 0, 310), Color3.fromRGB(150, 50, 50), function()
    espEnabled = not espEnabled
    Main.EspBtn.Text = espEnabled and "ESP: ON" or "ESP: OFF"
    Main.EspBtn.BackgroundColor3 = espEnabled and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(150, 50, 50)
end)
eBtn.Name = "EspBtn"

makeBtn("Infinite Jump: ACTIVE", UDim2.new(0.05, 0, 0, 360), Color3.fromRGB(50, 100, 150), function() end)

-- 3. THE LOGIC LOOPS
-- Infinite Jump Fix (Safe Velocity Method)
UIS.JumpRequest:Connect(function()
    if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
        lp.Character.HumanoidRootPart.Velocity = Vector3.new(lp.Character.HumanoidRootPart.Velocity.X, 50, lp.Character.HumanoidRootPart.Velocity.Z)
    end
end)

-- Speed & Insta-Grab Logic
RS.Heartbeat:Connect(function()
    if speedEnabled and lp.Character and lp.Character:FindFirstChild("Humanoid") then
        lp.Character.Humanoid.WalkSpeed = currentSpeed
    end
end)

game:GetService("ProximityPromptService").PromptButtonHoldBegan:Connect(function(p)
    if grabEnabled then fireproximityprompt(p) end
end)

-- SIMPLE ESP LOGIC
RS.RenderStepped:Connect(function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= lp and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local char = p.Character
            if espEnabled then
                if not char:FindFirstChild("EspBox") then
                    local box = Instance.new("Highlight")
                    box.Name = "EspBox"
                    box.Adornee = char
                    box.FillColor = Color3.new(1, 0, 0)
                    box.OutlineColor = Color3.new(1, 1, 1)
                    box.Parent = char
                end
            else
                if char:FindFirstChild("EspBox") then char.EspBox:Destroy() end
            end
        end
    end
end)
