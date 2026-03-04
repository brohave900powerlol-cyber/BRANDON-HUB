-- BRANDON-HUB (STEAL A BRAINROT OPTIMIZED)
local Player = game:GetService("Players").LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()

-- 1. CHROMEBOOK PERFORMANCE (Prevents Network Crash)
for _, v in pairs(game:GetDescendants()) do
    if v:IsA("Part") or v:IsA("MeshPart") then
        v.Material = Enum.Material.SmoothPlastic
    elseif v:IsA("Decal") then
        v:Destroy()
    end
end

-- 2. GUI SETUP
local Screen = Instance.new("ScreenGui", Player:WaitForChild("PlayerGui"))
local Main = Instance.new("Frame", Screen)
Main.Size = UDim2.new(0, 160, 0, 130)
Main.Position = UDim2.new(0.1, 0, 0.4, 0)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Main.Active = true; Main.Draggable = true

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 30); Title.Text = "BRAINROT HUB"
Title.BackgroundColor3 = Color3.fromRGB(0, 255, 100); Title.TextColor3 = Color3.new(0,0,0)

-- 3. GOD-SPEED BUTTON (Safe for 2026)
local SBtn = Instance.new("TextButton", Main)
SBtn.Size = UDim2.new(0.9, 0, 0, 35); SBtn.Position = UDim2.new(0.05, 0, 0.3, 0)
SBtn.Text = "Super Speed (100)"

SBtn.MouseButton1Click:Connect(function()
    getgenv().Speed = true
    task.spawn(function()
        while getgenv().Speed do
            if Player.Character and Player.Character:FindFirstChild("Humanoid") then
                Player.Character.Humanoid.WalkSpeed = 100
            end
            task.wait(0.1)
        end
    end)
end)

-- 4. AUTO-PICKUP (Snag Brainrots instantly)
local ABtn = Instance.new("TextButton", Main)
ABtn.Size = UDim2.new(0.9, 0, 0, 35); ABtn.Position = UDim2.new(0.05, 0, 0.65, 0)
ABtn.Text = "Auto-Collect: OFF"

getgenv().AutoCol = false
ABtn.MouseButton1Click:Connect(function()
    getgenv().AutoCol = not getgenv().AutoCol
    ABtn.Text = getgenv().AutoCol and "Auto-Col: ON" or "Auto-Col: OFF"
    
    task.spawn(function()
        while getgenv().AutoCol do
            -- Look for Brainrots on the conveyor or dropped
            for _, item in pairs(workspace:GetChildren()) do
                if item:FindFirstChild("TouchInterest") and (item.Name:find("Brainrot") or item.Name:find("Item")) then
                    firetouchinterest(Player.Character.HumanoidRootPart, item, 0)
                    firetouchinterest(Player.Character.HumanoidRootPart, item, 1)
                end
            end
            task.wait(0.5) -- Half-second delay so the server doesn't kick you
        end
    end)
end)
