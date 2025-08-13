-- ╔═══════════════════════════════════════════════════════════════════════╗
-- ║                        TUX'S FREE KEYLESS M3NU                        ║
-- ║                             ADMIN PANEL                               ║
-- ║                            Version 1.9.5.                             ║
-- ║                         Made by Tux Da Modder                         ║
-- ╚═══════════════════════════════════════════════════════════════════════╝

-- Import Rayfield UI library with error handling
local success, Rayfield = pcall(function()
    return loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/master/source'))()
end)

if not success then
    warn("Failed to load Rayfield UI library!")
    return
end

-- ╔═══════════════════════════════════════════════════════════════════════╗
-- ║                           SERVICES                                    ║
-- ╚═══════════════════════════════════════════════════════════════════════╝

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local MarketplaceService = game:GetService("MarketplaceService")
local TeleportService = game:GetService("TeleportService")
local SoundService = game:GetService("SoundService")
local Lighting = game:GetService("Lighting")
local Teams = game:GetService("Teams")
local VirtualInputManager = game:GetService("VirtualInputManager")

-- ╔═══════════════════════════════════════════════════════════════════════╗
-- ║                          VARIABLES                                    ║
-- ╚═══════════════════════════════════════════════════════════════════════╝

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

-- Connection management
local connections = {}
local heartbeatConnections = {}
local renderSteppedConnections = {}

-- Movement variables
local flySpeed = 50
local walkSpeed = 16
local jumpPower = 50
local swimSpeed = 16
local hipHeight = 0

-- Visual variables
local espEnabled = false
local espColor = Color3.fromRGB(255, 0, 0)
local chamsEnabled = false
local tracersEnabled = false
local nameTagsEnabled = false

-- Combat variables
local aimbotEnabled = false
local aimbotFOV = 100
local aimbotSmoothness = 1
local triggerBotEnabled = false
local killAuraEnabled = false
local autoClickerEnabled = false
local clickSpeed = 10

-- Misc variables
local antiAfkEnabled = false
local autoRespawnEnabled = false
local chatSpamEnabled = false
local spamMessage = "Tux's FREE Menu is the best!"
local spamDelay = 1

-- Teleport positions
local teleportPositions = {}
local currentPosition = nil

-- Player list for targeting
local targetedPlayers = {}
local autoTargetEnabled = false

-- Game detection
local gameId = game.PlaceId
local gameName = ""

-- Performance monitoring
local fpsCounter = 0
local lastFpsUpdate = tick()
local memoryUsage = 0

-- ╔═══════════════════════════════════════════════════════════════════════╗
-- ║                       UTILITY FUNCTIONS                               ║
-- ╚═══════════════════════════════════════════════════════════════════════╝

-- Function to get character safely
local function getCharacter()
    return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
end

-- Function to get humanoid safely
local function getHumanoid()
    local character = getCharacter()
    return character and character:FindFirstChild("Humanoid")
end

-- Function to get root part safely
local function getRootPart()
    local character = getCharacter()
    return character and character:FindFirstChild("HumanoidRootPart")
end

-- Function to get head safely
local function getHead()
    local character = getCharacter()
    return character and character:FindFirstChild("Head")
end

