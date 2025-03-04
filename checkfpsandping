local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Stats = game:GetService("Stats")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
local fpsLabel = Instance.new("TextLabel")
local pingLabel = Instance.new("TextLabel")
local toggleButton = Instance.new("TextButton")

local isVisible = true

-- Cấu hình ScreenGui
screenGui.Parent = game.CoreGui
screenGui.DisplayOrder = 100

-- Cấu hình FPS Label
fpsLabel.Parent = screenGui
fpsLabel.Size = UDim2.new(0, 300, 0, 30)
fpsLabel.Position = UDim2.new(0, 72, 0, 56)
fpsLabel.Font = Enum.Font.FredokaOne
fpsLabel.TextScaled = true
fpsLabel.BackgroundTransparency = 1
fpsLabel.TextStrokeTransparency = 0.3
fpsLabel.TextColor3 = Color3.new(1, 1, 1)
fpsLabel.Visible = isVisible

-- Cấu hình Ping Label
pingLabel.Parent = screenGui
pingLabel.Size = UDim2.new(0, 443, 0, 29)
pingLabel.Position = UDim2.new(0, 50, 0, 80)
pingLabel.Font = Enum.Font.FredokaOne
pingLabel.TextScaled = true
pingLabel.BackgroundTransparency = 1
pingLabel.TextStrokeTransparency = 0.3
pingLabel.TextColor3 = Color3.new(1, 1, 1)
pingLabel.Visible = isVisible

-- Cấu hình Toggle Button
toggleButton.Parent = screenGui
toggleButton.Size = UDim2.new(0, 30, 0, 30)
toggleButton.Position = UDim2.new(0, 10, 0, 10)
toggleButton.BackgroundColor3 = Color3.new(0, 0, 0)
toggleButton.TextColor3 = Color3.new(1, 1, 1)
toggleButton.Font = Enum.Font.FredokaOne
toggleButton.Text = "ON"
toggleButton.TextScaled = true
toggleButton.AutoButtonColor = true
toggleButton.BorderSizePixel = 0
toggleButton.BackgroundTransparency = 0.2

-- Xử lý toggle visibility
toggleButton.MouseButton1Click:Connect(function()
    isVisible = not isVisible
    fpsLabel.Visible = isVisible
    pingLabel.Visible = isVisible
    toggleButton.Text = isVisible and "ON" or "OFF"
end)

-- Hàm lấy icon FPS
local function getFpsIcon(fps)
    if fps >= 15 then
        return "🟢"
    elseif fps >= 9 then
        return "🔵"
    elseif fps >= 4 then
        return "🔴"
    else
        return "⚫"
    end
end

-- Hàm tạo hiệu ứng cầu vồng với tần suất thấp hơn
local function rainbowColor()
    local hue = 0
    while true do
        hue = (hue + 0.005) % 1 -- Tăng chậm hơn để giảm tải
        fpsLabel.TextColor3 = Color3.fromHSV(hue, 1, 1)
        pingLabel.TextColor3 = Color3.fromHSV(hue, 1, 1)
        task.wait(0.1) -- Giảm tần suất cập nhật màu để tiết kiệm tài nguyên
    end
end

-- Khởi tạo biến theo dõi FPS và Ping
local frameCount = 0
local lastUpdate = os.clock()
local updateInterval = 1 -- Cập nhật mỗi giây

-- Kết nối sự kiện RenderStepped
RunService.RenderStepped:Connect(function(dt)
    frameCount = frameCount + 1
    local now = os.clock()

    if now - lastUpdate >= updateInterval then
        local fps = frameCount / (now - lastUpdate)
        frameCount = 0
        lastUpdate = now

        -- Lấy tên người chơi và ẩn một phần
        local userName = LocalPlayer and LocalPlayer.Name or "Unknown"
        local hiddenName = string.rep("*", 4) .. (string.sub(userName, 5) or "")

        -- Lấy Ping (kiểm tra lỗi cẩn thận)
        local ping = 0
        if Stats and Stats.Network and Stats.Network.ServerStatsItem and Stats.Network.ServerStatsItem["Data Ping"] then
            ping = Stats.Network.ServerStatsItem["Data Ping"]:GetValue() or 0
        end

        -- Cập nhật giao diện
        local fpsIcon = getFpsIcon(math.floor(fps))
        fpsLabel.Text = string.format("%s, FPS: %d %s", hiddenName, math.floor(fps), fpsIcon)
        pingLabel.Text = string.format("🎮 Ping: %dms", math.floor(ping))
    end
end)

-- Bắt đầu hiệu ứng cầu vồng
task.spawn(rainbowColor)
