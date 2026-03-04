local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- VARIABLES
local speedEnabled = false
local noclipEnabled = false
local infJumpEnabled = false

-- GUI
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "BrandonHub"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 200, 0, 150)
frame.Position = UDim2.new(0, 20, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 0

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "Brandon Hub"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundColor3 = Color3.fromRGB(40,40,40)
title.BorderSizePixel = 0

-- BOTON SPEED
local speedBtn = Instance.new("TextButton", frame)
speedBtn.Size = UDim2.new(1, -20, 0, 30)
speedBtn.Position = UDim2.new(0, 10, 0, 40)
speedBtn.Text = "Speed: OFF"

speedBtn.MouseButton1Click:Connect(function()
	speedEnabled = not speedEnabled
	if speedEnabled then
		humanoid.WalkSpeed = 50
		speedBtn.Text = "Speed: ON"
	else
		humanoid.WalkSpeed = 16
		speedBtn.Text = "Speed: OFF"
	end
end)

-- BOTON INF JUMP
local jumpBtn = Instance.new("TextButton", frame)
jumpBtn.Size = UDim2.new(1, -20, 0, 30)
jumpBtn.Position = UDim2.new(0, 10, 0, 75)
jumpBtn.Text = "Inf Jump: OFF"

jumpBtn.MouseButton1Click:Connect(function()
	infJumpEnabled = not infJumpEnabled
	jumpBtn.Text = infJumpEnabled and "Inf Jump: ON" or "Inf Jump: OFF"
end)

game:GetService("UserInputService").JumpRequest:Connect(function()
	if infJumpEnabled then
		humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)

-- BOTON NOCLIP
local noclipBtn = Instance.new("TextButton", frame)
noclipBtn.Size = UDim2.new(1, -20, 0, 30)
noclipBtn.Position = UDim2.new(0, 10, 0, 110)
noclipBtn.Text = "Noclip: OFF"

noclipBtn.MouseButton1Click:Connect(function()
	noclipEnabled = not noclipEnabled
	noclipBtn.Text = noclipEnabled and "Noclip: ON" or "Noclip: OFF"
end)

game:GetService("RunService").Stepped:Connect(function()
	if noclipEnabled then
		for _, part in pairs(character:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CanCollide = false
			end
		end
	end
end)
