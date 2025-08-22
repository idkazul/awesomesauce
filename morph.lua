local Players = game:GetService("Players")

local function fixCharacter(character)
    local prop = character:FindFirstChild("Prop")
    if prop then
        prop:Destroy()
    end
    for _, descendant in ipairs(character:GetDescendants()) do
        if descendant:IsA("BasePart") or descendant:IsA("Decal") then
            descendant.Transparency = 0
        elseif descendant:IsA("LayeredClothing") or descendant:IsA("Shirt") or descendant:IsA("Pants") or descendant:IsA("ShirtGraphic") then
            descendant.Transparency = 0
        end
    end
end

local function onPlayerAdded(player)
    player.CharacterAdded:Connect(fixCharacter)
    if player.Character then
        fixCharacter(player.Character)
    end
end

Players.PlayerAdded:Connect(onPlayerAdded)
for _, player in ipairs(Players:GetPlayers()) do
    onPlayerAdded(player)
end
