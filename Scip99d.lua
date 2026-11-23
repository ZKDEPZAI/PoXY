--[[
  Tubers Hub - 99 Nights in the Forest  (OP + TỰ ĐỘNG PHÁT HIỆN + NHIÊN LIỆU RAW_LOG)
  An toàn với Delta. Không tham chiếu tiến. Mỗi tab nằm trong do..end.
  Các tab: PhátHiện, MangVề, LửaTrại, TựĐộng, NgườiChơi, OP, GiảiTrí, ÂmThanh,
           DịchChuyển, HìnhẢnh, ĐánhDấu, HiệuỨng
]]

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local lp = Players.LocalPlayer

local Cleanup = {}
local function khiDong(fn) table.insert(Cleanup, fn) end
local function thanhTap(t) local s={} for _,w in ipairs(t) do s[w]=true end return s end

-- ============================================================
-- HÀM HỖ TRỢ CƠ BẢN
-- ============================================================
local function layHRP()
    local c = lp.Character
    return c and c:FindFirstChild("HumanoidRootPart") or nil
end
local function layHum()
    local c = lp.Character
    return c and c:FindFirstChildOfClass("Humanoid") or nil
end
local function chuanHoaTen(s) return s:lower():gsub("[%s_%-%.]","") end

-- ============================================================
-- CƠ SỞ DỮ LIỆU VẬT PHẨM
-- ============================================================
local DANH_MUC = {
    riu = thanhTap({"oldaxe","goodaxe","strongaxe","iceaxe","chainsaw","adminaxe","stoneaxe","corruptedaxe","axe","hatchet","pickaxe","steelpickaxe"}),
    bao = thanhTap({"oldsack","goodsack","infernalsack","giantsack","adminsack","sack","backpack","satchel","coffer","trunk","strongbox"}),
    dungcu = thanhTap({"oldrod","goodrod","fishingrod","oldtamingflute","goodtamingflute","tamingflute","oldflashlight","strongflashlight","flashlight","compass","shovel","spade","hoe","saw","wrench","pliers","screwdriver","crowbar","trap","beartrap","bunnytrap","lantern","lamp","candle","bucket","wateringcan","hammer","ironhammer","map","sundial"}),
    camtay = thanhTap({"spear","poisonspear","steelspear","katana","morningstar","lasersword","icesword","infernalsword","obsidironhammer","trident","scythe","cultistkingmace","poisonclaw","dagger","knife","machete","sword","ironsword","blade","club","mace","staff","battleaxe","scimitar","rapier"}),
    tamxa = thanhTap({"revolver","rifle","tacticalshotgun","shotgun","crossbow","infernalcrossbow","snowballcannon","snowball","blowpipe","bouncingblade","frozenshuriken","lasercannon","raygun","flamethrower","wildfire","witchpotion","pistol","gun","ammo","bullet","shell","cartridge","magazine","clip","arrow","arrows","bolt","dart","grenade","slug","buckshot","dynamite","impactgrenade"}),
    thucan = thanhTap({"carrot","corn","pumpkin","berry","berries","apple","morsel","steak","fish","mackerel","salmon","clownfish","eel","tuna","cod","trout","meat","rib","jerky","bacon","ham","pork","beef","venison","mushroom","cabbage","banana","orange","coconut","melon","mango","peach","pear","bread","cake","pie","cookie","egg","cheese","honey","ration","meal","snack","candycorn","turkeyleg"}),
    chin = thanhTap({"cookedsteak","cookedmorsel","cookedfish","cookedeel","cookedturkeyleg","berryjuice","stew","soup","chili","pumpkinstew","roastturkey","stuffedpeppers","spicyswordfish","mre","filledbowl","cashierroll"}),
    hoi = thanhTap({"bandage","medkit","medicine","pill","syrup","antibiotic","potion","herb","aloe","tonic","antidote","firstaid","healthpotion","regen"}),
    vatlieu = thanhTap({"wood","log","logs","rawlog","raw_log","timber","plank","board","stick","twig","branch","coal","charcoal","scrap","metal","sheetmetal","bolt","nut","screw","gear","cog","spring","propeller","wire","cable","pipe","iron","ironore","ironingot","steel","steelingot","copper","tin","gold","goldshard","silver","ingot","nugget","sand","glass","bottle","jar","glue","rope","cloth","leather","wool","fur","pelt","hide","bone","bones","skull","antler","horn","tooth","fang","claw"}),
    nhienlieu = thanhTap({"raw_log","rawlog","log","logs","timber","plank","board","stick","twig","branch","firewood","firelog","kindling","tinder","coal","charcoal","oil","barrel","drum","fuel","kerosene","gasoline","diesel","petrol","gas","jerrycan","canister","tank","cylinder","torch","match","lighter","biofuel","oilbarrel","fuelcanister","superlog"}),
    rung = thanhTap({"chest","crate","commonchest","goodchest","ironchest","legendarychest","goldchest","rubychest","diamondchest","alienchest","frogchest","obsidironchest","vampirechest","coldchest","icechest","hotchest","infernalchest","mazechest","rottenchest","eventchest","secretchest","loot","lootbox","cache","coffer","strongbox","safe","treasure"}),
    dacbiet = thanhTap({"diamond","gem","gemstone","crystal","ruby","emerald","sapphire","topaz","opal","amethyst","quartz","obsidian","jewel","shard","geode","prism","stardust","cultistgem","forestgem","forestgemfragment","meteor","meteorshard","coin","cash","money","bullion","relic","artifact","idol","totem","medallion","cultistmedallion","mossycoin","keycard","blueprint","redkey","bluekey","yellowkey","greykey","sacrificetotem","ufojunk","alienarmour","dripleaf","moonflowerbulb","stareweedpetal","cavevineflower","mandrake","halloweencandle"}),
    caycoi = thanhTap({"sapling","seed","seeds","sprout","flower","flowers","flowerseeds","fireflyseeds","berryseeds","bush","fern","leaf","leaves","foliage","grass","moss","vine","roots"}),
    giapphap = thanhTap({"armor","armour","helmet","helm","shield","chestplate","breastplate","gauntlet","greaves","pauldron","vest","cloak","cape","boots","gloves","mask","hat","leatherbody"}),
    cultist = thanhTap({"cultist","cultists","cult","ritual","sacrifice","altar","idol","totem","relic","skull","gem","gems","crystal","cultistgem","cultistmedallion","cultistkingmace"}),
}

