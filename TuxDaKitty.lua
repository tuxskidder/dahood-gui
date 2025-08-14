-- ╔═══════════════════════════════════════════════════════════════════════╗
-- ║                          TUX'S FREE MENU                             ║
-- ║                    Universal Mobile & PC Compatible                   ║
-- ║                         Version 3.0.1 - Fixed                       ║
-- ║          Works with Xeno, Delta, Fluxus, Arceus X & More            ║
-- ╚═══════════════════════════════════════════════════════════════════════╝

-- Universal executor compatibility check
local executor = identifyexecutor and identifyexecutor() or "Unknown"
warn("🚀 Loading Tux's FREE Menu on: " .. executor)

-- Safe service loading with fallbacks
local function getService(name)
    return game:FindService(name) or game:GetService(name)
end

-- Load Rayfield UI with multiple fallbacks
local Rayfield
local loadSuccess = false

-- Try multiple UI library sources
local sources = {
    'https://sirius.menu/rayfield',
    'https://raw.githubusercontent.com/shlexware/Rayfield/main/source',
    'https://raw.githubusercontent.com/shlexware/Rayfield/master/source'
}

for i, source in ipairs(sources) do
    local success, result = pcall(function()
        return loadstring(game:HttpGet(source))()
    end)
    if success and result then
        Rayfield = result
        loadSuccess = true
        warn("✅ UI loaded from source " .. i)
        break
    end
end

if not loadSuccess then
    -- Fallback notification
    local StarterGui = getService("StarterGui")
    StarterGui:SetCore("SendNotification", {
        Title = "Tux's FREE Menu";
        Text = "Failed to load UI! Check your executor.";
        Duration = 10;
    })
    return
end

-- Universal Services (compatible with all executors)
local Players = getService("Players")
local RunService = getService("RunService")
local UserInputService = getService("UserInputService")
local TweenService = getService("TweenService")
local Workspace = getService("Workspace") or workspace
local StarterGui = getService("StarterGui")
local HttpService = getService("HttpService")
local TeleportService = getService("TeleportService")
local Lighting = getService("Lighting")
local ReplicatedStorage = getService("ReplicatedStorage")
local VirtualInputManager = getService("VirtualInputManager")
local GuiService = getService("GuiService")
local ContextActionService = getService("ContextActionService")

-- Mobile detection
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

-- Variables
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera or Workspace:FindFirstChild("Camera")
local Mouse = LocalPlayer:GetMouse()

-- Connection management
local connections = {}
local activeConnections = 0

-- Movement variables
local flySpeed = 50
local walkSpeed = 16
local jumpPower = 50
local flyEnabled = false
local noclipEnabled = false
local speedHackEnabled = false
local infiniteJumpEnabled = false
local flyBodyVelocity = nil
local flyBodyAngularVelocity = nil

-- Visual variables
local espEnabled = false
local espColor = Color3.fromRGB(255, 0, 0)
local fullbrightEnabled = false
local teamCheckEnabled = true
local espObjects = {}

-- Combat variables
local aimbotEnabled = false
local aimbotFOV = 100
local killAuraEnabled = false
local autoClickerEnabled = false
local clickSpeed = 10
local lastClick = 0

-- Misc variables
local antiAfkEnabled = false
local chatSpamEnabled = false
local spamMessage = "Tux's FREE Menu is the best!"
local spamDelay = 1

-- Performance tracking
local fpsCounter = 0
local lastFpsUpdate = tick()
local scriptStartTime = tick()

-- ╔═══════════════════════════════════════════════════════════════════════╗
-- ║                    UNIVERSAL UTILITY FUNCTIONS                        ║
-- ╚═══════════════════════════════════════════════════════════════════════╝

-- Safe character getter with retries
local function getCharacter(player, retries)
    player = player or LocalPlayer
    retries = retries or 5
    
    for i = 1, retries do
        local char = player.Character
        if char and char.Parent then
            return char
        end
        if i < retries then
            wait(0.1)
        end
    end
    return nil
end

-- Safe humanoid getter
local function getHumanoid(player)
    local character = getCharacter(player)
    if not character then return nil end
    
    return character:FindFirstChildOfClass("Humanoid") or 
           character:FindFirstChild("Humanoid")
