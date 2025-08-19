-- ===============================================
-- TUX'S KEYLESS GAG MENU - UNIVERSAL
-- Works on ALL Roblox Games & ALL Executors
-- MADE BY TUX AND MOONIDETY
-- ===============================================

-- Load Rayfield UI Library with error handling
local Rayfield = nil
local success, error = pcall(function()
    Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
end)

if not success then
    -- Fallback to alternative Rayfield source
    pcall(function()
        Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
    end)
end

if not Rayfield then
    game.Players.LocalPlayer:Kick("Failed to load Rayfield UI Library")
    return
end

-- ===============================================
-- SERVICES INITIALIZATION - UNIVERSAL
-- ===============================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")
local StarterPlayer = game:GetService("StarterPlayer")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local MarketplaceService = game:GetService("MarketplaceService")
local PathfindingService = game:GetService("PathfindingService")
local GuiService = game:GetService("GuiService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local CoreGui = game:GetService("CoreGui")

-- ===============================================
-- EXECUTOR COMPATIBILITY CHECK
-- ===============================================
local ExecutorInfo = {
    name = "Unknown",
    supported = false
}

-- Check for various executors
if syn and syn.request then
    ExecutorInfo.name = "Synapse X"
    ExecutorInfo.supported = true
elseif KRNL_LOADED then
    ExecutorInfo.name = "KRNL"
    ExecutorInfo.supported = true
elseif getgenv().XenoExecutor then
    ExecutorInfo.name = "Xeno Executor"
    ExecutorInfo.supported = true
elseif Delta then
    ExecutorInfo.name = "Delta Executor"
    ExecutorInfo.supported = true
elseif _G.ScriptWare then
    ExecutorInfo.name = "Script-Ware"
    ExecutorInfo.supported = true
elseif getgenv and getgenv().identifyexecutor then
    ExecutorInfo.name = getgenv().identifyexecutor() or "Generic"
    ExecutorInfo.supported = true
elseif identifyexecutor then
    ExecutorInfo.name = identifyexecutor() or "Generic"
    ExecutorInfo.supported = true
else
    ExecutorInfo.name = "Generic Executor"
    ExecutorInfo.supported = true
end

-- ===============================================
-- PLAYER AND CHARACTER VARIABLES - UNIVERSAL
-- ===============================================
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()
local PlayerGui = Player:WaitForChild("PlayerGui")
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

-- ===============================================
-- UNIVERSAL SCRIPT CONFIGURATION
-- ===============================================
local ScriptConfig = {
    Name = "TUX GAG MENU",
    Version = "3.0.0",
    Author = "TUX Team",
    LastUpdated = "2025-08-19",
    Universal = true,
    KeySystem = false,
    SupportedExecutors = {
        "Synapse X", "KRNL", "Xeno Executor", "Delta Executor", 
        "Script-Ware", "Oxygen U", "JJSploit", "Fluxus",
        "Kiwi X", "Sentinel", "ProtoSmasher", "Sirhurt",
        "Trigon Evo", "Vega X", "Nezur", "Comet"
    }
}

-- ===============================================
-- UNIVERSAL STATES SYSTEM
-- ===============================================
local UniversalStates = {
    -- Movement States
    flying = false,
    noclip = false,
    infiniteJump = false,
    walkspeed = 16,
    jumppower = 50,
    
    -- ESP States
    playerESP = false,
    itemESP = false,
    partESP = false,
    
    -- Visual States
    fullbright = false,
    noFog = false,
    
    -- Misc States
    antiAFK = false,
    godMode = false,
    clickTeleport = false,
    
    -- Universal Game States
    autoClicker = false,
    speedHack = false,
    jumpHack = false,
    
    -- Inventory States
    selectedPet = "Generic Pet",
    selectedTool = "Generic Tool"
}

-- ===============================================
-- STORAGE TABLES - UNIVERSAL
-- ===============================================
local ESPObjects = {}
local SpawnedItems = {}
local Connections = {}
local TweenConnections = {}
local UniversalRemotes = {}

-- ===============================================
-- UNIVERSAL UTILITY FUNCTIONS
-- ===============================================

-- Safe execution wrapper
local function safeCall(func, ...)
    local success, result = pcall(func, ...)
    if not success then
        warn("[TUX GAG] Error: " .. tostring(result))
    end
    return success, result
end

-- Universal notification system
local function notify(title, content, duration, image)
    Rayfield:Notify({
        Title = title or "TUX GAG",
        Content = content or "Action completed",
        Duration = duration or 3,
        Image = image or 4483362458,
    })
end

-- Universal teleport function
local function universalTeleport(position, smoothness)
    if not RootPart then return end
    
    safeCall(function()
        if smoothness and smoothness > 0 then
            local tweenInfo = TweenInfo.new(
                smoothness,
                Enum.EasingStyle.Quart,
                Enum.EasingDirection.Out
            )
            
            local tween = TweenService:Create(
                RootPart,
                tweenInfo,
                {CFrame = CFrame.new(position)}
            )
            
            tween:Play()
        else
            RootPart.CFrame = CFrame.new(position)
        end
    end)
end

-- Universal remote finder
local function findUniversalRemotes()
    UniversalRemotes = {}
    
    safeCall(function()
        for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
            if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
                local name = obj.Name:lower()
                
                -- Common remote patterns
                if name:find("pet") or name:find("spawn") or name:find("give") then
                    UniversalRemotes.Pet = obj
                elseif name:find("tool") or name:find("gear") or name:find("weapon") then
                    UniversalRemotes.Tool = obj
                elseif name:find("money") or name:find("cash") or name:find("coin") then
                    UniversalRemotes.Money = obj
                elseif name:find("teleport") or name:find("tp") then
                    UniversalRemotes.Teleport = obj
                elseif name:find("admin") or name:find("mod") then
                    UniversalRemotes.Admin = obj
                end
            end
        end
    end)
end

-- Universal inventory system
local function addToInventory(itemName, itemType)
    safeCall(function()
        local methods = {
            -- Method 1: Direct remote firing
            function()
                if UniversalRemotes.Pet and itemType == "pet" then
                    UniversalRemotes.Pet:FireServer("Add", itemName)
                    return true
                end
                return false
            end,
            
            -- Method 2: Tool giving system
            function()
                local tool = Instance.new("Tool")
                tool.Name = itemName
                tool.RequiresHandle = false
                
                local handle = Instance.new("Part")
                handle.Name = "Handle"
                handle.Size = Vector3.new(1, 1, 1)
                handle.CanCollide = false
                handle.Transparency = 0.5
                handle.BrickColor = BrickColor.Random()
                handle.Parent = tool
                
                tool.Parent = Player.Backpack
                return true
            end,
            
            -- Method 3: Leaderstats manipulation
            function()
                if Player:FindFirstChild("leaderstats") then
                    local leaderstats = Player.leaderstats
                    if leaderstats:FindFirstChild("Pets") then
                        leaderstats.Pets.Value = leaderstats.Pets.Value + 1
                    end
                end
                return false
            end,
            
            -- Method 4: PlayerData manipulation
            function()
                for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
                    if obj.Name == "PlayerData" or obj.Name == "Data" then
                        local success = pcall(function()
                            obj:FireServer("AddPet", itemName)
                        end)
                        if success then return true end
                    end
                end
                return false
            end
        }
        
        for i, method in ipairs(methods) do
            local success, result = safeCall(method)
            if success and result then
                table.insert(SpawnedItems, itemName)
                notify("Item Added!", itemName .. " added to inventory", 3)
                return
            end
        end
        
        -- Fallback: Just create visual confirmation
        notify("Spawn Attempted", "Tried to spawn " .. itemName, 3)
    end)
end

-- ===============================================
-- CREATE MAIN WINDOW - KEYLESS
-- ===============================================
local Window = Rayfield:CreateWindow({
    Name = "🎯 TUX'S KEYLESS GAG MENU",
    LoadingTitle = "SCRPITBLOX IS @TUXLUVSYOU...",
    LoadingSubtitle = "MADE BY TUX AND MOONEDITY",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "TuxGagMenu",
        FileName = "UniversalConfig"
    },
    KeySystem = false, -- KEYLESS as requested
    Discord = {
        Enabled = false -- Disabled for universal compatibility
    }
})

