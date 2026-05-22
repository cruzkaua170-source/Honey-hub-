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

task.delay(0.1,function()
    redzlib:SetBackgroundImage(135003123565230)
end)

local MainTab = Window:MakeTab({"Brookhaven","home"})

MainTab:AddSection({"Player"})

-- SPEED

MainTab:AddSlider({
    Name = "Speed",
    Min = 16,
    Max = 100,
    Increase = 1,
    Default = 16,

    Callback = function(Value)

        local Humanoid =
        game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")

        if Humanoid then
            Humanoid.WalkSpeed = Value
        end
    end
})

-- JUMP

MainTab:AddSlider({
    Name = "Jump",
    Min = 50,
    Max = 200,
    Increase = 1,
    Default = 50,

    Callback = function(Value)

        local Humanoid =
        game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")

        if Humanoid then
            Humanoid.JumpPower = Value
        end
    end
})

-- FLY PREMIUM

local Fly = false
local FlySpeed = 70

MainTab:AddToggle({
    Name = "Fly",
    Description = "Smooth Fly",
    Default = false,

    Callback = function(Value)

        Fly = Value

        local player = game.Players.LocalPlayer
        local char = player.Character
        local hrp = char:WaitForChild("HumanoidRootPart")
        local humanoid = char:WaitForChild("Humanoid")

        if Fly then

            local BG = Instance.new("BodyGyro")
            BG.Name = "HoneyFlyGyro"
            BG.P = 9e4
            BG.Parent = hrp
            BG.MaxTorque = Vector3.new(9e9,9e9,9e9)
            BG.CFrame = hrp.CFrame

            local BV = Instance.new("BodyVelocity")
            BV.Name = "HoneyFlyVelocity"
            BV.Parent = hrp
            BV.MaxForce = Vector3.new(9e9,9e9,9e9)
            BV.Velocity = Vector3.new(0,0,0)

            task.spawn(function()

                while Fly do
                    task.wait()

                    humanoid.PlatformStand = true

                    local cam = workspace.CurrentCamera
                    local moveDirection = humanoid.MoveDirection

                    BV.Velocity =
                        (cam.CFrame.LookVector * moveDirection.Z +
                        cam.CFrame.RightVector * moveDirection.X)
                        * FlySpeed

                    BG.CFrame = cam.CFrame
                end

                humanoid.PlatformStand = false

                if hrp:FindFirstChild("HoneyFlyGyro") then
                    hrp.HoneyFlyGyro:Destroy()
                end

                if hrp:FindFirstChild("HoneyFlyVelocity") then
                    hrp.HoneyFlyVelocity:Destroy()
                end
            end)

        else

            humanoid.PlatformStand = false

            if hrp:FindFirstChild("HoneyFlyGyro") then
                hrp.HoneyFlyGyro:Destroy()
            end

            if hrp:FindFirstChild("HoneyFlyVelocity") then
                hrp.HoneyFlyVelocity:Destroy()
            end
        end
    end
})

-- NOCLIP

local noclip = false

MainTab:AddToggle({
    Name = "Noclip",
    Description = "Walk Through Walls",
    Default = false,

    Callback = function(Value)
        noclip = Value
    end
})

game:GetService("RunService").Stepped:Connect(function()

    if noclip then

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

-- ESP

local esp = false

MainTab:AddToggle({
    Name = "ESP",
    Description = "Players ESP",
    Default = false,

    Callback = function(Value)

        esp = Value

        for _,plr in pairs(game.Players:GetPlayers()) do

            if plr ~= game.Players.LocalPlayer then

                if Value then

                    if plr.Character and
                    not plr.Character:FindFirstChild("HoneyESP") then

                        local Highlight = Instance.new("Highlight")
                        Highlight.Name = "HoneyESP"
                        Highlight.FillTransparency = 0.5
                        Highlight.OutlineTransparency = 0
                        Highlight.Parent = plr.Character
                    end

                else

                    if plr.Character and
                    plr.Character:FindFirstChild("HoneyESP") then

                        plr.Character.HoneyESP:Destroy()
                    end
                end
            end
        end
    end
})

MainTab:AddSection({"Teleport"})

MainTab:AddButton({
    Name = "Bank",
    Callback = function()

        game.Players.LocalPlayer.Character:MoveTo(
            Vector3.new(-399,23,73)
        )

    end
})

MainTab:AddButton({
    Name = "Hospital",
    Callback = function()

        game.Players.LocalPlayer.Character:MoveTo(
            Vector3.new(-309,54,-25)
        )

    end
})

MainTab:AddButton({
    Name = "Police",
    Callback = function()

        game.Players.LocalPlayer.Character:MoveTo(
            Vector3.new(-164,23,189)
        )

    end
})

MainTab:AddButton({
    Name = "Spawn",
    Callback = function()

        game.Players.LocalPlayer.Character:MoveTo(
            Vector3.new(0,5,0)
        )

    end
})

MainTab:AddSection({"Misc"})

MainTab:AddButton({
    Name = "Rejoin",
    Callback = function()

        game:GetService("TeleportService"):Teleport(
            game.PlaceId,
            game.Players.LocalPlayer
        )

    end
})

MainTab:AddDiscordInvite({
    Name = "Honey Hub",
    Description = "Join Discord",
    Logo = "rbxassetid://18751483361",
    Invite = "https://discord.gg/3b5YppShP"
})

local minimizeIcon = "rbxassetid://71014873973869"

Window:AddMinimizeButton({
    Button = {
        Image = minimizeIcon,
        BackgroundTransparency = 0,
        Size = UDim2.fromOffset(50,20)
    },

    Corner = {
        CornerRadius = UDim.new(100,1)
    },
})
