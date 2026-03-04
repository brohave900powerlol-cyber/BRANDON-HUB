-- BRANDON-HUB VISUAL PETS (CHROMEBOOK SAFE)
local Player = game:GetService("Players").LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()

-- Set the name of the pet you WANT to see
local DesiredPet = "Shadow Dragon" 

local function MakeVisual()
    -- Look for your current equipped pet
    for _, v in pairs(workspace:GetChildren()) do
        -- Adopt Me pets usually follow the player in a folder or model
        if v:IsA("Model") and v:FindFirstChild("PetID") then
            if v.Name ~= DesiredPet then
                print("Changing Visual to: " .. DesiredPet)
                v.Name = DesiredPet
                -- This changes the label above the pet
                if v:FindFirstChild("Head") and v.Head:FindFirstChild("Nametag") then
                    v.Head.Nametag.Label.Text = DesiredPet
                end
            end
        end
    end
end

-- Run it once, then keep checking every 5 seconds so it doesn't lag Delta
task.spawn(function()
    while true do
        task.wait(5) 
        pcall(MakeVisual)
    end
end)