local THU_TU_DANH_MUC = {"riu","bao","dungcu","camtay","tamxa","thucan","chin","hoi","vatlieu","nhienlieu","rung","dacbiet","caycoi","giapphap","cultist"}

local LOAI_TRU = thanhTap({"part","model","meshpart","union","unionoperation","wedge","wedgepart","cornerwedgepart","trusspart","seat","vehicleseat","decal","texture","folder","effect","hitbox","trigger","zone","region","collider","invisible","terrain","baseplate","spawn","spawnlocation","camera","sky","handle","rootjoint","torso","head","limb","humanoidrootpart","base","floor","wall","ceiling","door","window","stairs","railing","fence"})

local PHONG_CANH = thanhTap({"tree","oak","pine","birch","spruce","willow","maple","palm","bush","bushes","rock","rocks","boulder","boulders","cliff","cliffs","hill","hills","mountain","mountains","bark","trunk","stump","grass","fern","leaf","leaves","foliage","water","river","lake","pond","stream","cloud","sun","moon"})

-- ============================================================
-- BỘ TÁCH TỪ
-- ============================================================
local boDem_cache, boDem_dem = {}, 0
local function tachTu(n)
    local c = boDem_cache[n]; if c then return c end
    local s = n:gsub("(%l)(%u)","%1 %2")
        :gsub("(%a)(%d)","%1 %2"):gsub("(%d)(%a)","%1 %2")
        :gsub("[^%w]+"," "):lower()
    local t = {}
    for w in s:gmatch("%S+") do t[#t+1] = w end
    if boDem_dem > 4096 then boDem_cache = {}; boDem_dem = 0 end
    boDem_cache[n] = t; boDem_dem = boDem_dem + 1
    return t
end
local function khopSoNhieu(tok, tap)
    if tap[tok] then return true end
    if tok:sub(-1) == "s" and tap[tok:sub(1,-2)] then return true end
    if tok:sub(-2) == "es" and tap[tok:sub(1,-3)] then return true end
    return false
end
local function khopTap(ten, tap)
    for _, tok in ipairs(tachTu(ten)) do
        if khopSoNhieu(tok, tap) then return true end
    end
    return false
end
local function khopDanhMucBatKy(ten)
    for _, dm in ipairs(THU_TU_DANH_MUC) do
        if khopTap(ten, DANH_MUC[dm]) then return true, dm end
    end
    return false, nil
end
local function khopDanhMuc(ten, dm)
    if dm == "tatca" then return khopDanhMucBatKy(ten) end
    return khopTap(ten, DANH_MUC[dm] or {})
end
local function laPhongCanh(ten)
    local n = chuanHoaTen(ten)
    for k in pairs(PHONG_CANH) do
        if n:find(k, 1, true) then return true end
    end
    return false
end
local function laRiuManh(ten)
    local n = chuanHoaTen(ten)
    return n:find("strongaxe", 1, true) ~= nil
        or (n:find("axe", 1, true) and n:find("strong", 1, true))
end
local function laKunai(ten) return chuanHoaTen(ten):find("kunai", 1, true) ~= nil end

local function laNhienLieu(ten)
    local raw = ten:lower()
    if raw:find("raw_log", 1, true) or raw:find("rawlog", 1, true) then
        return true
    end
    return khopTap(ten, DANH_MUC.nhienlieu) and not laPhongCanh(ten)
end

local function laThan(ten) return chuanHoaTen(ten):find("coal", 1, true) ~= nil end

-- ============================================================
-- TRẠNG THÁI
-- ============================================================
local conSong, daMoKhoa = true, false
local daDiChuyen = setmetatable({}, {__mode="k"})
local boNhoNPC = setmetatable({}, {__mode="k"})
local dangBan = false
local C = { chiSoGioiHan=5, lechTrai=3, treTuDong=3, hieuNang=false }
local GIOI_HAN = {25,50,150,300,600,1500}
local KICH_THUOC_TOI_DA = 120
local BO_QUA = 4
local denLuaTrai = false
local boNhoLuaTrai
local vatPhamTimThay = {}
local npcBiDong = setmetatable({}, {__mode="k"})

-- ============================================================
-- PHÁT HIỆN SINH VẬT
-- ============================================================
local function laSinhVat(inst)
    local c = boNhoNPC[inst]; if c ~= nil then return c end
    local r = false
    if Players:GetPlayerFromCharacter(inst) then r = true end
    local m = inst:IsA("Model") and inst or inst:FindFirstAncestorOfClass("Model")
    if m and Players:GetPlayerFromCharacter(m) then r = true end
    local d = 0
    while not r and m and m ~= workspace and d < 6 do
        if m:FindFirstChildOfClass("Humanoid") or m:FindFirstChildOfClass("AnimationController") then
            r = true; break
        end
        m = m:FindFirstAncestorOfClass("Model"); d = d + 1
    end
    if not r and inst:IsA("Model") then
        if inst:FindFirstChildWhichIsA("Motor6D", true)
        or inst:FindFirstChildWhichIsA("Animator", true) then r = true end
    end
    boNhoNPC[inst] = r
    return r
end

-- ============================================================
-- HÀM DI CHUYỂN
-- ============================================================
local function boNeoVatPham(item)
    if not item or not item.Parent then return end
    if item:IsA("BasePart") then
        pcall(function() item.Anchored = false end)
    elseif item:IsA("Model") then
        for _, p in ipairs(item:GetDescendants()) do
            if p:IsA("BasePart") then pcall(function() p.Anchored = false end) end
        end
    end
end
local function layQuyenSoHuu(item)
    if not item or not item.Parent then return end
    if item:IsA("BasePart") then
        pcall(function() item:SetNetworkOwner(lp) end)
    elseif item:IsA("Model") then
        for _, p in ipairs(item:GetDescendants()) do
            if p:IsA("BasePart") and not p.Anchored then
                pcall(function() p:SetNetworkOwner(lp) end)
            end
        end
    end
end

pcall(function()
    if sethiddenproperty then
        sethiddenproperty(lp, "SimulationRadius", math.huge)
        sethiddenproperty(lp, "MaxSimulationRadius", math.huge)
    end
end)

-- ============================================================
-- LỬA TRẠI
-- ============================================================
local KHOA_LUA = {"campfire","bonfire","firepit","hearth","fire pit","camp fire"}

local function timLuaTrai(lamMoi)
    if boNhoLuaTrai and boNhoLuaTrai.Parent and not lamMoi then return boNhoLuaTrai end
    boNhoLuaTrai = nil
    for _, d in ipairs(workspace:GetDescendants()) do
        local n = d.Name:lower()
        for _, k in ipairs(KHOA_LUA) do
            if n:find(k, 1, true) then
                local timThay
                if d:IsA("BasePart") then timThay = d
                elseif d:IsA("Model") then
                    timThay = d.PrimaryPart or d:FindFirstChildWhichIsA("BasePart", true)
                end
                if timThay then boNhoLuaTrai = timThay; return timThay end
            end
        end
    end
end

local function gioiHanHienTai()
    local c = GIOI_HAN[C.chiSoGioiHan]
    return C.hieuNang and math.min(c, 50) or c
end

-- ============================================================
-- MANG VỀ (tự chứa)
-- ============================================================
local function mangVe(boKhop, gioiHan, nhan)
    local char = lp.Character
    if not char then return 0 end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return 0 end
    local ppos = hrp.Position

    local cfGoc = hrp.CFrame
    if denLuaTrai then
        local cf = boNhoLuaTrai
        if not (cf and cf.Parent) then
            cf = nil
            local keys = {"campfire","bonfire","firepit","hearth"}
            for _, d in ipairs(workspace:GetDescendants()) do
                local n = d.Name:lower()
                for _, k in ipairs(keys) do
                    if n:find(k, 1, true) then
                        if d:IsA("BasePart") then cf = d
                        elseif d:IsA("Model") then
                            cf = d.PrimaryPart or d:FindFirstChildWhichIsA("BasePart", true)
                        end
                        if cf then boNhoLuaTrai = cf break end
                    end
                end
                if cf then break end
            end
        end
        if cf then cfGoc = cf.CFrame * CFrame.new(0, C.lechTrai, 0) end
    end

    local daMang = 0
    local khongGioiHan = (gioiHan == nil) or (gioiHan == math.huge) or (gioiHan <= 0)
    local demDanhMuc = {}

    local tatCa = workspace:GetDescendants()
    local i = 0
    for _, d in ipairs(tatCa) do
        i = i + 1
        if i % 500 == 0 then task.wait() end
        if not khongGioiHan and daMang >= gioiHan then break end
        if not d.Parent then goto tiep end

        local laModel = d:IsA("Model")
        local laPart = d:IsA("BasePart")
        if not (laModel or laPart) then goto tiep end
        if daDiChuyen[d] then goto tiep end

        if laPart then
            if d.Anchored then goto tiep end
        else
            local coPartTuDo = false
            for _, p in ipairs(d:GetDescendants()) do
                if p:IsA("BasePart") and not p.Anchored then coPartTuDo = true break end
            end
            if not coPartTuDo then goto tiep end
        end

        if laPhongCanh(d.Name) then goto tiep end
        if LOAI_TRU[d.Name:lower()] then goto tiep end
        if laSinhVat(d) then goto tiep end

        local khop = boKhop(d.Name)
        if not khop then
            local nhan2 = ""
            for _, ch in ipairs(d:GetChildren()) do
                if ch:IsA("ProximityPrompt") then
                    nhan2 = nhan2 .. " " .. ch.ObjectText .. " " .. ch.ActionText
                elseif ch:IsA("StringValue") then
                    nhan2 = nhan2 .. " " .. ch.Value
                end
            end
            if #nhan2 > 0 and boKhop(nhan2) then khop = true end
        end
        if not khop then goto tiep end

        local kichThuoc = 0
        if laPart then
            kichThuoc = d.Size.Magnitude
        else
            local ok, ext = pcall(function() return d:GetExtentsSize() end)
            if ok and ext then kichThuoc = ext.Magnitude end
        end
        if kichThuoc > KICH_THUOC_TOI_DA then goto tiep end

        local pos
        if laPart then
            pos = d.Position
        else
            local ok, pv = pcall(function() return d:GetPivot() end)
            pos = (ok and pv and pv.Position) or (d.PrimaryPart and d.PrimaryPart.Position) or Vector3.zero
        end
        if (pos - ppos).Magnitude < BO_QUA then goto tiep end

        layQuyenSoHuu(d)

        local dich = cfGoc * CFrame.new(math.random(-6,6), 2, math.random(-6,6))
        local okDiChuyen = pcall(function()
            if laModel then d:PivotTo(dich)
            else d.CFrame = dich end
        end)
        if okDiChuyen then
            daDiChuyen[d] = true
            daMang = daMang + 1
            local _, dm = khopDanhMucBatKy(d.Name)
            if dm then demDanhMuc[dm] = (demDanhMuc[dm] or 0) + 1 end
        end

        ::tiep::
    end

    for d in pairs(daDiChuyen) do
        if d and d.Parent then boNeoVatPham(d) end
    end

    return daMang, demDanhMuc
end

-- ============================================================
-- TỰ ĐỘNG PHÁT HIỆN (dùng cho tab PhátHiện)
-- ============================================================
local function chayTuDongPhatHien()
    local ketQua = {}
    local dem = 0
    local tatCa = workspace:GetDescendants()
    local i = 0
    for _, d in ipairs(tatCa) do
        i = i + 1
        if i % 500 == 0 then task.wait() end
        if not d.Parent then goto tiep end
        if not (d:IsA("Model") or d:IsA("BasePart")) then goto tiep end
        if LOAI_TRU[d.Name:lower()] then goto tiep end
        if laPhongCanh(d.Name) then goto tiep end
        if laSinhVat(d) then goto tiep end

        local laPart = d:IsA("BasePart")
        if laPart then
            if d.Anchored then goto tiep end
        else
            local coPartTuDo = false
            for _, p in ipairs(d:GetDescendants()) do
                if p:IsA("BasePart") and not p.Anchored then coPartTuDo = true break end
            end
            if not coPartTuDo then goto tiep end
        end

        local khop, dm = khopDanhMucBatKy(d.Name)
        if not khop then
            local nhan2 = ""
            for _, ch in ipairs(d:GetChildren()) do
                if ch:IsA("ProximityPrompt") then
                    nhan2 = nhan2 .. " " .. ch.ObjectText .. " " .. ch.ActionText
                elseif ch:IsA("StringValue") then
                    nhan2 = nhan2 .. " " .. ch.Value
                end
            end
            if #nhan2 > 0 then khop, dm = khopDanhMucBatKy(nhan2) end
        end
        if khop then
            dem = dem + 1
            local pos
            if laPart then pos = d.Position
            else
                local ok, pv = pcall(function() return d:GetPivot() end)
                pos = (ok and pv and pv.Position) or Vector3.zero
            end
            ketQua[#ketQua+1] = {inst = d, ten = d.Name, dm = dm, pos = pos}
        end

        ::tiep::
    end
    vatPhamTimThay = ketQua
    return dem
end

-- ============================================================
-- ÂM THANH
-- ============================================================
local amThanhHoatDong = {}
local function layChaAmThanh()
    return lp:FindFirstChildOfClass("PlayerGui") or workspace.CurrentCamera or workspace
end
local function phatAmThanhTheoId(id, amLuong, lapLai)
    local num = tostring(id):gsub("%D","")
    if #num == 0 then return nil end
    local s = Instance.new("Sound")
    s.SoundId = "rbxassetid://"..num
    s.Volume = amLuong or 1
    s.Looped = lapLai or false
    s.Parent = layChaAmThanh()
    pcall(function() s:Play() end)
    amThanhHoatDong[#amThanhHoatDong+1] = s
    if not lapLai then
        task.delay(30, function() pcall(function() s:Destroy() end) end)
    end
    return s
end
local function dungTatCaAmThanh()
    for _, s in ipairs(amThanhHoatDong) do
        pcall(function() s:Stop() s:Destroy() end)
    end
    table.clear(amThanhHoatDong)
end

-- ============================================================
-- THIẾT LẬP GUI (an toàn Delta)
-- ============================================================
local GIAO_DIEN = {
    NEN = Color3.fromRGB(15,15,20), BANG = Color3.fromRGB(22,22,30),
    NUT = Color3.fromRGB(32,32,42), NHAN = Color3.fromRGB(220,40,40),
    CHU = Color3.fromRGB(240,240,245), MO = Color3.fromRGB(150,150,160),
    OK = Color3.fromRGB(60,200,120), VANG = Color3.fromRGB(255,200,50),
}
local laDiDong = UIS.TouchEnabled and not UIS.KeyboardEnabled

local playerGui = lp:WaitForChild("PlayerGui", 15)
local guiCha = playerGui
if gethui then
    local ok, hui = pcall(gethui)
    if ok and hui then guiCha = hui end
end
if not guiCha then guiCha = playerGui end

local gui = Instance.new("ScreenGui")
gui.Name = "TubersHub_"..tostring(math.random(100000,999999))
gui.ResetOnSpawn = false
gui.DisplayOrder = 999
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = guiCha

if syn and syn.protect_gui then
    pcall(syn.protect_gui, gui)
elseif protect_gui then
    pcall(protect_gui, gui)
end

local function boTron(inst, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 6); c.Parent = inst
end

local goc = Instance.new("Frame")
goc.Size = UDim2.new(0, 340, 0, 520)
goc.Position = UDim2.new(0.5, -170, 0.5, -260)
goc.BackgroundColor3 = GIAO_DIEN.NEN
goc.BorderSizePixel = 0
goc.Active = true
goc.Draggable = true
goc.Visible = false
goc.Parent = gui
boTron(goc, 10)

local tieuDe = Instance.new("TextLabel")
tieuDe.Size = UDim2.new(1, -44, 0, 34)
tieuDe.Position = UDim2.new(0, 12, 0, 0)
tieuDe.BackgroundTransparency = 1
tieuDe.Text = "Tubers Hub - OP"
tieuDe.TextColor3 = GIAO_DIEN.VANG
tieuDe.Font = Enum.Font.GothamBold
tieuDe.TextSize = 14
tieuDe.TextXAlignment = Enum.TextXAlignment.Left
tieuDe.Parent = goc

local nutDong = Instance.new("TextButton")
nutDong.Size = UDim2.new(0, 26, 0, 26)
nutDong.Position = UDim2.new(1, -34, 0, 4)
nutDong.BackgroundColor3 = GIAO_DIEN.NHAN
nutDong.Text = "x"
nutDong.TextColor3 = Color3.new(1,1,1)
nutDong.Font = Enum.Font.GothamBold
nutDong.TextSize = 16
nutDong.Parent = goc
boTron(nutDong, 6)

local trangThai = Instance.new("TextLabel")
trangThai.Size = UDim2.new(1, -24, 0, 18)
trangThai.Position = UDim2.new(0, 12, 1, -22)
trangThai.BackgroundTransparency = 1
trangThai.Text = "Sẵn sàng."
trangThai.TextColor3 = GIAO_DIEN.MO
trangThai.Font = Enum.Font.Gotham
trangThai.TextSize = 11
trangThai.TextXAlignment = Enum.TextXAlignment.Left
trangThai.Parent = goc

local function datTrangThai(t)
    trangThai.Text = t
    if _G.__TH_thongBao then pcall(_G.__TH_thongBao, t) end
end

-- ============================================================
-- THÔNG BÁO NHANH
-- ============================================================
local notifGui = Instance.new("ScreenGui")
notifGui.Name = "TH_Notif_"..tostring(math.random(100000,999999))
notifGui.ResetOnSpawn = false
notifGui.DisplayOrder = 1000
notifGui.Parent = guiCha

local khungNotif = Instance.new("Frame")
khungNotif.Size = UDim2.new(0, 260, 0, 200)
khungNotif.Position = UDim2.new(0.5, -130, 0, 10)
khungNotif.BackgroundTransparency = 1
khungNotif.Parent = notifGui
local boCucNotif = Instance.new("UIListLayout")
boCucNotif.Padding = UDim.new(0, 4)
boCucNotif.SortOrder = Enum.SortOrder.LayoutOrder
boCucNotif.HorizontalAlignment = Enum.HorizontalAlignment.Center
boCucNotif.Parent = khungNotif

_G.__TH_thongBao = function(tin)
    local n = Instance.new("Frame")
    n.Size = UDim2.new(1, 0, 0, 26)
    n.BackgroundColor3 = Color3.fromRGB(20,20,28)
    n.BackgroundTransparency = 0.15
    n.BorderSizePixel = 0
    n.Parent = khungNotif
    boTron(n, 5)
    local t = Instance.new("TextLabel")
    t.Size = UDim2.new(1, -10, 1, 0)
    t.Position = UDim2.new(0, 5, 0, 0)
    t.BackgroundTransparency = 1
    t.Text = tin
    t.TextColor3 = GIAO_DIEN.CHU
    t.Font = Enum.Font.GothamMedium
    t.TextSize = 11
    t.TextTruncate = Enum.TextTruncate.AtEnd
    t.TextXAlignment = Enum.TextXAlignment.Left
    t.Parent = n
    task.delay(2.5, function() pcall(function() n:Destroy() end) end)
end

khiDong(function() pcall(function() notifGui:Destroy() end) end)

-- ============================================================
-- THANH TAB + HÀM HỖ TRỢ
-- ============================================================
local thanhTab = Instance.new("ScrollingFrame")
thanhTab.Size = UDim2.new(1, -20, 0, 30)
thanhTab.Position = UDim2.new(0, 10, 0, 36)
thanhTab.BackgroundTransparency = 1
thanhTab.BorderSizePixel = 0
thanhTab.ScrollBarThickness = 3
thanhTab.ScrollBarImageColor3 = GIAO_DIEN.NHAN
thanhTab.ScrollingDirection = Enum.ScrollingDirection.X
thanhTab.CanvasSize = UDim2.new(0,0,0,0)
thanhTab.AutomaticCanvasSize = Enum.AutomaticSize.X
thanhTab.Parent = goc
local boCucTab = Instance.new("UIListLayout")
boCucTab.FillDirection = Enum.FillDirection.Horizontal
boCucTab.Padding = UDim.new(0, 3)
boCucTab.Parent = thanhTab

local cacTrang, cacNutTab = {}, {}
local trangHienTai
local RONG_TAB = laDiDong and 62 or 52

local function hienTrang(n)
    for k, p in pairs(cacTrang) do p.Visible = (k == n) end
    for k, b in pairs(cacNutTab) do
        b.BackgroundColor3 = (k == n) and GIAO_DIEN.NHAN or GIAO_DIEN.NUT
    end
end

local function taoTab(ten)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0, RONG_TAB, 1, 0)
    b.BackgroundColor3 = GIAO_DIEN.NUT
    b.BorderSizePixel = 0
    b.Text = ten
    b.TextColor3 = GIAO_DIEN.CHU
    b.Font = Enum.Font.GothamMedium
    b.TextSize = laDiDong and 10 or 9
    b.Parent = thanhTab
    boTron(b,