end

-- Safe root part getter with multiple fallbacks
local function getRootPart(player)
    local character = getCharacter(player)
    if not character then return nil end
    
    return character:FindFirstChild("HumanoidRootPart") or
           character:FindFirstChild("Torso") or
           character:FindFirstChild("UpperTorso") or
           character:FindFirstChild("LowerTorso") or
           character:FindFirstChild("Root")
end

-- Enhanced alive check
local function isAlive(player)
    player = player or LocalPlayer
    local character = getCharacter(player, 1)
    if not character then return false end
    
    local humanoid = getHumanoid(player)
    local rootPart = getRootPart(player)
    
    return humanoid and rootPart and 
           humanoid.Health > 0 and 
           humanoid.Parent and 
           rootPart.Parent
end

-- Universal closest player finder
local function getClosestPlayer(maxDistance)
    local closestPlayer = nil
    local shortestDistance = maxDistance or math.huge
    local myRootPart = getRootPart()
    
    if not myRootPart then return nil end
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and isAlive(player) then
            local theirRootPart = getRootPart(player)
            if theirRootPart then
                local distance = (myRootPart.Position - theirRootPart.Position).Magnitude
                if distance < shortestDistance then
                    if not teamCheckEnabled or not player.Team or player.Team ~= LocalPlayer.Team then
                        shortestDistance = distance
                        closestPlayer = player
                    end
                end
            end
        end
    end
    
    return closestPlayer, shortestDistance
end

-- Universal notification system
local function notify(title, content, duration, image)
    duration = duration or 3
    image = image or 4483362458
    
    -- Try Rayfield notification
    pcall(function()
        if Rayfield and Rayfield.Notify then
            Rayfield:Notify({
                Title = title,
                Content = content,
                Duration = duration,
                Image = image
            })
        end
    end)
    
    -- Fallback to StarterGui
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = title,
            Text = content,
            Duration = duration
        })
    end)
    
    -- Console output for debugging
    warn("📢 " .. title .. ": " .. content)
end

-- Universal clipboard function
local function setClipboard(text)
    local clipboardFunctions = {
        function() setclipboard(text) end,
        function() toclipboard(text) end,
        function() writefile("clipboard.txt", text) end,
        function() 
            if syn and syn.set_clipboard then
                syn.set_clipboard(text)
            end
        end,
        function()
            if Clipboard and Clipboard.set then
                Clipboard.set(text)
            end
        end
    }
    
    for _, func in ipairs(clipboardFunctions) do
        local success = pcall(func)
        if success then
            notify("📋 Copied", "Text copied to clipboard!", 2)
            return true
        end
    end
    
    notify("❌ Error", "Clipboard not supported on this executor", 3)
    return false
end

-- Connection cleanup
local function cleanupConnection(name)
    if connections[name] then
        pcall(function()
            connections[name]:Disconnect()
        end)
        connections[name] = nil
        activeConnections = math.max(0, activeConnections - 1)
    end
end

local function cleanupAllConnections()
    for name, connection in pairs(connections) do
        pcall(function()
            if connection and connection.Connected then
                connection:Disconnect()
            end
        end)
    end
    connections = {}
    activeConnections = 0
end

-- Safe input detection for mobile/PC
local function isKeyDown(key)
    if isMobile then
        return false -- Mobile doesn't support keyboard
    end
    return UserInputService:IsKeyDown(key)
end

-- Universal mouse click
local function performClick()
    local currentTime = tick()
    if currentTime - lastClick < (1 / clickSpeed) then
        return
    end
    lastClick = currentTime
    
    pcall(function()
        if mouse1click then
            mouse1click()
        elseif Mouse.Button1Click then
            Mouse.Button1Click:Fire()
        elseif VirtualInputManager then
            VirtualInputManager:SendMouseButtonEvent(Mouse.X, Mouse.Y, 0, true, game, false)
            wait()
            VirtualInputManager:SendMouseButtonEvent(Mouse.X, Mouse.Y, 0, false, game, false)
        end
    end)
end

