-- BRANDON-HUB: Speed, Insta-Grab, & Lag Fix
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ProximityPromptService = game:GetService("ProximityPromptService")
local Lighting = game:GetService("Lighting")
local lp = Players.LocalPlayer

-- 1. FPS BOOSTER (No Lag)
-- This removes shadows, blurs, and fancy textures to increase your FPS
local function Optimize()
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 9e9
    settings().Rendering.QualityLevel = 1
    
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("Part") or v:IsA("UnionOperation") or v:IsA("MeshPart") then
            v.Material = Enum.Material.Plastic
            v.Reflectance = 0
        elseif v:IsA("Decal") or v:IsA("Texture") then
            v:Destroy()
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
            v.Enabled = false
        end
    end
end
Optimize()

-- 2. SPEED HACK (Set to 50)
RunService.Heartbeat:Connect(function()
    if lp.Character and lp.Character:FindFirstChild("Humanoid") then
        lp.Character.Humanoid.WalkSpeed = 50 
    end
end)

-- 3. INSTA-GRAB
ProximityPromptService.PromptButtonHoldBegan:Connect(function(prompt)
    fireproximityprompt(prompt)
end)

-- Success Notification
game.StarterGui:SetCore("SendNotification", {
    Title = "BRANDON-HUB";
    Text = "Speed, Insta-Grab, & FPS Boosted!";
    Duration = 5;
})
