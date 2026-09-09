local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local Settings = {
	AIM = {
		Enabled = false,
		TeamCheck = true,
		FOV = 200,
		Smoothness = 8,
		MaxDistance = 500,
		TargetPart = "Head"
	},

	ESP = {
		Players = true,
		Bots = true,
		ShowName = true,
		ShowDistance = true,
		ShowType = true,
		ShowHealth = true,
		Box = true,
		TeamCheck = true,
		PlayerDistance = 1000,
		BotDistance = 1000
	}
}

local PlayerColor = Color3.fromRGB(125, 70, 230)
local BotColor = Color3.fromRGB(255, 145, 40)

local ESPObjects = {}

local GUI = Instance.new("ScreenGui")
GUI.Name = "GfoxHack"
GUI.ResetOnSpawn = false
GUI.IgnoreGuiInset = true
GUI.Parent = LocalPlayer:WaitForChild("PlayerGui")

local Main = Instance.new("Frame")
Main.Size = UDim2.fromOffset(410, 560)
Main.Position = UDim2.new(0.5, -205, 0.5, -280)
Main.BackgroundColor3 = Color3.fromRGB(16, 16, 22)
Main.BorderSizePixel = 0
Main.Parent = GUI

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(100, 70, 190)
MainStroke.Thickness = 1.5
MainStroke.Parent = Main

local Top = Instance.new("Frame")
Top.Size = UDim2.new(1, 0, 0, 70)
Top.BackgroundColor3 = Color3.fromRGB(23, 23, 31)
Top.BorderSizePixel = 0
Top.Active = true
Top.Parent = Main

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 16)
TopCorner.Parent = Top

local TopFix = Instance.new("Frame")
TopFix.Size = UDim2.new(1, 0, 0, 20)
TopFix.Position = UDim2.new(0, 0, 1, -20)
TopFix.BackgroundColor3 = Color3.fromRGB(23, 23, 31)
TopFix.BorderSizePixel = 0
TopFix.Parent = Top

local Logo = Instance.new("Frame")
Logo.Size = UDim2.fromOffset(45, 45)
Logo.Position = UDim2.fromOffset(15, 12)
Logo.BackgroundColor3 = Color3.fromRGB(95, 65, 190)
Logo.BorderSizePixel = 0
Logo.Parent = Top

local LogoCorner = Instance.new("UICorner")
LogoCorner.CornerRadius = UDim.new(0, 12)
LogoCorner.Parent = Logo

local LogoText = Instance.new("TextLabel")
LogoText.Size = UDim2.fromScale(1, 1)
LogoText.BackgroundTransparency = 1
LogoText.Text = "G"
LogoText.TextColor3 = Color3.new(1, 1, 1)
LogoText.Font = Enum.Font.GothamBold
LogoText.TextSize = 25
LogoText.Parent = Logo

local Title = Instance.new("TextLabel")
Title.Size = UDim2.fromOffset(250, 30)
Title.Position = UDim2.fromOffset(72, 9)
Title.BackgroundTransparency = 1
Title.Text = "GfoxHack"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 24
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Top

local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.fromOffset(250, 22)
Subtitle.Position = UDim2.fromOffset(73, 38)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "AIM • ESP • PLAYER SYSTEM"
Subtitle.TextColor3 = Color3.fromRGB(145, 140, 165)
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextSize = 10
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.Parent = Top

local Status = Instance.new("TextLabel")
Status.Size = UDim2.fromOffset(70, 25)
Status.Position = UDim2.new(1, -85, 0, 22)
Status.BackgroundColor3 = Color3.fromRGB(30, 100, 65)
Status.Text = "ONLINE"
Status.TextColor3 = Color3.fromRGB(150, 255, 200)
Status.Font = Enum.Font.GothamBold
Status.TextSize = 10
Status.Parent = Top

local StatusCorner = Instance.new("UICorner")
StatusCorner.CornerRadius = UDim.new(1, 0)
StatusCorner.Parent = Status

