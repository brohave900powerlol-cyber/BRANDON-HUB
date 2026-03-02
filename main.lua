-- BRANDON-HUB: Pro Edition
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local ProximityPromptService = game:GetService("ProximityPromptService")
local lp = Players.LocalPlayer

-- Variables for Toggles
local speedEnabled = false
local grabEnabled = false
local currentSpeed = 50 -- Default speed

-- MAIN GUI
local BrandonHub = Instance.new("ScreenGui")
BrandonHub.Name = "BrandonHub"
BrandonHub.Parent = game:GetService("CoreGui")

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 250, 0, 420)
Main.Position = UDim2.new(0.5, -125, 0.5, -210)
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Main.Active = true
Main.Draggable = true
Main.Parent = BrandonHub

-- PICTURE LOGO
local Logo = Instance.new("ImageLabel")
Logo.Size = UDim2.new(0.9, 0, 0, 150)
Logo.Position = UDim2.new(0.05, 0, 0.02, 0)
Logo.Image = "rbxassetid://17355005862" -- Your custom ID
Logo.BackgroundTransparency = 1
Logo.Parent = Main

-- SPEED INPUT BOX
local SpeedInput = Instance.new("TextBox")
SpeedInput.Size = UDim2.new(0.9, 0, 0, 35)
SpeedInput.Position = UDim2.new(0.05, 0, 0, 160)
SpeedInput.PlaceholderText = "Enter Speed (e.g. 100)"
SpeedInput.Text = ""
SpeedInput.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
SpeedInput.TextColor3 = Color3.new(1, 1, 1)
SpeedInput.Parent = Main

SpeedInput.FocusLost:Connect(function()
    currentSpeed = tonumber(SpeedInput.Text) or 50
end)

-- TOGGLE BUTTON CREATOR
local function createToggle(text, pos, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Position = pos
    btn.Text = text .. ": OFF"
    btn.BackgroundColor3 = Color3.fromRGB(180, 50, 50) -- Red for OFF
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Parent = Main
    
    local enabled = false
    btn.MouseButton1Click:Connect(function()
        enabled = not enabled
        btn.Text = text .. (enabled and ": ON" or ": OFF")
        btn.BackgroundColor3 = enabled and Color3.fromRGB(50, 180, 50) or Color3.fromRGB(180, 50, 50)
        callback(enabled)
    end)
end

-- 1. SPEED TOGGLE
createToggle("Speed Boost", UDim2.new(0.05, 0, 0, 210), function(state)
    speedEnabled = state
end)

-- 2. INSTA-GRAB TOGGLE
createToggle("Insta-Grab", UDim2.new(0.05, 0, 0, 260), function(state)
    grabEnabled = state
end)

-- 3. INFINITE JUMP BUTTON
local InfJump = Instance.new("TextButton")
InfJump.Size = UDim2.new(0.9, 0, 0, 40)
InfJump.Position = UDim2.new(0.05, 0, 0, 310)
InfJump.Text = "Infinite Jump: ON"
InfJump.BackgroundColor3 = Color3.fromRGB(50, 120, 180)
InfJump.TextColor3 = Color3.new(1, 1, 1)
InfJump.Parent = Main

-- LOOPS FOR FEATURES
game:GetService("RunService").Heartbeat:Connect(function()
    if speedEnabled and lp.Character and lp.Character:FindFirstChild("Humanoid") then
        lp.Character.Humanoid.WalkSpeed = currentSpeed
    elseif not speedEnabled and lp.Character and lp.Character:FindFirstChild("Humanoid") then
        lp.Character.Humanoid.WalkSpeed = 16 -- Normal speed
    end
end)

ProximityPromptService.PromptButtonHoldBegan:Connect(function(prompt)
    if grabEnabled then
        fireproximityprompt(prompt)
    end
end)

UserInputService.JumpRequest:Connect(function()
    if lp.Character and lp.Character:FindFirstChild("Humanoid") then
        lp.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)