-- Function to check if player is alive
local function isAlive(player)
    player = player or LocalPlayer
    local character = player.Character
    if not character then return false end
    local humanoid = character:FindFirstChild("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    return humanoid and rootPart and humanoid.Health > 0
end

-- Function to get closest player
local function getClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = math.huge
    local rootPart = getRootPart()
    
    if not rootPart then return nil end
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and isAlive(player) then
            local playerRootPart = player.Character:FindFirstChild("HumanoidRootPart")
            if playerRootPart then
                local distance = (rootPart.Position - playerRootPart.Position).Magnitude
                if distance < shortestDistance then
                    shortestDistance = distance
                    closestPlayer = player
                end
            end
        end
    end
    
    return closestPlayer
end

-- Function to get player from mouse position
local function getPlayerFromMouse()
    local target = Mouse.Target
    if target then
        local character = target.Parent
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            return Players:GetPlayerFromCharacter(character)
        end
    end
    return nil
end

-- Function to create notification
local function createNotification(title, content, duration)
    duration = duration or 3
    Rayfield:Notify({
        Title = title,
        Content = content,
        Duration = duration,
        Image = 4483362458
    })
end

-- Function to copy to clipboard safely
local function safeSetClipboard(text)
    local success, error = pcall(function()
        setclipboard(text)
    end)
    if success then
        createNotification("Clipboard", "Text copied successfully!")
    else
        createNotification("Error", "Failed to copy to clipboard: " .. tostring(error))
    end
end

-- Function to play sound
local function playSound(soundId, volume, pitch)
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://" .. tostring(soundId)
    sound.Volume = volume or 0.5
    sound.Pitch = pitch or 1
    sound.Parent = SoundService
    sound:Play()
    
    sound.Ended:Connect(function()
        sound:Destroy()
    end)
end

-- ╔═══════════════════════════════════════════════════════════════════════╗
-- ║                        MAIN WINDOW CREATION                           ║
-- ╚═══════════════════════════════════════════════════════════════════════╝

local Window = Rayfield:CreateWindow({
    Name = "Tux's FREE Menu",
    LoadingTitle = "Loading Tux's FREE Menu...",
    LoadingSubtitle = "by Tux Skidder",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "TuxFreeMenu",
        FileName = "TuxConfig"
    },
    Discord = {
        Enabled = true,
        Invite = "4F7rMQtGhe",
        RememberJoins = true
    },
    KeySystem = false
})

-- ╔═══════════════════════════════════════════════════════════════════════╗
-- ║                           MAIN TAB                                    ║
-- ╚═══════════════════════════════════════════════════════════════════════╝

local MainTab = Window:CreateTab("🏠 Main", 4483362458)

-- Welcome Section
local WelcomeSection = MainTab:CreateSection("Welcome to Tux's FREE Menu!")

local WelcomeLabel = MainTab:CreateLabel("Version 2.0.0 - Advanced Script Hub")

-- Game Info Section
local GameInfoSection = MainTab:CreateSection("Game Information")

-- Get game info
pcall(function()
    gameName = MarketplaceService:GetProductInfo(gameId).Name
end)