local Tabs = Instance.new("Frame")
Tabs.Size = UDim2.new(1, -30, 0, 45)
Tabs.Position = UDim2.fromOffset(15, 82)
Tabs.BackgroundColor3 = Color3.fromRGB(25, 25, 33)
Tabs.BorderSizePixel = 0
Tabs.Parent = Main

local TabsCorner = Instance.new("UICorner")
TabsCorner.CornerRadius = UDim.new(0, 10)
TabsCorner.Parent = Tabs

local AimTab = Instance.new("TextButton")
AimTab.Size = UDim2.new(0.5, -4, 1, -8)
AimTab.Position = UDim2.fromOffset(4, 4)
AimTab.BackgroundColor3 = Color3.fromRGB(95, 65, 190)
AimTab.Text = "AIM"
AimTab.TextColor3 = Color3.new(1, 1, 1)
AimTab.Font = Enum.Font.GothamBold
AimTab.TextSize = 14
AimTab.BorderSizePixel = 0
AimTab.Parent = Tabs

local AimTabCorner = Instance.new("UICorner")
AimTabCorner.CornerRadius = UDim.new(0, 8)
AimTabCorner.Parent = AimTab

local ESPTab = Instance.new("TextButton")
ESPTab.Size = UDim2.new(0.5, -4, 1, -8)
ESPTab.Position = UDim2.new(0.5, 0, 0, 4)
ESPTab.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
ESPTab.Text = "ESP"
ESPTab.TextColor3 = Color3.fromRGB(180, 175, 195)
ESPTab.Font = Enum.Font.GothamBold
ESPTab.TextSize = 14
ESPTab.BorderSizePixel = 0
ESPTab.Parent = Tabs

local ESPTabCorner = Instance.new("UICorner")
ESPTabCorner.CornerRadius = UDim.new(0, 8)
ESPTabCorner.Parent = ESPTab

local AimPage = Instance.new("ScrollingFrame")
AimPage.Size = UDim2.new(1, -30, 1, -145)
AimPage.Position = UDim2.fromOffset(15, 140)
AimPage.BackgroundTransparency = 1
AimPage.BorderSizePixel = 0
AimPage.ScrollBarThickness = 3
AimPage.CanvasSize = UDim2.fromOffset(0, 500)
AimPage.Parent = Main

local ESPPage = Instance.new("ScrollingFrame")
ESPPage.Size = UDim2.new(1, -30, 1, -145)
ESPPage.Position = UDim2.fromOffset(15, 140)
ESPPage.BackgroundTransparency = 1
ESPPage.BorderSizePixel = 0
ESPPage.ScrollBarThickness = 3
ESPPage.CanvasSize = UDim2.fromOffset(0, 600)
ESPPage.Visible = false
ESPPage.Parent = Main

local function createToggle(parent, text, y, value)
	local holder = Instance.new("Frame")
	holder.Size = UDim2.new(1, 0, 0, 52)
	holder.Position = UDim2.fromOffset(0, y)
	holder.BackgroundColor3 = Color3.fromRGB(25, 25, 33)
	holder.BorderSizePixel = 0
	holder.Parent = parent

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 10)
	corner.Parent = holder

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -80, 1, 0)
	label.Position = UDim2.fromOffset(15, 0)
	label.BackgroundTransparency = 1
	label.Text = text
	label.TextColor3 = Color3.new(1, 1, 1)
	label.Font = Enum.Font.GothamMedium
	label.TextSize = 14
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = holder

	local toggle = Instance.new("TextButton")
	toggle.Size = UDim2.fromOffset(52, 28)
	toggle.Position = UDim2.new(1, -67, 0.5, -14)
	toggle.BackgroundColor3 =
		value and Color3.fromRGB(95, 65, 190)
		or Color3.fromRGB(55, 55, 65)
	toggle.Text = ""
	toggle.BorderSizePixel = 0
	toggle.Parent = holder

	local toggleCorner = Instance.new("UICorner")
	toggleCorner.CornerRadius = UDim.new(1, 0)
	toggleCorner.Parent = toggle

	local circle = Instance.new("Frame")
	circle.Size = UDim2.fromOffset(22, 22)
	circle.Position =
		value
		and UDim2.new(1, -25, 0.5, -11)
		or UDim2.new(0, 3, 0.5, -11)
	circle.BackgroundColor3 = Color3.new(1, 1, 1)
	circle.BorderSizePixel = 0
	circle.Parent = toggle

	local circleCorner = Instance.new("UICorner")
	circleCorner.CornerRadius = UDim.new(1, 0)
	circleCorner.Parent = circle

	return toggle, circle
