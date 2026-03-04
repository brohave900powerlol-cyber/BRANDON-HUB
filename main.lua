-- [[ BRANDON HUB: STEALTH EDITION ]] --
local P = game:GetService("Players").LocalPlayer
local UIS = game:GetService("UserInputService")

-- 1. NO-KILL STEALTH SPEED
-- We don't touch WalkSpeed (which kills you). We nudge your position.
getgenv().Speed = 1.5 -- Set this between 1 and 3 for God Speed
task.spawn(function()
    while true do
        local char = P.Character
        local hum = char and char:FindFirstChild("Humanoid")
        local root = char and char:FindFirstChild("HumanoidRootPart")
        
        if hum and root and hum.MoveDirection.Magnitude > 0 then
            -- Moves you forward based on where you are looking
            root.CFrame = root.CFrame + (hum.MoveDirection * getgenv().Speed)
        end
        task.wait() -- High-speed loop
    end
end)

-- 2. NO-KILL INF JUMP
-- Instead of 'Jumping' state (which kills), we apply a physics bump
UIS.JumpRequest:Connect(function()
    local root = P.Character and P.Character:FindFirstChild("HumanoidRootPart")
    if root then
        -- This is a safe velocity boost that doesn't trigger the death script
        root.Velocity = Vector3.new(root.Velocity.X, 60, root.Velocity.Z)
    end
end)

-- 3. AUTO-GRAB (PROXIMITY VACUUM)
-- This version searches folders deeper to find hidden items
task.spawn(function()
    while true do
        for _, v in pairs(workspace:GetDescendants()) do
            -- Looks for 'TouchInterest' which is what handles item pickups
            if v:IsA("TouchInterest") and v.Parent then
                local item = v.Parent
                if P.Character and P.Character:FindFirstChild("HumanoidRootPart") then
                    -- Only grabs items close to you to prevent the server from lagging
                    local rootPos = P.Character.HumanoidRootPart.Position
                    local itemPos = item:IsA("Model") and item:GetModelCFrame().p or item.Position
                    
                    if (rootPos - itemPos).Magnitude < 60 then
                        firetouchinterest(P.Character.HumanoidRootPart, item, 0)
                        firetouchinterest(P.Character.HumanoidRootPart, item, 1)
                    end
                end
            end
        end
        task.wait(0.3)
    end
end)

print("BRANDON HUB: Stealth Mode Activated")
