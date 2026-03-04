-- [[ BRANDON HUB: NO-KILL FINAL ]] --
local P = game:GetService("Players").LocalPlayer
local UIS = game:GetService("UserInputService")

-- 1. VELOCITY SPEED (No-Kill Bypass)
-- This is set to a "God Speed" that shouldn't trigger the death script
getgenv().SpeedValue = 90 
task.spawn(function()
    while true do
        local char = P.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChild("Humanoid")

        if root and hum and hum.MoveDirection.Magnitude > 0 then
            -- We push your physics forward instead of teleporting you
            root.Velocity = Vector3.new(hum.MoveDirection.X * getgenv().SpeedValue, root.Velocity.Y, hum.MoveDirection.Z * getgenv().SpeedValue)
        end
        task.wait()
    end
end)

-- 2. FLOAT JUMP (No-Kill Inf Jump)
-- Instead of a 'Jump' state, we just give you a vertical lift
UIS.JumpRequest:Connect(function()
    local root = P.Character and P.Character:FindFirstChild("HumanoidRootPart")
    if root then
        root.Velocity = Vector3.new(root.Velocity.X, 55, root.Velocity.Z)
    end
end)

-- 3. INSTA-GRAB (RE-CODED)
-- Steal a Brainrot puts items in 'workspace.Dropped' or 'workspace.Items'
task.spawn(function()
    while true do
        for _, v in pairs(workspace:GetDescendants()) do
            -- Look for things players can touch
            if v:IsA("TouchInterest") and v.Parent then
                local item = v.Parent
                if P.Character and P.Character:FindFirstChild("HumanoidRootPart") then
                    -- Grabs items within a large radius
                    firetouchinterest(P.Character.HumanoidRootPart, item, 0)
                    firetouchinterest(P.Character.HumanoidRootPart, item, 1)
                end
            end
        end
        task.wait(0.3) -- Fast enough to steal, slow enough for Chromebooks
    end
end)

print("BRANDON HUB: Physics Bypass Loaded!")