local GameNameLabel = MainTab:CreateLabel("Game: " .. (gameName ~= "" and gameName or "Unknown Game"))
local GameIdLabel = MainTab:CreateLabel("Place ID: " .. tostring(gameId))
local PlayersLabel = MainTab:CreateLabel("Players: " .. tostring(#Players:GetPlayers()) .. "/" .. tostring(Players.MaxPlayers))

-- Performance Section
local PerformanceSection = MainTab:CreateSection("Performance Monitor")

local FpsLabel = MainTab:CreateLabel("FPS: Calculating...")
local MemoryLabel = MainTab:CreateLabel("Memory: Calculating...")

-- Update performance info
spawn(function()
    while true do
        wait(1)
        fpsCounter = fpsCounter + 1
        
        if tick() - lastFpsUpdate >= 1 then
            FpsLabel:Set("FPS: " .. tostring(math.floor(fpsCounter)))
            fpsCounter = 0
            lastFpsUpdate = tick()
            
            -- Update memory usage
            local memStats = game:GetService("Stats")
            if memStats then
                local memory = memStats:GetTotalMemoryUsageMb()
                MemoryLabel:Set("Memory: " .. tostring(math.floor(memory)) .. " MB")
            end
            
            -- Update player count
            PlayersLabel:Set("Players: " .. tostring(#Players:GetPlayers()) .. "/" .. tostring(Players.MaxPlayers))
        end
    end
end)

-- ╔═══════════════════════════════════════════════════════════════════════╗
-- ║                        MOVEMENT TAB                                   ║
-- ╚═══════════════════════════════════════════════════════════════════════╝

local MovementTab = Window:CreateTab("🚀 Movement", 4370318685)

-- Flight Section
local FlightSection = MovementTab:CreateSection("Flight System")

-- Enhanced Fly Toggle
local FlyToggle = MovementTab:CreateToggle({
    Name = "Fly Mode",
    CurrentValue = false,
    Flag = "fly_toggle",
    Callback = function(Value)
        if Value then
            local character = getCharacter()
            local rootPart = getRootPart()
            local humanoid = getHumanoid()
            
            if not rootPart or not humanoid then
                createNotification("Error", "Character not found!")
                return
            end
            
            -- Create fly objects
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.Velocity = Vector3.new(0, 0, 0)
            bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
            bodyVelocity.Parent = rootPart
            
            local bodyAngularVelocity = Instance.new("BodyAngularVelocity")
            bodyAngularVelocity.AngularVelocity = Vector3.new(0, 0, 0)
            bodyAngularVelocity.MaxTorque = Vector3.new(0, 4000, 0)
            bodyAngularVelocity.Parent = rootPart
            
            -- Fly control loop
            connections.fly = RunService.RenderStepped:Connect(function()
                local moveVector = humanoid.MoveDirection * flySpeed
                local cameraDirection = Camera.CFrame.LookVector
                local rightVector = Camera.CFrame.RightVector
                
                bodyVelocity.Velocity = Vector3.new(moveVector.X, 0, moveVector.Z)
                
                -- Vertical movement
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                    bodyVelocity.Velocity = bodyVelocity.Velocity + Vector3.new(0, flySpeed, 0)
                elseif UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or UserInputService:IsKeyDown(Enum.KeyCode.RightShift) then
                    bodyVelocity.Velocity = bodyVelocity.Velocity - Vector3.new(0, flySpeed, 0)
                end
                
                -- Camera-relative movement
                if UserInputService:IsKeyDown(Enum.KeyCode.Q) then
                    bodyVelocity.Velocity = bodyVelocity.Velocity + (rightVector * flySpeed)
                elseif UserInputService:IsKeyDown(Enum.KeyCode.E) then
                    bodyVelocity.Velocity = bodyVelocity.Velocity - (rightVector * flySpeed)
                end
            end)
            
            createNotification("Flight", "Fly mode enabled!")
            playSound(131961136, 0.3, 1.2)
        else
            -- Disable fly
            if connections.fly then
                connections.fly:Disconnect()
                connections.fly = nil
            end
            
            local rootPart = getRootPart()
            if rootPart then
                local bodyVelocity = rootPart:FindFirstChild("BodyVelocity")
                local bodyAngularVelocity = rootPart:FindFirstChild("BodyAngularVelocity")
                if bodyVelocity then bodyVelocity:Destroy() end
                if bodyAngularVelocity then bodyAngularVelocity:Destroy() end
            end
            
            createNotification("Flight", "Fly mode disabled!")
        end
    end
})

-- Fly Speed Slider
local FlySpeedSlider = MovementTab:CreateSlider({
    Name = "Fly Speed",
    Range = {1, 1000},
    Increment = 5,
    Suffix = " Speed",
    CurrentValue = 50,
    Flag = "fly_speed",
    Callback = function(Value)
        flySpeed = Value
    end
})

-- Noclip Section
local NoclipSection = MovementTab:CreateSection("Collision Control")

-- Enhanced Noclip Toggle
local NoclipToggle = MovementTab:CreateToggle({
    Name = "Noclip",
    CurrentValue = false,
    Flag = "noclip_toggle",
    Callback = function(Value)
        if Value then
            connections.noclip = RunService.Stepped:Connect(function()
                local character = getCharacter()
                if character then
                    for _, part in pairs(character:GetDescendants()) do
                        if part:IsA("BasePart") and part.CanCollide and part.Name ~= "HumanoidRootPart" then
                            part.CanCollide = false
                        end
                    end
                end
            end)
            createNotification("Noclip", "Noclip enabled!")
        else
            if connections.noclip then
                connections.noclip:Disconnect()
                connections.noclip = nil
            end
            
            local character = getCharacter()
            if character then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                        part.CanCollide = true
                    end
                end
            end
            createNotification("Noclip", "Noclip disabled!")
        end
    end
})

-- Character Enhancement Section
local CharacterSection = MovementTab:CreateSection("Character Enhancements")

-- Walk Speed Slider
local WalkSpeedSlider = MovementTab:CreateSlider({
    Name = "Walk Speed",
    Range = {1, 1000},
    Increment = 5,
    Suffix = " Speed",
    CurrentValue = 16,
    Flag = "walk_speed",
    Callback = function(Value)
        walkSpeed = Value
        local humanoid = getHumanoid()
        if humanoid then
            humanoid.WalkSpeed = Value
        end
    end
})

-- Jump Power Slider
local JumpPowerSlider = MovementTab:CreateSlider({
    Name = "Jump Power",
    Range = {1, 1000},
    Increment = 5,
    Suffix = " Power",
    CurrentValue = 50,
    Flag = "jump_power",
    Callback = function(Value)
        jumpPower = Value
        local humanoid = getHumanoid()
        if humanoid then
            humanoid.JumpPower = Value
        end
    end
})

-- Hip Height Slider
local HipHeightSlider = MovementTab:CreateSlider({
    Name = "Hip Height",
    Range = {0, 100},
    Increment = 1,
    Suffix = " Height",
    CurrentValue = 0,
    Flag = "hip_height",
    Callback = function(Value)
        hipHeight = Value
        local humanoid = getHumanoid()
        if humanoid then
            humanoid.HipHeight = Value
        end
    end
})

-- Infinite Jump Toggle
local InfiniteJumpToggle = MovementTab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Flag = "infinite_jump",
    Callback = function(Value)
        if Value then
            connections.infiniteJump = UserInputService.JumpRequest:Connect(function()
                local humanoid = getHumanoid()
                if humanoid then
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end)
            createNotification("Jump", "Infinite jump enabled!")
        else
            if connections.infiniteJump then
                connections.infiniteJump:Disconnect()
                connections.infiniteJump = nil
            end
            createNotification("Jump", "Infinite jump disabled!")
        end
    end
})

-- Click TP Toggle
local ClickTPToggle = MovementTab:CreateToggle({
    Name = "Click Teleport",
    CurrentValue = false,
    Flag = "click_tp",
    Callback = function(Value)
        if Value then
            connections.clickTP = Mouse.Button1Down:Connect(function()
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
                    local rootPart = getRootPart()
                    if rootPart and Mouse.Hit then
                        rootPart.CFrame = CFrame.new(Mouse.Hit.Position + Vector3.new(0, 5, 0))
                        createNotification("Teleport", "Teleported to clicked position!")
                    end
                end
            end)
            createNotification("Teleport", "Click teleport enabled! Hold CTRL and click to teleport.")
        else
            if connections.clickTP then
                connections.clickTP:Disconnect()
                connections.clickTP = nil
            end
            createNotification("Teleport", "Click teleport disabled!")
        end
    end
})

-- ╔═══════════════════════════════════════════════════════════════════════╗
-- ║                          COMBAT TAB                                   ║
-- ╚═══════════════════════════════════════════════════════════════════════╝

local CombatTab = Window:CreateTab("⚔️ Combat", 4370318826)

-- Aimbot Section
local AimbotSection = CombatTab:CreateSection("Aimbot System")

local AimbotToggle = CombatTab:CreateToggle({
    Name = "Aimbot",
    CurrentValue = false,
    Flag = "aimbot_toggle",
    Callback = function(Value)
        aimbotEnabled = Value
        if Value then
            connections.aimbot = RunService.RenderStepped:Connect(function()
                local closestPlayer = getClosestPlayer()
                if closestPlayer and closestPlayer.Character then
                    local head = closestPlayer.Character:FindFirstChild("Head")
                    if head then
                        local screenPoint = Camera:WorldToScreenPoint(head.Position)
                        local distance = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(screenPoint.X, screenPoint.Y)).Magnitude
                        
                        if distance <= aimbotFOV then
                            local targetPosition = head.Position
                            Camera.CFrame = Camera.CFrame:Lerp(CFrame.lookAt(Camera.CFrame.Position, targetPosition), aimbotSmoothness / 10)
                        end
                    end
                end
            end)
            createNotification("Aimbot", "Aimbot enabled!")
        else
            if connections.aimbot then
                connections.aimbot:Disconnect()
                connections.aimbot = nil
            end
            createNotification("Aimbot", "Aimbot disabled!")
        end
    end
})

local AimbotFOVSlider = CombatTab:CreateSlider({
    Name = "Aimbot FOV",
    Range = {10, 500},
    Increment = 10,
    Suffix = " FOV",
    CurrentValue = 100,
    Flag = "aimbot_fov",
    Callback = function(Value)
        aimbotFOV = Value
    end
})

local AimbotSmoothnessSlider = CombatTab:CreateSlider({
    Name = "Aimbot Smoothness",
    Range = {1, 10},
    Increment = 1,
    Suffix = " Smooth",
    CurrentValue = 1,
    Flag = "aimbot_smoothness",
    Callback = function(Value)
        aimbotSmoothness = Value
    end
})

-- Auto Clicker Section
local AutoClickerSection = CombatTab:CreateSection("Auto Clicker")

local AutoClickerToggle = CombatTab:CreateToggle({
    Name = "Auto Clicker",
    CurrentValue = false,
    Flag = "auto_clicker",
    Callback = function(Value)
        autoClickerEnabled = Value
        if Value then
            connections.autoClicker = RunService.Heartbeat:Connect(function()
                wait(1 / clickSpeed)
                if autoClickerEnabled then
                    Mouse1click()
                end
            end)
            createNotification("Auto Clicker", "Auto clicker enabled!")
        else
            if connections.autoClicker then
                connections.autoClicker:Disconnect()
                connections.autoClicker = nil
            end
            createNotification("Auto Clicker", "Auto clicker disabled!")
        end
    end
})

local ClickSpeedSlider = CombatTab:CreateSlider({
    Name = "Click Speed",
    Range = {1, 100},
    Increment = 1,
    Suffix = " CPS",
    CurrentValue = 10,
    Flag = "click_speed",
    Callback = function(Value)
        clickSpeed = Value
    end
})

-- Trigger Bot Toggle
local TriggerBotToggle = CombatTab:CreateToggle({
    Name = "Trigger Bot",
    CurrentValue = false,
    Flag = "trigger_bot",
    Callback = function(Value)
        triggerBotEnabled = Value
        if Value then
            connections.triggerBot = Mouse.Move:Connect(function()
                local player = getPlayerFromMouse()
                if player and player ~= LocalPlayer then
                    Mouse1click()
                end
            end)
            createNotification("Trigger Bot", "Trigger bot enabled!")
        else
            if connections.triggerBot then
                connections.triggerBot:Disconnect()
                connections.triggerBot = nil
            end
            createNotification("Trigger Bot", "Trigger bot disabled!")
        end
    end
})

-- ╔═══════════════════════════════════════════════════════════════════════╗
-- ║                          VISUAL TAB                                   ║
-- ╚═══════════════════════════════════════════════════════════════════════╝

local VisualTab = Window:CreateTab("👁️ Visual", 4370341699)

-- ESP Section
local ESPSection = VisualTab:CreateSection("ESP Features")

-- Player ESP Toggle
local PlayerESPToggle = VisualTab:CreateToggle({
    Name = "Player ESP",
    CurrentValue = false,
    Flag = "player_esp",
    Callback = function(Value)
        espEnabled = Value
        if Value then
            connections.esp = RunService.RenderStepped:Connect(function()
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character then
                        local character = player.Character
                        local rootPart = character:FindFirstChild("HumanoidRootPart")
                        
                        if rootPart and not character:FindFirstChild("ESP_Highlight") then
                            local highlight = Instance.new("Highlight")
                            highlight.Name = "ESP_Highlight"
                            highlight.FillColor = espColor
                            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                            highlight.FillTransparency = 0.5
                            highlight.OutlineTransparency = 0
                            highlight.Parent = character
                        end
                    end
                end
            end)
            createNotification("ESP", "Player ESP enabled!")
        else
            if connections.esp then
                connections.esp:Disconnect()
                connections.esp = nil
            end
            
            for _, player in pairs(Players:GetPlayers()) do
                if player.Character then
                    local highlight = player.Character:FindFirstChild("ESP_Highlight")
                    if highlight then
                        highlight:Destroy()
                    end
                end
            end
            createNotification("ESP", "Player ESP disabled!")
        end
    end
})

-- Tracers Toggle
local TracersToggle = VisualTab:CreateToggle({
    Name = "Tracers",
    CurrentValue = false,
    Flag = "tracers",
    Callback = function(Value)
        tracersEnabled = Value
        if Value then
            connections.tracers = RunService.RenderStepped:Connect(function()
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character then
                        local character = player.Character
                        local rootPart = character:FindFirstChild("HumanoidRootPart")
                        
                        if rootPart then
                            local screenPoint = Camera:WorldToScreenPoint(rootPart.Position)
                            if not character:FindFirstChild("Tracer") then
                                local tracer = Drawing.new("Line")
                                tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                                tracer.To = Vector2.new(screenPoint.X, screenPoint.Y)
                                tracer.Color = espColor
                                tracer.Thickness = 2
                                tracer.Transparency = 0.8
                                tracer.Visible = screenPoint.Z > 0
                                
                                local tracerObject = Instance.new("ObjectValue")
                                tracerObject.Name = "Tracer"
                                tracerObject.Value = tracer
                                tracerObject.Parent = character
                            end
                        end
                    end
                end
            end)
            createNotification("Tracers", "Tracers enabled!")
        else
            if connections.tracers then
                connections.tracers:Disconnect()
                connections.tracers = nil
            end
            createNotification("Tracers", "Tracers disabled!")
        end
    end
})

-- Name Tags Toggle
local NameTagsToggle = VisualTab:CreateToggle({
    Name = "Name Tags",
    CurrentValue = false,
    Flag = "name_tags",
    Callback = function(Value)
        nameTagsEnabled = Value
        if Value then
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    local character = player.Character
                    local head = character:FindFirstChild("Head")
                    
                    if head and not head:FindFirstChild("NameTag") then
                        local billboardGui = Instance.new("BillboardGui")
                        billboardGui.Name = "NameTag"
                        billboardGui.Size = UDim2.new(0, 200, 0, 50)
                        billboardGui.Adornee = head
                        billboardGui.Parent = head
                        
                        local textLabel = Instance.new("TextLabel")
                        textLabel.Size = UDim2.new(1, 0, 1, 0)
                        textLabel.BackgroundTransparency = 1
                        textLabel.Text = player.Name
                        textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                        textLabel.TextStrokeTransparency = 0
                        textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                        textLabel.Font = Enum.Font.SourceSansBold
                        textLabel.TextSize = 14
                        textLabel.Parent = billboardGui
                    end
                end
            end
            createNotification("Name Tags", "Name tags enabled!")
        else
            for _, player in pairs(Players:GetPlayers()) do
                if player.Character then
                    local head = player.Character:FindFirstChild("Head")
                    if head then
                        local nameTag = head:FindFirstChild("NameTag")
                        if nameTag then
                            nameTag:Destroy()
                        end
                    end
                end
            end
            createNotification("Name Tags", "Name tags disabled!")
        end
    end
})

-- Lighting Section
local LightingSection = VisualTab:CreateSection("Lighting Controls")

-- Fullbright Toggle
local FullbrightToggle = VisualTab:CreateToggle({
    Name = "Fullbright",
    CurrentValue = false,
    Flag = "fullbright",
    Callback = function(Value)
        if Value then
            Lighting.Brightness = 2
            Lighting.ClockTime = 14
            Lighting.FogEnd = 100000
            Lighting.GlobalShadows = false
            Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
            createNotification("Lighting", "Fullbright enabled!")
        else
            Lighting.Brightness = 1
            Lighting.ClockTime = 12
            Lighting.FogEnd = 100000
            Lighting.GlobalShadows = true
            Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 70)
            createNotification("Lighting", "Fullbright disabled!")
        end
    end
})

-- No Fog Toggle
local NoFogToggle = VisualTab:CreateToggle({
    Name = "No Fog",
    CurrentValue = false,
    Flag = "no_fog",
    Callback = function(Value)
        if Value then
            Lighting.FogEnd = 100000
            Lighting.FogStart = 0
            createNotification("Lighting", "Fog removed!")
        else
            Lighting.FogEnd = 100000
            Lighting.FogStart = 0
        end
    end
})
