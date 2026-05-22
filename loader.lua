local Fluent = loadstring(game:HttpGet(
"https://raw.githubusercontent.com/dawid-scripts/Fluent/master/source.lua"
))()

Fluent:SetTheme("Dark")

Fluent.Themes.Dark.Background = Color3.fromRGB(10, 20, 40)
Fluent.Themes.Dark.SecondaryBackground = Color3.fromRGB(20, 35, 65)
Fluent.Themes.Dark.Accent = Color3.fromRGB(0, 140, 255)
Fluent.Themes.Dark.Text = Color3.fromRGB(255,255,255)

local Window = Fluent:CreateWindow({
    Title = "Honey Hub",
    SubTitle = "Brookhaven",
    TabWidth = 170,
    Size = UDim2.fromOffset(850, 600),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    Main = Window:AddTab({ Title = "Main" }),
    Player = Window:AddTab({ Title = "Player" }),
    Teleport = Window:AddTab({ Title = "Teleport" }),
    Misc = Window:AddTab({ Title = "Misc" })
}

-- MAIN

Tabs.Main:AddParagraph({
    Title = "Honey Hub",
    Content = "Premium Brookhaven Script"
})

Tabs.Main:AddButton({
    Title = "Copy Discord",
    Callback = function()
        setclipboard("https://discord.gg/3b5YppShP")
    end
})

-- PLAYER

Tabs.Player:AddSlider("Speed", {
    Title = "WalkSpeed",
    Description = "Player Speed",
    Default = 16,
    Min = 16,
    Max = 100,
    Rounding = 1,

    Callback = function(Value)

        local Humanoid =
        game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")

        if Humanoid then
            Humanoid.WalkSpeed = Value
        end
    end
})

Tabs.Player:AddSlider("Jump", {
    Title = "JumpPower",
    Description = "Player Jump",
    Default = 50,
    Min = 50,
    Max = 200,
    Rounding = 1,

    Callback = function(Value)

        local Humanoid =
        game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")

        if Humanoid then
            Humanoid.JumpPower = Value
        end
    end
})

-- FLY

local Fly = false
local FlySpeed = 70

Tabs.Player:AddToggle("Fly", {
    Title = "Fly",
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

Tabs.Player:AddToggle("Noclip", {
    Title = "Noclip",
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

Tabs.Player:AddToggle("ESP", {
    Title = "ESP",
    Description = "See Players",
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

-- TELEPORTS

Tabs.Teleport:AddButton({
    Title = "Bank",

    Callback = function()

        game.Players.LocalPlayer.Character:MoveTo(
            Vector3.new(-399,23,73)
        )

    end
})

Tabs.Teleport:AddButton({
    Title = "Hospital",

    Callback = function()

        game.Players.LocalPlayer.Character:MoveTo(
            Vector3.new(-309,54,-25)
        )

    end
})

Tabs.Teleport:AddButton({
    Title = "Police",

    Callback = function()

        game.Players.LocalPlayer.Character:MoveTo(
            Vector3.new(-164,23,189)
        )

    end
})

Tabs.Teleport:AddButton({
    Title = "Spawn",

    Callback = function()

        game.Players.LocalPlayer.Character:MoveTo(
            Vector3.new(0,5,0)
        )

    end
})

-- MISC

Tabs.Misc:AddButton({
    Title = "Rejoin",

    Callback = function()

        game:GetService("TeleportService"):Teleport(
            game.PlaceId,
            game.Players.LocalPlayer
        )

    end
})

Fluent:Notify({
    Title = "Honey Hub",
    Content = "Loaded Successfully",
    Duration = 5
})