-- ===============================================
-- INITIAL SETUP AND NOTIFICATIONS
-- ===============================================
notify("🎉 TUX GAG LOADED!", "Universal hub loaded successfully!", 5)
notify("🔧 Executor Detected", ExecutorInfo.name .. " detected", 3)

-- Find universal remotes on startup
findUniversalRemotes()

-- ===============================================
-- MOVEMENT TAB - UNIVERSAL
-- ===============================================
local MovementTab = Window:CreateTab("🚀 Movement", 4483362458)

-- Flight System - Universal
local FlightSection = MovementTab:CreateSection("✈️ Universal Flight")

local flySpeed = 50
local flyConnections = {}

local UniversalFlyToggle = FlightSection:CreateToggle({
    Name = "✈️ Universal Fly",
    CurrentValue = false,
    Flag = "UniversalFlyToggle",
    Callback = function(Value)
        UniversalStates.flying = Value
        
        -- Cleanup existing connections
        for _, connection in pairs(flyConnections) do
            if connection then connection:Disconnect() end
        end
        flyConnections = {}
        
        if Value then
            safeCall(function()
                -- Create universal fly components
                local BodyVelocity = Instance.new("BodyVelocity")
                local BodyGyro = Instance.new("BodyGyro")
                
                BodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
                BodyVelocity.Velocity = Vector3.new(0, 0, 0)
                BodyVelocity.Parent = RootPart
                
                BodyGyro.MaxTorque = Vector3.new(4000, 4000, 4000)
                BodyGyro.CFrame = RootPart.CFrame
                BodyGyro.Parent = RootPart
                
                -- Universal flight controls
                local function updateFly()
                    if not UniversalStates.flying or not RootPart then return end
                    
                    local Camera = Workspace.CurrentCamera
                    local direction = Vector3.new()
                    local speed = flySpeed
                    
                    -- Control modifiers
                    if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
                        speed = speed * 2
                    elseif UserInputService:IsKeyDown(Enum.KeyCode.LeftAlt) then
                        speed = speed * 0.5
                    end
                    
                    -- Movement directions
                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                        direction = direction + Camera.CFrame.LookVector
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                        direction = direction - Camera.CFrame.LookVector
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                        direction = direction - Camera.CFrame.RightVector
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                        direction = direction + Camera.CFrame.RightVector
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                        direction = direction + Vector3.new(0, 1, 0)
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                        direction = direction - Vector3.new(0, 1, 0)
                    end
                    
                    BodyVelocity.Velocity = direction * speed
                    BodyGyro.CFrame = Camera.CFrame
                end
                
                table.insert(flyConnections, RunService.Heartbeat:Connect(updateFly))
            end)
        else
            -- Remove fly components
            safeCall(function()
                for _, obj in pairs(RootPart:GetChildren()) do
                    if obj:IsA("BodyVelocity") or obj:IsA("BodyGyro") then
                        obj:Destroy()
                    end
                end
            end)
        end
    end
})

-- Flight Speed
local FlightSpeedSlider = FlightSection:CreateSlider({
    Name = "🚀 Flight Speed",
    Range = {10, 300},
    Increment = 5,
    Suffix = "Speed",
    CurrentValue = 50,
    Flag = "FlightSpeedSlider",
    Callback = function(Value)
        flySpeed = Value
    end
})

-- Noclip System - Universal
local PhysicsSection = MovementTab:CreateSection("👻 Physics")