end

local function updateToggle(toggle, circle, value)
	TweenService:Create(
		toggle,
		TweenInfo.new(0.15),
		{
			BackgroundColor3 =
				value
				and Color3.fromRGB(95, 65, 190)
				or Color3.fromRGB(55, 55, 65)
		}
	):Play()

	TweenService:Create(
		circle,
		TweenInfo.new(0.15),
		{
			Position =
				value
				and UDim2.new(1, -25, 0.5, -11)
				or UDim2.new(0, 3, 0.5, -11)
		}
	):Play()
end

local function createInput(parent, name, value, y)
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(0.5, 0, 0, 25)
	label.Position = UDim2.fromOffset(0, y)
	label.BackgroundTransparency = 1
	label.Text = name
	label.TextColor3 = Color3.fromRGB(175, 170, 190)
	label.Font = Enum.Font.Gotham
	label.TextSize = 13
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = parent

	local box = Instance.new("TextBox")
	box.Size = UDim2.new(0.5, 0, 0, 36)
	box.Position = UDim2.new(0.5, 0, 0, y - 5)
	box.BackgroundColor3 = Color3.fromRGB(25, 25, 33)
	box.Text = tostring(value)
	box.TextColor3 = Color3.new(1, 1, 1)
	box.Font = Enum.Font.GothamMedium
	box.TextSize = 14
	box.ClearTextOnFocus = false
	box.BorderSizePixel = 0
	box.Parent = parent

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 9)
	corner.Parent = box

	return box
end

local AimToggle, AimCircle =
	createToggle(
		AimPage,
		"AIM Assist",
		0,
		Settings.AIM.Enabled
	)

local AimTeamToggle, AimTeamCircle =
	createToggle(
		AimPage,
		"Team Check",
		62,
		Settings.AIM.TeamCheck
	)

local TargetButton = Instance.new("TextButton")
TargetButton.Size = UDim2.new(1, 0, 0, 52)
TargetButton.Position = UDim2.fromOffset(0, 124)
TargetButton.BackgroundColor3 = Color3.fromRGB(25, 25, 33)
TargetButton.Text = "Target Part     HEAD"
TargetButton.TextColor3 = Color3.new(1, 1, 1)
TargetButton.Font = Enum.Font.GothamMedium
TargetButton.TextSize = 14
TargetButton.BorderSizePixel = 0
TargetButton.Parent = AimPage

local TargetCorner = Instance.new("UICorner")
TargetCorner.CornerRadius = UDim.new(0, 10)
TargetCorner.Parent = TargetButton

local FOVBox =
	createInput(
		AimPage,
		"FOV Radius",
		Settings.AIM.FOV,
		190
	)

local SmoothBox =
	createInput(
		AimPage,
		"Smoothness",
		Settings.AIM.Smoothness,
		240
	)

local AIMDistanceBox =
	createInput(
		AimPage,
		"Max Distance",
		Settings.AIM.MaxDistance,
		290
	)

local ESPPlayersToggle, ESPPlayersCircle =
	createToggle(
		ESPPage,
		"ESP Players",
		0,
		Settings.ESP.Players
	)

local ESPBotsToggle, ESPBotsCircle =
	createToggle(
		ESPPage,
		"ESP Bots",
		62,
		Settings.ESP.Bots
	)

local ShowNameToggle, ShowNameCircle =
	createToggle(
		ESPPage,
		"Show Name",
		124,
		Settings.ESP.ShowName
	)

