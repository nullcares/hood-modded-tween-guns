local ts = game:GetService('TweenService')
local lp = game.Players.LocalPlayer

local con = getgenv()
con.magnitudediv = 100
con.activetween = nil

-- Gui to Lua
-- Version: 3.2

-- Instances:

local HoodModdedBuy = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Bar = Instance.new("Frame")
local Credits = Instance.new("TextLabel")
local Close = Instance.new("TextButton")
local Fill = Instance.new("Frame")
local Controls = Instance.new("Frame")
local UIGridLayout = Instance.new("UIGridLayout")
local Refresh = Instance.new("ImageButton")
local Pause = Instance.new("ImageButton")
local Content = Instance.new("ScrollingFrame")
local UIGridLayout_2 = Instance.new("UIGridLayout")
local BuyTemplate = Instance.new("TextButton")

--Properties:

HoodModdedBuy.Name = "HoodModdedBuy"
HoodModdedBuy.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
HoodModdedBuy.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
HoodModdedBuy.ResetOnSpawn = false

MainFrame.Name = "MainFrame"
MainFrame.Parent = HoodModdedBuy
MainFrame.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
MainFrame.Position = UDim2.new(0.347757667, 0, 0.344072163, 0)
MainFrame.Size = UDim2.new(0.304484665, 0, 0.310566992, 0)

Bar.Name = "Bar"
Bar.Parent = MainFrame
Bar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Bar.BackgroundTransparency = 0.800
Bar.Size = UDim2.new(1, 0, 0.0705394223, 0)

Credits.Name = "Credits"
Credits.Parent = Bar
Credits.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Credits.BackgroundTransparency = 1.000
Credits.Size = UDim2.new(1, 0, 1, 0)
Credits.Font = Enum.Font.SourceSans
Credits.Text = "nulare#4408"
Credits.TextColor3 = Color3.fromRGB(255, 255, 255)
Credits.TextScaled = true
Credits.TextSize = 14.000
Credits.TextWrapped = true

Close.Name = "Close"
Close.Parent = Bar
Close.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Close.BackgroundTransparency = 1.000
Close.Position = UDim2.new(0.95348835, 0, 0, 0)
Close.Size = UDim2.new(0.0465116277, 0, 1, 0)
Close.Font = Enum.Font.SourceSans
Close.Text = "X"
Close.TextColor3 = Color3.fromRGB(255, 255, 255)
Close.TextScaled = true
Close.TextSize = 14.000
Close.TextWrapped = true

Fill.Name = "Fill"
Fill.Parent = Bar
Fill.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
Fill.BackgroundTransparency = 0.300
Fill.Size = UDim2.new(1, 0, 1, 0)
Fill.Visible = false

Controls.Name = "Controls"
Controls.Parent = MainFrame
Controls.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Controls.BackgroundTransparency = 0.700
Controls.Position = UDim2.new(0, 0, 0.0705394223, 0)
Controls.Size = UDim2.new(0.0697674453, 0, 0.929460645, 0)

UIGridLayout.Parent = Controls
UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIGridLayout.CellSize = UDim2.new(1, 0, 0.125, 0)

Refresh.Name = "Refresh"
Refresh.Parent = Controls
Refresh.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Refresh.BackgroundTransparency = 1.000
Refresh.Size = UDim2.new(0, 100, 0, 100)
Refresh.Image = "http://www.roblox.com/asset/?id=6433106861"

Pause.Name = "Refresh"
Pause.Parent = Controls
Pause.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Pause.BackgroundTransparency = 1.000
Pause.Size = UDim2.new(0, 100, 0, 100)
Pause.Image = "http://www.roblox.com/asset/?id=6417985201"

Content.Name = "Content"
Content.Parent = MainFrame
Content.Active = true
Content.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Content.BackgroundTransparency = 1.000
Content.Position = UDim2.new(0.0697674453, 0, 0.0705394223, 0)
Content.Size = UDim2.new(0.930232584, 0, 0.929460645, 0)

UIGridLayout_2.Parent = Content
UIGridLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
UIGridLayout_2.CellSize = UDim2.new(0.959999979, 0, 0, 30)

BuyTemplate.Name = "BuyTemplate"
BuyTemplate.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
BuyTemplate.BackgroundTransparency = 0.700
BuyTemplate.Size = UDim2.new(0, 200, 0, 50)
BuyTemplate.Visible = false
BuyTemplate.Font = Enum.Font.SourceSans
BuyTemplate.Text = "[gun shop model (full name)]"
BuyTemplate.TextColor3 = Color3.fromRGB(255, 255, 255)
BuyTemplate.TextScaled = true
BuyTemplate.TextSize = 14.000
BuyTemplate.TextWrapped = true

local function tween_to(pos)
	local hrp = lp.Character:WaitForChild('HumanoidRootPart')
	if hrp and con.activetween ~= nil then
		if con.activetween ~= nil then
			con.activetween:Cancel()
			con.activetween = nil
		end
		con.activetween = ts:Create(
			hrp, 
			TweenInfo.new((pos - hrp.Position).Magnitude/con.magnitudediv, Enum.EasingStyle.Linear), 
			{CFrame = CFrame.new(pos, hrp.CFrame.LookVector)}
		)
		con.activetween:Play()
		con.activetween.Completed:Connect(function()
			con.activetween = nil
		end)
	end
end

local function create_button(model)
	local n = BuyTemplate:Clone()
	n.Text = model.Name
	n.Visible = true
	n.Parent = Content
	n.MouseButton1Click:Connect(function()
		tween_to(model.Head.Position)
	end)
end

local function list_guns()
	local shop = game:GetService("Workspace").Shop
	local found = #shop:GetDescendants()
	local current = 0
	
	for _, v in pairs(Content:GetChildren()) do
		if v:IsA(BuyTemplate.ClassName) then
			v:Destroy()
		end
	end
	
	Fill.Visible = true
	Fill.Size = UDim2.new(0, 0, 1, 0)
	Fill.BackgroundTransparency = 0.8
	
	for _, f in pairs(shop:GetChildren()) do
		if f:IsA('Folder') then
			for _, v in pairs(f:GetChildren()) do
				if v:FindFirstChild('Head') then
					create_button(v)
					current += 1
					Fill.Size = UDim2.new(current/found, 0, 1, 0)
				end
			end
		end
	end
	
	Fill.Size = UDim2.new(1, 0, 1, 0)
	local a = ts:Create(Fill, TweenInfo.new(0.5), {BackgroundTransparency = 1})
	a.Completed:Connect(function()
		Fill.Visible = false
	end)
end

Refresh.MouseButton1Click:Connect(function()
	list_guns()
end)

Pause.MouseButton1Click:Connect(function()
	if con.activetween ~= nil then
		con.activetween:Cancel()
		con.activetween = nil
	end
end)
