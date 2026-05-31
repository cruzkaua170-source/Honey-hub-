local redzlib = loadstring(game:HttpGet(
"https://raw.githubusercontent.com/cruzkaua170-source/Honey-hub-/main/main.lua"))()

local Window = redzlib:MakeWindow({
    Title = "Honey Hub",
    SubTitle = "Brookhaven Utility",
    SaveFolder = "Honey.json",
    Icon = "",
    Key = "HONEY-8C2D9-4B5E7-6F1A3"
})

task.delay(0.1, function()
    redzlib:SetBackgroundImage(135003123565230)
end)

-- Criação das Abas (Removida a aba de trapaças)
local MainTab = Window:MakeTab({"Início", "home"})
local PlayerTab = Window:MakeTab({"Jogador", "user"})
local TeleportTab = Window:MakeTab({"Teleporte", "map"})
local MiscTab = Window:MakeTab({"Outros", "settings"})

-- ==========================================
-- ABA INÍCIO (MAIN)
-- ==========================================

MainTab:AddParagraph({
    "Honey Hub",
    "Painel Utilitário Próprio para Brookhaven"
})

MainTab:AddDiscordInvite({
    Name = "Honey Hub",
    Description = "Entre no nosso Discord",
    Logo = "rbxassetid://18751483361",
    Invite = "https://discord.gg/3b5YppShP"
})

-- ==========================================
-- ABA JOGADOR (PLAYER MODS)
-- ==========================================

PlayerTab:AddSection({"Configurações do Personagem"})

-- Controle deslizante para ajustar a velocidade padrão de caminhada
PlayerTab:AddSlider({
    Name = "Velocidade (WalkSpeed)",
    Min = 16,
    Max = 60, -- Limitado a um valor padrão seguro
    Increase = 1,
    Default = 16,
    Callback = function(Value)
        local Character = game.Players.LocalPlayer.Character
        if Character then
            local Humanoid = Character:FindFirstChild("Humanoid")
            if Humanoid then
                Humanoid.WalkSpeed = Value
            end
        end
    end
})

-- Controle deslizante para ajustar a altura do pulo padrão
PlayerTab:AddSlider({
    Name = "Força do Pulo (JumpPower)",
    Min = 50,
    Max = 120, -- Limitado a um valor padrão seguro
    Increase = 1,
    Default = 50,
    Callback = function(Value)
        local Character = game.Players.LocalPlayer.Character
        if Character then
            local Humanoid = Character:FindFirstChild("Humanoid")
            if Humanoid then
                Humanoid.UseJumpPower = true
                Humanoid.JumpPower = Value
            end
        end
    end
})

-- ==========================================
-- ABA TELEPORTES (TELEPORT PLACES)
-- ==========================================

TeleportTab:AddSection({"Locais Disponíveis"})

TeleportTab:AddButton({
    Name = "Banco",
    Callback = function()
        local Character = game.Players.LocalPlayer.Character
        if Character and Character:FindFirstChild("HumanoidRootPart") then
            Character:MoveTo(Vector3.new(-399, 23, 73))
        end
    end
})

TeleportTab:AddButton({
    Name = "Hospital",
    Callback = function()
        local Character = game.Players.LocalPlayer.Character
        if Character and Character:FindFirstChild("HumanoidRootPart") then
            Character:MoveTo(Vector3.new(-309, 54, -25))
        end
    end
})

TeleportTab:AddButton({
    Name = "Polícia",
    Callback = function()
        local Character = game.Players.LocalPlayer.Character
        if Character and Character:FindFirstChild("HumanoidRootPart") then
            Character:MoveTo(Vector3.new(-164, 23, 189))
        end
    end
})

TeleportTab:AddButton({
    Name = "Spawn Principal",
    Callback = function()
        local Character = game.Players.LocalPlayer.Character
        if Character and Character:FindFirstChild("HumanoidRootPart") then
            Character:MoveTo(Vector3.new(0, 5, 0))
        end
    end
})

-- ==========================================
-- ABA OUTROS (MISC)
-- ==========================================

MiscTab:AddSection({"Opções do Servidor"})

-- Botão para reconectar ao mesmo servidor rapidamente em caso de travamento
MiscTab:AddButton({
    Name = "Reentrar no Servidor (Rejoin)",
    Callback = function()
        game:GetService("TeleportService"):Teleport(
            game.PlaceId,
            game.Players.LocalPlayer
        )
    end
})

-- Icone e Botão para Minimizar o Menu do RedzLib
local minimizeIcon = "rbxassetid://71014873973869"

Window:AddMinimizeButton({
    Button = {
        Image = minimizeIcon,
        BackgroundTransparency = 0,
        Size = UDim2.fromOffset(50, 20)
    },
    Corner = {
        CornerRadius = UDim.new(100, 1)
    },
})
