repeat task.wait() until game:IsLoaded()

local Fluent = loadstring(game:HttpGet(
"https://raw.githubusercontent.com/dawid-scripts/Fluent/master/source.lua"
))()

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

Tabs.Player:AddSlider("Speed", {
    Title = "WalkSpeed",
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

Fluent:Notify({
    Title = "Honey Hub",
    Content = "Loaded Successfully",
    Duration = 5
})
