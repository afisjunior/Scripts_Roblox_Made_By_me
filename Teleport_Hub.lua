-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService") -- To detect K key

-- Variables
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local isTeleporting = false
local targetUsername = ""
local isGuiVisible = true -- Visibility Control

-- Create ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TeleportHub"
ScreenGui.Parent = PlayerGui

-- Create Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 300, 0, 250) 
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -125)
MainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

-- Add corner radius to MainFrame
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- Create Title
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Teleport Hub"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 24
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

-- Create Username TextBox
local UsernameBox = Instance.new("TextBox")
UsernameBox.Name = "UsernameBox"
UsernameBox.Size = UDim2.new(0.8, 0, 0, 40)
UsernameBox.Position = UDim2.new(0.1, 0, 0.3, 0)
UsernameBox.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
UsernameBox.BorderSizePixel = 0
UsernameBox.Text = ""
UsernameBox.PlaceholderText = "Digite o nome do jogador"
UsernameBox.TextColor3 = Color3.fromRGB(255, 255, 255)
UsernameBox.PlaceholderColor3 = Color3.fromRGB(180, 180, 180)
UsernameBox.TextSize = 18
UsernameBox.Font = Enum.Font.Gotham
UsernameBox.Parent = MainFrame

-- Add corner radius to UsernameBox
local BoxCorner = Instance.new("UICorner")
BoxCorner.CornerRadius = UDim.new(0, 6)
BoxCorner.Parent = UsernameBox

-- Create Teleport Button
local TeleportButton = Instance.new("TextButton")
TeleportButton.Name = "TeleportButton"
TeleportButton.Size = UDim2.new(0.8, 0, 0, 40)
TeleportButton.Position = UDim2.new(0.1, 0, 0.5, 0)
TeleportButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
TeleportButton.BorderSizePixel = 0
TeleportButton.Text = "Teleportar"
TeleportButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TeleportButton.TextSize = 18
TeleportButton.Font = Enum.Font.GothamBold
TeleportButton.Parent = MainFrame

-- Create Disable Button
local DisableButton = Instance.new("TextButton")
DisableButton.Name = "DisableButton"
DisableButton.Size = UDim2.new(0.8, 0, 0, 40)
DisableButton.Position = UDim2.new(0.1, 0, 0.7, 0)
DisableButton.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
DisableButton.BorderSizePixel = 0
DisableButton.Text = "Desativar"
DisableButton.TextColor3 = Color3.fromRGB(255, 255, 255)
DisableButton.TextSize = 18
DisableButton.Font = Enum.Font.GothamBold
DisableButton.Parent = MainFrame
DisableButton.Visible = false

-- Add corner radius to buttons
local ButtonCorner1 = Instance.new("UICorner")
ButtonCorner1.CornerRadius = UDim.new(0, 6)
ButtonCorner1.Parent = TeleportButton

local ButtonCorner2 = Instance.new("UICorner")
ButtonCorner2.CornerRadius = UDim.new(0, 6)
ButtonCorner2.Parent = DisableButton

-- Create Status Label
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Name = "StatusLabel"
StatusLabel.Size = UDim2.new(0.8, 0, 0, 30)
StatusLabel.Position = UDim2.new(0.1, 0, 0.9, 0)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = ""
StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusLabel.TextSize = 14
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Parent = MainFrame

-- Create KeyBind Label
local KeybindLabel = Instance.new("TextLabel")
KeybindLabel.Name = "KeybindLabel"
KeybindLabel.Size = UDim2.new(0.8, 0, 0, 20)
KeybindLabel.Position = UDim2.new(0.1, 0, 0, 5)
KeybindLabel.BackgroundTransparency = 1
KeybindLabel.Text = "Pressione 'K' para mostrar/ocultar"
KeybindLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
KeybindLabel.TextSize = 12
KeybindLabel.Font = Enum.Font.Gotham
KeybindLabel.Parent = MainFrame

-- Function to teleport to player
local function TeleportToPlayer(targetUsername)
    local targetPlayer = Players:FindFirstChild(targetUsername)
    
    if targetPlayer then
        local targetCharacter = targetPlayer.Character
        if targetCharacter then
            local humanoidRootPart = targetCharacter:FindFirstChild("HumanoidRootPart")
            if humanoidRootPart then
                local character = LocalPlayer.Character
                if character then
                    local myHumanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                    if myHumanoidRootPart then
                        local tweenInfo = TweenInfo.new(
                            0.5,
                            Enum.EasingStyle.Quad,
                            Enum.EasingDirection.Out
                        )
                        
                        local tween = TweenService:Create(myHumanoidRootPart, tweenInfo, {
                            CFrame = humanoidRootPart.CFrame
                        })
                        
                        tween:Play()
                        return true
                    end
                end
            end
        end
    end
    return false
end

