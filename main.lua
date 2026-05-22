--// HONEY HUB - MAIN.LUA (TUDO EM 1 ARQUIVO)

local redzlib = loadstring(game:HttpGet("COLOQUE_AQUI_O_RAW_DA_REDZLIB"))()

local Window = redzlib:MakeWindow({
    Title = "Honey-Hub",
    SubTitle = "by Breno",
    SaveFolder = "Honey.json",
    Icon = "",
    Key = "HONEY-8C2D9-4B5E7-6F1A3"
})

task.delay(0.1, function()
    redzlib:SetBackgroundImage(135003123565230)
end)

Window:Dialog({
    Title = "Dialog",
    Text = "This is a Dialog",
    Options = {
        {"Confirm", function()
            print("Confirmado")
        end},

        {"Maybe", function()
            print("Maybe")
        end},

        {"Cancel", function()
            print("Cancelado")
        end}
    }
})

local minimizeIcon = "rbxassetid://71014873973869"

pcall(function()
    if writefile and getcustomasset then
        if not isfile("honey_minimize.png") then
            local success, content = pcall(function()
                return game:HttpGet("https://iili.io/C9E3NXn.png")
            end)

            if success and content then
                writefile("honey_minimize.png", content)
            end
        end

        if isfile("honey_minimize.png") then
            minimizeIcon = getcustomasset("honey_minimize.png")
        end
    end
end)

Window:AddMinimizeButton({
    Button = {
        Image = minimizeIcon,
        BackgroundTransparency = 0,
        Size = UDim2.fromOffset(50, 20)
    },

    Corner = {
        CornerRadius = UDim.new(100, 1)
    }
})

local Tab1 = Window:MakeTab({"Teste", "cherry"})

Tab1:AddDiscordInvite({
    Name = "Honey Hub",
    Description = "Join server",
    Logo = "rbxassetid://18751483361",
    Invite = "Link discord invite"
})

Tab1:AddSection({"Section"})

Tab1:AddParagraph({
    "Paragraph",
    "This is a Paragraph\nSecond Line"
})

Tab1:AddButton({
    "Print",
    function()
        print("Hello World!")
    end
})

local Toggle1 = Tab1:AddToggle({
    Name = "Toggle",
    Description = "This is a Toggle Example",
    Default = false
})

Toggle1:Callback(function(Value)
    print("Toggle:", Value)
end)

Tab1:AddSlider({
    Name = "Speed",
    Min = 1,
    Max = 100,
    Increase = 1,
    Default = 16,

    Callback = function(Value)
        print("Speed:", Value)
    end
})
