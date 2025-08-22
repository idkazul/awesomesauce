local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

local function getNearestHider()
    local nearestHider = nil
    local nearestDistance = math.huge
    local localPos = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character.HumanoidRootPart.Position

    if not localPos then
        return nil
    end

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and not player:GetAttribute("Seeker") and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (player.Character.HumanoidRootPart.Position - localPos).Magnitude
            if distance < nearestDistance then
                nearestHider = player
                nearestDistance = distance
            end
        end
    end

    return nearestHider
end

local function stealthTeleport()
    local hider = getNearestHider()
    if hider and hider.Character and hider.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(hider.Character.HumanoidRootPart.Position + Vector3.new(5, 0, 5))
        print("Stealth teleported to Hider: " .. hider.Name)
    else
        print("No Hiders found to teleport to!")
    end
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.T then
        stealthTeleport()
    end
end)