local ShowDistanceToggle, ShowDistanceCircle =
	createToggle(
		ESPPage,
		"Show Distance",
		186,
		Settings.ESP.ShowDistance
	)

local ShowTypeToggle, ShowTypeCircle =
	createToggle(
		ESPPage,
		"Show Type",
		248,
		Settings.ESP.ShowType
	)

local ShowHealthToggle, ShowHealthCircle =
	createToggle(
		ESPPage,
		"Show Health",
		310,
		Settings.ESP.ShowHealth
	)

local BoxToggle, BoxCircle =
	createToggle(
		ESPPage,
		"Box ESP",
		372,
		Settings.ESP.Box
	)

local ESPTeamToggle, ESPTeamCircle =
	createToggle(
		ESPPage,
		"Team Check",
		434,
		Settings.ESP.TeamCheck
	)

local PlayerDistanceBox =
	createInput(
		ESPPage,
		"Player Distance",
		Settings.ESP.PlayerDistance,
		500
	)

local BotDistanceBox =
	createInput(
		ESPPage,
		"Bot Distance",
		Settings.ESP.BotDistance,
		550
	)

local FOVCircle = Instance.new("Frame")
FOVCircle.AnchorPoint = Vector2.new(0.5, 0.5)
FOVCircle.Position = UDim2.fromScale(0.5, 0.5)
FOVCircle.Size =
	UDim2.fromOffset(
		Settings.AIM.FOV * 2,
		Settings.AIM.FOV * 2
	)
FOVCircle.BackgroundTransparency = 1
FOVCircle.BorderSizePixel = 0
FOVCircle.Visible = false
FOVCircle.Parent = GUI

local FOVCorner = Instance.new("UICorner")
FOVCorner.CornerRadius = UDim.new(1, 0)
FOVCorner.Parent = FOVCircle

local FOVStroke = Instance.new("UIStroke")
FOVStroke.Color = PlayerColor
FOVStroke.Thickness = 2
FOVStroke.Parent = FOVCircle

local function isEnemy(player)
	if not Settings.AIM.TeamCheck then
		return true
	end

	if player.Team == nil or LocalPlayer.Team == nil then
		return true
	end

	return player.Team ~= LocalPlayer.Team
end

local function removeESP(character)
	local data = ESPObjects[character]

	if data then
		if data.highlight then
			data.highlight:Destroy()
		end

		if data.billboard then
			data.billboard:Destroy()
		end

		ESPObjects[character] = nil
	end
end

local function createESP(character, isPlayer, player)
	if not character then
		return
	end

	local humanoid =
		character:FindFirstChildOfClass("Humanoid")

	local head =
		character:FindFirstChild("Head")

	if not humanoid or not head then
		return
	end

	removeESP(character)

	local color =
		isPlayer
		and PlayerColor
		or BotColor

	local highlight = Instance.new("Highlight")
	highlight.Name = "GfoxESP"
	highlight.FillColor = color
	highlight.OutlineColor = Color3.new(1, 1, 1)
	highlight.FillTransparency = 0.65
	highlight.OutlineTransparency = 0
	highlight.DepthMode =
		Enum.HighlightDepthMode.AlwaysOnTop
	highlight.Parent = character

	local billboard = Instance.new("BillboardGui")
	billboard.Name = "GfoxESPInfo"
	billboard.Size = UDim2.fromOffset(180, 75)
	billboard.StudsOffset = Vector3.new(0, 3.2, 0)
	billboard.AlwaysOnTop = true
	billboard.Parent = character

	local label = Instance.new("TextLabel")
	label.Size = UDim2.fromScale(1, 1)
	label.BackgroundTransparency = 1
	label.TextColor3 = color
	label.TextStrokeTransparency = 0.25
	label.Font = Enum.Font.GothamBold
	label.TextSize = 13
	label.TextWrapped = true
	label.Parent = billboard

	ESPObjects[character] = {
		highlight = highlight,
		billboard = billboard,
		label = label,
		isPlayer = isPlayer,
		player = player,
		humanoid = humanoid
	}
end

