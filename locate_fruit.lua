local AutoCollectEnabled = false
local function findAndStoreFruits()
    while AutoCollectEnabled do
        local Fruit_InServer = false
        local Fruits_InServer = {}
        local Fruit_InHand = nil

        for _, v in ipairs(workspace:GetChildren()) do
            if v:IsA("Tool") and v:FindFirstChild("Handle") then
                Fruit_InServer = true
                table.insert(Fruits_InServer, v)
            end
        end

        if Fruit_InServer then
            for _, v in pairs(Fruits_InServer) do
                returnHRP().CFrame = v.Handle.CFrame
                task.wait(.1)
                Fruit_InHand = string.gsub(v.Name, " Fruit", "")
                Fruit_InHand = Fruit_InHand .. "-" .. Fruit_InHand
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", Fruit_InHand, returnHRP().Parent:FindFirstChildOfClass("Tool"))
                task.wait(.1)
            end
        end

        task.wait(1) -- Reduce the wait time between checks to 1 second
    end
end

local function notifyFruit()
    local lastFruits = {}
    while true do
        local Fruits_InServer = {}
        local detectedFruits = {}

        for _, v in ipairs(workspace:GetChildren()) do
            if v:IsA("Tool") and v:FindFirstChild("Handle") then
                table.insert(Fruits_InServer, v)
                if not lastFruits[v] then
                    detectedFruits[v] = v.Name
                end
            end
        end

        if next(detectedFruits) then
            for _, fruitName in pairs(detectedFruits) do
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "Fruta Encontrada!",
                    Text = "Fruta encontrada: " .. string.gsub(fruitName, " Fruit", ""),
                    Duration = 5,
                })
            end
        end

        lastFruits = {}
        for _, v in ipairs(Fruits_InServer) do
            lastFruits[v] = true
        end

        task.wait(1) -- Check every 1 second
    end
end

local function toggleAutoCollect()
    AutoCollectEnabled = not AutoCollectEnabled
    if AutoCollectEnabled then
        findAndStoreFruits()
    end
end

-- Start the notification function immediately
spawn(notifyFruit)
