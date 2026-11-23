--[[
  Menu Người Dùng (Phong cách Valorant)
  Chức năng: Hiển thị GUI dạng menu hiện đại.
  Tương thích: Delta, Xeno, Fluxus.
]]

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local lp = Players.LocalPlayer
local playerGui = lp:WaitForChild("PlayerGui")

-- ============================================================
-- CẤU HÌNH GIAO DIỆN
-- ============================================================
local MAU_NEN = Color3.fromRGB(15, 15, 20)
local MAU_THANH = Color3.fromRGB(25, 25, 30)
local MAU_DO = Color3.fromRGB(255, 70, 85) -- Đỏ Valorant
local MAU_CHU = Color3.fromRGB(240, 240, 245)
local MAU_MO = Color3.fromRGB(150, 150, 160)

local laDiDong = UIS.TouchEnabled and not UIS.KeyboardEnabled
local kichThuocMenu = laDiDong and UDim2.new(0, 320, 0, 480) or UDim2.new(0, 500, 0, 400)

-- ============================================================
-- KHỞI TẠO GUI
-- ============================================================
local gui = Instance.new("ScreenGui")
gui.Name = "NSMOD_ValorantMenu"
gui.ResetOnSpawn = false
gui.DisplayOrder = 999
gui.IgnoreGuiInset = true
gui.Parent = playerGui

local main = Instance.new("Frame")
main.Size = kichThuocMenu
main.Position = UDim2.new(0.5, -kichThuocMenu.Size.X.Offset/2, 0.5, -kichThuocMenu.Size.Y.Offset/2)
main.BackgroundColor3 = MAU_NEN
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = gui

local vien = Instance.new("UIStroke")
vien.Color = Color3.fromRGB(40, 40, 45)
vien.Thickness = 1
vien.Parent = main

local boTron = Instance.new("UICorner")
boTron.CornerRadius = UDim.new(0, 10)
boTron.Parent = main

-- ============================================================
-- THANH ĐIỀU HƯỚNG BÊN TRÁI
-- ============================================================
local leftNav = Instance.new("Frame")
leftNav.Size = UDim2.new(0, 60, 1, 0)
leftNav.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
leftNav.BorderSizePixel = 0
leftNav.Parent = main

local navCorner = Instance.new("UICorner")
navCorner.CornerRadius = UDim.new(0, 10)
navCorner.Parent = leftNav

local fixCorner = Instance.new("Frame") -- Che góc dưới bên phải của nav
fixCorner.Size = UDim2.new(0, 10, 0, 10)
fixCorner.Position = UDim2.new(1, -10, 1, -10)
fixCorner.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
fixCorner.BorderSizePixel = 0
fixCorner.Parent = leftNav

-- ============================================================
-- KHU VỰC NỘI DUNG BÊN PHẢI
-- ============================================================
local rightContent = Instance.new("Frame")
rightContent.Size = UDim2.new(1, -60, 1, 0)
rightContent.Position = UDim2.new(0, 60, 0, 0)
rightContent.BackgroundTransparency = 1
rightContent.Parent = main

-- Tiêu đề chào mừng
local tieuDe = Instance.new("TextLabel")
tieuDe.Size = UDim2.new(1, -20, 0, 40)
tieuDe.Position = UDim2.new(0, 10, 0, 10)
tieuDe.BackgroundTransparency = 1
tieuDe.Text = "Chào buổi tối, " .. lp.Name
tieuDe.TextColor3 = MAU_DO
tieuDe.Font = Enum.Font.GothamBold
tieuDe.TextSize = laDiDong and 16 or 20
tieuDe.TextXAlignment = Enum.TextXAlignment.Left
tieuDe.Parent = rightContent

-- Nút Đóng (X)
local nutDong = Instance.new("TextButton")
nutDong.Size = UDim2.new(0, 30, 0, 30)
nutDong.Position = UDim2.new(1, -40, 0, 10)
nutDong.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
nutDong.Text = "X"
nutDong.TextColor3 = MAU_CHU
nutDong.Font = Enum.Font.GothamBold
nutDong.TextSize = 14
nutDong.Parent = rightContent
local dongCorner = Instance.new("UICorner")
dongCorner.CornerRadius = UDim.new(0, 6)
dongCorner.Parent = nutDong
nutDong.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Khung chứa Banner / Text
local khungBanner = Instance.new("Frame")
khungBanner.Size = UDim2.new(1, -20, 0, 80)
khungBanner.Position = UDim2.new(0, 10, 0, 60)
khungBanner.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
khungBanner.Parent = rightContent
local bannerCorner = Instance.new("UICorner")
bannerCorner.CornerRadius = UDim.new(0, 8)
bannerCorner.Parent = khungBanner