local function setupPlayer(player)
	if player == LocalPlayer then
		return
	end

	local function characterAdded(character)
		task.wait(0.2)
		createESP(character, true, player)
	end

	if player.Character then
		characterAdded(player.Character)
	end

	player.CharacterAdded:Connect(characterAdded)

	player.CharacterRemoving:Connect(function(character)
		removeESP(character)
	end)
end

for _, player in ipairs(Players:GetPlayers()) do
	setupPlayer(player)
end

Players.PlayerAdded:Connect(setupPlayer)

Players.PlayerRemoving:Connect(function(player)
	if player.Character then
		removeESP(player.Character)
	end
end)

local function scanBots()
	for _, object in ipairs(workspace:GetDescendants()) do
		if object:IsA("Model") then
			local humanoid =
				object:FindFirstChildOfClass("Humanoid")

			local player =
				Players:GetPlayerFromCharacter(object)

			if humanoid and not player then
				if object:FindFirstChild("Head") then
					if not ESPObjects[object] then
						createESP(
							object,
							false,
							nil
						)
					end
				end
			end
		end
	end
end

scanBots()

workspace.DescendantAdded:Connect(function(object)
	if object:IsA("Model") then
		task.wait(0.1)

		local humanoid =
			object:FindFirstChildOfClass("Humanoid")

		local player =
			Players:GetPlayerFromCharacter(object)

		if humanoid and not player then
			if object:FindFirstChild("Head") then
				createESP(
					object,
					false,
					nil
				)
			end
		end
	end
end)

local function getTarget()
	local center = Vector2.new(
		Camera.ViewportSize.X / 2,
		Camera.ViewportSize.Y / 2
	)

	local closest
	local closestDistance = Settings.AIM.FOV

	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer then
			if isEnemy(player) then

				local character = player.Character

				if character then
					local humanoid =
						character:FindFirstChildOfClass("Humanoid")

					local part =
						character:FindFirstChild(
							Settings.AIM.TargetPart
						)

					if humanoid
						and humanoid.Health > 0
						and part then

						local worldDistance =
							(
								Camera.CFrame.Position
								- part.Position
							).Magnitude

						if worldDistance <= Settings.AIM.MaxDistance then

							local screenPosition, visible =
								Camera:WorldToViewportPoint(
									part.Position
								)

							if visible and screenPosition.Z > 0 then

								local distance =
									(
										Vector2.new(
											screenPosition.X,
											screenPosition.Y
										) - center
									).Magnitude

								if distance < closestDistance then
									closestDistance = distance
									closest = part
								end
							end
						end
					end
				end
			end
		end
	end

	return closest
end

local function aimAt(part)
	if not part then
		return
	end

	local cameraPosition =
		Camera.CFrame.Position

	local target =
		CFrame.lookAt(
			cameraPosition,
			part.Position
		)

	Camera.CFrame =
		Camera.CFrame:Lerp(
			target,
			math.clamp(
				Settings.AIM.Smoothness / 100,
				0.01,
				1
			)
		)
end

local function updateESP()
	for character, data in pairs(ESPObjects) do

		if not character.Parent then
			removeESP(character)
			continue
		end

		local root =
			character:FindFirstChild(
				"HumanoidRootPart"
			)

		if not root then
			continue
		end

		local distance =
			(
				Camera.CFrame.Position
				- root.Position
			).Magnitude

		local allowedDistance =
			data.isPlayer
			and Settings.ESP.PlayerDistance
			or Settings.ESP.BotDistance

		local enabled =
			data.isPlayer
			and Settings.ESP.Players
			or (not data.isPlayer
			and Settings.ESP.Bots)

		if data.isPlayer and data.player then
			if Settings.ESP.TeamCheck then
				if not isEnemy(data.player) then
					enabled = false
				end
			end
		end

		if distance > allowedDistance then
			enabled = false
		end

		data.highlight.Enabled =
			enabled and Settings.ESP.Box

		data.billboard.Enabled = enabled

		local lines = {}

		if Settings.ESP.ShowName then
			if data.isPlayer and data.player then
				table.insert(
					lines,
					data.player.DisplayName
				)
			else
				table.insert(
					lines,
					character.Name
				)
			end
		end

		if Settings.ESP.ShowType then
			table.insert(
				lines,
				data.isPlayer
				and "PLAYER"
				or "BOT"
			)
		end

		if Settings.ESP.ShowDistance then
			table.insert(
				lines,
				math.floor(distance)
					.. " studs"
			)
		end

		if Settings.ESP.ShowHealth then
			table.insert(
				lines,
				"HP: "
					.. math.floor(
						data.humanoid.Health
					)
					.. "/"
					.. math.floor(
						data.humanoid.MaxHealth
					)
			)
		end

		data.label.Text =
			table.concat(lines, "\n")
	end
