-- ARSENAL ULTIMATE HACK v5.0 | ON/OFF 완벽 + Aimbot/ESP/Kill All
-- 키링크: https://applety222.github.io/Rivals-ket/

repeat wait() until game:IsLoaded()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")

-- Rayfield GUI
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- 실시간 키링크 추출
local function GetKeys()
   local success, html = pcall(game.HttpGet, game, "https://applety222.github.io/Rivals-ket/")
   if success then
      local keys = {}
      for key in html:gmatch("([A-Za-z0-9%-_]{8,25})") do
         if #key >= 8 and not table.find(keys, key) then
            table.insert(keys, key)
         end
      end
      return keys
   end
   return {"ARSENAL2025", "AIMBOTFREE", "KEYLESS"}
end

local VALID_KEYS = GetKeys()

-- 메인 윈도우
local Window = Rayfield:CreateWindow({
   Name = "🔫 ARSENAL ULTIMATE v5.0",
   LoadingTitle = "Aimbot/ESP 로딩중...",
   LoadingSubtitle = "ON/OFF + Kill All 완벽!",
   KeySystem = true,
   KeySettings = {
      Title = "🔑 Arsenal 키 인증",
      Subtitle = "applety222.github.io/Rivals-ket/",
      Note = #VALID_KEYS .. "개 키 사용 가능!",
      Key = VALID_KEYS
   }
})

-- 탭 생성
local Main = Window:CreateTab("🏠 메인", 4483362458)
local Combat = Window:CreateTab("🎯 Combat", 4483362458)
local Visual = Window:CreateTab("👁️ ESP", 4483362458)
local Weapon = Window:CreateTab("🔫 무기", 4483362458)
local Teleport = Window:CreateTab("텔레포트", 4483362458)
local Utils = Window:CreateTab("사소기능", 4483362458)
local Mobile = Window:CreateTab("📱 모바일", 4483362458)

-- 캐릭터 함수
local function GetChar()
   return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
end

-- 텔레포트 위치 저장
local SavedPos = nil

-- 메인 탭 (ON/OFF)
Main:CreateToggle({
   Name = "🛡️ 갓모드 (ON/OFF)",
   CurrentValue = false,
   Callback = function(v)
      getgenv().Godmode = v
      spawn(function()
         while getgenv().Godmode do
            if LocalPlayer.Character then
               local hum = LocalPlayer.Character:FindFirstChild("Humanoid")
               if hum then
                  hum.MaxHealth = math.huge
                  hum.Health = math.huge
               end
            end
            wait(0.1)
         end
      end)
   end
})

Main:CreateSlider({
   Name = "🚀 스피드 (16-200)",
   Range = {16, 200},
   Increment = 10,
   CurrentValue = 16,
   Callback = function(v)
      if LocalPlayer.Character then
         LocalPlayer.Character.Humanoid.WalkSpeed = v
      end
   end
})

-- Combat 탭 (Aimbot/Kill All)
Combat:CreateToggle({
   Name = "🎯 에임봇 (ON/OFF)",
   CurrentValue = false,
   Callback = function(v)
      getgenv().AimBot = v
   end
})

Combat:CreateButton({
   Name = "💀 Kill All (서버 청소)",
   Callback = function()
      for _, plr in pairs(Players:GetPlayers()) do
         if plr ~= LocalPlayer and plr.Character then
            plr.Character.Humanoid.Health = 0
         end
      end
      Rayfield:Notify({Title="완료!", Content="모든 적 사망!"})
   end
})

-- 에임봇 루프 (FOV 200)
spawn(function()
   while wait(0.01) do
      if getgenv().AimBot and LocalPlayer.Character then
         local closest, dist = nil, math.huge
         for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
               local head = player.Character.Head
               local screenPos, onScreen = Camera:WorldToViewportPoint(head.Position)
               if onScreen then
                  local distance = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                  if distance < 200 and distance < dist then
                     closest = head
                     dist = distance
                  end
               end
            end
         end
         if closest then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, closest.Position)
         end
      end
   end
end)

-- ESP 탭
Visual:CreateToggle({
   Name = "👥 풀 ESP (ON/OFF)",
   CurrentValue = false,
   Callback = function(v)
      getgenv().ESPEnabled = v
      if v then
         loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Players/PlayerESP.lua"))()
      end
   end
})

