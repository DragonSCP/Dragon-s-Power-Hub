-- locate_fruit.lua
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local RootPart = Character:WaitForChild("HumanoidRootPart")
local Fruits = {"Mera", "Gura", "Suna", "Hie", "Magu", "Yami"} -- Adicione os nomes das frutas que você quer localizar aqui

local function locateFruit()
    local closestFruit = nil
    local closestDistance = math.huge -- Começa com um valor muito grande

    -- Percorrer todas as frutas no jogo
    for _, fruitName in ipairs(Fruits) do
        local fruit = game.Workspace:FindFirstChild(fruitName) -- Verifica se a fruta está no Workspace
        if fruit then
            -- Calcular a distância entre o jogador e a fruta
            local distance = (RootPart.Position - fruit.Position).magnitude

            -- Verificar se essa fruta é a mais próxima até agora
            if distance < closestDistance then
                closestDistance = distance
                closestFruit = fruitName
            end
        end
    end

    -- Exibir as informações da fruta mais próxima
    if closestFruit then
        print("Fruta mais próxima: " .. closestFruit .. ", Distância: " .. math.floor(closestDistance) .. " studs")
    else
        print("Nenhuma fruta encontrada no raio de alcance.")
    end
end

return locateFruit
