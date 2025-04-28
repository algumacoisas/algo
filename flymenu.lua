--[[
Coloque isso em um LocalScript dentro de StarterGui
--]]

-- Variáveis
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local flying = false
local flySpeed = 50
local walkSpeed = 16

-- Criar a Interface
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 200, 0, 150)
frame.Position = UDim2.new(0.5, -100, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
frame.Active = true
frame.Draggable = true -- Torna o frame arrastável

local flyButton = Instance.new("TextButton", frame)
flyButton.Size = UDim2.new(1, -20, 0, 30)
flyButton.Position = UDim2.new(0, 10, 0, 10)
flyButton.Text = "Ativar/Desativar Voo"
flyButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)

local increaseFlySpeed = Instance.new("TextButton", frame)
increaseFlySpeed.Size = UDim2.new(1, -20, 0, 30)
increaseFlySpeed.Position = UDim2.new(0, 10, 0, 50)
increaseFlySpeed.Text = "Aumentar Velocidade do Voo"
increaseFlySpeed.BackgroundColor3 = Color3.fromRGB(100, 100, 100)

local decreaseFlySpeed = Instance.new("TextButton", frame)
decreaseFlySpeed.Size = UDim2.new(1, -20, 0, 30)
decreaseFlySpeed.Position = UDim2.new(0, 10, 0, 90)
decreaseFlySpeed.Text = "Diminuir Velocidade do Voo"
decreaseFlySpeed.BackgroundColor3 = Color3.fromRGB(100, 100, 100)

local walkSpeedBox = Instance.new("TextBox", frame)
walkSpeedBox.Size = UDim2.new(1, -20, 0, 30)
walkSpeedBox.Position = UDim2.new(0, 10, 0, 130)
walkSpeedBox.PlaceholderText = "Velocidade de Andar"
walkSpeedBox.BackgroundColor3 = Color3.fromRGB(100, 100, 100)

-- Funções
function toggleFly()
    flying = not flying

    if flying then
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Name = "FlyVelocity"
        bodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
        bodyVelocity.Velocity = Vector3.zero
        bodyVelocity.Parent = character.PrimaryPart

        game:GetService("RunService").Heartbeat:Connect(function()
            if flying and bodyVelocity.Parent then
                local moveDirection = humanoid.MoveDirection
                bodyVelocity.Velocity = moveDirection * flySpeed
            end
        end)
    else
        if character.PrimaryPart:FindFirstChild("FlyVelocity") then
            character.PrimaryPart.FlyVelocity:Destroy()
        end
    end
end

function setFlySpeed(newSpeed)
    flySpeed = newSpeed
end

function setWalkSpeed(newSpeed)
    walkSpeed = newSpeed
    humanoid.WalkSpeed = walkSpeed
end

-- Conectar botões
flyButton.MouseButton1Click:Connect(function()
    toggleFly()
end)

increaseFlySpeed.MouseButton1Click:Connect(function()
    setFlySpeed(flySpeed + 10)
end)

decreaseFlySpeed.MouseButton1Click:Connect(function()
    setFlySpeed(flySpeed - 10)
end)

walkSpeedBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local value = tonumber(walkSpeedBox.Text)
        if value then
            setWalkSpeed(value)
        end
    end
end)
