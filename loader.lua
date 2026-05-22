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

local PlayerTab = Window:MakeTab({"Player","home"})

PlayerTab:AddSection({"Player Mods"})

-- SPEED

PlayerTab:AddSlider({
    Name = "WalkSpeed",
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

PlayerTab:AddSlider({
    Name = "JumpPower",
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

-- FLY

local FlyEnabled = false

PlayerTab:AddToggle({
    Name = "Fly",
    Description = "Smooth Fly",
    Default = false,
    Callback = function(Value)

        FlyEnabled = Value

        local plr = game.Players.LocalPlayer
        local char = plr.Character
        local hrp = char:WaitForChild("HumanoidRootPart")

        if Value then

            local BV = Instance.new("BodyVelocity")
            BV.Name = "HoneyFlyVelocity"
            BV.MaxForce = Vector3.new(1e9,1e9,1e9)
            BV.Velocity = Vector3.zero
            BV.Parent = hrp

            local BG = Instance.new("BodyGyro")
            BG.Name = "HoneyFlyGyro"
            BG.MaxTorque = Vector3.new(1e9,1e9,1e9)
            BG.P = 1000
            BG.CFrame = workspace.CurrentCamera.CFrame
            BG.Parent = hrp

            task.spawn(function()

                while FlyEnabled do
                    task.wait()

                    BV.Velocity =
                        workspace.CurrentCamera.CFrame.LookVector * 70

                    BG.CFrame =
                        workspace.CurrentCamera.CFrame
                end

                if hrp:FindFirstChild("HoneyFlyVelocity") then
                    hrp.HoneyFlyVelocity:Destroy()
                end

                if hrp:FindFirstChild("HoneyFlyGyro") then
                    hrp.HoneyFlyGyro:Destroy()
                end
            end)
        else

            if hrp:FindFirstChild("HoneyFlyVelocity") then
                hrp.HoneyFlyVelocity:Destroy()
            end

            if hrp:FindFirstChild("HoneyFlyGyro") then
                hrp.HoneyFlyGyro:Destroy()
            end
        end
    end
})

-- NOCLIP

local noclip = false

PlayerTab:AddToggle({
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

-- TELEPORT TAB

local TeleportTab =
Window:MakeTab({"Teleport","cherry"})

TeleportTab:AddSection({"Brookhaven Places"})

TeleportTab:AddButton({
    Name = "Bank",
    Callback = function()

        game.Players.LocalPlayer.Character:MoveTo(
            Vector3.new(-399,23,73)
        )

    end
})

TeleportTab:AddButton({
    Name = "Hospital",
    Callback = function()

        game.Players.LocalPlayer.Character:MoveTo(
            Vector3.new(-309,54,-25)
        )

    end
})

TeleportTab:AddButton({
    Name = "Police",
    Callback = function()

        game.Players.LocalPlayer.Character:MoveTo(
            Vector3.new(-164,23,189)
        )

    end
})

TeleportTab:AddButton({
    Name = "Spawn",
    Callback = function()

        game.Players.LocalPlayer.Character:MoveTo(
            Vector3.new(0,5,0)
        )

    end
})

-- MISC

local MiscTab =
Window:MakeTab({"Misc","settings"})

MiscTab:AddSection({"Hub"})

MiscTab:AddButton({
    Name = "Rejoin",
    Callback = function()

        game:GetService("TeleportService"):Teleport(
            game.PlaceId,
            game.Players.LocalPlayer
        )

    end
})

MiscTab:AddDiscordInvite({
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