-- ╔═══════════════════════════════════════════════════════════════════════╗
-- ║                        UNIVERSAL WINDOW CREATION                      ║
-- ╚═══════════════════════════════════════════════════════════════════════╝

local Window = Rayfield:CreateWindow({
    Name = "Tux's FREE Menu - Universal",
    LoadingTitle = "Loading Universal Menu...",
    LoadingSubtitle = "Compatible with " .. executor .. " | Mobile & PC Ready",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "TuxUniversalMenu",
        FileName = "UniversalConfig"
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

HomeTab:CreateLabel("🎉 Tux's FREE Menu - Universal Edition")
HomeTab:CreateLabel("📱 " .. (isMobile and "Mobile" or "PC") .. " Mode | Executor: " .. executor)
HomeTab:CreateLabel("👨‍💻 Created by Tux Skidder")

-- Game info with error handling
local gameInfo = "Unknown Game"
local gameId = game.PlaceId or 0

pcall(function()
    if HttpService then
        local success, result = pcall(function()
            return HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. gameId))
        end)
        if success and result and result.name then
            gameInfo = result.name
        end
    end
end)

HomeTab:CreateLabel("🎮 Game: " .. gameInfo)
HomeTab:CreateLabel("🆔 Place ID: " .. tostring(gameId))
HomeTab:CreateLabel("👥 Players: " .. tostring(#Players:GetPlayers()))

-- Performance labels
local FpsLabel = HomeTab:CreateLabel("📊 FPS: Calculating...")
local MemoryLabel = HomeTab:CreateLabel("💾 Memory: Calculating...")
local UptimeLabel = HomeTab:CreateLabel("⏱️ Uptime: 0s")
local ConnectionsLabel = HomeTab:CreateLabel("🔗 Connections: 0")

-- Performance monitoring
spawn(function()
    while wait(1) do
        pcall(function()
            fpsCounter = fpsCounter + 1
            if tick() - lastFpsUpdate >= 1 then
                local fps = math.floor(fpsCounter)
                FpsLabel:Set("📊 FPS: " .. tostring(fps))
                fpsCounter = 0
                lastFpsUpdate = tick()
                
                -- Memory (if available)
                local memoryText = "💾 Memory: N/A"
                if game:GetService("Stats") then
                    local success, memory = pcall(function()
                        return game:GetService("Stats"):GetTotalMemoryUsageMb()
                    end)
                    if success and memory then
                        memoryText = "💾 Memory: " .. tostring(math.floor(memory)) .. " MB"
                    end
                end
                MemoryLabel:Set(memoryText)
                
                -- Uptime
                local uptime = math.floor(tick() - scriptStartTime)
                local minutes = math.floor(uptime / 60)
                local seconds = uptime % 60
                UptimeLabel:Set("⏱️ Uptime: " .. minutes .. "m " .. seconds .. "s")
                
                -- Connections
                ConnectionsLabel:Set("🔗 Connections: " .. tostring(activeConnections))
            end
        end)
    end
end)

-- Quick actions
HomeTab:CreateButton({
    Name = "🔄 Rejoin Server",
    Callback = function()
        notify("🔄 Rejoining", "Rejoining server...", 2)
        pcall(function()
            TeleportService:Teleport(gameId)
        end)
    end
})

HomeTab:CreateButton({
    Name = "📋 Copy Join Script",
    Callback = function()
        local joinScript = string.format(
            'game:GetService("TeleportService"):TeleportToPlaceInstance(%d, "%s")',
            gameId, game.JobId or "unknown"
        )
        setClipboard(joinScript)
    end
})

-- ╔═══════════════════════════════════════════════════════════════════════╗
-- ║                        MOVEMENT TAB                                   ║
-- ╚═══════════════════════════════════════════════════════════════════════╝

local MovementTab = Window:CreateTab("🚀 Movement", 4370318685)

-- Flight speed slider
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

-- Enhanced fly with mobile support
MovementTab:CreateToggle({
    Name = "🛸 Universal Fly",
    CurrentValue = false,
    Flag = "fly_toggle",
    Callback = function(Value)
        flyEnabled = Value
        cleanupConnection("fly")
        
        local character = getCharacter()
        local rootPart = getRootPart()
        
        if Value then
            if not rootPart then
                notify("❌ Error", "Character not found! Try respawning.", 3)
                return
            end
            
            -- Create body movers
            flyBodyVelocity = Instance.new("BodyVelocity")
            flyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
            flyBodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
            flyBodyVelocity.Parent = rootPart
            
            flyBodyAngularVelocity = Instance.new("BodyAngularVelocity")
            flyBodyAngularVelocity.AngularVelocity = Vector3.new(0, 0, 0)
            flyBodyAngularVelocity.MaxTorque = Vector3.new(4000, 4000, 4000)
            flyBodyAngularVelocity.Parent = rootPart
            
            -- Flight control loop
            connections["fly"] = RunService.Heartbeat:Connect(function()
                if not flyEnabled or not flyBodyVelocity or not flyBodyVelocity.Parent then
                    return
                end
                
                local moveVector = Vector3.new(0, 0, 0)
                local camera = Camera or Workspace.CurrentCamera
                
                if not isMobile then
                    -- PC Controls
                    if isKeyDown(Enum.KeyCode.W) then
                        moveVector = moveVector + camera.CFrame.LookVector
                    end
                    if isKeyDown(Enum.KeyCode.S) then
                        moveVector = moveVector - camera.CFrame.LookVector
                    end
                    if isKeyDown(Enum.KeyCode.A) then
                        moveVector = moveVector - camera.CFrame.RightVector
                    end
                    if isKeyDown(Enum.KeyCode.D) then
                        moveVector = moveVector + camera.CFrame.RightVector
                    end
                    if isKeyDown(Enum.KeyCode.Space) then
                        moveVector = moveVector + Vector3.new(0, 1, 0)
                    end
                    if isKeyDown(Enum.KeyCode.LeftShift) then
                        moveVector = moveVector - Vector3.new(0, 1, 0)
                    end
                else
                    -- Mobile auto-fly (follows camera direction)
                    moveVector = camera.CFrame.LookVector * 0.5
                end
                
                flyBodyVelocity.Velocity = moveVector * flySpeed
            end)
            
            activeConnections = activeConnections + 1
            notify("✅ Fly", "Universal fly enabled! " .. (isMobile and "(Auto-pilot mode)" or "(WASD controls)"), 3)
        else
            -- Cleanup
            if flyBodyVelocity then flyBodyVelocity:Destroy() end
            if flyBodyAngularVelocity then flyBodyAngularVelocity:Destroy() end
            flyBodyVelocity = nil
            flyBodyAngularVelocity = nil
            notify("❌ Fly", "Universal fly disabled!", 2)
        end
    end
})

-- Noclip
MovementTab:CreateToggle({
    Name = "👻 Noclip",
    CurrentValue = false,
    Flag = "noclip_toggle",
    Callback = function(Value)
        noclipEnabled = Value
        cleanupConnection("noclip")
        
        if Value then
            connections["noclip"] = RunService.Stepped:Connect(function()
                local character = getCharacter(LocalPlayer, 1)
                if character then
                    for _, part in pairs(character:GetDescendants()) do
                        if part:IsA("BasePart") and part.CanCollide then
                            part.CanCollide = false
                        end
                    end
                end
            end)
            activeConnections = activeConnections + 1
            notify("✅ Noclip", "Noclip enabled!", 2)
        else
            -- Re-enable collisions
            local character = getCharacter(LocalPlayer, 1)
            if character then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                        part.CanCollide = true
                    end
                end
            end
            notify("❌ Noclip", "Noclip disabled!", 2)
        end
    end
})

-- Walk speed
MovementTab:CreateSlider({
    Name = "Walk Speed",
    Range = {16, 500},
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

-- Jump power
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
            if humanoid.JumpPower then
                humanoid.JumpPower = Value
            elseif humanoid.JumpHeight then
                humanoid.JumpHeight = Value / 4
            end
        end
    end
})

-- Infinite jump
MovementTab:CreateToggle({
    Name = "🦘 Infinite Jump",
    CurrentValue = false,
    Flag = "infinite_jump",
    Callback = function(Value)
        infiniteJumpEnabled = Value
        cleanupConnection("infinite_jump")
        
        if Value then
            if not isMobile then
                connections["infinite_jump"] = UserInputService.JumpRequest:Connect(function()
                    local humanoid = getHumanoid()
                    if humanoid then
                        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                end)
                activeConnections = activeConnections + 1
            else
                -- Mobile alternative
                connections["infinite_jump"] = RunService.Heartbeat:Connect(function()
                    local humanoid = getHumanoid()
                    if humanoid and humanoid.Jump then
                        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                end)
                activeConnections = activeConnections + 1
            end
            notify("✅ Jump", "Infinite jump enabled!", 2)
        else
            notify("❌ Jump", "Infinite jump disabled!", 2)
        end
    end
})

-- ╔═══════════════════════════════════════════════════════════════════════╗
-- ║                         VISUAL TAB                                    ║
-- ╚═══════════════════════════════════════════════════════════════════════╝

local VisualTab = Window:CreateTab("👁️ Visual", 4335489011)

-- ESP
VisualTab:CreateToggle({
    Name = "🌟 Player ESP",
    CurrentValue = false,
    Flag = "esp_toggle",
    Callback = function(Value)
        espEnabled = Value
        
        -- Clean up existing ESP
        for _, espObj in pairs(espObjects) do
            if espObj and espObj.Parent then
                espObj:Destroy()
            end
        end
        espObjects = {}
        
        if Value then
            local function addESP(player)
                if player == LocalPlayer then return end
                
                pcall(function()
                    local character = getCharacter(player, 1)
                    if not character then return end
                    
                    -- Remove old ESP
                    local oldESP = character:FindFirstChild("TuxESP")
                    if oldESP then oldESP:Destroy() end
                    
                    -- Create new ESP
                    local highlight = Instance.new("Highlight")
                    highlight.Name = "TuxESP"
                    highlight.FillColor = espColor
                    highlight.OutlineColor = Color3.new(1, 1, 1)
                    highlight.FillTransparency = 0.5
                    highlight.OutlineTransparency = 0
                    highlight.Parent = character
                    
                    table.insert(espObjects, highlight)
                end)
            end
            
            -- Add ESP to existing players
            for _, player in pairs(Players:GetPlayers()) do
                if player.Character then
                    addESP(player)
                end
            end
            
            -- Add ESP to new players
            connections["esp_added"] = Players.PlayerAdded:Connect(function(player)
                player.CharacterAdded:Connect(function()
                    wait(1)
                    if espEnabled then
                        addESP(player)
                    end
                end)
            end)
            
            -- Update existing players
            connections["esp_spawn"] = Players.PlayerAdded:Connect(function(player)
                if player.Character then
                    addESP(player)
                end
            end)
            
            activeConnections = activeConnections + 2
            notify("✅ ESP", "Player ESP enabled!", 2)
        else
            cleanupConnection("esp_added")
            cleanupConnection("esp_spawn")
            notify("❌ ESP", "Player ESP disabled!", 2)
        end
    end
})

-- ESP Color picker
VisualTab:CreateColorPicker({
    Name = "ESP Color",
    Color = Color3.fromRGB(255, 0, 0),
    Flag = "esp_color",
    Callback = function(Value)
        espColor = Value
        
        -- Update existing ESP colors
        for _, espObj in pairs(espObjects) do
            if espObj and espObj.Parent then
                espObj.FillColor = Value
            end
        end
    end
})

-- Fullbright
VisualTab:CreateToggle({
    Name = "🔆 Fullbright",
    CurrentValue = false,
    Flag = "fullbright_toggle",
    Callback = function(Value)
        fullbrightEnabled = Value
        
        pcall(function()
            if Value then
                Lighting.Brightness = 2
                Lighting.ClockTime = 14
                Lighting.FogEnd = 100000
                Lighting.GlobalShadows = false
                Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
                notify("✅ Fullbright", "Fullbright enabled!", 2)
            else
                Lighting.Brightness = 1
                Lighting.ClockTime = 12
                Lighting.FogEnd = 100000
                Lighting.GlobalShadows = true
                Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 70)
                notify("❌ Fullbright", "Fullbright disabled!", 2)
            end
        end)
    end
})

-- Team check
VisualTab:CreateToggle({
    Name = "🎯 Team Check",
    CurrentValue = true,
    Flag = "team_check",
    Callback = function(Value)
        teamCheckEnabled = Value
        notify("🎯 Team Check", Value and "Enabled" or "Disabled", 2)
    end
})

-- ╔═══════════════════════════════════════════════════════════════════════╗
-- ║                         COMBAT TAB                                    ║
-- ╚═══════════════════════════════════════════════════════════════════════╝

local CombatTab = Window:CreateTab("⚔️ Combat", 4335454746)

-- Aimbot FOV
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

-- Aimbot
CombatTab:CreateToggle({
    Name = "🎯 Universal Aimbot",
    CurrentValue = false,
    Flag = "aimbot_toggle",
    Callback = function(Value)
        aimbotEnabled = Value
        cleanupConnection("aimbot")
        
        if Value then
            connections["aimbot"] = RunService.Heartbeat:Connect(function()
                local target, distance = getClosestPlayer(aimbotFOV)
                if target and distance then
                    local targetChar = getCharacter(target, 1)
                    if targetChar then
                        local targetHead = targetChar:FindFirstChild("Head")
                        if targetHead and Camera then
                            pcall(function()
                                local lookDirection = (targetHead.Position - Camera.CFrame.Position).Unit
                                Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, targetHead.Position)
                            end)
                        end
                    end
                end
            end)
            activeConnections = activeConnections + 1
            notify("✅ Aimbot", "Universal aimbot enabled!", 2)
        else
            notify("❌ Aimbot", "Universal aimbot disabled!", 2)
        end
    end
})

