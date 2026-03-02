-- BRANDON HUB: DELTA ULTIMATE EDITION
local Players = game:GetService("Players")
local RS = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local lp = Players.LocalPlayer

-- System Variables
local speedEnabled, grabEnabled, antiRagdoll, infJump, espEnabled = false, false, false, false, false
local currentSpeed = 60

-- Clean up
if game:GetService("CoreGui"):FindFirstChild("BrandonHub") then game:GetService("CoreGui").BrandonHub:Destroy() end

-- 1. GUI CONTAINER
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BrandonHub"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

-- 2. DRAGGABLE TOGGLE CIRCLE ("B")
local ToggleCircle = Instance.new("TextButton")
ToggleCircle.Parent = ScreenGui
ToggleCircle.Size = UDim2.new(0, 45, 0, 45)
ToggleCircle.Position = UDim2.new(0.02, 0, 0.4, 0)
ToggleCircle.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
ToggleCircle.Text = "B"
ToggleCircle.TextColor3 = Color3.fromRGB(135, 206, 235)
ToggleCircle.Font = Enum.Font.GothamBold
ToggleCircle.TextSize = 20
ToggleCircle.Draggable = true
Instance.new("UICorner", ToggleCircle).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", ToggleCircle).Color = Color3.fromRGB(135, 206, 235)

-- 3. COMPACT MAIN FRAME
local Main = Instance.new("Frame")
Main.Visible = false
Main.Size = UDim2.new(0, 260, 0, 350)
Main.Position = UDim2.new(0.5, -130, 0.5, -175)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Main.Parent = ScreenGui
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)
local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color = Color3.fromRGB(135, 206, 235)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "Brandon Hub"
Title.TextColor3 = Color3.fromRGB(135, 206, 235)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.Parent = Main

-- SCROLLING AREA (Keeps UI small)
local Scroll = Instance.new("ScrollingFrame")
Scroll.Size = UDim2.new(1, -20, 1, -60)
Scroll.Position = UDim2.new(0, 10, 0, 50)
Scroll.BackgroundTransparency = 1
Scroll.CanvasSize = UDim2.new(0, 0, 0, 450)
Scroll.ScrollBarThickness = 0
Scroll.Parent = Main
Instance.new("UIListLayout", Scroll).Padding = UDim.new(0, 5)

-- SPEED INPUT BOX
local SpeedInput = Instance.new("TextBox")
SpeedInput.Size = UDim2.new(1, 0, 0, 35)
SpeedInput.PlaceholderText = "Type Speed (Safe: 70)"
SpeedInput.Text = ""
SpeedInput.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
SpeedInput.TextColor3 = Color3.new(1, 1, 1)
SpeedInput.Parent = Scroll
SpeedInput.FocusLost:Connect(function() currentSpeed = tonumber(SpeedInput.Text) or 60 end)

-- Button Function
local function makeBtn(name, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    btn.Text = name .. ": OFF"
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Parent = Scroll
    Instance.new("UICorner", btn)
    local on = false
    btn.MouseButton1Click:Connect(function()
        on = not on
        btn.Text = name .. (on and ": ON" or ": OFF")
        btn.BackgroundColor3 = on and Color3.fromRGB(40, 80, 100) or Color3.fromRGB(25, 25, 25)
        callback(on)
    end)
end

-- FEATURES
makeBtn("Speed Boost", function(v) speedEnabled = v end)
makeBtn("Anti-Ragdoll", function(v) antiRagdoll = v end)
makeBtn("Insta-Steal", function(v) grabEnabled = v end)
makeBtn("Inf Jump", function(v) infJump = v end)
makeBtn("Player ESP", function(v) espEnabled = v end)

-- --- CORE LOGIC ---
ToggleCircle.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)

-- NO-DIE SPEED & INF JUMP
RS.Stepped:Connect(function()
    if speedEnabled and lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = lp.Character.HumanoidRootPart
        local hum = lp.Character.Humanoid
        if hum.MoveDirection.Magnitude > 0 then
            hrp.AssemblyLinearVelocity = Vector3.new(hum.MoveDirection.X * currentSpeed, hrp.AssemblyLinearVelocity.Y, hum.MoveDirection.Z * currentSpeed)
        end
    end
end)

UIS.JumpRequest:Connect(function()
    if infJump and lp.Character and lp.Character:FindFirstChild("Humanoid") then
        lp.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- ANTI RAGDOLL
RS.Heartbeat:Connect(function()
