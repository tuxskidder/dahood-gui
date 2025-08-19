-- ===============================================
-- TUX'S IMPROVED GAG MENU - STABLE VERSION
-- Universal & Lightweight
-- ===============================================

-- Load Rayfield with better error handling
local Rayfield
local success = pcall(function()
    Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
end)

if not success then
    warn("Failed to load Rayfield UI")
    return
end

-- ===============================================
-- CORE SERVICES
-- ===============================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

-- Player Variables
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

-- Get character safely
local function getCharacter()
    return Player.Character or Player.CharacterAdded:Wait()
end

local function getHumanoid()
    local char = getCharacter()
    return char:WaitForChild("Humanoid")
end

local function getRootPart()
    local char = getCharacter()
    return char:WaitForChild("HumanoidRootPart")
end

-- ===============================================
-- STATE MANAGEMENT
-- ===============================================
local States = {
    flying = false,
    noclip = false,
    walkspeed = 16,
    jumppower = 50,
    godmode = false,
    esp = false,
    fullbright = false
}

-- Connection storage
local Connections = {}

-- ===============================================
-- UTILITY FUNCTIONS
-- ===============================================
local function notify(title, text, duration)
    Rayfield:Notify({
        Title = title or "TUX GAG",
        Content = text or "Action completed",
        Duration = duration or 3,
        Image = 4483362458
    })
end

local function safeExecute(func)
    local success, error = pcall(func)
    if not success then
        warn("Error: " .. tostring(error))
    end
    return success
end

-- ===============================================
-- CREATE MAIN WINDOW
-- ===============================================
local Window = Rayfield:CreateWindow({
    Name = "🎯 TUX GAG MENU",
    LoadingTitle = "Loading TUX GAG...",
    LoadingSubtitle = "Made by TUX",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "TuxGag",
        FileName = "Config"
    },
    KeySystem = false
})

notify("✅ Loaded!", "TUX GAG Menu loaded successfully", 3)

-- ===============================================
-- MOVEMENT TAB
-- ===============================================
local MovementTab = Window:CreateTab("🚀 Movement", 4483362458)

-- Flight System
local FlightSection = MovementTab:CreateSection("✈️ Flight")

local flySpeed = 50
local flyBodyVelocity = nil
local flyBodyGyro = nil

local function enableFlight()
    safeExecute(function()
        local rootPart = getRootPart()
        
        -- Create flight components
        flyBodyVelocity = Instance.new("BodyVelocity")
        flyBodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
        flyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
        flyBodyVelocity.Parent = rootPart
        
        flyBodyGyro = Instance.new("BodyGyro")
        flyBodyGyro.MaxTorque = Vector3.new(4000, 4000, 4000)
        flyBodyGyro.CFrame = rootPart.CFrame
        flyBodyGyro.Parent = rootPart
        
        -- Flight controls
        Connections.FlightLoop = RunService.Heartbeat:Connect(function()
            if not States.flying then return end
            
            local camera = Workspace.CurrentCamera
            local direction = Vector3.new()
            
            -- WASD movement
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                direction = direction + camera.CFrame.LookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                direction = direction - camera.CFrame.LookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                direction = direction - camera.CFrame.RightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                direction = direction + camera.CFrame.RightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                direction = direction + Vector3.new(0, 1, 0)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                direction = direction - Vector3.new(0, 1, 0)
            end
            
            if flyBodyVelocity then
                flyBodyVelocity.Velocity = direction * flySpeed
            end
            if flyBodyGyro then
                flyBodyGyro.CFrame = camera.CFrame
            end
        end)
    end)
end

local function disableFlight()
    safeExecute(function()
        if Connections.FlightLoop then
            Connections.FlightLoop:Disconnect()
            Connections.FlightLoop = nil
        end
        
        if flyBodyVelocity then
            flyBodyVelocity:Destroy()
            flyBodyVelocity = nil
        end
        if flyBodyGyro then
            flyBodyGyro:Destroy()
            flyBodyGyro = nil
        end
    end)
end

FlightSection:CreateToggle({
    Name = "✈️ Flight",
    CurrentValue = false,
    Flag = "FlightToggle",
    Callback = function(Value)
        States.flying = Value
        if Value then
            enableFlight()
            notify("Flight", "Flight enabled", 2)
        else
            disableFlight()
            notify("Flight", "Flight disabled", 2)
        end
    end
})

FlightSection:CreateSlider({
    Name = "Flight Speed",
    Range = {10, 200},
    Increment = 5,
    Suffix = "Speed",
    CurrentValue = 50,
    Flag = "FlightSpeed",
    Callback = function(Value)
        flySpeed = Value
    end
})

-- Noclip
local PhysicsSection = MovementTab:CreateSection("👻 Physics")

local function toggleNoclip(enabled)
    safeExecute(function()
        local char = getCharacter()
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = not enabled
            end
        end
    end)
end