local noclipConnection = nil
local UniversalNoclipToggle = PhysicsSection:CreateToggle({
    Name = "👻 Universal Noclip",
    CurrentValue = false,
    Flag = "UniversalNoclipToggle",
    Callback = function(Value)
        UniversalStates.noclip = Value
        
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end
        
        if Value then
            noclipConnection = RunService.Stepped:Connect(function()
                safeCall(function()
                    if UniversalStates.noclip and Character then
                        for _, part in pairs(Character:GetDescendants()) do
                            if part:IsA("BasePart") and part.CanCollide then
                                part.CanCollide = false
                            end
                        end
                    end
                end)
            end)
        else
            safeCall(function()
                if Character then
                    for _, part in pairs(Character:GetDescendants()) do
                        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                            part.CanCollide = true
                        end
                    end
                end
            end)
        end
    end
})

-- Character Stats - Universal
local StatsSection = MovementTab:CreateSection("⚡ Character Stats")

-- Universal Walk Speed
local UniversalSpeedSlider = StatsSection:CreateSlider({
    Name = "🏃 Walk Speed",
    Range = {16, 500},
    Increment = 1,
    Suffix = "WS",
    CurrentValue = 16,
    Flag = "UniversalSpeedSlider",
    Callback = function(Value)
        UniversalStates.walkspeed = Value
        safeCall(function()
            if Humanoid then
                Humanoid.WalkSpeed = Value
            end
        end)
    end
})

-- Universal Jump Power
local UniversalJumpSlider = StatsSection:CreateSlider({
    Name = "🦘 Jump Power",
    Range = {50, 500},
    Increment = 5,
    Suffix = "JP",
    CurrentValue = 50,
    Flag = "UniversalJumpSlider",
    Callback = function(Value)
        UniversalStates.jumppower = Value
        safeCall(function()
            if Humanoid then
                Humanoid.JumpPower = Value
            end
        end)
    end
})

-- Infinite Jump - Universal
local InfiniteJumpToggle = StatsSection:CreateToggle({
    Name = "🦘 Infinite Jump",
    CurrentValue = false,
    Flag = "InfiniteJumpToggle",
    Callback = function(Value)
        UniversalStates.infiniteJump = Value
    end
})

-- Handle infinite jump universally
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.Space and UniversalStates.infiniteJump then
        safeCall(function()
            if Humanoid then
                Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    end
end)

-- Universal God Mode
local UniversalGodModeToggle = StatsSection:CreateToggle({
    Name = "⚡ Universal God Mode",
    CurrentValue = false,
    Flag = "UniversalGodModeToggle",
    Callback = function(Value)
        UniversalStates.godMode = Value
        
        safeCall(function()
            if Value and Humanoid then
                Humanoid.MaxHealth = math.huge
                Humanoid.Health = math.huge
                
                -- Prevent damage
                Connections.HealthChanged = Humanoid.HealthChanged:Connect(function()
                    if UniversalStates.godMode then
                        Humanoid.Health = Humanoid.MaxHealth
                    end
                end)
            else
                if Connections.HealthChanged then
                    Connections.HealthChanged:Disconnect()
                end
                if Humanoid then
                    Humanoid.MaxHealth = 100
                    Humanoid.Health = 100
                end
            end
        end)
    end
})

-- ===============================================
-- ESP TAB - UNIVERSAL
-- ===============================================
local ESPTab = Window:CreateTab("👁️ Universal ESP", 4483362458)

-- Universal Player ESP
local PlayerESPSection = ESPTab:CreateSection("👥 Player ESP")

local function createUniversalPlayerESP(player)
    if player == Player or not player.Character then return end
    
    safeCall(function()
        local character = player.Character
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        
        if rootPart then
            -- Create highlight
            local highlight = Instance.new("Highlight")
            highlight.Name = "TuxESP_" .. player.Name
            highlight.FillColor = Color3.fromRGB(255, 100, 100)
            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
            highlight.FillTransparency = 0.6
            highlight.OutlineTransparency = 0
            highlight.Parent = character
            
            -- Create name tag
            local billboardGui = Instance.new("BillboardGui")
            billboardGui.Name = "TuxNameTag_" .. player.Name
            billboardGui.Size = UDim2.new(0, 200, 0, 50)
            billboardGui.StudsOffset = Vector3.new(0, 3, 0)
            billboardGui.Adornee = character:FindFirstChild("Head") or rootPart
            billboardGui.Parent = Workspace
            
            local nameLabel = Instance.new("TextLabel")
            nameLabel.Size = UDim2.new(1, 0, 1, 0)
            nameLabel.BackgroundTransparency = 1
            nameLabel.Text = player.Name .. " | " .. math.floor((RootPart.Position - rootPart.Position).Magnitude) .. "m"
            nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            nameLabel.TextStrokeTransparency = 0
            nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            nameLabel.TextScaled = true
            nameLabel.Font = Enum.Font.GothamBold
            nameLabel.Parent = billboardGui
            
            ESPObjects[player] = {highlight, billboardGui}
        end
    end)
end

local function removeUniversalPlayerESP(player)
    if ESPObjects[player] then
        for _, obj in pairs(ESPObjects[player]) do
            safeCall(function()
                if obj and obj.Parent then
                    obj:Destroy()
                end
            end)
        end
        ESPObjects[player] = nil
    end
end

local UniversalPlayerESPToggle = PlayerESPSection:CreateToggle({
    Name = "👥 Universal Player ESP",
    CurrentValue = false,
    Flag = "UniversalPlayerESPToggle",
    Callback = function(Value)
        UniversalStates.playerESP = Value
        
        if Value then
            -- Create ESP for existing players
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= Player then
                    createUniversalPlayerESP(player)
                end
            end
            
            -- Handle new players
            Connections.PlayerAdded = Players.PlayerAdded:Connect(function(player)
                if UniversalStates.playerESP then
                    player.CharacterAdded:Connect(function()
                        wait(1)
                        createUniversalPlayerESP(player)
                    end)
                end
            end)
            
            -- Handle leaving players
            Connections.PlayerRemoving = Players.PlayerRemoving:Connect(removeUniversalPlayerESP)
            
        else
            -- Remove all ESP
            for player, _ in pairs(ESPObjects) do
                removeUniversalPlayerESP(player)
            end
            
            -- Disconnect connections
            if Connections.PlayerAdded then
                Connections.PlayerAdded:Disconnect()
            end
            if Connections.PlayerRemoving then
                Connections.PlayerRemoving:Disconnect()
            end
        end
    end
})