-- Auto clicker speed
CombatTab:CreateSlider({
    Name = "Auto Click Speed",
    Range = {1, 20},
    Increment = 1,
    Suffix = " cps",
    CurrentValue = 10,
    Flag = "click_speed",
    Callback = function(Value)
        clickSpeed = Value
    end
})

-- Auto clicker
CombatTab:CreateToggle({
    Name = "🖱️ Auto Clicker",
    CurrentValue = false,
    Flag = "auto_clicker",
    Callback = function(Value)
        autoClickerEnabled = Value
        cleanupConnection("auto_clicker")
        
        if Value then
            connections["auto_clicker"] = RunService.Heartbeat:Connect(function()
                if autoClickerEnabled then
                    performClick()
                end
            end)
            activeConnections = activeConnections + 1
            notify("✅ Auto Click", "Auto clicker enabled!", 2)
        else
            notify("❌ Auto Click", "Auto clicker disabled!", 2)
        end
    end
})

-- ╔═══════════════════════════════════════════════════════════════════════╗
-- ║                      MISCELLANEOUS TAB                                ║
-- ╚═══════════════════════════════════════════════════════════════════════╝

local MiscTab = Window:CreateTab("🔧 Misc", 4335486884)

-- Anti AFK
MiscTab:CreateToggle({
    Name = "😴 Anti AFK",
    CurrentValue = false,
    Flag = "anti_afk",
    Callback = function(Value)
        antiAfkEnabled = Value
        cleanupConnection("anti_afk")
        
        if Value then
            connections["anti_afk"] = LocalPlayer.Idled:Connect(function()
                pcall(function()
                    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.LeftShift, false, game)
                    wait(0.1)
                    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.LeftShift, false, game)
                end)
            end)
            activeConnections = activeConnections + 1
            notify("✅ Anti AFK", "Anti AFK enabled!", 2)
        else
            notify("❌ Anti AFK", "Anti AFK disabled!", 2)
        end
    end
})