PhysicsSection:CreateToggle({
    Name = "👻 Noclip",
    CurrentValue = false,
    Flag = "NoclipToggle",
    Callback = function(Value)
        States.noclip = Value
        
        if Connections.NoclipLoop then
            Connections.NoclipLoop:Disconnect()
        end
        
        if Value then
            Connections.NoclipLoop = RunService.Stepped:Connect(function()
                toggleNoclip(true)
            end)
            notify("Noclip", "Noclip enabled", 2)
        else
            toggleNoclip(false)
            notify("Noclip", "Noclip disabled", 2)
        end
    end
})

-- Character Stats
local StatsSection = MovementTab:CreateSection("⚡ Stats")

StatsSection:CreateSlider({
    Name = "Walk Speed",
    Range = {16, 300},
    Increment = 1,
    Suffix = "WS",
    CurrentValue = 16,
    Flag = "WalkSpeed",
    Callback = function(Value)
        States.walkspeed = Value
        safeExecute(function()
            getHumanoid().WalkSpeed = Value
        end)
    end
})

StatsSection:CreateSlider({
    Name = "Jump Power",
    Range = {50, 300},
    Increment = 5,
    Suffix = "JP",
    CurrentValue = 50,
    Flag = "JumpPower",
    Callback = function(Value)
        States.jumppower = Value
        safeExecute(function()
            getHumanoid().JumpPower = Value
        end)
    end
})

StatsSection:CreateToggle({
    Name = "⚡ God Mode",
    CurrentValue = false,
    Flag = "GodMode",
    Callback = function(Value)
        States.godmode = Value
        safeExecute(function()
            local humanoid = getHumanoid()
            if Value then
                humanoid.MaxHealth = math.huge
                humanoid.Health = math.huge
            else
                humanoid.MaxHealth = 100
                humanoid.Health = 100
            end
        end)
        notify("God Mode", Value and "Enabled" or "Disabled", 2)
    end
})

-- ===============================================
-- VISUALS TAB
-- ===============================================
local VisualsTab = Window:CreateTab("👁️ Visuals", 4483362458)

-- ESP System
local ESPSection = VisualsTab:CreateSection("👥 ESP")
local ESPObjects = {}

local function createPlayerESP(player)
    if player == Player or not player.Character then return end
    
    safeExecute(function()
        local char = player.Character
        local rootPart = char:FindFirstChild("HumanoidRootPart")
        if not rootPart then return end
        
        -- Create highlight
        local highlight = Instance.new("Highlight")
        highlight.Name = "TuxESP"
        highlight.FillColor = Color3.fromRGB(255, 100, 100)
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        highlight.FillTransparency = 0.6
        highlight.OutlineTransparency = 0
        highlight.Parent = char
        
        ESPObjects[player] = highlight
    end)
end

local function removePlayerESP(player)
    if ESPObjects[player] then
        safeExecute(function()
            ESPObjects[player]:Destroy()
            ESPObjects[player] = nil
        end)
    end
end

ESPSection:CreateToggle({
    Name = "👥 Player ESP",
    CurrentValue = false,
    Flag = "PlayerESP",
    Callback = function(Value)
        States.esp = Value
        
        if Value then
            -- Create ESP for existing players
            for _, player in pairs(Players:GetPlayers()) do
                createPlayerESP(player)
            end
            
            -- Handle new players
            Connections.PlayerAdded = Players.PlayerAdded:Connect(function(player)
                player.CharacterAdded:Connect(function()
                    wait(1)
                    if States.esp then
                        createPlayerESP(player)
                    end
                end)
            end)
            
            notify("ESP", "Player ESP enabled", 2)
        else
            -- Remove all ESP
            for player, _ in pairs(ESPObjects) do
                removePlayerESP(player)
            end
            
            if Connections.PlayerAdded then
                Connections.PlayerAdded:Disconnect()
            end
            notify("ESP", "Player ESP disabled", 2)
        end
    end
})

-- Fullbright
local LightingSection = VisualsTab:CreateSection("💡 Lighting")

LightingSection:CreateToggle({
    Name = "💡 Fullbright",
    CurrentValue = false,
    Flag = "Fullbright",
    Callback = function(Value)
        States.fullbright = Value
        safeExecute(function()
            if Value then
                Lighting.Brightness = 2
                Lighting.ClockTime = 14
                Lighting.FogEnd = 100000
            else
                Lighting.Brightness = 1
                Lighting.ClockTime = 8
                Lighting.FogEnd = 100000
            end
        end)
        notify("Fullbright", Value and "Enabled" or "Disabled", 2)
    end
})

-- ===============================================
-- TELEPORTS TAB
-- ===============================================
local TeleportsTab = Window:CreateTab("🌎 Teleports", 4483362458)

local TeleportSection = TeleportsTab:CreateSection("📍 Quick Teleports")

local function teleportTo(position)
    safeExecute(function()
        getRootPart().CFrame = CFrame.new(position)
    end)
end

-- Predefined teleports
local teleportLocations = {
    ["🏠 Spawn"] = Vector3.new(0, 10, 0),
    ["☁️ Sky"] = Vector3.new(0, 1000, 0),
    ["🌊 Water"] = Vector3.new(0, 0, 0)
}

for name, pos in pairs(teleportLocations) do
    TeleportSection:CreateButton({
        Name = name,
        Callback = function()
            teleportTo(pos)
            notify("Teleport", "Teleported to " .. name, 2)
        end
    })