-- Function to toggle GUI visibility
local function toggleGuiVisibility()
    isGuiVisible = not isGuiVisible
    
    -- Create fade animation
    local targetTransparency = isGuiVisible and 0 or 1
    local tweenInfo = TweenInfo.new(
        0.3,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out
    )
    
    -- Animate MainFrame
    local tween = TweenService:Create(MainFrame, tweenInfo, {
        BackgroundTransparency = targetTransparency
    })
    tween:Play()
    
    -- Animate all child elements
    for _, element in pairs(MainFrame:GetDescendants()) do
        if element:IsA("GuiObject") then
            local properties = {
                BackgroundTransparency = targetTransparency
            }
            
            if element:IsA("TextLabel") or element:IsA("TextButton") or element:IsA("TextBox") then
                properties.TextTransparency = targetTransparency
            end
            
            TweenService:Create(element, tweenInfo, properties):Play()
        end
    end
    
    -- Show/Hide teleport indicator
    if not isGuiVisible and isTeleporting then
        local indicator = ScreenGui:FindFirstChild("TeleportIndicator") or Instance.new("TextLabel")
        indicator.Name = "TeleportIndicator"
        indicator.Size = UDim2.new(0, 200, 0, 30)
        indicator.Position = UDim2.new(1, -220, 0, 20)
        indicator.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        indicator.TextColor3 = Color3.fromRGB(255, 255, 255)
        indicator.Text = "Teleporte Ativo: " .. targetUsername
        indicator.TextSize = 14
        indicator.Font = Enum.Font.Gotham
        indicator.BackgroundTransparency = 0.3
        indicator.TextTransparency = 0
        indicator.Parent = ScreenGui
        
        local corner = indicator:FindFirstChild("UICorner") or Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 6)
        corner.Parent = indicator
    else
        local indicator = ScreenGui:FindFirstChild("TeleportIndicator")
        if indicator then
            indicator:Destroy()
        end
    end
end

-- Connection variable for the teleport loop
local teleportConnection = nil

-- Function to start continuous teleport
local function StartContinuousTeleport(username)
    if teleportConnection then
        teleportConnection:Disconnect()
    end
    
    isTeleporting = true
    targetUsername = username
    DisableButton.Visible = true
    TeleportButton.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
    
    -- Update or create indicator if GUI is hidden
    if not isGuiVisible then
        toggleGuiVisibility()
        toggleGuiVisibility()
    end
    
    teleportConnection = RunService.Heartbeat:Connect(function()
        if isTeleporting then
            local success = TeleportToPlayer(targetUsername)
            if success then
                StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                StatusLabel.Text = "Teleportando para " .. targetUsername
            else
                StatusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
                StatusLabel.Text = "Jogador não encontrado!"
            end
        end
    end)
end

-- Function to stop teleport
local function StopTeleport()
    if teleportConnection then
        teleportConnection:Disconnect()
        teleportConnection = nil
    end
    
    isTeleporting = false
    targetUsername = ""
    DisableButton.Visible = false
    TeleportButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
    StatusLabel.Text = "Teleporte desativado"
    StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    
    -- Remove indicator if it exists
    local indicator = ScreenGui:FindFirstChild("TeleportIndicator")
    if indicator then
        indicator:Destroy()
    end
end

-- Button click handlers
TeleportButton.MouseButton1Click:Connect(function()
    local username = UsernameBox.Text
    if username ~= "" then
        if not isTeleporting then
            StartContinuousTeleport(username)
        end
    else
        StatusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
        StatusLabel.Text = "Digite um nome de usuário!"
    end
end)

DisableButton.MouseButton1Click:Connect(function()
    StopTeleport()
end)

-- Key press detection for toggling GUI
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.K then
        toggleGuiVisibility()
    end
end)

-- Button hover effects
TeleportButton.MouseEnter:Connect(function()
    if not isTeleporting then
        TweenService:Create(TeleportButton, TweenInfo.new(0.3), {
            BackgroundColor3 = Color3.fromRGB(0, 100, 180)
        }):Play()
    end
end)

TeleportButton.MouseLeave:Connect(function()
    if not isTeleporting then
        TweenService:Create(TeleportButton, TweenInfo.new(0.3), {
            BackgroundColor3 = Color3.fromRGB(0, 120, 215)
        }):Play()
    end
end)

DisableButton.MouseEnter:Connect(function()
    TweenService:Create(DisableButton, TweenInfo.new(0.3), {
        BackgroundColor3 = Color3.fromRGB(180, 40, 40)
    }):Play()
end)

DisableButton.MouseLeave:Connect(function()
    TweenService:Create(DisableButton, TweenInfo.new(0.3), {
        BackgroundColor3 = Color3.fromRGB(220, 50, 50)
    }):Play()
end)

-- Cleanup on script unload
ScreenGui.Destroying:Connect(function()
    StopTeleport()
end)