-- Chat spam message
MiscTab:CreateInput({
    Name = "Chat Message",
    PlaceholderText = "Enter message to spam...",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        spamMessage = Text
    end
})

-- Chat spam delay
MiscTab:CreateSlider({
    Name = "Spam Delay",
    Range = {0.5, 10},
    Increment = 0.1,
    Suffix = "s",
    CurrentValue = 1,
    Flag = "spam_delay",
    Callback = function(Value)
        spamDelay = Value
    end
})

-- Chat spam toggle
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
                        -- Try multiple chat methods for compatibility
                        if ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents") then
                            local chatEvents = ReplicatedStorage.DefaultChatSystemChatEvents
                            if chatEvents:FindFirstChild("SayMessageRequest") then
                                chatEvents.SayMessageRequest:FireServer(spamMessage, "All")
                            end
                        elseif game:GetService("TextChatService") then
                            local textChatService = game:GetService("TextChatService")
                            if textChatService.TextChannels and textChatService.TextChannels.RBXGeneral then
                                textChatService.TextChannels.RBXGeneral:SendAsync(spamMessage)
                            end
                        end
                    end)
                    wait(spamDelay)
                end
            end)
            activeConnections = activeConnections + 1
            notify("✅ Chat Spam", "Chat spam enabled!", 2)
        else
            notify("❌ Chat Spam", "Chat spam disabled!", 2)
        end
    end
})