local bannerText = Instance.new("TextLabel")
bannerText.Size = UDim2.new(1, -20, 1, 0)
bannerText.Position = UDim2.new(0, 10, 0, 0)
bannerText.BackgroundTransparency = 1
bannerText.Text = "WELCOME TO NSMOD\nHAVE FUN PLAYING THE GAME !"
bannerText.TextColor3 = MAU_CHU
bannerText.Font = Enum.Font.Code
bannerText.TextSize = 14
bannerText.TextXAlignment = Enum.TextXAlignment.Left
bannerText.Parent = khungBanner

-- ============================================================
-- DANH SÁCH CHỨC NĂNG (Dạng nút dài bo góc)
-- ============================================================
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, -20, 1, -160)
scrollFrame.Position = UDim2.new(0, 10, 0, 150)
scrollFrame.BackgroundTransparency = 1
scrollFrame.ScrollBarThickness = 2
scrollFrame.ScrollBarImageColor3 = MAU_DO
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
scrollFrame.Parent = rightContent

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 8)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Parent = scrollFrame

-- Hàm tạo nút chức năng
local function taoNutChucNang(tenChinh, tenPhu, hinhAnh, layoutOrder, callback)
    local nut = Instance.new("TextButton")
    nut.Size = UDim2.new(1, -10, 0, 50)
    nut.BackgroundColor3 = MAU_DO
    nut.BorderSizePixel = 0
    nut.Text = ""
    nut.LayoutOrder = layoutOrder
    nut.Parent = scrollFrame
    
    local nutCorner = Instance.new("UICorner")
    nutCorner.CornerRadius = UDim.new(0, 8)
    nutCorner.Parent = nut

    -- Chữ chính
    local textChinh = Instance.new("TextLabel")
    textChinh.Size = UDim2.new(1, -50, 0, 25)
    textChinh.Position = UDim2.new(0, 15, 0, 5)
    textChinh.BackgroundTransparency = 1
    textChinh.Text = tenChinh
    textChinh.TextColor3 = Color3.new(1, 1, 1)
    textChinh.Font = Enum.Font.GothamBold
    textChinh.TextSize = 14
    textChinh.TextXAlignment = Enum.TextXAlignment.Left
    textChinh.Parent = nut

    -- Chữ phụ
    local textPhu = Instance.new("TextLabel")
    textPhu.Size = UDim2.new(1, -50, 0, 15)
    textPhu.Position = UDim2.new(0, 15, 0, 25)
    textPhu.BackgroundTransparency = 1
    textPhu.Text = tenPhu
    textPhu.TextColor3 = Color3.fromRGB(255, 200, 200)
    textPhu.Font = Enum.Font.GothamMedium
    textPhu.TextSize = 11
    textPhu.TextXAlignment = Enum.TextXAlignment.Left
    textPhu.Parent = nut

    -- Mũi tên (Icon giả lập)
    local icon = Instance.new("TextLabel")
    icon.Size = UDim2.new(0, 30, 0, 30)
    icon.Position = UDim2.new(1, -40, 0, 10)
    icon.BackgroundColor3 = Color3.new(1, 1, 1)
    icon.BackgroundTransparency = 0.8
    icon.Text = hinhAnh
    icon.TextColor3 = Color3.new(1, 1, 1)
    icon.Font = Enum.Font.GothamBold
    icon.TextSize = 16
    icon.Parent = nut
    local iconCorner = Instance.new("UICorner")
    iconCorner.CornerRadius = UDim.new(1, 0)
    iconCorner.Parent = icon

    -- Hiệu ứng Hover
    nut.MouseEnter:Connect(function()
        TweenService:Create(nut, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 100, 110)}):Play()
    end)
    nut.MouseLeave:Connect(function()
        TweenService:Create(nut, TweenInfo.new(0.2), {BackgroundColor3 = MAU_DO}):Play()
    end)

    -- Sự kiện Click
    nut.MouseButton1Click:Connect(function()
        if callback then pcall(callback) end
    end)
end

-- ============================================================
-- KHAI BÁO CHỨC NĂNG
-- ============================================================
-- 1. Tự động ngắm (Aimbot)
taoNutChucNang("TỰ ĐỘNG NGẮM", "Tự động ngắm", "↓", 1, function()
    print("Đã bật tự động ngắm")
end)

-- 2. Bộ nhớ (Memory)
taoNutChucNang("BỘ NHỚ", "Chức năng bộ nhớ", "↓", 2, function()
    print("Đã bật bộ nhớ")
end)

-- 3. Hiển thị (ESP)
taoNutChucNang("HIỂN THỊ", "ESP & Vật phẩm", "↓", 3, function()
    print("Đã bật ESP")
end)

-- 4. Cài đặt
taoNutChucNang("CÀI ĐẶT", "Hệ thống cài đặt", "↓", 4, function()
    print("Mở cài đặt")
end)

-- 5. Thông tin
taoNutChucNang("THÔNG TIN", "Phím & Thông tin thiết bị", "↓", 5, function()
    print("Mở thông tin")
end)

-- ============================================================
-- PHÍM TẮT (Ẩn/Hiện Menu)
-- ============================================================
local dangHien = true
UIS.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.RightShift then
        dangHien = not dangHien
        main.Visible = dangHien
    end
end)
