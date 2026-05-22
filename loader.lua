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

-- PLAYER TAB

local PlayerTab = Window:MakeTab({"Player","user"})

PlayerTab:AddSection({"Player Mods"})

-- SPEED

PlayerTab:AddSlider({
    Name = "WalkSpeed",
    Min = 16,
    Max = 200,
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
    Max = 300,
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

local Fly = false
local FlySpeed = 80

PlayerTab:AddToggle({
    Name = "Fly",
    Description = "Smooth Fly",

    Default = false,

    Callback = function(Value)

        Fly = Value

        local player = game.Players.LocalPlayer
        local char = player.Character
        local hrp = char:WaitForChild("HumanoidRootPart")

        if Fly then

            local BV = Instance.new("BodyVelocity")
            BV.MaxForce = Vector3.new(9e9,9e9,9e9)
            BV.Velocity = Vector3.zero
            BV.Parent = hrp

            local BG = Instance.new("BodyGyro")
            BG.MaxTorque = Vector3.new(9e9,9e9,9e9)
            BG.P = 1000
            BG.CFrame = workspace.CurrentCamera.CFrame
            BG.Parent = hrp

            task.spawn(function()

                while Fly do
                    task.wait()

                    local cam = workspace.CurrentCamera

                    BG.CFrame = cam.CFrame

                    BV.Velocity =
                        cam.CFrame.LookVector * FlySpeed
                end

                BV:Destroy()
                BG:Destroy()

            end)
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

-- ESP

local ESP = false

PlayerTab:AddToggle({
    Name = "ESP Players",
    Description = "See Players",

    Default = false,

    Callback = function(Value)

        ESP = Value

        for _,plr in pairs(game.Players:GetPlayers()) do

            if plr ~= game.Players.LocalPlayer then

                if Value then

                    local Highlight =
                    Instance.new("Highlight")

                    Highlight.Name = "HoneyESP"
                    Highlight.FillTransparency = 0.5
                    Highlight.OutlineTransparency = 0
                    Highlight.Parent = plr.Character

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

-- TELEPORT TAB

local TeleportTab =
Window:MakeTab({"Teleport","map-pin"})

TeleportTab:AddSection({"Brookhaven Places"})

TeleportTab:AddButton({
    "Bank",
    function()

        game.Players.LocalPlayer.Character:MoveTo(
            Vector3.new(-399,23,73)
        )

    end
})

TeleportTab:AddButton({
    "Hospital",
    function()

        game.Players.LocalPlayer.Character:MoveTo(
            Vector3.new(-309,54,-25)
        )

    end
})

TeleportTab:AddButton({
    "Police",
    function()

        game.Players.LocalPlayer.Character:MoveTo(
            Vector3.new(-164,23,189)
        )

    end
})

TeleportTab:AddButton({
    "Spawn",
    function()

        game.Players.LocalPlayer.Character:MoveTo(
            Vector3.new(0,5,0)
        )

    end
})

-- VEHICLE TAB

local VehicleTab =
Window:MakeTab({"Vehicle","car"})

VehicleTab:Add