-- Reset character
MiscTab:CreateButton({
    Name = "💀 Reset Character",
    Callback = function()
        pcall(function()
            local humanoid = getHumanoid()
            if humanoid then
                humanoid.Health = 0
                notify("💀 Reset", "Character reset!", 2)
            end
        end)
    end
})

-- Respawn character
MiscTab:CreateButton({
    Name = "🔄 Respawn",
    Callback = function()
        pcall(function()
            LocalPlayer:LoadCharacter()
            notify("🔄 Respawn", "Character respawned!", 2)
        end)
    end
})

-- ╔═══════════════════════════════════════════════════════════════════════╗
-- ║                         SETTINGS TAB                                  ║
-- ╚═══════════════════════════════════════════════════════════════════════╝

local SettingsTab = Window:CreateTab("⚙️ Settings", 4335486884)

SettingsTab:CreateLabel("🎮 Executor: " .. executor)
SettingsTab:CreateLabel("📱 Platform: " .. (isMobile and "Mobile" or "PC"))
SettingsTab:CreateLabel("🔧 UI Library: Rayfield")

SettingsTab:CreateButton({
    Name = "🧹 Cleanup All Features",
    Callback = function()
        cleanupAllConnections()
        
        -- Reset character modifications
        local humanoid = getHumanoid()
        if humanoid then
            humanoid.WalkSpeed = 16
            humanoid.JumpPower = 50
        end
        
        -- Clean up ESP
        for _, espObj in pairs(espObjects) do
            if espObj and espObj.Parent then
                espObj:Destroy()
            end
        end
        espObjects = {}
        
        -- Reset lighting
        pcall(function()
            Lighting.Brightness = 1
            Lighting.ClockTime = 12
            Lighting.FogEnd = 100000
            Lighting.GlobalShadows = true
            Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 70)
        end)
        
        -- Clean up fly objects
        if flyBodyVelocity then flyBodyVelocity:Destroy() end
        if flyBodyAngularVelocity then flyBodyAngularVelocity:Destroy() end
        
        -- Reset flags
        flyEnabled = false
        noclipEnabled = false
        espEnabled = false
        aimbotEnabled = false
        autoClickerEnabled = false
        chatSpamEnabled = false
        antiAfkEnabled = false
        infiniteJumpEnabled = false
        fullbrightEnabled = false
        
        notify("🧹 Cleanup", "All features cleaned up!", 3)
    end
})

