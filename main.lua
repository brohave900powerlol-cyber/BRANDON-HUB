-- [[ BRANDON HUB: THE REAL FIX ]] --
local P = game:GetService("Players").LocalPlayer
local UIS = game:GetService("UserInputService")

-- 1. NO-KILL SPEED (FASTER & STEALTHY)
getgenv().Speed = 100
task.spawn(function()
    while true do
        local char = P.Character
        local hum = char and char:FindFirstChild("Humanoid")
        local root = char and char:FindFirstChild("HumanoidRootPart")
        
        if hum and root then
            -- We use MoveDirection to boost speed so the game doesn't 'Kill' you
            if hum.MoveDirection.Magnitude > 0 then
                root.CFrame = root.CFrame + (hum.MoveDirection * (getgenv().Speed / 50))
            end
        end
        task.wait() -- Fast loop for smooth speed
    end
end)

-- 2. NO-KILL INF JUMP (CFrame Method)
UIS.JumpRequest:Connect(function()
    local root = P.Character and P.Character:FindFirstChild("HumanoidRootPart")
    if root then
        -- This pushes you up safely instead of changing state (which kills you)
        root.Velocity = Vector3.new(root.Velocity.X, 50, root.Velocity.Z)
    end
end)

-- 3. AUTO-GRAB (DEEP SCANNER)
task.spawn(function()
    while true do
        -- Scans EVERYTHING for Brainrots or collectables
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("TouchInterest") and v.Parent then
                local item = v.Parent
                -- Only grab if it's within a reasonable distance to prevent lag/detection
                if P.Character and P.Character:FindFirstChild("HumanoidRootPart") then
                    local dist = (P.Character.HumanoidRootPart.Position - (item:IsA("Model") and item:GetModelCFrame().p or item.Position)).Magnitude
                    if dist < 50 then -- Only vacuums items within 50 studs
                        firetouchinterest(P.Character.HumanoidRootPart, item, 0)
                        firetouchinterest(P.Character.HumanoidRootPart, item, 1)
                    end
                end
            end
        end
        task.wait(0.2)
    end
end)

print("BRANDON HUB: Speed, Inf Jump, and Auto-Grab are ACTIVE")
