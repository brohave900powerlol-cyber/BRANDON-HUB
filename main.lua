-- BRANDON HUB: REBUILT FOR CHROMEBOOK 2026
local P = game:GetService("Players").LocalPlayer
local Character = P.Character or P.CharacterAdded:Wait()

-- 1. STABLE SPEED (GOD MODE)
getgenv().Speed = 100
task.spawn(function()
    while true do
        if P.Character and P.Character:FindFirstChild("Humanoid") then
            P.Character.Humanoid.WalkSpeed = getgenv().Speed
        end
        task.wait(0.5) -- Slower check = No crashing
    end
end)

-- 2. INF JUMP (ALWAYS ACTIVE)
game:GetService("UserInputService").JumpRequest:Connect(function()
    P.Character.Humanoid:ChangeState("Jumping")
end)

-- 3. AUTO-GRAB (SMART SCANNER)
-- This version looks inside Folders, which is why the old one "didn't work"
task.spawn(function()
    while true do
        -- Scans workspace AND folders for items
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("TouchInterest") and v.Parent:IsA("Model") then
                firetouchinterest(P.Character.HumanoidRootPart, v.Parent, 0)
                task.wait()
                firetouchinterest(P.Character.HumanoidRootPart, v.Parent, 1)
            end
        end
        task.wait(1) -- Set to 1 second so your Chromebook doesn't lag
    end
end)

print("BRANDON HUB LOADED SUCCESSFULLY")
