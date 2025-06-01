local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- สร้าง GUI ใน PlayerGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KillAuraGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") -- เปลี่ยนจาก CoreGui มา PlayerGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 150, 0, 60)
Frame.Position = UDim2.new(0, 10, 0, 100)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(1, -20, 0, 30)
ToggleButton.Position = UDim2.new(0, 10, 0, 15)
ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
ToggleButton.TextColor3 = Color3.new(1,1,1)
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.TextSize = 18
ToggleButton.Text = "Kill Aura: OFF"
ToggleButton.Parent = Frame

local auraOn = false
local radius = 10

ToggleButton.MouseButton1Click:Connect(function()
	auraOn = not auraOn
	if auraOn then
		ToggleButton.Text = "Kill Aura: ON"
		ToggleButton.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
	else
		ToggleButton.Text = "Kill Aura: OFF"
		ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
	end
end)

RunService.RenderStepped:Connect(function()
	if not auraOn then return end

	for _, enemy in pairs(Players:GetPlayers()) do
		if enemy ~= LocalPlayer and enemy.Character and enemy.Character:FindFirstChild("Humanoid") and enemy.Character:FindFirstChild("HumanoidRootPart") then
			local dist = (enemy.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
			if dist <= radius then
				enemy.Character.Humanoid.Health = 0
			end
		end
	end
end)
