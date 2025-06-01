-- KillAuraToggle.lua
-- สคริปต์นี้สามารถอัปโหลดขึ้น GitHub ได้เลย

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local auraOn = false
local radius = 10

-- เปิด/ปิดด้วยปุ่ม Q
UIS.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.Q then
		auraOn = not auraOn
		print("Kill Aura: " .. (auraOn and "เปิด" or "ปิด"))
	end
end)

-- วนตรวจจับรอบตัว
RunService.RenderStepped:Connect(function()
	if not auraOn then return end

	for _, enemy in pairs(Players:GetPlayers()) do
		if enemy ~= LocalPlayer and enemy.Character and enemy.Character:FindFirstChild("Humanoid") then
			local dist = (enemy.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
			if dist <= radius then
				enemy.Character.Humanoid.Health = 0 -- สั่งฆ่า
			end
		end
	end
end)
