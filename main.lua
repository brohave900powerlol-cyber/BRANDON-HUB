-- BRANDON HUB: SKY BLUE & FUNCTIONAL SPEED
local Players = game:GetService("Players")
local RS = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local lp = Players.LocalPlayer

-- Variables
local speedEnabled = false
local grabEnabled = false
local currentSpeed = 50

-- 1. GUI CONTAINER
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BrandonHub"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

-- 2. TOGGLE CIRCLE (The "B" button)
local ToggleCircle = Instance.new("TextButton")
ToggleCircle.Parent = ScreenGui
ToggleCircle.Size = UDim2.new(0, 50, 0, 50)
ToggleCircle.Position = UDim2.new(0.02, 0, 0.4, 0)
ToggleCircle.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ToggleCircle.Text = "B"
ToggleCircle.TextColor3 = Color3.fromRGB(135, 206, 235) -- Sky Blue
ToggleCircle.Font = Enum.Font.GothamBold
ToggleCircle.TextSize = 25
ToggleCircle.Draggable = true
Instance.new("UICorner", ToggleCircle).CornerRadius = UDim.new(1, 0)
local Stroke = Instance.new("UIStroke", ToggleCircle)
Stroke.Color = Color3.fromRGB(135, 206, 235)
Stroke.Thickness = 2

-- 3. MAIN FRAME
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 340, 0, 500)
Main.Position = UDim2.new(0.5, -170, 0.5, -250)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Main.Visible = false -- Hidden by default
Main.Active = true
Main.Draggable = true
Main.Parent = ScreenGui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)
local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color = Color3.fromRGB(135, 206, 235)
MainStroke.Thickness = 2

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Text = "Brandon Hub"
Title.TextColor3 = Color3.fromRGB(135, 206, 235)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 24
Title.Parent = Main

-- Speed Input
local SpeedInput = Instance.new("TextBox")
SpeedInput.Size = UDim2.new(0.9, 0, 0, 40)
SpeedInput.Position = UDim2.new(0.05, 0, 0, 100)
SpeedInput.PlaceholderText = "Type Speed (e.g. 100) & Enter"
SpeedInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
SpeedInput.TextColor3 = Color3.new(1, 1, 1)
SpeedInput.Parent = Main
SpeedInput.FocusLost:Connect(function()
    currentSpeed = tonumber(SpeedInput.Text) or 50
end)

-- Feature Toggles
local function makeBtn(name, pos, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 45)
    btn.Position = pos
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    btn.Text = name .. ": OFF"
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Parent = Main
    Instance.new("UICorner", btn)
    
    local enabled = false
    btn.MouseButton1Click:Connect(function()
        enabled = not enabled
        btn.Text = name .. (enabled and ": ON" or ": OFF")
        btn.BackgroundColor3 = enabled and Color3.fromRGB(40, 80, 100) or Color3.fromRGB(25, 25, 25)
        callback(enabled)
    end)
end

makeBtn("Speed Boost", UDim2.new(0.05, 0, 0, 160), function(v) speedEnabled = v end)
makeBtn("Insta-Grab", UDim2.new(0.05, 0, 0, 215), function(v) grabEnabled = v end)

-- TOGGLE LOGIC
ToggleCircle.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
end)

-- CORE PRIORITY SPEED FIX
RS.Stepped:Connect(function()
    if speedEnabled and lp.Character and lp.Character:FindFirstChild("Humanoid") then
        lp.Character.Humanoid.WalkSpeed = currentSpeed
        -- Overrides game-side resets by translating character CFrame
        if lp.Character.Humanoid.MoveDirection.Magnitude > 0 then
            lp.Character:TranslateBy(lp.Character.Humanoid.MoveDirection * (currentSpeed / 100))
        end
    end
end)
-- BRANDON HUB: SMOOTH SPEED (NO-DIE VERSION)
RS.Stepped:Connect(function()
    if speedEnabled and lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = lp.Character.HumanoidRootPart
        local hum = lp.Character.Humanoid
        
        -- Only apply speed if you are actually trying to move
        if hum.MoveDirection.Magnitude > 0 then
            -- We multiply your direction by the speed, but keep your falling gravity (Y) the same
            hrp.AssemblyLinearVelocity = Vector3.new(
                hum.MoveDirection.X * currentSpeed, 
                hrp.AssemblyLinearVelocity.Y, 
                hum.MoveDirection.Z * currentSpeed
            )
        end
    end
end)
