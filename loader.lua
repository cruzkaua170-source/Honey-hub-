local redzlib = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/cruzkaua170-source/Honey-hub-/main/main.lua"
))()

local Window = redzlib:MakeWindow({
    Title = "Honey Hub",
    SubTitle = "Brookhaven",
    SaveFolder = "HoneyHub.json",
    Icon = "",
    Key = "HONEY-8C2D9-4B5E7-6F1A3"
})

task.delay(0.1, function()
    redzlib:SetBackgroundImage(135003123565230)
end)

local MainTab = Window:MakeTab({"Brookhaven", "home"})

MainTab:AddSection({"Player Commands"})

-- WALKSPEED
local walkspeedEnabled = false
local normalSpeed = 16

local WalkToggle = MainTab:AddToggle({
    Name = "Speed",
    Description = "Aumenta velocidade",
    Default = false
})

WalkToggle:Callback(function(Value)
    walkspeedEnabled = Value

    if Value then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 50
    else
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = normalSpeed
    end
end)

-- JUMPPOWER
local JumpToggle = MainTab:AddToggle({
    Name = "High Jump",
    Description = "Pulo alto",
    Default = false
})

JumpToggle:Callback(function(Value)
    if Value then
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = 120
    else
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
    end
end)

-- FLY
local flying = false
local bodyGyro
local bodyVelocity

local FlyToggle = MainTab:AddToggle({
    Name = "Fly",
    Description = "Voar com botão ligar/desligar",
    Default = false
})

FlyToggle:Callback(function(Value)
    flying = Value

    local player = game.Players.LocalPlayer
    local char = player.Character
    local hrp = char:WaitForChild("HumanoidRootPart")

    if Value then
        bodyGyro = Instance.new("BodyGyro")
        bodyVelocity = Instance.new("BodyVelocity")

        bodyGyro.P = 9e4
        bodyGyro.Parent = hrp
        bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        bodyGyro.CFrame = hrp.CFrame

        bodyVelocity.Parent = hrp
        bodyVelocity.Velocity = Vector3.new(0,0,0)
        bodyVelocity.MaxForce = Vector3.new(9e9,9e9,9e9)

        task.spawn(function()
            while flying do
                task.wait()

                bodyGyro.CFrame = workspace.CurrentCamera.CFrame
                bodyVelocity.Velocity = workspace.CurrentCamera.CFrame.LookVector * 70
            end
        end)
    else
        if bodyGyro then
            bodyGyro:Destroy()
        end

        if bodyVelocity then
            bodyVelocity:Destroy()
        end
    end
end)

-- NOCLIP
local noclip = false

local NoclipToggle = MainTab:AddToggle({
    Name = "Noclip",
    Description = "Atravessar paredes",
    Default = false
})

NoclipToggle:Callback(function(Value)
    noclip = Value

    task.spawn(function()
        while noclip do
            task.wait()

            local char = game.Players.LocalPlayer.Character

            if char then
                for _,v in pairs(char:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = false
                    end
                end
            end
        end
    end)
end)

-- ESP PLAYERS
local esp = false

local ESPToggle = MainTab:AddToggle({
    Name = "ESP Players",
    Description = "Ver jogadores pelas paredes",
    Default = false
})

ESPToggle:Callback(function(Value)
    esp = Value

    for _,player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer then

            if Value then
                local highlight = Instance.new("Highlight")
                highlight.Name = "HoneyESP"
                highlight.FillColor = Color3.fromRGB(255,0,0)
                highlight.OutlineColor = Color3.fromRGB(255,255,255)
                highlight.Parent = player.Character
            else
                if player.Character and player.Character:FindFirstChild("HoneyESP") then
                    player.Character.HoneyESP:Destroy()
                end
            end

        end
    end
end)

-- TELEPORT TOOL
MainTab:AddButton({
    Name = "Teleport Spawn",
    Callback = function()
        local char = game.Players.LocalPlayer.Character

        if char then
            char:MoveTo(Vector3.new(0,5,0))
        end
    end
})

-- REJOIN
MainTab:AddButton({
    Name = "Rejoin Server",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
    end
})

-- COPY DISCORD
MainTab:AddDiscordInvite({
    Name = "Honey Hub",
    Description = "Discord Oficial",
    Logo = "rbxassetid://18751483361",
    Invite = "https://discord.gg/3b5YppShP"
})