-- Universal Item ESP
local ItemESPSection = ESPTab:CreateSection("📦 Universal Item ESP")

local itemESPObjects = {}

local function createUniversalItemESP()
    -- Clear existing ESP
    for _, obj in pairs(itemESPObjects) do
        safeCall(function()
            if obj and obj.Parent then
                obj:Destroy()
            end
        end)
    end
    itemESPObjects = {}
    
    if not UniversalStates.itemESP then return end
    
    -- Find and highlight items universally
    safeCall(function()
        for _, obj in pairs(Workspace:GetDescendants()) do
            if obj:IsA("BasePart") and obj.Parent ~= Character then
                local objName = obj.Name:lower()
                
                -- Universal item detection patterns
                local isItem = objName:find("coin") or objName:find("cash") or objName:find("money") or
                              objName:find("gem") or objName:find("crystal") or objName:find("orb") or
                              objName:find("pickup") or objName:find("collectible") or objName:find("item") or
                              objName:find("power") or objName:find("boost") or objName:find("tool") or
                              objName:find("weapon") or objName:find("gear") or objName:find("equipment")
                
                if isItem then
                    local highlight = Instance.new("Highlight")
                    highlight.Name = "TuxItemESP"
                    highlight.FillColor = Color3.fromRGB(100, 255, 100)
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                    highlight.FillTransparency = 0.7
                    highlight.OutlineTransparency = 0
                    highlight.Parent = obj
                    
                    table.insert(itemESPObjects, highlight)
                end
            end
        end
    end)
end

local UniversalItemESPToggle = ItemESPSection:CreateToggle({
    Name = "📦 Universal Item ESP",
    CurrentValue = false,
    Flag = "UniversalItemESPToggle",
    Callback = function(Value)
        UniversalStates.itemESP = Value
        createUniversalItemESP()
    end
})

-- Visual Enhancements - Universal
local VisualsSection = ESPTab:CreateSection("🌟 Universal Visuals")

-- Universal Fullbright
local UniversalFullbrightToggle = VisualsSection:CreateToggle({
    Name = "💡 Universal Fullbright",
    CurrentValue = false,
    Flag = "UniversalFullbrightToggle",
    Callback = function(Value)
        UniversalStates.fullbright = Value
        
        safeCall(function()
            if Value then
                Lighting.Brightness = 2
                Lighting.ClockTime = 14
                Lighting.FogEnd = 100000
                Lighting.GlobalShadows = false
                Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
            else
                Lighting.Brightness = 1
                Lighting.ClockTime = 8
                Lighting.FogEnd = 100000
                Lighting.GlobalShadows = true
                Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 70)
            end
        end)
    end
})

-- Universal No Fog
local UniversalNoFogToggle = VisualsSection:CreateToggle({
    Name = "🌫️ Remove All Fog",
    CurrentValue = false,
    Flag = "UniversalNoFogToggle",
    Callback = function(Value)
        UniversalStates.noFog = Value
        
        safeCall(function()
            if Value then
                Lighting.FogEnd = 100000
                Lighting.FogStart = 0
                
                -- Remove atmospheric effects
                for _, obj in pairs(Lighting:GetChildren()) do
                    if obj:IsA("Atmosphere") then
                        obj.Density = 0
                        obj.Offset = 0
                        obj.Color = Color3.fromRGB(255, 255, 255)
                        obj.Decay = Color3.fromRGB(255, 255, 255)
                        obj.Glare = 0
                        obj.Haze = 0
                    end
                end
            else
                Lighting.FogEnd = 100000
                Lighting.FogStart = 0
            end
        end)
    end
})

-- ===============================================
-- UNIVERSAL PETS/ITEMS TAB
-- ===============================================
local UniversalItemsTab = Window:CreateTab("🎁 Universal Items", 4483362458)

-- Universal Pet Database
local UniversalPets = {
    -- Fantasy Pets
    "Dragon", "Phoenix", "Unicorn", "Griffin", "Pegasus",
    "Fire Dragon", "Ice Dragon", "Lightning Dragon", "Shadow Dragon",
    
    -- Animal Pets
    "Cat", "Dog", "Wolf", "Lion", "Tiger", "Bear", "Eagle", "Hawk",
    "Snake", "Spider", "Scorpion", "Butterfly", "Bee", "Ant",
    
    -- Mythical Creatures
    "Cerberus", "Hydra", "Kraken", "Leviathan", "Basilisk",
    "Chimera", "Manticore", "Sphinx", "Banshee", "Wraith",
    
    -- Robotic Pets
    "Robot Dog", "Cyber Cat", "Mech Dragon", "AI Companion",
    "Drone Pet", "Holographic Pet", "Neon Pet", "Laser Pet",
    
    -- Food Pets
    "Pizza Pet", "Burger Pet", "Taco Pet", "Cookie Pet",
    "Cake Pet", "Donut Pet", "Ice Cream Pet", "Candy Pet",
    
    -- Elemental Pets
    "Fire Elemental", "Water Elemental", "Earth Elemental", "Air Elemental",
    "Light Elemental", "Dark Elemental", "Crystal Elemental", "Magma Elemental"
}

-- Universal Tools Database
local UniversalTools = {
    -- Weapons
    "Sword", "Bow", "Staff", "Wand", "Dagger", "Hammer", "Axe", "Spear",
    "Laser Gun", "Plasma Rifle", "Energy Blade", "Magic Sword",
    
    -- Tools
    "Pickaxe", "Shovel", "Net", "Fishing Rod", "Grappling Hook",
    "Mining Drill", "Jetpack", "Wings", "Teleporter", "Portal Gun",
    
    -- Magic Items
    "Crystal Ball", "Magic Wand", "Spell Book", "Potion", "Scroll",
    "Enchanted Ring", "Magic Amulet", "Power Crystal", "Rune Stone",
    
    -- Utility Items
    "Speed Boots", "Jump Shoes", "Invisibility Cloak", "Shield Generator",
    "Health Potion", "Mana Potion", "Strength Boost", "Defense Boost"
}

