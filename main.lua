-- BRANDON HUB: NO-DIE EDITION
local Players = game:GetService("Players")
local RS = game:GetService("RunService")
local lp = Players.LocalPlayer

-- System Variables
local speedEnabled = false
local grabEnabled = false
local antiRagdoll = false
local currentSpeed = 60 -- Recommended safe fast speed

-- 1. GUI CONTAINER
local BrandonHub = Instance.new("ScreenGui")
BrandonHub.Name = "BrandonHub"
BrandonHub.Parent = game:GetService("CoreGui")
BrandonHub.ResetOnSpawn = false

-- 2. TOGGLE CIRCLE ("B")
local ToggleCircle = Instance.new("TextButton")
ToggleCircle.Parent = BrandonHub
ToggleCircle.Size = UDim2.new(0, 50, 0, 50)
ToggleCircle.Position = UDim2.new(0.02, 0, 0.4, 0)
ToggleCircle.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
ToggleCircle.Text = "B"
ToggleCircle.TextColor3 = Color3.fromRGB(135, 206, 235)
ToggleCircle.Font = Enum.Font.GothamBold
ToggleCircle.TextSize = 25
ToggleCircle.Draggable = true
Instance.new("UICorner", ToggleCircle).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", ToggleCircle).Color = Color3.fromRGB(135, 206, 235)

-- 3. MAIN FRAME
local Main = Instance.new("Frame")
Main.Visible = false
Main.Size = UDim2.new(0, 320, 0, 400)
Main.Position = UDim2.new(0.5, -160, 0.5, -200)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Main.Parent = BrandonHub
Instance.new("UICorner", Main)
local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Color3.fromRGB(135, 206, 235)
Stroke.Thickness = 2

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Text = "Brandon Hub"
Title.TextColor3 = Color3.fromRGB(135, 206, 235)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22
Title.Parent = Main

-- Speed Input
local SpeedInput = Instance.new("TextBox")
SpeedInput.Size = UDim2.new(0.8, 0, 0, 35)
SpeedInput.Position = UDim2.new(0.1, 0, 0, 60)
SpeedInput.PlaceholderText = "Set Speed (e.g. 70)"
SpeedInput.Parent = Main
SpeedInput.FocusLost:Connect(function()
    currentSpeed = tonumber(SpeedInput.Text) or 60
end)

-- Button Function
local function makeBtn(name, pos, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.8, 0, 0, 40)
    btn.Position = pos
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.Text = name .. ": OFF"
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Parent = Main
    Instance.new("UICorner", btn)
    
    local on = false
    btn.MouseButton1Click:Connect(function()
        on = not on
        btn.Text = name .. (on and ": ON" or ": OFF")
        btn.BackgroundColor3 = on and Color3.fromRGB(40, 80, 100) or Color3.fromRGB(30, 30, 30)
        callback(on)
    end)
end

-- Feature Buttons
makeBtn("Speed Boost", UDim2.new(0.1, 0, 0, 110), function(v) speedEnabled = v end)
makeBtn("Anti-Ragdoll", UDim2.new(0.1, 0, 0, 160), function(v) antiRagdoll = v end)
makeBtn("Insta-Grab", UDim2.new(0.1, 0, 0, 210), function(v) grabEnabled = v end)

-- TOGGLE LOGIC
ToggleCircle.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)

-- --- CORE LOGIC ---

-- 1. NO-DIE SPEED (Velocity Based)
RS.Stepped:Connect(function()
    if speedEnabled and lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = lp.Character.HumanoidRootPart
        local hum = lp.Character.Humanoid
        if hum.MoveDirection.Magnitude > 0 then
            hrp.AssemblyLinearVelocity = Vector3.new(hum.MoveDirection.X * currentSpeed, hrp.AssemblyLinearVelocity.Y, hum.MoveDirection.Z * currentSpeed)
        end
    end
end)

-- 2. ANTI-RAGDOLL (Disables falling state)
RS.Heartbeat:Connect(function()
    if antiRagdoll and lp.Character and lp.Character:FindFirstChild("Humanoid") then
        -- This stops the character from entering the "FallingDown" or "Ragdoll" state
        lp.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
        lp.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
    elseif not antiRagdoll and lp.Character and lp.Character:FindFirstChild("Humanoid") then
        lp.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
        lp.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, true)
    end
end)

-- 3. INSTA-GRAB
game:GetService("ProximityPromptService").PromptButtonHoldBegan:Connect(function(p)
    if grabEnabled then fireproximityprompt(p) end
end)
