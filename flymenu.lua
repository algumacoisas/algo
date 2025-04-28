--// Simples Menu Drag + Hacks (Lua) \\--

-- Variáveis de configuração
local settings = {
    flyEnabled = false,
    flySpeed = 50,
    walkSpeed = 16,
    jumpPower = 50,
    noclipEnabled = false,
    aimbotEnabled = false,
    aimbotFOV = 90
}

-- Criação da Interface (ScreenGui)
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")

ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "SimpleHackMenu"

MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Position = UDim2.new(0.1, 0, 0.1, 0)
MainFrame.Size = UDim2.new(0, 300, 0, 400)
MainFrame.Active = true
MainFrame.Draggable = true

UICorner.Parent = MainFrame

-- Função rápida para criar botões
local function createButton(text, parent, position, onClick)
    local button = Instance.new("TextButton")
    button.Parent = parent
    button.Size = UDim2.new(0, 280, 0, 30)
    button.Position = position
    button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255,255,255)
    button.Font = Enum.Font.Gotham
    button.TextSize = 14
    button.MouseButton1Click:Connect(onClick)
    return button
end

local yOffset = 10

-- Botão: Ativar/Desativar Fly
createButton("Fly: OFF", MainFrame, UDim2.new(0, 10, 0, yOffset), function(btn)
    settings.flyEnabled = not settings.flyEnabled
    btn.Text = "Fly: " .. (settings.flyEnabled and "ON" or "OFF")
end)

yOffset = yOffset + 40

-- Botão: Definir Fly Speed
createButton("Fly Speed: "..settings.flySpeed, MainFrame, UDim2.new(0, 10, 0, yOffset), function(btn)
    local input = tonumber(string.match(game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("Chat").Frame.ChatBarParentFrame.Frame.BoxFrame.Frame.ChatBar.Text, "%d+"))
    if input then
        settings.flySpeed = input
        btn.Text = "Fly Speed: "..settings.flySpeed
    end
end)

yOffset = yOffset + 40

-- Botão: Definir Walk Speed
createButton("Walk Speed: "..settings.walkSpeed, MainFrame, UDim2.new(0, 10, 0, yOffset), function(btn)
    local input = tonumber(string.match(game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("Chat").Frame.ChatBarParentFrame.Frame.BoxFrame.Frame.ChatBar.Text, "%d+"))
    if input then
        settings.walkSpeed = input
        btn.Text = "Walk Speed: "..settings.walkSpeed
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = settings.walkSpeed
    end
end)

yOffset = yOffset + 40

-- Botão: Definir Jump Power
createButton("Jump Power: "..settings.jumpPower, MainFrame, UDim2.new(0, 10, 0, yOffset), function(btn)
    local input = tonumber(string.match(game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("Chat").Frame.ChatBarParentFrame.Frame.BoxFrame.Frame.ChatBar.Text, "%d+"))
    if input then
        settings.jumpPower = input
        btn.Text = "Jump Power: "..settings.jumpPower
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = settings.jumpPower
    end
end)

yOffset = yOffset + 40

-- Botão: Ativar/Desativar Noclip
createButton("Noclip: OFF", MainFrame, UDim2.new(0, 10, 0, yOffset), function(btn)
    settings.noclipEnabled = not settings.noclipEnabled
    btn.Text = "Noclip: " .. (settings.noclipEnabled and "ON" or "OFF")
end)

yOffset = yOffset + 40

-- Botão: Ativar/Desativar Aimbot
createButton("Aimbot: OFF", MainFrame, UDim2.new(0, 10, 0, yOffset), function(btn)
    settings.aimbotEnabled = not settings.aimbotEnabled
    btn.Text = "Aimbot: " .. (settings.aimbotEnabled and "ON" or "OFF")
end)

yOffset = yOffset + 40

-- Botão: Definir FOV Aimbot
createButton("Aimbot FOV: "..settings.aimbotFOV, MainFrame, UDim2.new(0, 10, 0, yOffset), function(btn)
    local input = tonumber(string.match(game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("Chat").Frame.ChatBarParentFrame.Frame.BoxFrame.Frame.ChatBar.Text, "%d+"))
    if input then
        settings.aimbotFOV = input
        btn.Text = "Aimbot FOV: "..settings.aimbotFOV
    end
end)

-- Funções de Fly e Noclip
game:GetService("RunService").Stepped:Connect(function()
    local player = game.Players.LocalPlayer
    local humanoid = player.Character and player.Character:FindFirstChildWhichIsA("Humanoid")
    if not humanoid then return end

    if settings.flyEnabled then
        humanoid.PlatformStand = true
        player.Character:Move(Vector3.new(0, settings.flySpeed/10, 0))
    else
        humanoid.PlatformStand = false
    end

    if settings.noclipEnabled then
        for _,v in pairs(player.Character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
    end
end)

-- Função simples de Aimbot (somente exemplo básico)
game:GetService("RunService").RenderStepped:Connect(function()
    if settings.aimbotEnabled then
        -- Aqui você pode fazer seu algoritmo de mirar no inimigo mais próximo dentro do FOV
    end
end)

print("Script iniciado com sucesso!")
