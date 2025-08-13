-- ╔═══════════════════════════════════════════════════════════════════════╗
-- ║                          TUX'S FREE M3NU                              ║
-- ║                 This Script Was Made By Tux Da Kitty                  ║
-- ║                           Version 1.4.9                               ║
-- ║                      Created by Tux Da Modder                         ║
-- ╚═══════════════════════════════════════════════════════════════════════╝

-- Load Rayfield UI with error handling
local success, Rayfield = pcall(function()
    return loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/master/source'))()
end)

if not success then
    warn("Failed to load Rayfield UI library!")
    return
end

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local StarterGui = game:GetService("StarterGui")
local HttpService = game:GetService("HttpService")
local MarketplaceService = game:GetService("MarketplaceService")
local TeleportService = game:GetService("TeleportService")
local Lighting = game:GetService("Lighting")
local Stats = game:GetService("Stats")
local SoundService = game:GetService("SoundService")

-- Variables
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

-- Connection management
local connections = {}

-- Movement variables
local flySpeed = 50
local walkSpeed = 16
local jumpPower = 50
local flyEnabled = false
local noclipEnabled = false
local speedHackEnabled = false
local infiniteJumpEnabled = false

-- Visual variables
local espEnabled = false
local espColor = Color3.fromRGB(255, 0, 0)
local fullbrightEnabled = false
local teamCheckEnabled = true

-- Combat variables
local aimbotEnabled = false
local aimbotFOV = 100
local killAuraEnabled = false
local autoClickerEnabled = false
local clickSpeed = 10

-- Misc variables
local antiAfkEnabled = false
local chatSpamEnabled = false
local spamMessage = "Tux's FREE Menu is the best!"
local spamDelay = 1

-- Performance
local fpsCounter = 0
local lastFpsUpdate = tick()
local scriptStartTime = tick()

-- ╔═══════════════════════════════════════════════════════════════════════╗
-- ║                       UTILITY FUNCTIONS                               ║
-- ╚═══════════════════════════════════════════════════════════════════════╝

local function getCharacter(player)
    player = player or LocalPlayer
    return player.Character or player.CharacterAdded:Wait()
end

local function getHumanoid(player)
    local character = getCharacter(player)
    return character and character:FindFirstChildOfClass("Humanoid")
end

local function getRootPart(player)
    local character = getCharacter(player)
    return character and (character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso"))
end

local function isAlive(player)
    player = player or LocalPlayer
    local humanoid = getHumanoid(player)
    local rootPart = getRootPart(player)
    return humanoid and rootPart and humanoid.Health > 0
end

local function getClosestPlayer(maxDistance)
    local closestPlayer = nil
    local shortestDistance = maxDistance or math.huge
    local rootPart = getRootPart()
    
    if not rootPart then return nil end
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and isAlive(player) then
            local playerRootPart = getRootPart(player)
            if playerRootPart then
                local distance = (rootPart.Position - playerRootPart.Position).Magnitude
                if distance < shortestDistance then
                    if not teamCheckEnabled or player.Team ~= LocalPlayer.Team then
                        shortestDistance = distance
                        closestPlayer = player
                    end
                end
            end
        end
    end
    
    return closestPlayer, shortestDistance
end

local function createNotification(title, content, duration)
    duration = duration or 3
    pcall(function()
        Rayfield:Notify({
            Title = title,
            Content = content,
            Duration = duration,
            Image = 4483362458
        })
    end)
end

local function safeSetClipboard(text)
    local methods = {
        function() setclipboard(text) end,
        function() toclipboard(text) end,
        function() 
            if syn and syn.set_clipboard then
                syn.set_clipboard(text)
            end
        end
    }
    
    for _, method in ipairs(methods) do
        local success = pcall(method)
        if success then
            createNotification("📋 Clipboard", "Text copied successfully!", 2)
            return
        end
    end
    createNotification("❌ Error", "Failed to copy to clipboard!", 3)
end

local function cleanupConnection(name)
    if connections[name] then
        connections[name]:Disconnect()
        connections[name] = nil
    end
end

-- ╔═══════════════════════════════════════════════════════════════════════╗
-- ║                        MAIN WINDOW                                    ║
-- ╚═══════════════════════════════════════════════════════════════════════╝

local Window = Rayfield:CreateWindow({
    Name = "Tux's FREE Menu",
    LoadingTitle = "Loading Tux's FREE Menu...",
    LoadingSubtitle = "by Tux Skidder - Version 3.0.0 Condensed",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "TuxFreeMenu",
        FileName = "TuxConfig"
    },
    Discord = {
        Enabled = true,
        Invite = "4F7rMQtGhe"
    },
    KeySystem = false
})