end

AimToggle.MouseButton1Click:Connect(function()
	Settings.AIM.Enabled =
		not Settings.AIM.Enabled

	updateToggle(
		AimToggle,
		AimCircle,
		Settings.AIM.Enabled
	)

	FOVCircle.Visible =
		Settings.AIM.Enabled
end)

AimTeamToggle.MouseButton1Click:Connect(function()
	Settings.AIM.TeamCheck =
		not Settings.AIM.TeamCheck

	updateToggle(
		AimTeamToggle,
		AimTeamCircle,
		Settings.AIM.TeamCheck
	)
end)

ESPTeamToggle.MouseButton1Click:Connect(function()
	Settings.ESP.TeamCheck =
		not Settings.ESP.TeamCheck

	updateToggle(
		ESPTeamToggle,
		ESPTeamCircle,
		Settings.ESP.TeamCheck
	)
end)

ESPPlayersToggle.MouseButton1Click:Connect(function()
	Settings.ESP.Players =
		not Settings.ESP.Players

	updateToggle(
		ESPPlayersToggle,
		ESPPlayersCircle,
		Settings.ESP.Players
	)
end)

ESPBotsToggle.MouseButton1Click:Connect(function()
	Settings.ESP.Bots =
		not Settings.ESP.Bots

	updateToggle(
		ESPBotsToggle,
		ESPBotsCircle,
		Settings.ESP.Bots
	)
end)

ShowNameToggle.MouseButton1Click:Connect(function()
	Settings.ESP.ShowName =
		not Settings.ESP.ShowName

	updateToggle(
		ShowNameToggle,
		ShowNameCircle,
		Settings.ESP.ShowName
	)
end)

ShowDistanceToggle.MouseButton1Click:Connect(function()
	Settings.ESP.ShowDistance =
		not Settings.ESP.ShowDistance

	updateToggle(
		ShowDistanceToggle,
		ShowDistanceCircle,
		Settings.ESP.ShowDistance
	)
end)

ShowTypeToggle.MouseButton1Click:Connect(function()
	Settings.ESP.ShowType =
		not Settings.ESP.ShowType

	updateToggle(
		ShowTypeToggle,
		ShowTypeCircle,
		Settings.ESP.ShowType
	)
end)

ShowHealthToggle.MouseButton1Click:Connect(function()
	Settings.ESP.ShowHealth =
		not Settings.ESP.ShowHealth

	updateToggle(
		ShowHealthToggle,
		ShowHealthCircle,
		Settings.ESP.ShowHealth
	)
end)

BoxToggle.MouseButton1Click:Connect(function()
	Settings.ESP.Box =
		not Settings.ESP.Box

	updateToggle(
		BoxToggle,
		BoxCircle,
		Settings.ESP.Box
	)
end)

TargetButton.MouseButton1Click:Connect(function()
	if Settings.AIM.TargetPart == "Head" then
		Settings.AIM.TargetPart =
			"HumanoidRootPart"

		TargetButton.Text =
			"Target Part     ROOT"
	else
		Settings.AIM.TargetPart =
			"Head"

		TargetButton.Text =
			"Target Part     HEAD"
	end
end)

