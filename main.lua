-- [[ BRANDON HUB: 2026 NO-KILL EDITION ]] --
local P = game:GetService("Players").LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- GUI SETUP
local Screen = Instance.new("ScreenGui", P.PlayerGui)
local Main = Instance.new("Frame", Screen)
Main.Size = UDim2.new(0, 180, 0, 220)
Main.Position = UDim2.new(0.4, 0, 0.4, 0)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Main.Visible = true
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

-- OPEN/CLOSE BUTTON (THE CIRCLE)
local ToggleBtn = Instance.new("TextButton", Screen)
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0.05, 0, 0.1, 0)
ToggleBtn.Text = "BH"
ToggleBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 255)
ToggleBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)

ToggleBtn.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
end)

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "BRANDON HUB"
Title.BackgroundColor3 = Color3.fromRGB(150, 0, 255)
Title.TextColor3 = Color3.new(1,1,1)

-- 1. NO-KILL SPEED (VELOCITY NUDGE)
local B1 = Instance.new("TextButton", Main)
B1.Size = UDim2.new(0.9, 0, 0, 30); B1.Position = UDim2.new(0.05, 0, 0.2, 0)
B1.Text = "Speed: OFF"; B1.BackgroundColor3 = Color3.fromRGB(40, 40, 40); B1.TextColor3 = Color3.new(1,1,1)

getgenv().SpeedOn = false
B1.MouseButton1Click:Connect(function()
    getgenv().SpeedOn = not getgenv().SpeedOn
    B1.Text = getgenv().SpeedOn and "Speed: ON" or "Speed: OFF"
    B1.BackgroundColor3 = getgenv().SpeedOn and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(40, 40, 40)
end)

RunService.Stepped:Connect(function()
    if getgenv().SpeedOn and P.Character and P.Character:FindFirstChild("HumanoidRootPart") then
        local hum = P.Character:FindFirstChild("Humanoid")
        if hum.MoveDirection.Magnitude > 0 then
            P.Character.HumanoidRootPart.CFrame = P.Character.HumanoidRootPart.CFrame + (hum.MoveDirection * 1.2)
        end
    end
end)

-- 2. NO-KILL INF JUMP
local B2 = Instance.new("TextButton", Main)
B2.Size = UDim2.new(0.9, 0, 0, 30); B2.Position = UDim2.new(0.05, 0, 0.4, 0)
B2.Text = "Inf Jump: OFF"; B2.BackgroundColor3 = Color3.fromRGB(40, 40, 40); B2.TextColor3 = Color3.new(1,1,1)

getgenv().JumpOn = false
B2.MouseButton1Click:Connect(function()
    getgenv().JumpOn = not getgenv().JumpOn
    B2.Text = getgenv().JumpOn and "Jump: ON" or "Inf Jump: OFF"
    B2.BackgroundColor3 = getgenv().JumpOn and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(40, 40, 40)
end)

UIS.JumpRequest:Connect(function()
    if getgenv().JumpOn and P.Character and P.Character:FindFirstChild("HumanoidRootPart") then
        P.Character.HumanoidRootPart.Velocity = Vector3.new(P.Character.HumanoidRootPart.Velocity.X, 50, P.Character.HumanoidRootPart.Velocity.Z)
    end
end)

-- 3. AUTO-GRAB (TARGETS 'BRAINROT' MODELS)
local B3 = Instance.new("TextButton", Main)
B3.Size = UDim2.new(0.9, 0, 0, 30); B3.Position = UDim2.new(0.05, 0, 0.6, 0)
B3.Text = "Auto-Grab: OFF"; B3.BackgroundColor3 = Color3.fromRGB(40, 40, 40); B3.TextColor3 = Color3.new(1,1,1)

getgenv().GrabOn = false
B3.MouseButton1Click:Connect(function()
    getgenv().GrabOn = not getgenv().GrabOn
    B3.Text = getgenv().GrabOn and "Grab: ON" or "Auto-Grab: OFF"
    B3.BackgroundColor3 = getgenv().GrabOn and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(40, 40, 40)
end)

task.spawn(function()
    while true do
        if getgenv().GrabOn then
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("TouchInterest") and v.Parent and (v.Parent.Name:lower():find("brainrot") or v.Parent:IsA("Model")) then
                    firetouchinterest(P.Character.HumanoidRootPart, v.Parent, 0)
                    task.wait()
                    firetouchinterest(P.Character.HumanoidRootPart, v.Parent, 1)
                end
            end
        end
        task.wait(0.5)
    end
end)

-- 4. ESP (SEE THROUGH WALLS)
local B4 = Instance.new("TextButton", Main)
B4.Size = UDim2.new(0.9, 0, 0, 30); B4.Position = UDim2.new(0.05, 0, 0.8, 0)
B4.Text = "ESP: OFF"; B4.BackgroundColor3 = Color3.fromRGB(40, 40, 40); B4.TextColor3 = Color3.new(1,1,1)

getgenv().EspOn = false
B4.MouseButton1Click:Connect(function()
    getgenv().EspOn = not getgenv().EspOn
    B4.Text = getgenv().EspOn and "ESP: ON" or "ESP: OFF"
    B4.BackgroundColor3 = getgenv().EspOn and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(40, 40, 40)
end)

RunService.RenderStepped:Connect(function()
    for _, plr in pairs(game.Players:GetPlayers()) do
        if plr ~= P and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local highlight = plr.Character:FindFirstChild("BH_ESP") or Instance.new("Highlight", plr.Character)
            highlight.Name = "BH_ESP"
            highlight.Enabled = getgenv().EspOn
            highlight.FillColor = Color3.fromRGB(150, 0, 255)
        end
    end
end)