end

-- Player teleports
local PlayerTeleportSection = TeleportsTab:CreateSection("👥 Player Teleports")

local function getPlayerNames()
    local names = {}
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= Player then
            table.insert(names, player.Name)
        end
    end
    return names
end

local playerNames = getPlayerNames()
if #playerNames > 0 then
    local selectedPlayer = playerNames[1]
    
    PlayerTeleportSection:CreateDropdown({
        Name = "Select Player",
        Options = playerNames,
        CurrentOption = playerNames[1],
        Flag = "PlayerTeleport",
        Callback = function(Option)
            selectedPlayer = Option
        end
    })
    
    PlayerTeleportSection:CreateButton({
        Name = "🚀 Teleport to Player",
        Callback = function()
            local targetPlayer = Players:FindFirstChild(selectedPlayer)
            if targetPlayer and targetPlayer.Character then
                safeExecute(function()
                    local targetRoot = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if targetRoot then
                        teleportTo(targetRoot.Position + Vector3.new(5, 0, 5))
                        notify("Teleport", "Teleported to " .. selectedPlayer, 2)
                    end
                end)
            end
        end
    })
end

-- ===============================================
-- MISC TAB
-- ===============================================
local MiscTab = Window:CreateTab("🔧 Misc", 4483362458)

-- Utilities
local UtilsSection = MiscTab:CreateSection("🛠️ Utilities")

UtilsSection:CreateButton({
    Name = "🔄 Rejoin Server",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, Player)
    end
})

-- Anti-AFK
local AntiAFKSection = MiscTab:CreateSection("⏰ Anti-AFK")

AntiAFKSection:CreateToggle({
    Name = "⏰ Anti-AFK",
    CurrentValue = false,
    Flag = "AntiAFK",
    Callback = function(Value)
        if Connections.AntiAFK then
            Connections.AntiAFK:Disconnect()
        end
        
        if Value then
            Connections.AntiAFK = RunService.Heartbeat:Connect(function()
                safeExecute(function()
                    game:GetService("VirtualUser"):CaptureController()
                    game:GetService("VirtualUser"):ClickButton2(Vector2.new())
                end)
            end)
            notify("Anti-AFK", "Anti-AFK enabled", 2)
        else
            notify("Anti-AFK", "Anti-AFK disabled", 2)
        end
    end
})

-- ===============================================
-- SETTINGS TAB
-- ===============================================
local SettingsTab = Window:CreateTab("⚙️ Settings", 4483362458)

local InfoSection = SettingsTab:CreateSection("ℹ️ Information")

InfoSection:CreateLabel("🎯 TUX GAG MENU")
InfoSection:CreateLabel("📦 Version: 2.0 Stable")
InfoSection:CreateLabel("👨‍💻 Made by TUX")

local ControlsSection = SettingsTab:CreateSection("🎮 Controls")

ControlsSection:CreateLabel("✈️ Flight: WASD + Space/Shift")
ControlsSection:CreateLabel("👻 Noclip: Walk through walls")

local EmergencySection = SettingsTab:CreateSection("🚨 Emergency")

EmergencySection:CreateButton({
    Name = "🛑 Disable All Features",
    Callback = function()
        -- Reset all states
        for key, _ in pairs(States) do
            if type(States[key]) == "boolean" then
                States[key] = false
            elseif key == "walkspeed" then
                States[key] = 16
            elseif key == "jumppower" then
                States[key] = 50
            end
        end
        
        -- Disconnect all connections
        for _, conn in pairs(Connections) do
            if conn then conn:Disconnect() end
        end
        Connections = {}
        
        -- Clean up flight
        disableFlight()
        
        -- Clean up ESP
        for player, _ in pairs(ESPObjects) do
            removePlayerESP(player)
        end
        
        -- Reset character stats
        safeExecute(function()
            local humanoid = getHumanoid()
            humanoid.WalkSpeed = 16
            humanoid.JumpPower = 50
            humanoid.MaxHealth = 100
            humanoid.Health = 100
        end)
        
        -- Reset lighting
        safeExecute(function()
            Lighting.Brightness = 1
            Lighting.ClockTime = 8
            Lighting.FogEnd = 100000
        end)
        
        notify("🛑 Emergency Stop", "All features disabled!", 3)
    end
})

-- ===============================================
-- CHARACTER RESPAWN HANDLING
-- ===============================================
Player.CharacterAdded:Connect(function()
    wait(2) -- Wait for character to load
    
    safeExecute(function()
        local humanoid = getHumanoid()
        humanoid.WalkSpeed = States.walkspeed
        humanoid.JumpPower = States.jumppower
        
        if States.godmode then
            humanoid.MaxHealth = math.huge
            humanoid.Health = math.huge
        end
    end)
    
    notify("Respawned", "Settings restored after respawn", 2)
end)

-- ===============================================
-- FINAL INITIALIZATION
-- ===============================================
print("🎯 TUX GAG MENU v2.0 Stable - Loaded Successfully!")
notify("🎉 Ready!", "All features loaded and ready to use!", 4)
