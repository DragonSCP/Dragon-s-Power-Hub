-- locate_fruit.lua
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local RootPart = Character:WaitForChild("HumanoidRootPart")

-- Função para verificar se a fruta está em um local específico
local function isFruitInArea(fruit)
    return fruit:IsA("Part") and fruit.Name:match("Fruit") -- Verifica se a parte é uma fruta
end

local function locateFruit()
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

return locateFruit
