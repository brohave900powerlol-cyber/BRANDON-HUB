-- BRANDON HUB: THE FINAL VERSION (BRAINROT EDITION)
local P = game:GetService("Players").LocalPlayer

-- POTATO MODE (FOR CHROMEBOOK PERFORMANCE)
for _, v in pairs(game:GetDescendants()) do
    if v:IsA("BasePart") then v.Material = Enum.Material.SmoothPlastic
    elseif v:IsA("Decal") then v:Destroy() end
end

-- GUI SETUP
local S = Instance.new("ScreenGui", P:WaitForChild("PlayerGui"))
local M = Instance.new("Frame", S)
M.Size = UDim2.new(0, 160, 0, 170); M.Position = UDim2.new(0.1, 0, 0.4, 0)
M.BackgroundColor3 = Color3.fromRGB(10, 10, 10); M.Active = true; M.Draggable = true

local T = Instance.new("TextLabel", M)
T.Size = UDim2.new(1, 0, 0, 30); T.Text = "BRANDON HUB"; T.TextColor3 = Color3.new(1,1,1)
T.BackgroundColor3 = Color3.fromRGB(150, 0, 255)

-- 1. SPEED TOGGLE (GOD SPEED 100)
local B1 = Instance.new("TextButton", M)
B1.Size = UDim2.new(0.9, 0, 0, 30); B1.Position = UDim2.new(0.05, 0, 0.25, 0)
B1.Text = "Speed: OFF"; B1.BackgroundColor3 = Color3.fromRGB(200, 0, 0)

getgenv().SpeedOn = false
B1.MouseButton1Click:Connect(function()
    getgenv().SpeedOn = not getgenv().SpeedOn
    B1.Text = getgenv().SpeedOn and "Speed: ON" or "Speed: OFF"
    B1.BackgroundColor3 = getgenv().SpeedOn and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
    task.spawn(function()
        while getgenv().SpeedOn do
            if P.Character and P.Character:FindFirstChild("Humanoid") then
                P.Character.Humanoid.WalkSpeed = 100
            end
            task.wait(0.1)
        end
        if P.Character and P.Character:FindFirstChild("Humanoid") then P.Character.Humanoid.WalkSpeed = 16 end
    end)
end)

-- 2. AUTO-GRAB (BRAINROT VACUUM)
local B2 = Instance.new("TextButton", M)
B2.Size = UDim2.new(0.9, 0, 0, 30); B2.Position = UDim2.new(0.05, 0, 0.50, 0)
B2.Text = "Auto-Grab: OFF"; B2.BackgroundColor3 = Color3.fromRGB(200, 0, 0)

getgenv().GrabOn = false
B2.MouseButton1Click:Connect(function()
    getgenv().GrabOn = not getgenv().GrabOn
    B2.Text = getgenv().GrabOn and "Grab: ON" or "Auto-Grab: OFF"
    B2.BackgroundColor3 = getgenv().GrabOn and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
    task.spawn(function()
        while getgenv().GrabOn do
            for _, i in pairs(workspace:GetChildren()) do
                if i:IsA("Model") and i:FindFirstChild("TouchInterest") then
                    firetouchinterest(P.Character.HumanoidRootPart, i, 0)
                    task.wait()
                    firetouchinterest(P.Character.HumanoidRootPart, i, 1)
                end
            end
            task.wait(0.3)
        end
    end)
end)

-- 3. INF JUMP (NEVER TOUCH THE FLOOR)
local B3 = Instance.new("TextButton", M)
B3.Size = UDim2.new(0.9, 0, 0, 30); B3.Position = UDim2.new(0.05, 0, 0.75, 0)
B3.Text = "Inf Jump: OFF"; B3.BackgroundColor3 = Color3.fromRGB(200, 0, 0)

getgenv().InfJumpOn = false
game:GetService("UserInputService").JumpRequest:Connect(function()
    if getgenv().InfJumpOn and P.Character and P.Character:FindFirstChildOfClass("Humanoid") then
        P.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

B3.MouseButton1Click:Connect(function()
    getgenv().InfJumpOn = not getgenv().InfJumpOn
    B3.Text = getgenv().InfJumpOn and "Inf Jump: ON" or "Inf Jump: OFF"
    B3.BackgroundColor3 = getgenv().InfJumpOn and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
end)
