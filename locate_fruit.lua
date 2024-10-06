-- locate_fruit.lua
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local RootPart = Character:WaitForChild("HumanoidRootPart")

local locateFruitModule = {}

-- Variáveis globais
local ESPPlayer = false
local DevilFruitESP = false
local IslandESP = false
local FlowerESP = false
local Number = math.random(1, 1000000)

-- Função para verificar se a fruta está em um local específico
local function isFruitInArea(fruit)
    return fruit:IsA("Part") and fruit.Name:match("Fruit") -- Verifica se a parte é uma fruta
end

-- Atualiza a visualização dos jogadores
function locateFruitModule.UpdatePlayerChams()
    for _, player in pairs(game:GetService("Players"):GetChildren()) do
        pcall(function()
            if player.Character then
                if ESPPlayer then
                    if player.Character.Head and not player.Character.Head:FindFirstChild('NameEsp'..Number) then
                        local bill = Instance.new('BillboardGui', player.Character.Head)
                        bill.Name = 'NameEsp'..Number
                        bill.ExtentsOffset = Vector3.new(0, 1, 0)
                        bill.Size = UDim2.new(1, 200, 1, 30)
                        bill.AlwaysOnTop = true
                        local name = Instance.new('TextLabel', bill)
                        name.Font = Enum.Font.GothamSemibold
                        name.FontSize = "Size14"
                        name.TextWrapped = true
                        name.Text = (player.Name ..' \n'.. round((LocalPlayer.Character.Head.Position - player.Character.Head.Position).Magnitude/3) ..' Distance')
                        name.Size = UDim2.new(1, 0, 1, 0)
                        name.TextYAlignment = 'Top'
                        name.BackgroundTransparency = 1
                        name.TextStrokeTransparency = 0.5
                        if player.Team == LocalPlayer.Team then
                            name.TextColor3 = Color3.new(0, 255, 0)
                        else
                            name.TextColor3 = Color3.new(255, 0, 0)
                        end
                    else
                        player.Character.Head['NameEsp'..Number].TextLabel.Text = (player.Name ..' | '.. round((LocalPlayer.Character.Head.Position - player.Character.Head.Position).Magnitude/3) ..' Distance\nHealth : ' .. round(player.Character.Humanoid.Health*100/player.Character.Humanoid.MaxHealth) .. '%')
                    end
                else
                    if player.Character.Head:FindFirstChild('NameEsp'..Number) then
                        player.Character.Head:FindFirstChild('NameEsp'..Number):Destroy()
                    end
                end
            end
        end)
    end
end

-- Função para localizar a fruta mais próxima
function locateFruitModule.locateFruit()
    local closestFruit = nil
    local closestDistance = math.huge -- Começa com um valor muito grande

    -- Percorrer todas as partes no Workspace para localizar frutas
    for _, fruit in ipairs(game.Workspace:GetChildren()) do
        if isFruitInArea(fruit) then
            -- Calcular a distância entre o jogador e a fruta
            local distance = (RootPart.Position - fruit.Position).magnitude

            -- Verificar se essa fruta é a mais próxima até agora
            if distance < closestDistance then
                closestDistance = distance
                closestFruit = fruit -- Armazena a referência à fruta encontrada
            end
        end
    end

    -- Exibir as informações da fruta mais próxima
    if closestFruit then
        print("Fruta mais próxima: " .. closestFruit.Name .. ", Distância: " .. math.floor(closestDistance) .. " studs")
    else
        print("Nenhuma fruta encontrada no raio de alcance.")
    end

    return closestFruit -- Retorna a fruta mais próxima
end

-- Função para ativar/desativar o ESP de jogadores
function locateFruitModule.SetPlayerESP(enabled)
    ESPPlayer = enabled
    if enabled then
        locateFruitModule.UpdatePlayerChams()
    end
end

-- Função para ativar/desativar o ESP de frutas
function locateFruitModule.SetFruitESP(enabled)
    DevilFruitESP = enabled
    while DevilFruitESP do wait()
        locateFruitModule.UpdatePlayerChams() -- Atualize conforme necessário
    end
end

-- Função para ativar/desativar o ESP de ilhas
function locateFruitModule.SetIslandESP(enabled)
    IslandESP = enabled
    while IslandESP do wait()
        locateFruitModule.UpdatePlayerChams() -- Atualize conforme necessário
    end
end

-- Função para ativar/desativar o ESP de flores
function locateFruitModule.SetFlowerESP(enabled)
    FlowerESP = enabled
    locateFruitModule.UpdatePlayerChams() -- Atualize conforme necessário
end

return locateFruitModule