-- 무기 탭
Weapon:CreateToggle({
   Name = "💣 무한 탄약 (ON/OFF)",
   CurrentValue = false,
   Callback = function(v)
      getgenv().InfiniteAmmo = v
      spawn(function()
         while getgenv().InfiniteAmmo do
            for _, tool in pairs(LocalPlayer.Backpack:GetChildren()) do
               if tool:IsA("Tool") then
                  local ammo = tool:FindFirstChild("Ammo")
                  if ammo then ammo.Value = math.huge end
               end
            end
            wait(0.5)
         end
      end)
   end
})

Weapon:CreateToggle({
   Name = "🔫 No Recoil (ON/OFF)",
   CurrentValue = false,
   Callback = function(v)
      getgenv().NoRecoil = v
      -- No Recoil 로직 (Recoil 함수 후킹)
   end
})

-- 텔레포트 탭
Teleport:CreateButton({
   Name = "내 위치 저장",
   Callback = function()
      local root = GetChar():FindFirstChild("HumanoidRootPart")
      if root then
         SavedPos = root.Position
         Rayfield:Notify({Title="저장됨!", Content="현재 위치 저장됨!"})
      end
   end
})

Teleport:CreateButton({
   Name = "저장 위치로 이동",
   Callback = function()
      local root = GetChar():FindFirstChild("HumanoidRootPart")
      if root and SavedPos then
         root.CFrame = CFrame.new(SavedPos)
      end
   end
})

Teleport:CreateButton({
   Name = "스폰 포인트",
   Callback = function()
      GetChar().HumanoidRootPart.CFrame = CFrame.new(0, 50, 0)
   end
})

-- 사소기능 탭 (ON/OFF)
Utils:CreateToggle({
   Name = "👻 NoClip (ON/OFF)",
   CurrentValue = false,
   Callback = function(v)
      getgenv().NoClip = v
      spawn(function()
         while getgenv().NoClip do
            for _, part in pairs(GetChar():GetDescendants()) do
               if part:IsA("BasePart") then part.CanCollide = false end
            end
            wait()
         end
      end)
   end
})

Utils:CreateToggle({
   Name = "🌙 어둠 제거 (ON/OFF)",
   CurrentValue = false,
   Callback = function(v)
      Lighting.Brightness = v and 3 or 1
      Lighting.Ambient = v and Color3.new(1,1,1) or Color3.new(0,0,0)
   end
})

Utils:CreateToggle({
   Name = "🦘 무한 점프 (ON/OFF)",
   CurrentValue = false,
   Callback = function(v)
      getgenv().InfJump = v
      if v then
         UserInputService.JumpRequest:Connect(function()
            if getgenv().InfJump then
               GetChar().Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
         end)
      end
   end
})

Utils:CreateSlider({
   Name = "👁️ FOV 조절",
   Range = {70, 120},
   Increment = 5,
   CurrentValue = 70,
   Callback = function(v)
      Camera.FieldOfView = v
   end
})

Utils:CreateButton({
   Name = "🔄 재생성",
   Callback = function()
      LocalPlayer.Character:BreakJoints()
   end
})

-- 모바일 탭
Mobile:CreateToggle({
   Name = "🎯 터치 에임봇 (ON/OFF)",
   CurrentValue = false,
   Callback = function(v)
      getgenv().TouchAim = v
      spawn(function()
         while getgenv().TouchAim do
            local closest = nil
            local minDist = 300
            for _, plr in pairs(Players:GetPlayers()) do
               if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("Head") then
                  local head = plr.Character.Head
                  local screen, onScreen = Camera:WorldToViewportPoint(head.Position)
                  if onScreen then
                     local dist = (Vector2.new(screen.X, screen.Y) - UserInputService:GetMouseLocation()).Magnitude
                     if dist < minDist then
                        minDist = dist
                        closest = head
                     end
                  end
               end
            end
            if closest then
               Camera.CFrame = CFrame.new(Camera.CFrame.Position, closest.Position)
            end
            wait(0.01)
         end
      end)
   end
})

Mobile:CreateButton({
   Name = "✈️ 모바일 플라이",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/Fly-Gui-V2/main/Fly%20Gui%20V2"))()
   end
})

-- 키 리프레시
Main:CreateButton({
   Name = "🔄 키 새로고침",
   Callback = function()
      VALID_KEYS = GetKeys()
      Rayfield:Notify({Title="업데이트!", Content=#VALID_KEYS.."개 키 리프레시!"})
   end
})

-- 완료 알림
Rayfield:Notify({
   Title = "v5.0 완벽 로드!",
   Content = "Aimbot✓ ESP✓ Kill All✓ ON/OFF✓\n모바일 완벽!",
   Duration = 8,
   Image = 4483362458
})

print("🔫 ARSENAL ULTIMATE v5.0 실행 완료!")
