repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer

-- Tạo GUI chính
local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Parent = player:FindFirstChild("PlayerGui") or player:WaitForChild("PlayerGui")

-- Tạo Frame chứa Ping & FPS (dễ ẩn/hiện hơn)
local statsFrame = Instance.new("Frame")
statsFrame.Size = UDim2.new(0, 200, 0, 50)
statsFrame.Position = UDim2.new(0, 10, 0.5, -25)
statsFrame.BackgroundTransparency = 1
statsFrame.Parent = gui

-- Tạo TextLabel hiển thị Ping & FPS
local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(1, 0, 1, 0)
textLabel.BackgroundTransparency = 1
textLabel.TextColor3 = Color3.new(1, 1, 1)
textLabel.TextScaled = true
textLabel.Parent = statsFrame

-- Tạo nút bật/tắt GUI (nút luôn hiển thị)
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 60, 0, 30)  
toggleButton.Position = UDim2.new(0, 10, 0, 10)  
toggleButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)  -- Màu xám đơn giản
toggleButton.TextColor3 = Color3.new(1, 1, 1)  -- Chữ trắng
toggleButton.Text = "OFF"
toggleButton.Parent = gui

-- Xử lý bật/tắt GUI (chỉ ẩn/hiện Ping & FPS, không ẩn nút)
local isOn = false
toggleButton.MouseButton1Click:Connect(function()
    isOn = not isOn
    statsFrame.Visible = isOn
    toggleButton.Text = isOn and "ON" or "OFF"
end)

-- Cập nhật Ping & FPS liên tục
task.spawn(function()
    while task.wait(1) do
        local ping = game:GetService("Stats").Network:FindFirstChild("Ping") 
        local fps = math.floor(1 / task.wait())

        if ping then
            textLabel.Text = "Ping: " .. math.floor(ping.Value) .. " ms | FPS: " .. fps
        else
            textLabel.Text = "Không thể lấy Ping | FPS: " .. fps
        end
    end
end)
