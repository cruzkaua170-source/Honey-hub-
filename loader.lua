local redzlib = loadstring(game:HttpGet(
"https://raw.githubusercontent.com/cruzkaua170-source/Honey-hub-/main/main.lua"))()

local Window = redzlib:MakeWindow({
    Title = "Honey-Hub",
    SubTitle = "Brookhaven",
    SaveFolder = "Honey.json",
    Key = "HONEYKEY"
})

task.delay(0.1,function()
    redzlib:SetBackgroundImage(135003123565230)
end)

-- PLAYER TAB

local PlayerTab = Window:MakeTab({"Player","user"})

PlayerTab:AddSection({"Player Mods"})

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

PlayerTab:AddButton({
    "Fly",
    function()

        loadstring(game:HttpGet(
            "https://pastebin.com/raw/YSL3xKYU"
        ))()

    end
})

local noclip = false

PlayerTab:AddToggle({
    Name = "Noclip",
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

-- VISUAL TAB

local VisualTab = Window:MakeTab({"Visual","eye"})

VisualTab:AddSection({"Visual Mods"})

VisualTab:AddButton({
    "ESP",
    function()

        loadstring(game:HttpGet(
            "https://raw.githubusercontent.com/ic3w0lf22/Unnamed-ESP/master/UnnamedESP.lua"
        ))()

    end
})

VisualTab:AddButton({
    "FullBright",
    function()

        game.Lighting.Brightness = 5
        game.Lighting.ClockTime = 12
        game.Lighting.FogEnd = 100000

    end
})

-- TROLL TAB

local TrollTab = Window:MakeTab({"Troll","skull"})

TrollTab:AddSection({"Troll Commands"})

TrollTab:AddButton({
    "Spin",
    function()

        local hrp =
            game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

        if hrp then

            while true do
                hrp.CFrame =
                    hrp.CFrame * CFrame.Angles(0,math.rad(30),0)

                task.wait()
            end

        end
    end
})

TrollTab:AddButton({
    "Reset",
    function()

        game.Players.LocalPlayer.Character:BreakJoints()

    end
})

-- PLAYER TAB 2

local PlayersTab = Window:MakeTab({"Players","users"})

PlayersTab:AddSection({"Player Commands"})

local PlayersList = {}

for _,v in pairs(game.Players:GetPlayers()) do
    if v ~= game.Players.LocalPlayer then
        table.insert(PlayersList,v.Name)
    end
end

local SelectedPlayer = nil

PlayersTab:AddDropdown({
    Name = "Select Player",
    Options = PlayersList,
    Default = PlayersList[1],

    Callback = function(Value)
        SelectedPlayer = Value
    end
})

PlayersTab:AddButton({
    "Teleport To Player",
    function()

        if SelectedPlayer then

            local plr =
                game.Players:FindFirstChild(SelectedPlayer)

            if plr and plr.Character then

                game.Players.LocalPlayer.Character:PivotTo(
                    plr.Character:GetPivot()
                )

            end
        end
    end
})

PlayersTab:AddButton({
    "View Player",
    function()

        if SelectedPlayer then

            local plr =
                game.Players:FindFirstChild(SelectedPlayer)

            if plr and plr.Character then

                workspace.CurrentCamera.CameraSubject =
                    plr.Character.Humanoid

            end
        end
    end
})

PlayersTab:AddButton({
    "UnView",
    function()

        workspace.CurrentCamera.CameraSubject =
            game.Players.LocalPlayer.Character.Humanoid

    end
})

-- MISC TAB

local MiscTab = Window:MakeTab({"Misc","settings"})

MiscTab:AddButton({
    "Infinite Yield",
    function()

        loadstring(game:HttpGet(
            "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"
        ))()

    end
})

MiscTab:AddButton({
    "Rejoin",
    function()

        game:GetService("TeleportService"):Teleport(
            game.PlaceId,
            game.Players.LocalPlayer
        )

    end
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
