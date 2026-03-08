-- BRANDON HUB: PREMIUM AUTO-JOINER (TOGGLE EDITION)
local Players = game:GetService("Players")
local RS = game:GetService("RunService")
local TS = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")

-- Configuration
local SCAN_DELAY = 8 -- Seconds to wait for world to load before hopping
local isRunning = false -- The Toggle Variable

-- Cleanup
if game:GetService("CoreGui"):FindFirstChild("BrandonFancy") then 
    game:GetService("CoreGui").BrandonFancy:Destroy() 
end

-- 1. FANCY UI DESIGN
local Screen = Instance.new("ScreenGui", game:GetService("CoreGui"))
Screen.Name = "BrandonFancy"
Screen.ResetOnSpawn = false

local Main = Instance.new("Frame", Screen)
Main.Size = UDim2.new(0, 220, 0, 130) -- Made slightly taller for button
Main.Position = UDim2.new(0.5, -110, 0.1, 0)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Main.BorderSizePixel = 0
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 15)

local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Color3.fromRGB(0, 170, 255)
Stroke.Thickness = 2
Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- Title & Status
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 35)
Title.Text = "BRANDON HUB"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.BackgroundTransparency = 1

local Status = Instance.new("TextLabel", Main)
Status.Size = UDim2.new(1, 0, 0, 25)
Status.Position = UDim2.new(0, 0, 0, 35)
Status.Text = "⏸️ Waiting for Start"
Status.TextColor3 = Color3.fromRGB(150, 150, 150)
Status.Font = Enum.Font.Gotham
Status.TextSize = 13
Status.BackgroundTransparency = 1

-- 2. THE START/STOP BUTTON
local ToggleBtn = Instance.new("TextButton", Main)
ToggleBtn.Size = UDim2.new(0.8, 0, 0, 35)
ToggleBtn.Position = UDim2.new(0.1, 0, 0, 75)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50) -- Start Red
ToggleBtn.Text = "START HOPPER"
ToggleBtn.TextColor3 = Color3.new(1, 1, 1)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 14
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 8)

-- 3. TOGGLE FUNCTIONALITY
ToggleBtn.MouseButton1Click:Connect(function()
    isRunning = not isRunning
    
    if isRunning then
        ToggleBtn.Text = "STOP HOPPER"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100) -- Green
        Status.Text = "🔍 Scanning Servers..."
        Status.TextColor3 = Color3.fromRGB(0, 170, 255)
        startScanning()
    else
        ToggleBtn.Text = "START HOPPER"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50) -- Red
        Status.Text = "⏸️ Waiting for Start"
        Status.TextColor3 = Color3.fromRGB(150, 150, 150)
    end
end)

-- 4. SMART LOGIC
function startScanning()
    task.spawn(function()
        task.wait(SCAN_DELAY)
        
        -- If user clicked stop during wait, don't hop
        if not isRunning then return end
        
        local foundRare = false
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj.Name:find("Strawberry") or obj.Name:find("Elephant") or obj.Name:find("Secret") then
                foundRare = true
                break
            end
        end

        if foundRare then
            Status.Text = "✅ RARE FOUND! Staying."
            Stroke.Color = Color3.fromRGB(0, 255, 100)
            isRunning = false -- Stop hopping since we found it
            ToggleBtn.Text = "RESTART SCAN"
        else
            if isRunning then
                Status.Text = "❌ No Rares. Hopping..."
                task.wait(2)
                TeleportService:Teleport(game.PlaceId, Players.LocalPlayer)
            end
        end
    end)
end

-- Fancy Pulse Effect
task.spawn(function()
    while task.wait(1) do
        TS:Create(Stroke, TweenInfo.new(1), {Thickness = 4}):Play()
        task.wait(1)
        TS:Create(Stroke, TweenInfo.new(1), {Thickness = 2}):Play()
    end
end)