-- ╔═══════════════════════════════════════════════════════════════════════╗
-- ║                           HOME TAB                                    ║
-- ╚═══════════════════════════════════════════════════════════════════════╝

local HomeTab = Window:CreateTab("🏠 Home", 4483362458)

HomeTab:CreateLabel("🎉 Welcome to Tux's FREE Menu!")
HomeTab:CreateLabel("🚀 Version 3.0.0 - Advanced Script Hub")
HomeTab:CreateLabel("👨‍💻 Created by Tux Skidder")

local gameInfo = ""
pcall(function()
    local productInfo = MarketplaceService:GetProductInfo(game.PlaceId)
    gameInfo = productInfo.Name
end)

HomeTab:CreateLabel("🎮 Game: " .. (gameInfo ~= "" and gameInfo or "Unknown"))
HomeTab:CreateLabel("🆔 Place ID: " .. tostring(game.PlaceId))
HomeTab:CreateLabel("👥 Players: " .. tostring(#Players:GetPlayers()))

local FpsLabel = HomeTab:CreateLabel("📊 FPS: Calculating...")
local MemoryLabel = HomeTab:CreateLabel("💾 Memory: Calculating...")
local UptimeLabel = HomeTab:CreateLabel("⏱️ Uptime: 0s")

-- Performance monitoring
spawn(function()
    while wait(1) do
        fpsCounter = fpsCounter + 1
        if tick() - lastFpsUpdate >= 1 then
            FpsLabel:Set("📊 FPS: " .. tostring(math.floor(fpsCounter)))
            fpsCounter = 0
            lastFpsUpdate = tick()
            
            pcall(function()
                local memory = Stats:GetTotalMemoryUsageMb()
                MemoryLabel:Set("💾 Memory: " .. tostring(math.floor(memory)) .. " MB")
            end)
            
            local uptime = math.floor(tick() - scriptStartTime)
            UptimeLabel:Set("⏱️ Uptime: " .. tostring(uptime) .. "s")
        end
    end
end)

HomeTab:CreateButton({
    Name = "🔄 Rejoin Server",
    Callback = function()
        TeleportService:Teleport(game.PlaceId)
    end
})

HomeTab:CreateButton({
    Name = "📋 Copy Join Script",
    Callback = function()
        local joinScript = 'game:GetService("TeleportService"):TeleportToPlaceInstance(' .. game.PlaceId .. ', "' .. game.JobId .. '")'
        safeSetClipboard(joinScript)
    end
})

-- ╔═══════════════════════════════════════════════════════════════════════╗
-- ║                        MOVEMENT TAB                                   ║
-- ╚═══════════════════════════════════════════════════════════════════════╝

local MovementTab = Window:CreateTab("🚀 Movement", 4370318685)

MovementTab:CreateSlider({
    Name = "Flight Speed",
    Range = {1, 200},
    Increment = 1,
    Suffix = " studs/s",
    CurrentValue = 50,
    Flag = "flight_speed",
    Callback = function(Value)
        flySpeed = Value
    end
})

MovementTab:CreateToggle({
    Name = "🛸 Enhanced Fly",
    CurrentValue = false,
    Flag = "fly_toggle",
    Callback = function(Value)
        flyEnabled = Value
        cleanupConnection("fly")
        
        if Value then
            local character = getCharacter()
            local rootPart = getRootPart()
            
            if not rootPart then
                createNotification("❌ Error", "Character not found!", 3)
                return
            end
            
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.Velocity = Vector3.new(0, 0, 0)
            bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
            bodyVelocity.Parent = rootPart
            
            connections["fly"] = RunService.Heartbeat:Connect(function()
                local moveVector = Vector3.new(0, 0, 0)
                
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    moveVector = moveVector + Camera.CFrame.LookVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    moveVector = moveVector - Camera.CFrame.LookVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    moveVector = moveVector - Camera.CFrame.RightVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    moveVector = moveVector + Camera.CFrame.RightVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                    moveVector = moveVector + Vector3.new(0, 1, 0)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                    moveVector = moveVector - Vector3.new(0, 1, 0)
                end
                
                bodyVelocity.Velocity = moveVector * flySpeed
            end)
            
            createNotification("✅ Fly", "Enhanced fly enabled!", 2)
        else
            local rootPart = getRootPart()
            if rootPart then
                local bodyVelocity = rootPart:FindFirstChild("BodyVelocity")
                if bodyVelocity then bodyVelocity:Destroy() end
            end
            createNotification("❌ Fly", "Enhanced fly disabled!", 2)
        end
    end
})

MovementTab:CreateToggle({
    Name = "👻 Noclip",
    CurrentValue = false,
    Flag = "noclip_toggle",
    Callback = function(Value)
        noclipEnabled = Value
        cleanupConnection("noclip")
        
        if Value then
            connections["noclip"] = RunService.Stepped:Connect(function()
                local character = getCharacter()
                if character then
                    for _, part in pairs(character:GetDescendants()) do
                        if part:IsA("BasePart") and part.CanCollide then
                            part.CanCollide = false
                        end
                    end
                end
            end)
            createNotification("✅ Noclip", "Noclip enabled!", 2)
        else
            local character = getCharacter()
            if character then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                    end
                end
            end
            createNotification("❌ Noclip", "Noclip disabled!", 2)
        end
    end
})

MovementTab:CreateSlider({
    Name = "Walk Speed",
    Range = {16, 200},
    Increment = 1,
    Suffix = " studs/s",
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

MovementTab:CreateSlider({
    Name = "Jump Power",
    Range = {50, 500},
    Increment = 1,
    Suffix = " power",
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

MovementTab:CreateToggle({
    Name = "🦘 Infinite Jump",
    CurrentValue = false,
    Flag = "infinite_jump",
    Callback = function(Value)
        infiniteJumpEnabled = Value
        cleanupConnection("infinite_jump")
        
        if Value then
            connections["infinite_jump"] = UserInputService.JumpRequest:Connect(function()
                local humanoid = getHumanoid()
                if humanoid then
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end)
            createNotification("✅ Jump", "Infinite jump enabled!", 2)
        else
            createNotification("❌ Jump", "Infinite jump disabled!", 2)
        end
    end
})

-- ╔═══════════════════════════════════════════════════════════════════════╗
-- ║                         VISUAL TAB                                    ║
-- ╚═══════════════════════════════════════════════════════════════════════╝

local VisualTab = Window:CreateTab("👁️ Visual", 4335489011)

VisualTab:CreateToggle({
    Name = "🌟 ESP Players",
    CurrentValue = false,
    Flag = "esp_toggle",
    Callback = function(Value)
        espEnabled = Value
        
        -- Clean up existing ESP
        for _, player in pairs(Players:GetPlayers()) do
            if player.Character then
                local highlight = player.Character:FindFirstChild("ESPHighlight")
                if highlight then highlight:Destroy() end
            end
        end
        
        if Value then
            local function addESP(player)
                if player == LocalPlayer then return end
                local character = player.Character
                if not character then return end
                
                local highlight = Instance.new("Highlight")
                highlight.Name = "ESPHighlight"
                highlight.FillColor = espColor
                highlight.OutlineColor = Color3.new(1, 1, 1)
                highlight.FillTransparency = 0.5
                highlight.OutlineTransparency = 0
                highlight.Parent = character
            end
            
            for _, player in pairs(Players:GetPlayers()) do
                if player.Character then
                    addESP(player)
                end
            end
            
            connections["esp"] = Players.PlayerAdded:Connect(function(player)
                player.CharacterAdded:Connect(function()
                    wait(0.5)
                    if espEnabled then
                        addESP(player)
                    end
                end)
            end)
            
            createNotification("✅ ESP", "Player ESP enabled!", 2)
        else
            cleanupConnection("esp")
            createNotification("❌ ESP", "Player ESP disabled!", 2)
        end
    end
})

VisualTab:CreateColorPicker({
    Name = "ESP Color",
    Color = Color3.fromRGB(255, 0, 0),
    Flag = "esp_color",
    Callback = function(Value)
        espColor = Value
        
        -- Update existing ESP colors
        for _, player in pairs(Players:GetPlayers()) do
            if player.Character then
                local highlight = player.Character:FindFirstChild("ESPHighlight")
                if highlight then
                    highlight.FillColor = Value
                end
            end
        end
    end
})

VisualTab:CreateToggle({
    Name = "🔆 Fullbright",
    CurrentValue = false,
    Flag = "fullbright_toggle",
    Callback = function(Value)
        fullbrightEnabled = Value
        
        if Value then
            Lighting.Brightness = 2
            Lighting.ClockTime = 14
            Lighting.FogEnd = 100000
            Lighting.GlobalShadows = false
            Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
            createNotification("✅ Fullbright", "Fullbright enabled!", 2)
        else
            Lighting.Brightness = 1
            Lighting.ClockTime = 12
            Lighting.FogEnd = 100000
            Lighting.GlobalShadows = true
            Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 70)
            createNotification("❌ Fullbright", "Fullbright disabled!", 2)
        end
    end
})

VisualTab:CreateToggle({
    Name = "🎯 Team Check",
    CurrentValue = true,
    Flag = "team_check",
    Callback = function(Value)
        teamCheckEnabled = Value
        createNotification("🎯 Team Check", Value and "Enabled" or "Disabled", 2)
    end
})

-- ╔═══════════════════════════════════════════════════════════════════════╗
-- ║                         COMBAT TAB                                    ║
-- ╚═══════════════════════════════════════════════════════════════════════╝

local CombatTab = Window:CreateTab("⚔️ Combat", 4335454746)

CombatTab:CreateSlider({
    Name = "Aimbot FOV",
    Range = {10, 360},
    Increment = 1,
    Suffix = "°",
    CurrentValue = 100,
    Flag = "aimbot_fov",
    Callback = function(Value)
        aimbotFOV = Value
    end
})

CombatTab:CreateToggle({
    Name = "🎯 Silent Aimbot",
    CurrentValue = false,
    Flag = "aimbot_toggle",
    Callback = function(Value)
        aimbotEnabled = Value
        cleanupConnection("aimbot")
        
        if Value then
            connections["aimbot"] = RunService.Heartbeat:Connect(function()
                local target, distance = getClosestPlayer(aimbotFOV)
                if target and distance then
                    local targetHead = target.Character and target.Character:FindFirstChild("Head")
                    if targetHead then
                        local screenPoint, onScreen = Camera:WorldToScreenPoint(targetHead.Position)
                        local mousePos = Vector2.new(Mouse.X, Mouse.Y)
                        local targetPos = Vector2.new(screenPoint.X, screenPoint.Y)
                        
                        if onScreen and (targetPos - mousePos).Magnitude <= aimbotFOV then
                            Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, targetHead.Position)
                        end
                    end
                end
            end)
            createNotification("✅ Aimbot", "Silent aimbot enabled!", 2)
        else
            createNotification("❌ Aimbot", "Silent aimbot disabled!", 2)
        end
    end
})

CombatTab:CreateSlider({
    Name = "Auto Clicker Speed",
    Range = {1, 50},
    Increment = 1,
    Suffix = " cps",
    CurrentValue = 10,
    Flag = "click_speed",
    Callback = function(Value)
        clickSpeed = Value
    end
})

CombatTab:CreateToggle({
    Name = "🖱️ Auto Clicker",
    CurrentValue = false,
    Flag = "auto_clicker",
    Callback = function(Value)
        autoClickerEnabled = Value
        cleanupConnection("auto_clicker")
        
        if Value then
            connections["auto_clicker"] = RunService.Heartbeat:Connect(function()
                if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
                    wait(1 / clickSpeed)
                    Mouse1Click()
                end
            end)
            createNotification("✅ Auto Click", "Auto clicker enabled!", 2)
        else
            createNotification("❌ Auto Click", "Auto clicker disabled!", 2)
        end
    end
})

-- ╔═══════════════════════════════════════════════════════════════════════╗
-- ║                      MISCELLANEOUS TAB                                ║
-- ╚═══════════════════════════════════════════════════════════════════════╝

local MiscTab = Window:CreateTab("🔧 Misc", 4335486884)

MiscTab:CreateToggle({
    Name = "😴 Anti AFK",
    CurrentValue = false,
    Flag = "anti_afk",
    Callback = function(Value)
        antiAfkEnabled = Value
        cleanupConnection("anti_afk")
        
        if Value then
            connections["anti_afk"] = game:GetService("Players").LocalPlayer.Idled:Connect(function()
                game:GetService("VirtualUser"):Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
                wait(1)
                game:GetService("VirtualUser"):Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            end)
            createNotification("✅ Anti AFK", "Anti AFK enabled!", 2)
        else
            createNotification("❌ Anti AFK", "Anti AFK disabled!", 2)
        end
    end
})

MiscTab:CreateInput({
    Name = "Chat Spam Message",
    PlaceholderText = "Enter spam message...",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        spamMessage = Text
    end
})

MiscTab:CreateSlider({
    Name = "Spam Delay",
    Range = {0.1, 10},
    Increment = 0.1,
    Suffix = "s",
    CurrentValue = 1,
    Flag = "spam_delay",
    Callback = function(Value)
        spamDelay = Value
    end
})

MiscTab:CreateToggle({
    Name = "💬 Chat Spam",
    CurrentValue = false,
    Flag = "chat_spam",
    Callback = function(Value)
        chatSpamEnabled = Value
        cleanupConnection("chat_spam")
        
        if Value then
            connections["chat_spam"] = task.spawn(function()
                while chatSpamEnabled do
                    pcall(function()
                        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(spamMessage, "All")
                    end)
                    wait(spamDelay)
                end
            end)
            createNotification("✅ Chat Spam", "Chat spam enabled!", 2)
        else
            createNotification("❌ Chat Spam", "Chat spam disabled!", 2)
        end
    end
})

-- ╔═══════════════════════════════════════════════════════════════════════╗
-- ║                         CREDITS TAB                                   ║
-- ╚═══════════════════════════════════════════════════════════════════════╝

local CreditsTab = Window:CreateTab("📜 Credits", 4335489547)

CreditsTab:CreateLabel("🎉 Tux's FREE Menu - Advanced Hub")
CreditsTab:CreateLabel("👨‍💻 Created by: Tux Skidder")
CreditsTab:CreateLabel("🌟 Version: 3.0.0 - Condensed Edition")
CreditsTab:CreateLabel("📊 Total Lines: 800")
CreditsTab:CreateLabel("🔗 Discord Server:")

CreditsTab:CreateButton({
    Name = "📋 Copy Discord Link",
    Callback = function()
        safeSetClipboard("https://discord.gg/4F7rMQtGhe")
    end
})

CreditsTab:CreateButton({
    Name = "🌐 Get More Scripts",
    Callback = function()
        safeSetClipboard("tuxskidder/nova-scripts")
    end
})

CreditsTab:CreateLabel("🙏 Thanks for using Tux's FREE Menu!")
CreditsTab:CreateLabel("⭐ Please star our repository!")

-- Initialize script
createNotification("🎉 Welcome", "Tux's FREE Menu loaded successfully!", 3)
warn("Tux's FREE Menu v3.0.0 - Condensed Edition loaded successfully!")
warn("Created by Tux Skidder - 800 lines of optimized code!")

-- Clean up on script end
game.Players.PlayerRemoving:Connect(function(player)
    if player == LocalPlayer then
        for name, connection in pairs(connections) do
            if connection and connection.Connected then
                connection:Disconnect()
            end
        end
    end
end)
