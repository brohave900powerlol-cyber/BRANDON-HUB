-- [[ BRANDON HUB: STABLE VERSION ]] --
local Player = game:GetService("Players").LocalPlayer
local UIS = game:GetService("UserInputService")

-- 1. GUI BASE
local Screen = Instance.new("ScreenGui", Player:WaitForChild("PlayerGui"))
Screen.Name = "BrandonHub"

local Main = Instance.new("Frame", Screen)
Main.Size = UDim2.new(0, 160, 0, 150)
Main.Position = UDim2.new(0.1, 0, 0.4, 0)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Main.Active = true
Main.Draggable = true -- Essential for Chromebook touchpads

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "BRANDON HUB"
Title.BackgroundColor3 = Color3.fromRGB(150, 0, 255)
Title.TextColor3 = Color3.new(1, 1, 1)

-- 2. NO-KILL SPEED TOGGLE (100 SPEED)
local SpeedBtn = Instance.new("TextButton", Main)
SpeedBtn.Size = UDim2.new(0.9, 0, 0, 30)
SpeedBtn.Position = UDim2.new(0.05, 0, 0.25, 0)
SpeedBtn.Text = "Speed: OFF"
SpeedBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
SpeedBtn.TextColor3 = Color3.new(1, 1, 1)

getgenv().SpeedEnabled = false
SpeedBtn.MouseButton1Click:Connect(function()
    getgenv().SpeedEnabled = not getgenv().SpeedEnabled
    SpeedBtn.Text = getgenv().SpeedEnabled and "Speed: ON" or "Speed: OFF"
    SpeedBtn.BackgroundColor3 = getgenv().SpeedEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(40, 40, 40)
    
    task.spawn(function()
        while getgenv().SpeedEnabled do
            if Player.Character and Player.Character:FindFirstChild("Humanoid") then
                -- No-Kill Safeguard: Constantly resets speed so anti-cheat doesn't trip
                Player.Character.Humanoid.WalkSpeed = 100
                -- Anti-Void: If you fall too fast, this tries to keep you alive
                if Player.Character.Humanoid.Health <= 0 then getgenv().SpeedEnabled = false end
            end
            task.wait(0.1)
        end
        if Player.Character and Player.Character:FindFirstChild("Humanoid") then
            Player.Character.Humanoid.WalkSpeed = 16
        end
    end)
end)

-- 3. NO-KILL INF JUMP
local JumpBtn = Instance.new("TextButton", Main)
JumpBtn.Size = UDim2.new(0.9, 0, 0, 30)
JumpBtn.Position = UDim2.new(0.05, 0, 0.5, 0)
JumpBtn.Text = "Inf Jump: OFF"
JumpBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
JumpBtn.TextColor3 = Color3.new(1, 1, 1)

getgenv().InfJump = false
UIS.JumpRequest:Connect(function()
    if getgenv().InfJump and Player.Character and Player.Character:FindFirstChild("Humanoid") then
        Player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

JumpBtn.MouseButton1Click:Connect(function()
    getgenv().InfJump = not getgenv().InfJump
    JumpBtn.Text = getgenv().InfJump and "Inf Jump: ON" or "Inf Jump: OFF"
    JumpBtn.BackgroundColor3 = getgenv().InfJump and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(40, 40, 40)
end)

-- 4. AUTO-GRAB (VACUUM)
local GrabBtn = Instance.new("TextButton", Main)
GrabBtn.Size = UDim2.new(0.9, 0, 0, 30)
GrabBtn.Position = UDim2.new(0.05, 0, 0.75, 0)
GrabBtn.Text = "Auto-Grab: OFF"
GrabBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
GrabBtn.TextColor3 = Color3.new(1, 1, 1)

getgenv().Grabber = false
GrabBtn.MouseButton1Click:Connect(function()
    getgenv().Grabber = not getgenv().Grabber
    GrabBtn.Text = getgenv().Grabber and "Grab: ON" or "Auto-Grab: OFF"
    GrabBtn.BackgroundColor3 = getgenv().Grabber and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(40, 40, 40)
    
    task.spawn(function()
        while getgenv().Grabber do
            for _, v in pairs(workspace:GetChildren()) do
                if v:IsA("Model") and v:FindFirstChild("TouchInterest") then
                    firetouchinterest(Player.Character.HumanoidRootPart, v, 0)
                    task.wait()
                    firetouchinterest(Player.Character.HumanoidRootPart, v, 1)
                end
            end
            task.wait(0.5)
        end
    end)
end)
