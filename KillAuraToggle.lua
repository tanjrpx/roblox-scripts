-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer

-- ====== GUI ======
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DungeonHeroesGUI"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 250, 0, 200)
Frame.Position = UDim2.new(0, 20, 0, 120)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

local function createToggle(name, posY)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 130, 0, 30)
    label.Position = UDim2.new(0, 10, 0, posY)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.new(1,1,1)
    label.Font = Enum.Font.SourceSansBold
    label.TextSize = 18
    label.Text = name
    label.Parent = Frame

    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 80, 0, 30)
    button.Position = UDim2.new(0, 160, 0, posY)
    button.BackgroundColor3 = Color3.fromRGB(0,170,0)
    button.TextColor3 = Color3.new(1,1,1)
    button.Font = Enum.Font.SourceSansBold
    button.TextSize = 18
    button.Text = "OFF"
    button.Parent = Frame

    return button
end

local killAuraBtn = createToggle("Kill Aura", 10)
local autoDungeonBtn = createToggle("Auto Dungeon", 50)
local autoSellBtn = createToggle("Auto Sell", 90)
local autoReplayBtn = createToggle("Auto Replay", 130)
local autoSkipRewardBtn = createToggle("Skip Reward", 170)

-- ====== Variables ======
local killAuraOn = false
local autoDungeonOn = false
local autoSellOn = false
local autoReplayOn = false
local autoSkipRewardOn = false

local killAuraRadius = 15

-- ====== Toggle Button Logic ======
local function toggleButton(button, stateVarName)
    local currentState = _G[stateVarName]
    _G[stateVarName] = not currentState
    if _G[stateVarName] then
        button.Text = "ON"
        button.BackgroundColor3 = Color3.fromRGB(170,0,0)
    else
        button.Text = "OFF"
        button.BackgroundColor3 = Color3.fromRGB(0,170,0)
    end
end

killAuraBtn.MouseButton1Click:Connect(function()
    toggleButton(killAuraBtn, "killAuraOn")
end)

autoDungeonBtn.MouseButton1Click:Connect(function()
    toggleButton(autoDungeonBtn, "autoDungeonOn")
end)

autoSellBtn.MouseButton1Click:Connect(function()
    toggleButton(autoSellBtn, "autoSellOn")
end)

autoReplayBtn.MouseButton1Click:Connect(function()
    toggleButton(autoReplayBtn, "autoReplayOn")
end)

autoSkipRewardBtn.MouseButton1Click:Connect(function()
    toggleButton(autoSkipRewardBtn, "autoSkipRewardOn")
end)

-- ====== Core Functions ======

-- Kill Aura Function
local function doKillAura()
    local character = LocalPlayer.Character
    if not character then return end
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local humanoid = player.Character:FindFirstChild("Humanoid")
            local enemyHRP = player.Character:FindFirstChild("HumanoidRootPart")
            if humanoid and enemyHRP and humanoid.Health > 0 then
                local distance = (enemyHRP.Position - hrp.Position).Magnitude
                if distance <= killAuraRadius then
                    humanoid.Health = 0 -- ฆ่าศัตรู
                end
            end
        end
    end
end

-- Auto Dungeon Function (ตัวอย่างส่งคำสั่งเล่นดันเจี้ยน)
local function doAutoDungeon()
    -- ตัวอย่างใช้ RemoteEvent/Function ที่เหมาะสมกับเกมจริง
    -- สมมติชื่อ RemoteEvent ว่า "StartDungeon"
    local remote = ReplicatedStorage:FindFirstChild("StartDungeon")
    if remote and remote:IsA("RemoteEvent") then
        remote:FireServer()
    end
end

-- Auto Sell Function (ตัวอย่างส่งคำสั่งขายของ)
local function doAutoSell()
    -- สมมติ RemoteEvent ชื่อ "SellItems"
    local remote = ReplicatedStorage:FindFirstChild("SellItems")
    if remote and remote:IsA("RemoteEvent") then
        remote:FireServer()
    end
end

-- Auto Replay Function (ตัวอย่างส่งคำสั่งเล่นซ้ำดันเจี้ยน)
local function doAutoReplay()
    -- สมมติ RemoteEvent ชื่อ "ReplayDungeon"
    local remote = ReplicatedStorage:FindFirstChild("ReplayDungeon")
    if remote and remote:IsA("RemoteEvent") then
        remote:FireServer()
    end
end

-- Auto Skip Reward Function (ตัวอย่างกดข้ามหน้าต่างรางวัล)
local function doSkipReward()
    -- สมมติ RemoteEvent ชื่อ "SkipReward"
    local remote = ReplicatedStorage:FindFirstChild("SkipReward")
    if remote and remote:IsA("RemoteEvent") then
        remote:FireServer()
    end
end

-- ====== Main Loop ======
RunService.Heartbeat:Connect(function()
    if killAuraOn then
        doKillAura()
    end

    if autoDungeonOn then
        doAutoDungeon()
    end

    if autoSellOn then
        doAutoSell()
    end

    if autoReplayOn then
        doAutoReplay()
    end

    if autoSkipRewardOn then
        doSkipReward()
    end
end)
