-- teleport_fruit.lua
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local RootPart = Character:WaitForChild("HumanoidRootPart")

local function teleportToFruit()
    local closestFruit = nil
    local closestDistance = math.huge -- Começa com um valor muito grande

    -- Percorrer todas as frutas no Workspace
    for _, item in ipairs(game.Workspace:GetChildren()) do
        if item:IsA("Part") and item.Name:match("Fruit") then -- Verifica se o item é uma parte e se o nome contém "Fruit"
            -- Calcular a distância entre o jogador e a fruta
            local distance = (RootPart.Position - item.Position).magnitude

            -- Verificar se essa fruta é a mais próxima até agora
            if distance < closestDistance then
                closestDistance = distance
                closestFruit = item
            end
        end
    end

    -- Teleportar o jogador para a fruta mais próxima, se encontrada
    if closestFruit then
        print("Teleportando para a fruta: " .. closestFruit.Name .. ", Distância: " .. math.floor(closestDistance) .. " studs")
        RootPart.CFrame = closestFruit.CFrame + Vector3.new(0, 3, 0) -- Teleporta o jogador para a posição da fruta, um pouco acima dela
    else
        print("Nenhuma fruta encontrada no raio de alcance.")
    end
end

return teleportToFruit