FOVBox.FocusLost:Connect(function()
	local value =
		tonumber(FOVBox.Text)

	if value then
		Settings.AIM.FOV =
			math.clamp(value, 50, 600)

		FOVBox.Text =
			tostring(Settings.AIM.FOV)

		FOVCircle.Size =
			UDim2.fromOffset(
				Settings.AIM.FOV * 2,
				Settings.AIM.FOV * 2
			)
	end
end)

SmoothBox.FocusLost:Connect(function()
	local value =
		tonumber(SmoothBox.Text)

	if value then
		Settings.AIM.Smoothness =
			math.clamp(value, 1, 100)

		SmoothBox.Text =
			tostring(Settings.AIM.Smoothness)
	end
end)

AIMDistanceBox.FocusLost:Connect(function()
	local value =
		tonumber(AIMDistanceBox.Text)

	if value then
		Settings.AIM.MaxDistance =
			math.clamp(value, 50, 5000)

		AIMDistanceBox.Text =
			tostring(Settings.AIM.MaxDistance)
	end
end)

PlayerDistanceBox.FocusLost:Connect(function()
	local value =
		tonumber(PlayerDistanceBox.Text)

	if value then
		Settings.ESP.PlayerDistance =
			math.clamp(value, 50, 5000)

		PlayerDistanceBox.Text =
			tostring(
				Settings.ESP.PlayerDistance
			)
	end
end)

BotDistanceBox.FocusLost:Connect(function()
	local value =
		tonumber(BotDistanceBox.Text)

	if value then
		Settings.ESP.BotDistance =
			math.clamp(value, 50, 5000)

		BotDistanceBox.Text =
			tostring(
				Settings.ESP.BotDistance
			)
	end
end)

AimTab.MouseButton1Click:Connect(function()
	AimPage.Visible = true
	ESPPage.Visible = false

	AimTab.BackgroundColor3 =
		Color3.fromRGB(95, 65, 190)

	ESPTab.BackgroundColor3 =
		Color3.fromRGB(35, 35, 45)

	AimTab.TextColor3 =
		Color3.new(1, 1, 1)

	ESPTab.TextColor3 =
		Color3.fromRGB(180, 175, 195)
end)

ESPTab.MouseButton1Click:Connect(function()
	AimPage.Visible = false
	ESPPage.Visible = true

	AimTab.BackgroundColor3 =
		Color3.fromRGB(35, 35, 45)

	ESPTab.BackgroundColor3 =
		Color3.fromRGB(95, 65, 190)

	AimTab.TextColor3 =
		Color3.fromRGB(180, 175, 195)

	ESPTab.TextColor3 =
		Color3.new(1, 1, 1)
end)

local dragging = false
local dragStart
local startPosition

Top.InputBegan:Connect(function(input)
	if input.UserInputType ==
		Enum.UserInputType.MouseButton1
		or input.UserInputType ==
		Enum.UserInputType.Touch then

		dragging = true
		dragStart = input.Position
		startPosition = Main.Position
	end
end)

Top.InputEnded:Connect(function(input)
	if input.UserInputType ==
		Enum.UserInputType.MouseButton1
		or input.UserInputType ==
		Enum.UserInputType.Touch then

		dragging = false
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if not dragging then
		return
	end

	if input.UserInputType ==
		Enum.UserInputType.MouseMovement
		or input.UserInputType ==
		Enum.UserInputType.Touch then

		local delta =
			input.Position - dragStart

		Main.Position = UDim2.new(
			startPosition.X.Scale,
			startPosition.X.Offset + delta.X,
			startPosition.Y.Scale,
			startPosition.Y.Offset + delta.Y
		)
	end
end)

UserInputService.InputBegan:Connect(function(input, processed)
	if processed then
		return
	end

	if input.KeyCode == Enum.KeyCode.Z then
		Main.Visible =
			not Main.Visible
	end
end)

RunService.RenderStepped:Connect(function()
	if Settings.AIM.Enabled then
		local target = getTarget()

		if target then
			aimAt(target)
		end
	end

	updateESP()
end)

FOVCircle.Visible =
	Settings.AIM.Enabled