SettingsTab:CreateButton({
    Name = "📊 Performance Info",
    Callback = function()
        local info = string.format([[
🎮 Executor: %s
📱 Platform: %s
⚡ Active Features: %d
💾 Memory: %s MB
📡 Ping: %s ms
⏱️ Uptime: %ds
        ]], 
        executor,
        isMobile and "Mobile" or "PC",
        activeConnections,
        pcall(function() return tostring(math.floor(game:GetService("Stats"):GetTotalMemoryUsageMb())) end) and tostring(math.floor(game:GetService("Stats"):GetTotalMemoryUsageMb())) or "N/A",
        pcall(function() return tostring(math.floor(LocalPlayer:GetNetworkPing() * 1000)) end) and tostring(math.floor(LocalPlayer:GetNetworkPing() * 1000)) or "N/A",
        math.floor(tick() - scriptStartTime)
        )
        setClipboard(info)
    end
})

-- ╔═══════════════════════════════════════════════════════════════════════╗
-- ║                         CREDITS TAB                                   ║
-- ╚═══════════════════════════════════════════════════════════════════════╝

local CreditsTab = Window:CreateTab("📜 Credits", 4335489547)

CreditsTab:CreateLabel("🎉 Tux's FREE Menu - Universal Edition")
CreditsTab:CreateLabel("👨‍💻 Created by: Tux Skidder")
CreditsTab:CreateLabel("🌟 Version: 3.0.1 - Fixed & Universal")
CreditsTab:CreateLabel("📱 Mobile & PC Compatible")
CreditsTab:CreateLabel("🔧 Works on: Xeno, Delta, Fluxus, Arceus X, etc.")
CreditsTab:CreateLabel("")
CreditsTab:CreateLabel("🔗 Join our Discord for more scripts!")

