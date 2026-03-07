-- [[ BRANDON HUB: SKY BLUE STABLE 50 ]] --
local P = game:GetService("Players").LocalPlayer
local RS = game:GetService("RunService")

-- 1. THE UI (ULTRA MINI)
local Screen = Instance.new("ScreenGui", P.PlayerGui)
local Main = Instance.new("Frame", Screen)
Main.Size = UDim2.new(0, 120, 0, 60); Main.Position = UDim2.new(0.05, 0, 0.4, 0)
Main.BackgroundColor3 = Color3.fromRGB(5, 5, 10); Main.Active = true; Main.Draggable = true

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 20); Title.Text = "BRANDON HUB"; Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundColor3 = Color3.fromRGB(0, 191, 255) 

-- 2. THE BUTTON
local Btn = Instance.new("TextButton", Main)
Btn.Size = UDim2.new(0.9, 0, 0, 30); Btn.Position = UDim2.new(0.05, 0, 0.45, 0)
Btn.Text = "STABLE 50: OFF"; Btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30); Btn.TextColor3 = Color3.new(1, 1, 1)

getgenv().StableSpeed = false

Btn.MouseButton1Click:Connect(function()
    getgenv().StableSpeed = not getgenv().StableSpeed
    Btn.Text = getgenv().StableSpeed and "50 ON" or "OFF"
    Btn.BackgroundColor3 = getgenv().StableSpeed and Color3.fromRGB(0, 191, 255) or Color3.fromRGB(30, 30, 30)
end)

-- 3. THE STABLE ENGINE
RS.Heartbeat:Connect(function()
    if getgenv().StableSpeed and P.Character and P.Character:FindFirstChild("HumanoidRootPart") then
        local Root = P.Character.HumanoidRootPart
        local Hum = P.Character:FindFirstChild("Humanoid")
        
        if Hum.MoveDirection.Magnitude > 0 then
            -- We use 50 because it's the safest 'Fast' speed for Mobile
            -- This setting prevents the 'Lag-Back' you saw in your video
            Root.AssemblyLinearVelocity = Vector3.new(Hum.MoveDirection.X * 50, Root.AssemblyLinearVelocity.Y, Hum.MoveDirection.Z * 50)
        end
    end
end)
