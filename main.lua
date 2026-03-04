-- BRANDON-HUB: BRAINROT AUTO-GRAB + TOGGLE SPEED
local P = game:GetService("Players").LocalPlayer

-- POTATO MODE (PREVENTS CHROMEBOOK CRASH)
for _, v in pairs(game:GetDescendants()) do
    if v:IsA("BasePart") then v.Material = Enum.Material.SmoothPlastic
    elseif v:IsA("Decal") then v:Destroy() end
end

-- GUI SETUP
local S = Instance.new("ScreenGui", P:WaitForChild("PlayerGui"))
local M = Instance.new("Frame", S)
M.Size = UDim2.new(0, 160, 0, 130); M.Position = UDim2.new(0.1, 0, 0.4, 0)
M.BackgroundColor3 = Color3.fromRGB(15, 15, 15); M.Active = true; M.Draggable = true

local T = Instance.new("TextLabel", M)
T.Size = UDim2.new(1, 0, 0, 30); T.Text = "BRAINROT HUB"; T.TextColor3 = Color3.new(1,1,1)
T.BackgroundColor3 = Color3.fromRGB(150, 0, 255)

-- 1. TOGGLE SPEED (STAYS ON)
local B1 = Instance.new("TextButton", M)
B1.Size = UDim2.new(0.9, 0, 0, 35); B1.Position = UDim2.new(0.05, 0, 0.3, 0)
B1.Text = "Speed: OFF"
B1.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

getgenv().SpeedEnabled = false
B1.MouseButton1Click:Connect(function()
    getgenv().SpeedEnabled = not getgenv().SpeedEnabled
    B1.Text = getgenv().SpeedEnabled and "Speed: ON" or "Speed: OFF"
    B1.BackgroundColor3 = getgenv().SpeedEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(50, 50, 50)
    
    task.spawn(function()
        while getgenv().SpeedEnabled do
            if P.Character and P.Character:FindFirstChild("Humanoid") then
                P.Character.Humanoid.WalkSpeed = 100
            end
            task.wait(0.1)
        end
        if P.Character and P.Character:FindFirstChild("Humanoid") then
            P.Character.Humanoid.WalkSpeed = 16 -- Reset to normal when OFF
        end
    end)
end)

-- 2. AUTO-GRAB (VACUUM ITEMS)
local B2 = Instance.new("TextButton", M)
B2.Size = UDim2.new(0.9, 0, 0, 35); B2.Position = UDim2.new(0.05, 0, 0.65, 0)
B2.Text = "Auto-Grab: OFF"
B2.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

getgenv().GrabEnabled = false
B2.MouseButton1Click:Connect(function()
    getgenv().GrabEnabled = not getgenv().GrabEnabled
    B2.Text = getgenv().GrabEnabled and "Grab: ON" or "Auto-Grab: OFF"
    B2.BackgroundColor3 = getgenv().GrabEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(50, 50, 50)
    
    task.spawn(function()
        while getgenv().GrabEnabled do
            for _, item in pairs(workspace:GetChildren()) do
                -- Specifically targets Brainrots and collectable models
                if item:IsA("Model") and item:FindFirstChild("TouchInterest") then
                    firetouchinterest(P.Character.HumanoidRootPart, item, 0)
                    task.wait() -- Micro-wait to prevent physics lag
                    firetouchinterest(P.Character.HumanoidRootPart, item, 1)
                end
            end
            task.wait(0.3) -- Fast collection speed for Chromebook
        end
    end)
end)