CreditsTab:CreateButton({
    Name = "📋 Copy Discord Invite",
    Callback = function()
        setClipboard("https://discord.gg/4F7rMQtGhe")
    end
})

CreditsTab:CreateButton({
    Name = "🌐 Get More Scripts",
    Callback = function()
        setClipboard("github.com/tuxskidder/nova-scripts")
    end
})

CreditsTab:CreateButton({
    Name = "⭐ Support the Project",
    Callback = function()
        setClipboard("Thanks for using Tux's FREE Menu! Please star our repository and share with friends!")
    end
})

CreditsTab:CreateLabel("")
CreditsTab:CreateLabel("🙏 Thanks for using Tux's FREE Menu!")
CreditsTab:CreateLabel("💝 This script is completely free and open source")

-- ╔═══════════════════════════════════════════════════════════════════════╗
-- ║                        INITIALIZATION                                 ║
-- ╚═══════════════════════════════════════════════════════════════════════╝

-- Character respawn handling
LocalPlayer.CharacterAdded:Connect(function(character)
    wait(2) -- Wait for character to fully load
    
    -- Reapply speed/jump if they were modified
    local humanoid = getHumanoid()
    if humanoid then
        if walkSpeed ~= 16 then
            humanoid.WalkSpeed = walkSpeed
        end
        if jumpPower ~= 50 then
            if humanoid.JumpPower then
                humanoid.JumpPower = jumpPower
            elseif humanoid.JumpHeight then
                humanoid.JumpHeight = jumpPower / 4
            end
        end
    end
    
    -- Reapply ESP if enabled
    if espEnabled then
        wait(1)
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                pcall(function()
                    local highlight = Instance.new("Highlight")
                    highlight.Name = "TuxESP"
                    highlight.FillColor = espColor
                    highlight.OutlineColor = Color3.new(1, 1, 1)
                    highlight.FillTransparency = 0.5
                    highlight.OutlineTransparency = 0
                    highlight.Parent = player.Character
                    table.insert(espObjects, highlight)
                end)
            end
        end
    end
end)

-- Cleanup on leaving
game:BindToClose(function()
    cleanupAllConnections()
end)

-- Final notifications
notify("🎉 Success!", "Tux's FREE Menu loaded successfully!", 3)
notify("📱 Platform", (isMobile and "Mobile mode enabled!" or "PC mode enabled!"), 2)
notify("🔧 Executor", "Running on: " .. executor, 2)

-- Console output
warn("✅ Tux's FREE Menu v3.0.1 - Universal Edition loaded!")
warn("📱 Platform: " .. (isMobile and "Mobile" or "PC"))
warn("🔧 Executor: " .. executor)
warn("🌟 All features are now compatible with your executor!")
warn("📋 Total lines: 800+ (Universal compatibility)")

-- Success message
print([[
╔═══════════════════════════════════════════════════╗
║            TUX'S FREE MENU LOADED!               ║
║                                                   ║
║  ✅ Universal Compatibility                      ║
║  📱 Mobile & PC Support                          ║
║  🔧 Works with all major executors               ║
║  🎯 Optimized for performance                    ║
║                                                   ║
║  Enjoy using Tux's FREE Menu!                    ║
╚═══════════════════════════════════════════════════╝
]])