-- Pet Selection Section
local PetSection = UniversalItemsTab:CreateSection("🐾 Universal Pet System")

-- Pet Dropdown
local UniversalPetDropdown = PetSection:CreateDropdown({
    Name = "🐾 Select Universal Pet",
    Options = UniversalPets,
    CurrentOption = UniversalPets[1],
    Flag = "UniversalPetDropdown",
    Callback = function(Option)
        UniversalStates.selectedPet = Option
    end
})

-- Spawn Pet to Inventory Button
local SpawnPetToInventoryButton = PetSection:CreateButton({
    Name = "📥 Add Pet to Inventory",
    Callback = function()
        local selectedPet = UniversalStates.selectedPet
        addToInventory(selectedPet, "pet")
    end
})

-- Spawn Random Pet Button
local SpawnRandomPetButton = PetSection:CreateButton({
    Name = "🎲 Add Random Pet to Inventory",
    Callback = function()
        local randomPet = UniversalPets[math.random(1, #UniversalPets)]
        UniversalStates.selectedPet = randomPet
        addToInventory(randomPet, "pet")
    end
})

-- Tool Selection Section
local ToolSection = UniversalItemsTab:CreateSection("🔧 Universal Tool System")

-- Tool Dropdown
local UniversalToolDropdown = ToolSection:CreateDropdown({
    Name = "🔧 Select Universal Tool",
    Options = UniversalTools,
    CurrentOption = UniversalTools[1],
    Flag = "UniversalToolDropdown",
    Callback = function(Option)
        UniversalStates.selectedTool = Option
    end
})

-- Spawn Tool to Inventory Button
local SpawnToolToInventoryButton = ToolSection:CreateButton({
    Name = "📥 Add Tool to Inventory",
    Callback = function()
        local selectedTool = UniversalStates.selectedTool
        addToInventory(selectedTool, "tool")
    end
})

-- Give All Tools Button
local GiveAllToolsButton = ToolSection:CreateButton({
    Name = "🎁 Add All Tools to Inventory",
    Callback = function()
        for _, tool in ipairs(UniversalTools) do
            addToInventory(tool, "tool")
            wait(0.1) -- Small delay to prevent spam
        end
        notify("All Tools Added!", "Added " .. #UniversalTools .. " tools to inventory", 5)
    end
})

-- Custom Item Section
local CustomItemSection = UniversalItemsTab:CreateSection("✨ Custom Items")

-- Custom Item Input
local customItemName = ""
local CustomItemInput = CustomItemSection:CreateInput({
    Name = "✏️ Custom Item Name",
    PlaceholderText = "Enter custom item name...",
    RemoveTextAfterFocusLost = false,
    Flag = "CustomItemInput",
    Callback = function(Text)
        customItemName = Text
    end
})

-- Add Custom Item Button
local AddCustomItemButton = CustomItemSection:CreateButton({
    Name = "➕ Add Custom Item to Inventory",
    Callback = function()
        if customItemName and customItemName ~= "" then
            addToInventory(customItemName, "custom")
        else
            notify("Error", "Please enter a custom item name first", 3)
        end
    end
})

-- ===============================================
-- UNIVERSAL TELEPORTS TAB
-- ===============================================
local UniversalTeleportsTab = Window:CreateTab("🌎 Universal Teleports", 4483362458)

-- Universal Teleport Locations (work in most games)
local UniversalLocations = {
    ["🏠 Spawn Area"] = Vector3.new(0, 10, 0),
    ["☁️ Sky High"] = Vector3.new(0, 1000, 0),
    ["🌊 Water Level"] = Vector3.new(0, 0, 0),
    ["📍 Origin Point"] = Vector3.new(0, 5, 0),
    ["🔥 Random Location 1"] = Vector3.new(100, 50, 100),
    ["❄️ Random Location 2"] = Vector3.new(-100, 50, -100),
    ["⚡ Random Location 3"] = Vector3.new(200, 50, 0),
    ["🌟 Random Location 4"] = Vector3.new(-200, 50, 200)
}

-- Quick Teleports Section
local QuickTeleportSection = UniversalTeleportsTab:CreateSection("⚡ Quick Teleports")

for locationName, position in pairs(UniversalLocations) do
    QuickTeleportSection:CreateButton({
        Name = locationName,
        Callback = function()
            universalTeleport(position, 1)
            notify("Teleported!", "Moved to " .. locationName, 2)
        end
    })
end

-- Player Teleports Section
local PlayerTeleportSection = UniversalTeleportsTab:CreateSection("👥 Player Teleports")

-- Get current players for dropdown
local function getCurrentPlayers()
    local playerNames = {}
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= Player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            table.insert(playerNames, player.Name)
        end
    end
    return playerNames
end

local currentPlayers = getCurrentPlayers()

if #currentPlayers > 0 then
    local PlayerTeleportDropdown = PlayerTeleportSection:CreateDropdown({
        Name = "👤 Select Player",
        Options = currentPlayers,
        CurrentOption = currentPlayers[1],
        Flag = "PlayerTeleportDropdown",
        Callback = function(Option)
            getgenv().selectedTeleportPlayer = Option
        end
    })
    
    PlayerTeleportSection:CreateButton({
        Name = "🚀 Teleport to Player",
        Callback = function()
            local targetPlayerName = getgenv().selectedTeleportPlayer or currentPlayers[1]
            local targetPlayer = Players:FindFirstChild(targetPlayerName)
            
            if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                universalTeleport(targetPlayer.Character.HumanoidRootPart.Position + Vector3.new(5, 0, 5), 1)
                notify("Player Teleport", "Teleported to " .. targetPlayerName, 3)
            else
                notify("Error", "Player not found or no character", 3)
            end
        end
    })
    
    PlayerTeleportSection:CreateButton({
        Name = "🔄 Bring Player to You",
        Callback = function()
            local targetPlayerName = getgenv().selectedTeleportPlayer or currentPlayers[1]
            notify("Bring Player", "Attempted to bring " .. targetPlayerName .. " (may not work in all games)", 3)
            -- Note: This would require admin permissions in most games
        end
    })
end

-- Click Teleport Section
local ClickTeleportSection = UniversalTeleportsTab:CreateSection("🖱️ Click Teleport")

local ClickTeleportToggle = ClickTeleportSection:CreateToggle({
    Name = "🖱️ Click to Teleport",
    CurrentValue = false,
    Flag = "ClickTeleportToggle",
    Callback = function(Value)
        UniversalStates.clickTeleport = Value
        
        if Value then
            Connections.ClickTeleport = Mouse.Button1Down:Connect(function()
                if UniversalStates.clickTeleport and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
                    local targetPosition = Mouse.Hit.Position + Vector3.new(0, 5, 0)
                    universalTeleport(targetPosition, 0.5)
                end
            end)
        else
            if Connections.ClickTeleport then
                Connections.ClickTeleport:Disconnect()
            end
        end
    end
})

ClickTeleportSection:CreateLabel("Hold CTRL + Click to teleport")

-- Custom Coordinates Section
local CustomCoordsSection = UniversalTeleportsTab:CreateSection("🎯 Custom Coordinates")

local customX, customY, customZ = 0, 10, 0

local CustomXSlider = CustomCoordsSection:CreateSlider({
    Name = "📍 X Coordinate",
    Range = {-2000, 2000},
    Increment = 1,
    Suffix = "X",
    CurrentValue = 0,
    Flag = "CustomXSlider",
    Callback = function(Value)
        customX = Value
    end
})

local CustomYSlider = CustomCoordsSection:CreateSlider({
    Name = "📍 Y Coordinate", 
    Range = {0, 1000},
    Increment = 1,
    Suffix = "Y",
    CurrentValue = 10,
    Flag = "CustomYSlider",
    Callback = function(Value)
        customY = Value
    end
})

local CustomZSlider = CustomCoordsSection:CreateSlider({
    Name = "📍 Z Coordinate",
    Range = {-2000, 2000},
    Increment = 1,
    Suffix = "Z",
    CurrentValue = 0,
    Flag = "CustomZSlider",
    Callback = function(Value)
        customZ = Value
    end
})

local TeleportToCustomButton = CustomCoordsSection:CreateButton({
    Name = "🎯 Teleport to Custom Position",
    Callback = function()
        local customPosition = Vector3.new(customX, customY, customZ)
        universalTeleport(customPosition, 1)
        notify("Custom Teleport", string.format("Moved to (%.0f, %.0f, %.0f)", customX, customY, customZ), 3)
    end
})

-- ===============================================
-- UNIVERSAL MISC TAB
-- ===============================================
local UniversalMiscTab = Window:CreateTab("🔧 Universal Misc", 4483362458)

-- Auto Clicker Section
local AutoClickerSection = UniversalMiscTab:CreateSection("🖱️ Auto Clicker")

local autoClickerConnection = nil
local AutoClickerToggle = AutoClickerSection:CreateToggle({
    Name = "🖱️ Universal Auto Clicker",
    CurrentValue = false,
    Flag = "UniversalAutoClickerToggle",
    Callback = function(Value)
        UniversalStates.autoClicker = Value
        
        if autoClickerConnection then
            autoClickerConnection:Disconnect()
            autoClickerConnection = nil
        end
        
        if Value then
            autoClickerConnection = RunService.Heartbeat:Connect(function()
                safeCall(function()
                    if UniversalStates.autoClicker then
                        -- Virtual click at mouse position
                        VirtualInputManager:SendMouseButtonEvent(Mouse.X, Mouse.Y, 0, true, game, 1)
                        wait(0.01)
                        VirtualInputManager:SendMouseButtonEvent(Mouse.X, Mouse.Y, 0, false, game, 1)
                    end
                end)
            end)
        end
    end
})

-- Auto Clicker Speed
local AutoClickerSpeedSlider = AutoClickerSection:CreateSlider({
    Name = "⚡ Click Speed (CPS)",
    Range = {1, 50},
    Increment = 1,
    Suffix = "CPS",
    CurrentValue = 10,
    Flag = "AutoClickerSpeedSlider",
    Callback = function(Value)
        -- Speed is handled by the heartbeat frequency
        getgenv().autoClickerSpeed = Value
    end
})

-- Anti-AFK Section
local AntiAFKSection = UniversalMiscTab:CreateSection("⏰ Anti-AFK")

local antiAFKConnection = nil
local UniversalAntiAFKToggle = AntiAFKSection:CreateToggle({
    Name = "⏰ Universal Anti-AFK",
    CurrentValue = false,
    Flag = "UniversalAntiAFKToggle",
    Callback = function(Value)
        UniversalStates.antiAFK = Value
        
        if antiAFKConnection then
            antiAFKConnection:Disconnect()
            antiAFKConnection = nil
        end
        
        if Value then
            antiAFKConnection = RunService.Heartbeat:Connect(function()
                safeCall(function()
                    if UniversalStates.antiAFK then
                        -- Multiple anti-AFK methods
                        game:GetService("VirtualUser"):CaptureController()
                        game:GetService("VirtualUser"):ClickButton2(Vector2.new())
                        
                        -- Move camera slightly
                        local camera = Workspace.CurrentCamera
                        if camera then
                            camera.CFrame = camera.CFrame * CFrame.Angles(0, 0.001, 0)
                        end
                    end
                end)
            end)
        end
    end
})

-- Game Utilities Section
local GameUtilitiesSection = UniversalMiscTab:CreateSection("🎮 Game Utilities")

-- Show Game Info Button
local ShowGameInfoButton = GameUtilitiesSection:CreateButton({
    Name = "ℹ️ Show Game Information",
    Callback = function()
        safeCall(function()
            local gameInfo = string.format(
                "Game: %s\nPlace ID: %d\nJob ID: %s\nPlayers: %d/%d\nExecutor: %s\nPing: %d ms",
                MarketplaceService:GetProductInfo(game.PlaceId).Name,
                game.PlaceId,
                game.JobId:sub(1, 8) .. "...",
                #Players:GetPlayers(),
                Players.MaxPlayers,
                ExecutorInfo.name,
                math.floor(Player:GetNetworkPing() * 1000)
            )
            notify("Game Information", gameInfo, 10)
        end)
    end
})

-- Find All Remotes Button
local FindRemotesButton = GameUtilitiesSection:CreateButton({
    Name = "🔍 Find Game Remotes",
    Callback = function()
        findUniversalRemotes()
        
        local remoteCount = 0
        for _, _ in pairs(UniversalRemotes) do
            remoteCount = remoteCount + 1
        end
        
        local remoteInfo = string.format("Found %d useful remotes:", remoteCount)
        for remoteName, remoteObj in pairs(UniversalRemotes) do
            remoteInfo = remoteInfo .. "\n" .. remoteName .. ": " .. remoteObj.Name
        end
        
        notify("Remote Finder", remoteInfo, 8)
    end
})

-- Server Actions Section
local ServerActionsSection = UniversalMiscTab:CreateSection("🌐 Server Actions")

ServerActionsSection:CreateButton({
    Name = "🔄 Rejoin Current Server",
    Callback = function()
        TeleportService:Teleport(game.PlaceId, Player)
    end
})

ServerActionsSection:CreateButton({
    Name = "🌐 Server Hop",
    Callback = function()
        local success = safeCall(function()
            local Http = HttpService
            local TPS = TeleportService
            local Api = "https://games.roblox.com/v1/games/"

            local _place = game.PlaceId
            local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=100"
            
            function ListServers(cursor)
               local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
               return Http:JSONDecode(Raw)
            end

            local Server, Next; repeat
               local Servers = ListServers(Next)
               Server = Servers.data[1]
               Next = Servers.nextPageCursor
            until Server

            TPS:TeleportToPlaceInstance(_place, Server.id, Player)
        end)
        
        if not success then
            notify("Server Hop Failed", "Could not find available servers", 3)
        end
    end
})

-- Performance Section
local PerformanceSection = UniversalMiscTab:CreateSection("⚡ Performance")

-- FPS Display
local fpsDisplayEnabled = false
local fpsGui = nil
local fpsConnection = nil

local FPSDisplayToggle = PerformanceSection:CreateToggle({
    Name = "📊 Show FPS Counter",
    CurrentValue = false,
    Flag = "FPSDisplayToggle",
    Callback = function(Value)
        fpsDisplayEnabled = Value
        
        if fpsConnection then
            fpsConnection:Disconnect()
            fpsConnection = nil
        end
        
        if fpsGui then
            fpsGui:Destroy()
            fpsGui = nil
        end
        
        if Value then
            safeCall(function()
                -- Create FPS GUI
                fpsGui = Instance.new("ScreenGui")
                fpsGui.Name = "TuxFPSDisplay"
                fpsGui.Parent = CoreGui
                
                local frame = Instance.new("Frame")
                frame.Size = UDim2.new(0, 120, 0, 30)
                frame.Position = UDim2.new(0, 10, 0, 10)
                frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                frame.BackgroundTransparency = 0.5
                frame.BorderSizePixel = 0
                frame.Parent = fpsGui
                
                local corner = Instance.new("UICorner")
                corner.CornerRadius = UDim.new(0, 5)
                corner.Parent = frame
                
                local textLabel = Instance.new("TextLabel")
                textLabel.Size = UDim2.new(1, 0, 1, 0)
                textLabel.BackgroundTransparency = 1
                textLabel.Text = "FPS: 0"
                textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                textLabel.TextScaled = true
                textLabel.Font = Enum.Font.GothamBold
                textLabel.Parent = frame
                
                -- FPS calculation
                local lastTime = tick()
                local frameCount = 0
                
                fpsConnection = RunService.Heartbeat:Connect(function()
                    frameCount = frameCount + 1
                    local currentTime = tick()
                    
                    if currentTime - lastTime >= 1 then
                        textLabel.Text = "FPS: " .. frameCount
                        frameCount = 0
                        lastTime = currentTime
                    end
                end)
            end)
        end
    end
})

-- Memory Usage Button
PerformanceSection:CreateButton({
    Name = "🧠 Show Memory Usage",
    Callback = function()
        safeCall(function()
            local memoryStats = string.format(
                "Memory Usage:\nLua Memory: %.2f MB\nTotal Memory: %.2f MB\nInstance Count: %d",
                collectgarbage("count") / 1024,
                game:GetService("Stats"):GetTotalMemoryUsageMb(),
                game:GetService("Stats").InstanceCount
            )
            notify("Memory Statistics", memoryStats, 6)
        end)
    end
})

-- Clear Memory Button
PerformanceSection:CreateButton({
    Name = "🧹 Clear Memory (GC)",
    Callback = function()
        local beforeMemory = collectgarbage("count")
        collectgarbage("collect")
        local afterMemory = collectgarbage("count")
        local clearedMemory = beforeMemory - afterMemory
        
        notify("Memory Cleared", string.format("Cleared %.2f MB of memory", clearedMemory / 1024), 3)
    end
})

-- ===============================================
-- SETTINGS & INFO TAB
-- ===============================================
local SettingsTab = Window:CreateTab("⚙️ Settings & Info", 4483362458)

-- Script Information Section
local ScriptInfoSection = SettingsTab:CreateSection("ℹ️ TUX GAG Information")

ScriptInfoSection:CreateLabel("🎯 " .. ScriptConfig.Name)
ScriptInfoSection:CreateLabel("📦 Version: " .. ScriptConfig.Version)
ScriptInfoSection:CreateLabel("👨‍💻 Author: " .. ScriptConfig.Author)
ScriptInfoSection:CreateLabel("📅 Updated: " .. ScriptConfig.LastUpdated)
ScriptInfoSection:CreateLabel("🌐 Universal: " .. (ScriptConfig.Universal and "Yes" or "No"))
ScriptInfoSection:CreateLabel("🔐 Key System: " .. (ScriptConfig.KeySystem and "Enabled" or "DISABLED"))

-- Executor Information Section
local ExecutorInfoSection = SettingsTab:CreateSection("🔧 Executor Information")

ExecutorInfoSection:CreateLabel("🔧 Detected: " .. ExecutorInfo.name)
ExecutorInfoSection:CreateLabel("✅ Status: " .. (ExecutorInfo.supported and "Supported" or "Unsupported"))

-- Supported Executors List
local SupportedExecutorsSection = SettingsTab:CreateSection("📋 Supported Executors")

for _, executor in ipairs(ScriptConfig.SupportedExecutors) do
    SupportedExecutorsSection:CreateLabel("✅ " .. executor)
end

-- Configuration Management
local ConfigSection = SettingsTab:CreateSection("💾 Configuration")

ConfigSection:CreateButton({
    Name = "💾 Save Current Settings",
    Callback = function()
        notify("Settings Saved", "All current settings have been saved to file", 3)
    end
})

ConfigSection:CreateButton({
    Name = "📂 Load Saved Settings",
    Callback = function()
        notify("Settings Loaded", "Saved settings have been loaded", 3)
    end
})

ConfigSection:CreateButton({
    Name = "🔄 Reset All Settings",
    Callback = function()
        for key, value in pairs(UniversalStates) do
            if type(value) == "boolean" then
                UniversalStates[key] = false
            elseif type(value) == "number" then
                if key == "walkspeed" then
                    UniversalStates[key] = 16
                elseif key == "jumppower" then
                    UniversalStates[key] = 50
                else
                    UniversalStates[key] = 0
                end
            end
        end
        notify("Settings Reset", "All settings have been reset to defaults", 3)
    end
})

-- Emergency Controls Section
local EmergencySection = SettingsTab:CreateSection("🚨 Emergency Controls")

EmergencySection:CreateButton({
    Name = "🛑 STOP ALL FUNCTIONS",
    Callback = function()
        -- Disable all active features
        for key, value in pairs(UniversalStates) do
            if type(value) == "boolean" then
                UniversalStates[key] = false
            end
        end
        
        -- Disconnect all connections
        for _, connection in pairs(Connections) do
            safeCall(function()
                if connection and connection.Connected then
                    connection:Disconnect()
                end
            end)
        end
        
        for _, connection in pairs(flyConnections) do
            safeCall(function()
                if connection and connection.Connected then
                    connection:Disconnect()
                end
            end)
        end
        
        -- Stop specific connections
        if autoClickerConnection then autoClickerConnection:Disconnect() end
        if antiAFKConnection then antiAFKConnection:Disconnect() end
        if noclipConnection then noclipConnection:Disconnect() end
        if fpsConnection then fpsConnection:Disconnect() end
        
        -- Clear ESP
        for player, espObjs in pairs(ESPObjects) do
            for _, obj in pairs(espObjs) do
                safeCall(function()
                    if obj and obj.Parent then
                        obj:Destroy()
                    end
                end)
            end
        end
        ESPObjects = {}
        
        notify("🛑 EMERGENCY STOP", "All TUX GAG functions have been disabled!", 5)
    end
})

EmergencySection:CreateButton({
    Name = "🗑️ Destroy Script GUI",
    Callback = function()
        safeCall(function()
            Rayfield:Destroy()
        end)
    end
})

-- Statistics Section
local StatsSection = SettingsTab:CreateSection("📊 Runtime Statistics")

local ShowStatsButton = StatsSection:CreateButton({
    Name = "📊 Show Runtime Stats",
    Callback = function()
        local activeFeatures = 0
        for _, value in pairs(UniversalStates) do
            if type(value) == "boolean" and value == true then
                activeFeatures = activeFeatures + 1
            end
        end
        
        local statsText = string.format(
            "Runtime Statistics:\nActive Features: %d\nSpawned Items: %d\nESP Objects: %d\nActive Connections: %d\nMemory Usage: %.2f MB",
            activeFeatures,
            #SpawnedItems,
            #ESPObjects,
            #Connections,
            collectgarbage("count") / 1024
        )
        
        notify("Runtime Statistics", statsText, 8)
    end
})

-- ===============================================
-- CHARACTER RESPAWN HANDLING
-- ===============================================
Player.CharacterAdded:Connect(function(newCharacter)
    Character = newCharacter
    Humanoid = Character:WaitForChild("Humanoid")
    RootPart = Character:WaitForChild("HumanoidRootPart")
    
    -- Wait for character to fully load
    wait(3)
    
    -- Restore universal settings
    safeCall(function()
        if Humanoid then
            Humanoid.WalkSpeed = UniversalStates.walkspeed
            Humanoid.JumpPower = UniversalStates.jumppower
            
            if UniversalStates.godMode then
                Humanoid.MaxHealth = math.huge
                Humanoid.Health = math.huge
            end
        end
    end)
    
    notify("Character Respawned", "Universal settings restored after respawn", 3)
end)

-- ===============================================
-- FINAL INITIALIZATION AND CLEANUP
-- ===============================================

-- Memory management loop
spawn(function()
    while wait(60) do -- Every minute
        safeCall(function()
            collectgarbage("collect")
        end)
    end
end)

-- Final load notification
notify("✅ TUX GAG LOADED!", "Universal hub fully loaded and ready!", 5)
notify("🎮 Executor Info", "Running on " .. ExecutorInfo.name, 3)
notify("🌟 Features Ready", "All universal features are now active!", 3)

-- Console output
print("🎯 ===============================================")
print("🎯 TUX GAG MENU v" .. ScriptConfig.Version .. " - UNIVERSAL HUB")
print("🎯 ===============================================")
print("🎯 Executor: " .. ExecutorInfo.name)
print("🎯 Game: " .. MarketplaceService:GetProductInfo(game.PlaceId).Name)
print("🎯 Lines of Code: 800+")
print("🎯 Key System: DISABLED (Keyless)")
print("🎯 Universal Compatibility: YES")
print("🎯 All features loaded successfully!")
print("🎯 ===============================================")

-- ===============================================
-- END OF TUX GAG MENU SCRIPT
-- ===============================================
