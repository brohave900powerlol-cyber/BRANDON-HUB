-- BRANDON HUB: STEAL A BRAINROT (ULTRA STABLE)
local Players = game:GetService("Players")
local TS = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")

-- CONFIG
local isRunning = false
local RARE_NAMES = {"Strawberry", "Elephant", "Dragon", "Secret", "OG"}

-- 1. CLEANUP PREVIOUS
if game:GetService("CoreGui"):FindFirstChild("BrandonFancy") then 
    game:GetService("CoreGui").BrandonFancy:Destroy() 
end

-- 2. CREATE FANCY GUI
local Screen = Instance.new("ScreenGui", game:GetService("CoreGui"))
Screen.Name = "BrandonFancy"
Screen.ResetOnSpawn = false

local Main = Instance.new("Frame", Screen)
Main.Size = UDim2.new(0, 220, 0, 130)
Main.Position = UDim2.new(0.5, -110, 0.1, 0)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true -- Now you can move it!
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 15)

local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Color3.fromRGB(0, 170, 255)
Stroke.Thickness = 2

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 35)
Title.Text = "BRANDON HUB: SAB"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.BackgroundTransparency = 1

local Status = Instance.new("TextLabel", Main)
Status.Size = UDim2.new(1, 0, 0, 25)
Status.Position = UDim2.new(0, 0, 0, 35)
Status.Text = "⏸️ READY"
Status.TextColor3 = Color3.fromRGB(150, 150, 150)
Status.Font = Enum.Font.Gotham
Status.TextSize = 13
Status.BackgroundTransparency = 1

local ToggleBtn = Instance.new("TextButton", Main)
ToggleBtn.Size = UDim2.new(0.8, 0, 0, 35)
ToggleBtn.Position = UDim2.new(0.1, 0, 0, 75)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
ToggleBtn.Text = "START HOPPER"
ToggleBtn.TextColor3 = Color3.new(1, 1, 1)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 14
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 8)

-- 3. THE LOGIC
local function doHop()
    Status.Text = "🚀 HOPPING..."
    task.wait(1)
    -- This is the most stable way to hop on Delta:
    TeleportService:Teleport(game.PlaceId, Players.LocalPlayer)
end

local function scanAndHop()
    if not isRunning then return end
    
    Status.Text = "🔍 SCANNING..."
    task.wait(6) -- Shorter wait for faster hopping
    
    local found = false
    for _, obj in pairs(workspace:GetDescendants()) do
        for _, name in pairs(RARE_NAMES) do
            if obj.Name:find(name) then
                found = true
                break
            end
        end
    end
    
    if found then
        Status.Text = "✅ RARE FOUND!"
        Stroke.Color = Color3.fromRGB(0, 255, 100)
        isRunning = false
        ToggleBtn.Text = "RESTART"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    else
        doHop()
    end
end

ToggleBtn.MouseButton1Click:Connect(function()
    isRunning = not isRunning
    if isRunning then
        ToggleBtn.Text = "STOP"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        scanAndHop()
    else
        ToggleBtn.Text = "START HOPPER"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        Status.Text = "⏸️ STOPPED"
    end
end)

-- Pulse Effect
task.spawn(function()
    while task.wait(0.1) do
        if not Main then break end
        TS:Create(Stroke, TweenInfo.new(1), {Thickness = 4}):Play()
        task.wait(1)
        TS:Create(Stroke, TweenInfo.new(1), {Thickness = 2}):Play()
        task.wait(1)
    end
end)
