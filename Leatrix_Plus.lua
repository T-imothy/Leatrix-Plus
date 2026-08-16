-- Leatrix Plus - CMaNGOS compatibility edition.
-- The build descriptor is supplied by Client.lua in the TBC/WotLK ports.

local LeaPlusBuild = LeaPlusBuild or {
	name = "Classic", interface = 11200, version = "1.12.1-allinone.29",
	theme = {
		normal = {0.34, 0.055, 0.045, 0.98}, hover = {0.62, 0.09, 0.06, 1},
		border = {0.82, 0.24, 0.15, 1}, active = {0.72, 0.10, 0.055, 1},
		text = {1, 0.92, 0.88, 1}, accent = {1, 0.30, 0.20, 1}
	}
}
local LEAPLUS_VERSION = LeaPlusBuild.version
local LEAPLUS_CLIENT_NAME = LeaPlusBuild.name or "Classic"
local LEAPLUS_INTERFACE = LeaPlusBuild.interface or 11200
local LEAPLUS_THEME = LeaPlusBuild.theme
local LEAPLUS_PREFIX = "|cff00bfffLeatrix Plus " .. LEAPLUS_CLIENT_NAME .. ":|r "
local LEAPLUS_FLIGHT_END_GRACE = 2.50

local function LeaPlus_HandlerSelf(self)
	return self or this
end

local function LeaPlus_HandlerArg(value, legacy)
	if value ~= nil then return value end
	return legacy
end

local function LeaPlus_UnpackColor(color)
	return color[1], color[2], color[3], color[4]
end

local function LeaPlus_StyleButton(button, active)
	if not button then return end
	if button.SetNormalTexture then button:SetNormalTexture("") end
	if button.SetPushedTexture then button:SetPushedTexture("") end
	if button.SetHighlightTexture then button:SetHighlightTexture("") end
	if button.SetDisabledTexture then button:SetDisabledTexture("") end
	button:SetBackdrop({
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tile = true, tileSize = 16, edgeSize = 7,
		insets = {left = 2, right = 2, top = 2, bottom = 2}
	})
	local color = active and LEAPLUS_THEME.active or LEAPLUS_THEME.normal
	button:SetBackdropColor(LeaPlus_UnpackColor(color))
	button:SetBackdropBorderColor(LeaPlus_UnpackColor(LEAPLUS_THEME.border))
	if button.GetFontString and button:GetFontString() then
		button:GetFontString():SetTextColor(LeaPlus_UnpackColor(LEAPLUS_THEME.text))
	end
	button:SetScript("OnEnter", function(self)
		local owner = LeaPlus_HandlerSelf(self)
		if owner then owner:SetBackdropColor(LeaPlus_UnpackColor(LEAPLUS_THEME.hover)) end
	end)
	button:SetScript("OnLeave", function(self)
		local owner = LeaPlus_HandlerSelf(self)
		if owner then owner:SetBackdropColor(LeaPlus_UnpackColor(color)) end
		GameTooltip:Hide()
	end)
end

local LeaPlusDefaults = {
	AutomateQuests = "Off",
	GuideAwareQuests = "On",
	AutomateGossip = "Off",
	AutoAcceptSummon = "Off",
	AutoAcceptRes = "Off",
	AutoReleasePvP = "Off",
	AutoSellJunk = "Off",
	AutoRepairGear = "Off",
	NoDuelRequests = "Off",
	NoPartyInvites = "Off",
	AcceptPartyFriends = "Off",
	AcceptPartyStrangers = "Off",
	PausePartyAcceptInBG = "Off",
	InviteFromWhisper = "Off",
	UseArrowKeysInChat = "Off",
	NoStickyChat = "Off",
	NoChatFade = "Off",
	MaxChatHstory = "Off",
	NoCombatLogTab = "Off",
	NoChatButtons = "Off",
	MoveChatEditBoxToTop = "Off",
	HideErrorMessages = "Off",
	HideZoneText = "Off",
	MinimapMod = "Off",
	NoGryphons = "Off",
	NoClassBar = "Off",
	NoScreenGlow = "Off",
	NoScreenEffects = "Off",
	MaxCameraZoom = "Off",
	FasterLooting = "Off",
	StandAndDismount = "Off",
	AutoQueueBG = "Off",
	AutoEnterBG = "Off",
	AutoLeaveBG = "Off",
	AnnounceBGQueue = "Off",
	BlockBGQuestShare = "Off",
	LootAtCursor = "Off",
	ImprovedBagRightClick = "Off",
	EasyStackSplit = "Off",
	ZGNeed = "Off",
	ZGGreed = "Off",
	ZGPass = "Off",
	GreenNeed = "Off",
	GreenGreed = "Off",
	GreenPass = "Off",
	RepeatableQuestAssist = "Off",
	SpecialKeyCombos = "Off",
	PrivateServerSave = "Off",
	MuteWorldDungeon = "Off",
	MuteWorldRaid = "Off",
	MuteWorldBG = "Off",
	MuteWorldAlways = "Off",
	FilterDuplicateChat = "Off",
	FilterUncommonRolls = "Off",
	FilterRareRolls = "Off",
	FilterLowLoot = "Off",
	RemoveSalvationAlways = "Off",
	RemoveSalvationTank = "Off",
	ShowEnemyPlates = "Off",
	ShowFriendlyPlates = "Off",
	HideUncheckedPlates = "Off",
	ExpandedQuestLog = "Off",
	FlightTimer = "On"
}

local LeaPlusOptionKeys = {
	"AutomateQuests", "GuideAwareQuests", "AutomateGossip", "AutoAcceptSummon",
	"AutoAcceptRes", "AutoReleasePvP", "AutoSellJunk",
	"AutoRepairGear", "NoDuelRequests", "NoPartyInvites",
	"AcceptPartyFriends", "AcceptPartyStrangers", "PausePartyAcceptInBG",
	"InviteFromWhisper", "UseArrowKeysInChat",
	"NoStickyChat", "NoChatFade", "MaxChatHstory", "NoCombatLogTab",
	"NoChatButtons", "MoveChatEditBoxToTop", "HideErrorMessages",
	"HideZoneText", "MinimapMod", "NoGryphons", "NoClassBar",
	"NoScreenGlow", "NoScreenEffects", "MaxCameraZoom",
	"FasterLooting", "StandAndDismount", "AutoQueueBG",
	"AutoEnterBG", "AutoLeaveBG", "AnnounceBGQueue",
	"BlockBGQuestShare", "LootAtCursor", "ImprovedBagRightClick",
	"EasyStackSplit", "ZGNeed", "ZGGreed", "ZGPass",
	"GreenNeed", "GreenGreed", "GreenPass", "RepeatableQuestAssist",
	"SpecialKeyCombos", "PrivateServerSave", "MuteWorldDungeon",
	"MuteWorldRaid", "MuteWorldBG", "MuteWorldAlways",
	"FilterDuplicateChat", "FilterUncommonRolls", "FilterRareRolls",
	"FilterLowLoot", "RemoveSalvationAlways", "RemoveSalvationTank",
	"ShowEnemyPlates", "ShowFriendlyPlates", "HideUncheckedPlates",
	"ExpandedQuestLog", "FlightTimer"
}

local LeaPlusRecommendedKeys = {
	"GuideAwareQuests",
	"AutoSellJunk", "AutoRepairGear", "NoDuelRequests",
	"UseArrowKeysInChat", "NoStickyChat", "NoChatFade",
	"MaxChatHstory", "MinimapMod", "MaxCameraZoom",
	"FasterLooting", "StandAndDismount", "LootAtCursor",
	"FilterDuplicateChat", "PrivateServerSave", "ExpandedQuestLog", "FlightTimer"
}

local LeaPlusCheckButtons = {}
local LeaPlusPages = {}
local LeaPlusCurrentPage = 1
local LeaPlusOriginalEditPoint = nil
local LeaPlusOriginalEditRelative = nil
local LeaPlusOriginalEditRelativePoint = nil
local LeaPlusOriginalEditX = nil
local LeaPlusOriginalEditY = nil
local LeaPlusMerchantActive = nil
local LeaPlusMerchantProcessed = {}
local LeaPlusMerchantSold = 0
local LeaPlusMerchantRepairDone = nil
local LeaPlusMerchantTick = 0
local LeaPlusInitialized = nil
local LeaPlusApplied = {}
local LeaPlusApplyNameplates = nil
local LeaPlusApplyWorldChannel = nil
local LeaPlusCheckSalvation = nil
local LeaPlusIsQueuedOrInBG = nil
local LeaPlusOriginalUseContainerItem = nil
local LeaPlusOriginalLootFrameOnEvent = nil
local LeaPlusOriginalLootFrameUpdate = nil
local LeaPlusOriginalChatFrameOnEvent = nil
local LeaPlusOriginalSelectGossipActiveQuest = nil
local LeaPlusOriginalSelectGossipAvailableQuest = nil
local LeaPlusOriginalSelectActiveQuest = nil
local LeaPlusOriginalSelectAvailableQuest = nil
local LeaPlusOriginalTakeTaxiNode = nil
local LeaPlusRepeatQuestActive = nil
local LeaPlusQuestPendingEvent = nil
local LeaPlusQuestPendingDelay = 0
local LeaPlus_ProcessQuestDialog = nil
local LeaPlusWSGCarrier = nil
local LeaPlusBGLeaveDone = nil
local LeaPlusTradeOpen = nil
local LeaPlusMailOpen = nil
local LeaPlusAuctionOpen = nil
local LeaPlusBankOpen = nil
local LeaPlusWorldFrames = {}
local LeaPlusWorldChannelName = nil
local LeaPlusChatHistory = {}
local LeaPlusPrivateSaveAt = nil
local LeaPlusPrivateSaveSentAt = 0
local LeaPlusPrivateSaveDisabled = nil
local LeaPlusLastCombo = ""
local LeaPlusComboReadyAt = 0
local LeaPlusPopupCheckAt = 0
local LeaPlusInitialEnemyPlates = nil
local LeaPlusInitialFriendlyPlates = nil
local LeaPlusStackAmount = 1
local LeaPlusStackUntil = 0
local LeaPlusStackAdjustAt = 0
local LeaPlusStackTasks = {}
local LeaPlusSelfShiftAt = nil
local LeaPlusLootPending = nil
local LeaPlusLootStartedAt = 0
local LeaPlusLootNextAt = 0
local LeaPlusLootStopAt = 0
local LeaPlusLootFrameWasOpen = nil
local LeaPlusSearchLastQuery = ""
local LeaPlusSearchIndex = 0
local LeaPlusSearchMatches = {}
local LeaPlusQuestGreetingSignature = nil
local LeaPlusGossipSignature = nil
local LeaPlusFlightPending = nil
local LeaPlusFlightActive = nil
local LeaPlusFlightUpdateAt = 0

local function LeaPlus_Print(message)
	if DEFAULT_CHAT_FRAME then
		DEFAULT_CHAT_FRAME:AddMessage(LEAPLUS_PREFIX .. message)
	end
end

local function LeaPlus_IsOn(option)
	return LeaPlusDB and LeaPlusDB[option] == "On"
end

local function LeaPlus_SafeGetCVar(name)
	if not GetCVar then return nil end
	local ok, value = pcall(GetCVar, name)
	if ok then return value end
	return nil
end

local function LeaPlus_SafeSetCVar(name, value)
	if SetCVar then pcall(SetCVar, name, value) end
end

local function LeaPlus_NormalizeName(name)
	if not name then return "" end
	name = string.gsub(name, "%-.*$", "")
	return string.lower(name)
end

local function LeaPlus_IsFriend(name)
	local wanted = LeaPlus_NormalizeName(name)
	local i
	for i = 1, GetNumFriends() do
		local friendName = GetFriendInfo(i)
		if friendName and LeaPlus_NormalizeName(friendName) == wanted then
			return true
		end
	end
	return nil
end

local function LeaPlus_IsGuildMate(name)
	if not IsInGuild or not IsInGuild() then return nil end
	local wanted = LeaPlus_NormalizeName(name)
	local i
	for i = 1, GetNumGuildMembers() do
		local guildName = GetGuildRosterInfo(i)
		if guildName and LeaPlus_NormalizeName(guildName) == wanted then
			return true
		end
	end
	return nil
end

local function LeaPlus_IsKnownPlayer(name)
	return LeaPlus_IsFriend(name) or LeaPlus_IsGuildMate(name)
end

local function LeaPlus_MoneyString(copper)
	if not copper then copper = 0 end
	local gold = math.floor(copper / 10000)
	local silver = math.floor(mod(copper / 100, 100))
	local coins = math.floor(mod(copper, 100))
	return gold .. "g " .. silver .. "s " .. coins .. "c"
end

local function LeaPlus_FlightTimeText(seconds)
	seconds = math.max(0, math.floor((seconds or 0) + 0.5))
	local minutes = math.floor(seconds / 60)
	local remainder = mod(seconds, 60)
	return string.format("%d:%02d", minutes, remainder)
end

local function LeaPlus_FlightRouteKey(sourceName, destinationName)
	local faction = UnitFactionGroup and UnitFactionGroup("player") or "Neutral"
	return tostring(faction or "Neutral") .. "\031" .. tostring(sourceName or "Unknown") ..
		"\031" .. tostring(destinationName or "Unknown")
end

function LeaPlus_ResetFlightBarPosition()
	if not LeaPlusDB then return end
	LeaPlusDB.FlightBarX = 0
	LeaPlusDB.FlightBarY = 0
	LeaPlusDB.FlightBarMoved = nil
	if LeaPlusFlightBar then
		LeaPlusFlightBar:ClearAllPoints()
		LeaPlusFlightBar:SetPoint("TOP", UIParent, "TOP", 0, -115)
	end
	LeaPlus_Print("Flight timer position reset.")
end

function LeaPlus_FlightBar_OnDragStop(self)
	self = LeaPlus_HandlerSelf(self)
	if not self then return end
	self:StopMovingOrSizing()
	if not LeaPlusDB or not self.GetCenter or not UIParent.GetCenter then return end
	local x, y = self:GetCenter()
	local parentX, parentY = UIParent:GetCenter()
	if x and y and parentX and parentY then
		LeaPlusDB.FlightBarX = x - parentX
		LeaPlusDB.FlightBarY = y - parentY
		LeaPlusDB.FlightBarMoved = true
		self:ClearAllPoints()
		self:SetPoint("CENTER", UIParent, "CENTER", LeaPlusDB.FlightBarX, LeaPlusDB.FlightBarY)
	end
end

function LeaPlus_FlightBar_OnMouseDown(self, button)
	button = LeaPlus_HandlerArg(button, arg1)
	if button == "RightButton" then LeaPlus_ResetFlightBarPosition() end
end

local function LeaPlus_CreateFlightBar()
	if LeaPlusFlightBar then return end
	local frame = CreateFrame("Frame", "LeaPlusFlightBar", UIParent)
	frame:SetWidth(330)
	frame:SetHeight(54)
	frame:SetFrameStrata("HIGH")
	frame:SetMovable(true)
	frame:EnableMouse(true)
	frame:RegisterForDrag("LeftButton")
	frame:SetScript("OnDragStart", function(self) local owner = LeaPlus_HandlerSelf(self); if owner then owner:StartMoving() end end)
	frame:SetScript("OnDragStop", LeaPlus_FlightBar_OnDragStop)
	frame:SetScript("OnMouseDown", LeaPlus_FlightBar_OnMouseDown)
	frame:SetBackdrop({
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tile = true, tileSize = 16, edgeSize = 12,
		insets = {left = 3, right = 3, top = 3, bottom = 3}
	})
	frame:SetBackdropColor(0.02, 0.02, 0.02, 0.90)
	frame:SetBackdropBorderColor(0.72, 0.48, 0.08, 1)
	if LeaPlusDB and LeaPlusDB.FlightBarMoved then
		frame:SetPoint("CENTER", UIParent, "CENTER", LeaPlusDB.FlightBarX or 0, LeaPlusDB.FlightBarY or 0)
	else
		frame:SetPoint("TOP", UIParent, "TOP", 0, -115)
	end

	frame.title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	frame.title:SetPoint("TOP", frame, "TOP", 0, -8)
	frame.title:SetWidth(306)
	frame.title:SetJustifyH("CENTER")
	frame.title:SetTextColor(LeaPlus_UnpackColor(LEAPLUS_THEME.accent))

	frame.status = CreateFrame("StatusBar", nil, frame)
	frame.status:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 10, 9)
	frame.status:SetWidth(310)
	frame.status:SetHeight(18)
	frame.status:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
	frame.status:SetStatusBarColor(0.20, 0.72, 0.92)
	frame.status:SetMinMaxValues(0, 1)
	frame.status:SetValue(0)
	frame.status.bg = frame.status:CreateTexture(nil, "BACKGROUND")
	frame.status.bg:SetAllPoints(frame.status)
	frame.status.bg:SetTexture(0.06, 0.06, 0.06, 0.92)
	frame.status.text = frame.status:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
	frame.status.text:SetPoint("CENTER", frame.status, "CENTER", 0, 0)
	frame.status.text:SetWidth(300)
	frame.status.text:SetJustifyH("CENTER")
	frame:Hide()
	LeaPlusFlightBar = frame
end

local function LeaPlus_FlightEstimate(originX, originY, destinationX, destinationY)
	if not originX or not originY or not destinationX or not destinationY then return 90 end
	local dx = destinationX - originX
	local dy = destinationY - originY
	local estimate = 25 + math.sqrt(dx * dx + dy * dy) * 600
	if estimate < 30 then estimate = 30 end
	if estimate > 600 then estimate = 600 end
	return estimate
end

-- Stable coordinate hash used by the bundled preset database.  The taxi-map
-- coordinates are more dependable than localized flight-master names.
local function LeaPlus_FlightNodeHash(x)
	if not x then return nil end
	return tostring(math.floor(x * 100000000))
end

-- ALL-IN-ONE 25: private 1.12 clients can return taxi-map coordinates a few
-- floating-point units away from the values used to build the preset table.
-- Prefer an exact key, then tolerate only a very small coordinate difference.
local function LeaPlus_ClosestFlightHash(container, wanted)
	if not container or not wanted then return nil end
	if container[wanted] then return wanted end
	local target = tonumber(wanted)
	if not target then return nil end
	local best, bestDelta = nil, nil
	local key
	for key in pairs(container) do
		local numeric = tonumber(key)
		if numeric then
			local delta = math.abs(numeric - target)
			if not bestDelta or delta < bestDelta then
				best, bestDelta = key, delta
			end
		end
	end
	if bestDelta and bestDelta <= 2500 then return best end
	return nil
end

local function LeaPlus_FlightPreset(sourceHash, destinationHash)
	local faction = UnitFactionGroup and UnitFactionGroup("player") or nil
	local factionData = faction and LeaPlusFlightDefaults112 and LeaPlusFlightDefaults112[faction]
	local sourceKey = LeaPlus_ClosestFlightHash(factionData, sourceHash)
	local sourceData = sourceKey and factionData[sourceKey]
	local destinationKey = LeaPlus_ClosestFlightHash(sourceData, destinationHash)
	return destinationKey and sourceData[destinationKey] or nil
end

local function LeaPlus_BeginFlight()
	if not LeaPlusFlightPending or LeaPlusFlightActive then return end
	LeaPlusFlightActive = LeaPlusFlightPending
	LeaPlusFlightPending = nil
	LeaPlusFlightActive.started = GetTime()
	LeaPlusFlightActive.offTaxiSince = nil
	if LeaPlus_IsOn("FlightTimer") then
		LeaPlus_CreateFlightBar()
		LeaPlusFlightBar.title:SetText("Flight to " .. tostring(LeaPlusFlightActive.destination or "destination"))
		LeaPlusFlightBar:Show()
	end
end

local function LeaPlus_EndFlight()
	if not LeaPlusFlightActive then return end
	local actual = GetTime() - (LeaPlusFlightActive.started or GetTime())
	if actual > 5 and LeaPlusFlightActive.key and LeaPlusDB then
		if type(LeaPlusDB.FlightTimes) ~= "table" then LeaPlusDB.FlightTimes = {} end
		local previous = LeaPlusDB.FlightTimes[LeaPlusFlightActive.key]
		LeaPlusDB.FlightTimes[LeaPlusFlightActive.key] = actual
		if not previous or math.abs(previous - actual) > 5 then
			LeaPlus_Print("Learned flight: |cffffffff" .. tostring(LeaPlusFlightActive.source) ..
				" to " .. tostring(LeaPlusFlightActive.destination) .. "|r (" ..
				LeaPlus_FlightTimeText(actual) .. ").")
		end
	end
	if LeaPlusFlightBar then LeaPlusFlightBar:Hide() end
	LeaPlusFlightActive = nil
end

function LeaPlus_TakeTaxiNode_Hook(index)
	local sourceName, destinationName
	local sourceX, sourceY, destinationX, destinationY
	local sourceHash, destinationHash
	if NumTaxiNodes and TaxiNodeName then
		local i
		for i = 1, NumTaxiNodes() do
			if TaxiNodeGetType and TaxiNodeGetType(i) == "CURRENT" then
				sourceName = TaxiNodeName(i)
				if TaxiNodePosition then
					sourceX, sourceY = TaxiNodePosition(i)
					sourceHash = LeaPlus_FlightNodeHash(sourceX)
				end
				break
			end
		end
		destinationName = TaxiNodeName(index)
		if TaxiNodePosition then
			destinationX, destinationY = TaxiNodePosition(index)
			destinationHash = LeaPlus_FlightNodeHash(destinationX)
		end
	end
	local key = LeaPlus_FlightRouteKey(sourceName, destinationName)
	local learned = LeaPlusDB and type(LeaPlusDB.FlightTimes) == "table" and LeaPlusDB.FlightTimes[key] or nil
	local preset = LeaPlus_FlightPreset(sourceHash, destinationHash)
	LeaPlusFlightPending = {
		source = sourceName or "Flight master",
		destination = destinationName or "destination",
		key = key,
		duration = learned or preset or LeaPlus_FlightEstimate(sourceX, sourceY, destinationX, destinationY),
		estimated = not learned and not preset,
		preset = not learned and preset and true or false,
		requested = GetTime()
	}
	return LeaPlusOriginalTakeTaxiNode(index)
end

local function LeaPlus_UpdateFlightTimer()
	local now = GetTime()
	if now < LeaPlusFlightUpdateAt then return end
	LeaPlusFlightUpdateAt = now + 0.05
	if LeaPlusFlightPending and UnitOnTaxi and UnitOnTaxi("player") then LeaPlus_BeginFlight() end
	if LeaPlusFlightPending and now - (LeaPlusFlightPending.requested or now) > 3 and
		(not UnitOnTaxi or not UnitOnTaxi("player")) then
		LeaPlusFlightPending = nil
	end
	if not LeaPlusFlightActive then return end
	local elapsed = now - (LeaPlusFlightActive.started or now)
	if elapsed > 1.5 and UnitOnTaxi then
		if UnitOnTaxi("player") then
			-- Multi-leg Vanilla flights can briefly flicker false at a transfer
			-- node. Returning to true proves the route is still in progress.
			LeaPlusFlightActive.offTaxiSince = nil
		elseif not LeaPlusFlightActive.offTaxiSince then
			LeaPlusFlightActive.offTaxiSince = now
		elseif now - LeaPlusFlightActive.offTaxiSince >= LEAPLUS_FLIGHT_END_GRACE then
			LeaPlus_EndFlight()
			return
		end
	end
	if not LeaPlus_IsOn("FlightTimer") then
		if LeaPlusFlightBar then LeaPlusFlightBar:Hide() end
		return
	end
	LeaPlus_CreateFlightBar()
	if not LeaPlusFlightBar:IsShown() then LeaPlusFlightBar:Show() end
	local duration = LeaPlusFlightActive.duration or 90
	local shownElapsed = elapsed
	if shownElapsed > duration then shownElapsed = duration end
	LeaPlusFlightBar.status:SetMinMaxValues(0, duration)
	LeaPlusFlightBar.status:SetValue(shownElapsed)
	local remaining = duration - elapsed
	if remaining <= 0 then
		LeaPlusFlightBar.status.text:SetText(LeaPlus_FlightTimeText(elapsed) ..
			" elapsed  |  correcting route")
	elseif LeaPlusFlightActive.estimated then
		if remaining > 0 then
			LeaPlusFlightBar.status.text:SetText("~" .. LeaPlus_FlightTimeText(remaining) ..
				" remaining  |  learning route")
		end
	elseif LeaPlusFlightActive.preset then
		LeaPlusFlightBar.status.text:SetText(LeaPlus_FlightTimeText(remaining) ..
			" remaining  |  preset route")
	else
		LeaPlusFlightBar.status.text:SetText(LeaPlus_FlightTimeText(remaining) ..
			" remaining  |  " .. LeaPlus_FlightTimeText(elapsed) .. " elapsed")
	end
end

local function LeaPlus_SetShown(frame, shown)
	if not frame then return end
	if shown then frame:Show() else frame:Hide() end
end

function LeaPlus_MinimapWheel(self, delta)
	delta = LeaPlus_HandlerArg(delta, arg1)
	if delta and delta > 0 then
		Minimap_ZoomIn()
	else
		Minimap_ZoomOut()
	end
end

local function LeaPlus_ApplyChatOptions()
	if ChatFrameEditBox then
		if LeaPlus_IsOn("UseArrowKeysInChat") and ChatFrameEditBox.SetAltArrowKeyMode then
			ChatFrameEditBox:SetAltArrowKeyMode(false)
			LeaPlusApplied.UseArrowKeysInChat = true
		elseif LeaPlusApplied.UseArrowKeysInChat and ChatFrameEditBox.SetAltArrowKeyMode then
			ChatFrameEditBox:SetAltArrowKeyMode(true)
			LeaPlusApplied.UseArrowKeysInChat = nil
		end

		if LeaPlus_IsOn("MoveChatEditBoxToTop") and not LeaPlusOriginalEditPoint then
			LeaPlusOriginalEditPoint, LeaPlusOriginalEditRelative,
			LeaPlusOriginalEditRelativePoint, LeaPlusOriginalEditX,
			LeaPlusOriginalEditY = ChatFrameEditBox:GetPoint(1)
		end

		if LeaPlus_IsOn("MoveChatEditBoxToTop") and ChatFrame1 then
			ChatFrameEditBox:ClearAllPoints()
			ChatFrameEditBox:SetPoint("BOTTOMLEFT", ChatFrame1, "TOPLEFT", -5, 5)
			ChatFrameEditBox:SetPoint("BOTTOMRIGHT", ChatFrame1, "TOPRIGHT", 5, 5)
			LeaPlusApplied.MoveChatEditBoxToTop = true
		elseif LeaPlusApplied.MoveChatEditBoxToTop and LeaPlusOriginalEditPoint then
			ChatFrameEditBox:ClearAllPoints()
			ChatFrameEditBox:SetPoint(LeaPlusOriginalEditPoint,
				LeaPlusOriginalEditRelative, LeaPlusOriginalEditRelativePoint,
				LeaPlusOriginalEditX, LeaPlusOriginalEditY)
			LeaPlusApplied.MoveChatEditBoxToTop = nil
		end
	end

	local chatCount = NUM_CHAT_WINDOWS or 7
	local i
	for i = 1, chatCount do
		local chatFrame = getglobal("ChatFrame" .. i)
		if chatFrame then
			if LeaPlus_IsOn("NoChatFade") and chatFrame.SetFading then
				chatFrame:SetFading(false)
				LeaPlusApplied.NoChatFade = true
			elseif LeaPlusApplied.NoChatFade and chatFrame.SetFading then
				chatFrame:SetFading(true)
			end
			if LeaPlus_IsOn("MaxChatHstory") and chatFrame.SetMaxLines then
				chatFrame:SetMaxLines(4096)
			end
		end
	end
	if not LeaPlus_IsOn("NoChatFade") then LeaPlusApplied.NoChatFade = nil end

	if LeaPlus_IsOn("NoStickyChat") and ChatTypeInfo then
		local chatTypes = {"SAY", "PARTY", "RAID", "GUILD", "OFFICER", "WHISPER", "CHANNEL"}
		for i = 1, table.getn(chatTypes) do
			if ChatTypeInfo[chatTypes[i]] then
				ChatTypeInfo[chatTypes[i]].sticky = 0
			end
		end
	end

	if LeaPlus_IsOn("NoCombatLogTab") then
		LeaPlus_SetShown(ChatFrame2, false)
		LeaPlus_SetShown(ChatFrame2Tab, false)
		LeaPlusApplied.NoCombatLogTab = true
	elseif LeaPlusApplied.NoCombatLogTab then
		LeaPlus_SetShown(ChatFrame2, true)
		LeaPlus_SetShown(ChatFrame2Tab, true)
		LeaPlusApplied.NoCombatLogTab = nil
	end

	if LeaPlus_IsOn("NoChatButtons") then
		LeaPlus_SetShown(ChatFrameMenuButton, false)
		LeaPlus_SetShown(ChatFrame1UpButton, false)
		LeaPlus_SetShown(ChatFrame1DownButton, false)
		LeaPlus_SetShown(ChatFrame1BottomButton, false)
		LeaPlusApplied.NoChatButtons = true
	elseif LeaPlusApplied.NoChatButtons then
		LeaPlus_SetShown(ChatFrameMenuButton, true)
		LeaPlus_SetShown(ChatFrame1UpButton, true)
		LeaPlus_SetShown(ChatFrame1DownButton, true)
		LeaPlus_SetShown(ChatFrame1BottomButton, true)
		LeaPlusApplied.NoChatButtons = nil
	end
end

local function LeaPlus_ApplyMinimap()
	if not Minimap then return end
	if LeaPlus_IsOn("MinimapMod") then
		Minimap:EnableMouseWheel(true)
		Minimap:SetScript("OnMouseWheel", LeaPlus_MinimapWheel)
		Minimap:SetScale(LeaPlusDB.MinimapScale or 1)
		LeaPlus_SetShown(MinimapZoomIn, false)
		LeaPlus_SetShown(MinimapZoomOut, false)
		LeaPlusApplied.MinimapMod = true
	elseif LeaPlusApplied.MinimapMod then
		Minimap:EnableMouseWheel(false)
		Minimap:SetScript("OnMouseWheel", nil)
		Minimap:SetScale(1)
		LeaPlus_SetShown(MinimapZoomIn, true)
		LeaPlus_SetShown(MinimapZoomOut, true)
		LeaPlusApplied.MinimapMod = nil
	end
end

local function LeaPlus_ApplyVisualOptions()
	if UIErrorsFrame and LeaPlus_IsOn("HideErrorMessages") then
		UIErrorsFrame:SetAlpha(0)
		LeaPlusApplied.HideErrorMessages = true
	elseif UIErrorsFrame and LeaPlusApplied.HideErrorMessages then
		UIErrorsFrame:SetAlpha(1)
		LeaPlusApplied.HideErrorMessages = nil
	end

	if LeaPlus_IsOn("HideZoneText") then
		if ZoneTextFrame then ZoneTextFrame:SetAlpha(0) end
		if SubZoneTextFrame then SubZoneTextFrame:SetAlpha(0) end
		LeaPlusApplied.HideZoneText = true
	elseif LeaPlusApplied.HideZoneText then
		if ZoneTextFrame then ZoneTextFrame:SetAlpha(1) end
		if SubZoneTextFrame then SubZoneTextFrame:SetAlpha(1) end
		LeaPlusApplied.HideZoneText = nil
	end

	if LeaPlus_IsOn("NoGryphons") then
		LeaPlus_SetShown(MainMenuBarLeftEndCap, false)
		LeaPlus_SetShown(MainMenuBarRightEndCap, false)
		LeaPlusApplied.NoGryphons = true
	elseif LeaPlusApplied.NoGryphons then
		LeaPlus_SetShown(MainMenuBarLeftEndCap, true)
		LeaPlus_SetShown(MainMenuBarRightEndCap, true)
		LeaPlusApplied.NoGryphons = nil
	end

	if LeaPlus_IsOn("NoClassBar") then
		LeaPlus_SetShown(ShapeshiftBarFrame, false)
		LeaPlusApplied.NoClassBar = true
	elseif LeaPlusApplied.NoClassBar then
		LeaPlus_SetShown(ShapeshiftBarFrame, true)
		LeaPlusApplied.NoClassBar = nil
	end

	if LeaPlus_IsOn("NoScreenGlow") then
		LeaPlus_SafeSetCVar("ffxGlow", "0")
		LeaPlusApplied.NoScreenGlow = true
	elseif LeaPlusApplied.NoScreenGlow then
		LeaPlus_SafeSetCVar("ffxGlow", "1")
		LeaPlusApplied.NoScreenGlow = nil
	end
	if LeaPlus_IsOn("NoScreenEffects") then
		LeaPlus_SafeSetCVar("ffxDeath", "0")
		LeaPlusApplied.NoScreenEffects = true
	elseif LeaPlusApplied.NoScreenEffects then
		LeaPlus_SafeSetCVar("ffxDeath", "1")
		LeaPlusApplied.NoScreenEffects = nil
	end
	if LeaPlus_IsOn("MaxCameraZoom") then
		LeaPlus_SafeSetCVar("cameraDistanceMax", "50")
		LeaPlusApplied.MaxCameraZoom = true
	elseif LeaPlusApplied.MaxCameraZoom then
		LeaPlus_SafeSetCVar("cameraDistanceMax", "15")
		LeaPlusApplied.MaxCameraZoom = nil
	end
end

local LeaPlusExpandedQuestLogApplied = nil
local LeaPlusExpandedQuestLogConflict = nil

local function LeaPlus_FindQuestLogReplacement()
	local addons = {
		"pfUI", "EQL3", "ExtendedQuestLog", "QuestLogEx", "QuestGuru",
		"ClassicQuestLog", "QuestLogPlus", "UberQuest"
	}
	if IsAddOnLoaded then
		local i
		for i = 1, table.getn(addons) do
			if IsAddOnLoaded(addons[i]) then return addons[i] end
		end
	end
	-- Catch replacements unknown to this build by observing the live Blizzard frame.
	-- The stock 1.12 quest log is roughly 384 pixels wide; expanded replacements are not.
	if QuestLogFrame and QuestLogFrame.GetWidth and QuestLogFrame:GetWidth() > 500 then
		return "another quest-log addon"
	end
	return nil
end

local function LeaPlus_RefreshExpandedQuestRows()
	if not LeaPlusExpandedQuestLogApplied then return end
	local i
	for i = 1, (QUESTS_DISPLAYED or 20) do
		local row = getglobal("QuestLogTitle" .. i)
		local check = getglobal("QuestLogTitle" .. i .. "Check")
		if row and check then
			check:ClearAllPoints()
			check:SetPoint("RIGHT", row, "LEFT", 22, 0)
		end
	end
end

local function LeaPlus_StripFrameTextures(frame)
	if not frame or not frame.GetRegions then return end
	local regions = {frame:GetRegions()}
	local i
	for i = 1, table.getn(regions) do
		local region = regions[i]
		if region and region.GetObjectType and region:GetObjectType() == "Texture" then
			region:SetTexture(nil)
		end
	end
end

local function LeaPlus_CreateQuestPane(parent, name)
	local pane = parent:CreateTexture(name, "BACKGROUND")
	pane:SetAllPoints(parent)
	pane:SetTexture("Interface\\Stationery\\StationeryTest1")
	pane:SetTexCoord(0.08, 0.92, 0.02, 0.98)
	return pane
end

local function LeaPlus_ApplyExpandedQuestLog()
	if not LeaPlus_IsOn("ExpandedQuestLog") or LeaPlusExpandedQuestLogApplied then return end
	if not QuestLogFrame or not QuestLogListScrollFrame or not QuestLogDetailScrollFrame then return end

	local replacement = LeaPlus_FindQuestLogReplacement()
	if replacement then
		LeaPlusExpandedQuestLogConflict = replacement
		if not LeaPlusApplied.QuestLogConflictNotice then
			LeaPlusApplied.QuestLogConflictNotice = true
			LeaPlus_Print("Expanded quest log left to |cffffffff" .. replacement .. "|r to prevent a layout conflict.")
		end
		return
	end

	local oldDisplayed = QUESTS_DISPLAYED or 6
	QUESTS_DISPLAYED = 20
	local i
	for i = oldDisplayed + 1, QUESTS_DISPLAYED do
		local row = getglobal("QuestLogTitle" .. i)
		if not row then
			row = CreateFrame("Button", "QuestLogTitle" .. i, QuestLogFrame, "QuestLogTitleButtonTemplate")
			row:SetID(i)
		end
		row:ClearAllPoints()
		row:SetPoint("TOPLEFT", getglobal("QuestLogTitle" .. (i - 1)), "BOTTOMLEFT", 0, 1)
	end

	-- Blizzard's 384px artwork is assembled from fixed texture slices. Remove
	-- those slices before widening the frame, then provide complete parchment
	-- surfaces for both panes so dark quest text remains readable.
	LeaPlus_StripFrameTextures(QuestLogFrame)
	LeaPlus_StripFrameTextures(EmptyQuestLogFrame)
	LeaPlus_StripFrameTextures(QuestLogListScrollFrame)
	LeaPlus_StripFrameTextures(QuestLogDetailScrollFrame)
	LeaPlus_StripFrameTextures(QuestLogDetailScrollChildFrame)

	QuestLogFrame:SetWidth(720)
	QuestLogFrame:SetHeight(475)
	QuestLogFrame:SetBackdrop({
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tile = true, tileSize = 16, edgeSize = 14,
		insets = {left = 4, right = 4, top = 4, bottom = 4}
	})
	QuestLogFrame:SetBackdropColor(0.025, 0.018, 0.01, 0.96)
	QuestLogFrame:SetBackdropBorderColor(0.72, 0.48, 0.08, 1)

	if QuestLogTitleText then
		QuestLogTitleText:ClearAllPoints()
		QuestLogTitleText:SetPoint("TOP", QuestLogFrame, "TOP", 0, -13)
	end
	if QuestLogQuestCount then
		QuestLogQuestCount:ClearAllPoints()
		QuestLogQuestCount:SetPoint("TOPRIGHT", QuestLogFrame, "TOPRIGHT", -42, -31)
	end

	QuestLogListScrollFrame:ClearAllPoints()
	QuestLogListScrollFrame:SetPoint("TOPLEFT", QuestLogFrame, "TOPLEFT", 18, -58)
	QuestLogListScrollFrame:SetWidth(305)
	QuestLogListScrollFrame:SetHeight(350)
	LeaPlus_CreateQuestPane(QuestLogListScrollFrame, "LeaPlusExpandedQuestListPane")
	if QuestLogTitle1 then
		QuestLogTitle1:ClearAllPoints()
		QuestLogTitle1:SetPoint("TOPLEFT", QuestLogListScrollFrame, "TOPLEFT", 0, 0)
	end
	if QuestLogCollapseAllButton and QuestLogTitle1 then
		QuestLogCollapseAllButton:ClearAllPoints()
		QuestLogCollapseAllButton:SetPoint("BOTTOMLEFT", QuestLogTitle1, "TOPLEFT", -5, 5)
	end

	QuestLogDetailScrollFrame:ClearAllPoints()
	QuestLogDetailScrollFrame:SetPoint("TOPLEFT", QuestLogListScrollFrame, "TOPRIGHT", 42, 0)
	QuestLogDetailScrollFrame:SetWidth(325)
	QuestLogDetailScrollFrame:SetHeight(350)
	LeaPlus_CreateQuestPane(QuestLogDetailScrollFrame, "LeaPlusExpandedQuestDetailPane")
	if QuestLogDetailScrollChildFrame then
		QuestLogDetailScrollChildFrame:SetWidth(300)
		QuestLogDetailScrollChildFrame:SetHeight(350)
	end

	if QuestLogFrameAbandonButton then
		QuestLogFrameAbandonButton:ClearAllPoints()
		QuestLogFrameAbandonButton:SetPoint("BOTTOMLEFT", QuestLogFrame, "BOTTOMLEFT", 18, 16)
	end
	if QuestFramePushQuestButton and QuestLogFrameAbandonButton then
		QuestFramePushQuestButton:ClearAllPoints()
		QuestFramePushQuestButton:SetPoint("LEFT", QuestLogFrameAbandonButton, "RIGHT", 6, 0)
	end
	if QuestFrameExitButton then
		QuestFrameExitButton:ClearAllPoints()
		QuestFrameExitButton:SetPoint("BOTTOMRIGHT", QuestLogFrame, "BOTTOMRIGHT", -18, 16)
	end

	LeaPlusExpandedQuestLogApplied = true
	if QuestLog_Update and not LeaPlusApplied.QuestLogUpdateHook then
		local originalQuestLogUpdate = QuestLog_Update
		QuestLog_Update = function()
			originalQuestLogUpdate()
			LeaPlus_RefreshExpandedQuestRows()
		end
		LeaPlusApplied.QuestLogUpdateHook = true
	end
	LeaPlus_RefreshExpandedQuestRows()
	if QuestLog_Update then QuestLog_Update() end
end

function LeaPlus_ApplyAll()
	LeaPlus_ApplyChatOptions()
	LeaPlus_ApplyMinimap()
	LeaPlus_ApplyVisualOptions()
	LeaPlus_ApplyExpandedQuestLog()
	if LeaPlusApplyNameplates then LeaPlusApplyNameplates() end
	if LeaPlusApplyWorldChannel then LeaPlusApplyWorldChannel() end
	if LeaPlusCheckSalvation then LeaPlusCheckSalvation() end
end

function LeaPlus_UpdateScaleText()
	if LeaPlusScaleText and LeaPlusDB then
		LeaPlusScaleText:SetText("Minimap scale: " .. string.format("%.2f", LeaPlusDB.MinimapScale or 1))
	end
end

function LeaPlus_ChangeMinimapScale(amount)
	if not LeaPlusDB then return end
	local scale = (LeaPlusDB.MinimapScale or 1) + amount
	if scale < 0.70 then scale = 0.70 end
	if scale > 1.50 then scale = 1.50 end
	LeaPlusDB.MinimapScale = scale
	LeaPlus_UpdateScaleText()
	LeaPlus_ApplyMinimap()
end

function LeaPlus_UpdateOptions()
	local option, button
	for option, button in pairs(LeaPlusCheckButtons) do
		button:SetChecked(LeaPlus_IsOn(option))
		if option == "GuideAwareQuests" then
			local provider = getglobal and getglobal("ZygorClassic_ShouldAcceptQuest308")
			if type(provider) == "function" then button:Show() else button:Hide() end
		end
	end
	if LeaPlusKeywordBox and LeaPlusDB then
		LeaPlusKeywordBox:SetText(LeaPlusDB.InvKey or "inv")
	end
	LeaPlus_UpdateScaleText()
	if LeaPlusStatusText and LeaPlusDB then
		local enabled = 0
		local i
		for i = 1, table.getn(LeaPlusOptionKeys) do
			if LeaPlus_IsOn(LeaPlusOptionKeys[i]) then enabled = enabled + 1 end
		end
		local repeatName = LeaPlusDB.RepeatQuestName or "none recorded"
		LeaPlusStatusText:SetText("|cffffcc33ACTIVE PROFILE|r   " .. enabled .. " enabled   |cff8f8f8f•|r   Repeat quest: |cffffffff" .. repeatName .. "|r")
	end
end

function LeaPlus_ToggleOption(option, checked)
	if not LeaPlusDB then return end
	if checked then LeaPlusDB[option] = "On" else LeaPlusDB[option] = "Off" end
	if option == "ExpandedQuestLog" and not checked and LeaPlusExpandedQuestLogApplied then
		LeaPlus_Print("Expanded quest log disabled. Type |cffffffff/reload|r to restore Blizzard's original layout.")
	end
	if option == "FlightTimer" and not checked and LeaPlusFlightBar then LeaPlusFlightBar:Hide() end
	local exclusive = {
		ZGNeed = {"ZGGreed", "ZGPass"},
		ZGGreed = {"ZGNeed", "ZGPass"},
		ZGPass = {"ZGNeed", "ZGGreed"},
		GreenNeed = {"GreenGreed", "GreenPass"},
		GreenGreed = {"GreenNeed", "GreenPass"},
		GreenPass = {"GreenNeed", "GreenGreed"},
		RemoveSalvationAlways = {"RemoveSalvationTank"},
		RemoveSalvationTank = {"RemoveSalvationAlways"},
		NoPartyInvites = {"AcceptPartyStrangers"},
		AcceptPartyStrangers = {"NoPartyInvites"},
		MuteWorldAlways = {"MuteWorldDungeon", "MuteWorldRaid", "MuteWorldBG"},
		MuteWorldDungeon = {"MuteWorldAlways"},
		MuteWorldRaid = {"MuteWorldAlways"},
		MuteWorldBG = {"MuteWorldAlways"}
	}
	if checked and exclusive[option] then
		local i
		for i = 1, table.getn(exclusive[option]) do
			LeaPlusDB[exclusive[option][i]] = "Off"
		end
	end
	LeaPlus_ApplyAll()
	LeaPlus_UpdateOptions()
end

function LeaPlus_Check_OnClick(self)
	self = LeaPlus_HandlerSelf(self)
	if self then LeaPlus_ToggleOption(self.option, self:GetChecked()) end
end

function LeaPlus_Check_OnEnter(self)
	self = LeaPlus_HandlerSelf(self)
	if not self then return end
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	GameTooltip:SetText(self.label or "Leatrix Plus")
	if self.tip then GameTooltip:AddLine(self.tip, 1, 1, 1, 1) end
	GameTooltip:Show()
end

function LeaPlus_Check_OnLeave()
	GameTooltip:Hide()
end

local function LeaPlus_CreateCheckbox(parent, index, option, label, tip, x, y)
	local name = "LeaPlusCheck" .. index
	local check = CreateFrame("CheckButton", name, parent, "UICheckButtonTemplate")
	check:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)
	check:SetWidth(24)
	check:SetHeight(24)
	check.option = option
	check.label = label
	check.tip = tip
	check:SetScript("OnClick", LeaPlus_Check_OnClick)
	check:SetScript("OnEnter", LeaPlus_Check_OnEnter)
	check:SetScript("OnLeave", LeaPlus_Check_OnLeave)
	local text = getglobal(name .. "Text")
	if text then
		text:SetText(label)
		text:SetWidth(292)
		text:SetJustifyH("LEFT")
		text:SetTextColor(0.93, 0.90, 0.82)
	end
	LeaPlusCheckButtons[option] = check
	return check
end

function LeaPlus_ShowPage(pageNumber)
	local i
	LeaPlusCurrentPage = pageNumber
	for i = 1, table.getn(LeaPlusPages) do
		if i == pageNumber then LeaPlusPages[i]:Show()
		else LeaPlusPages[i]:Hide() end
		if LeaPlusPages[i].tab then
			if i == pageNumber then
				LeaPlusPages[i].tab:Disable()
				LeaPlusPages[i].tab:SetBackdropColor(LeaPlus_UnpackColor(LEAPLUS_THEME.active))
			else
				LeaPlusPages[i].tab:Enable()
				LeaPlusPages[i].tab:SetBackdropColor(LeaPlus_UnpackColor(LEAPLUS_THEME.normal))
			end
		end
	end
end

function LeaPlus_FindOption()
	if not LeaPlusSearchBox or not LeaPlusSearchResult then return end
	local query = string.lower(LeaPlusSearchBox:GetText() or "")
	query = string.gsub(query, "^%s+", "")
	query = string.gsub(query, "%s+$", "")
	if query == "" then
		LeaPlusSearchLastQuery = ""
		LeaPlusSearchIndex = 0
		LeaPlusSearchMatches = {}
		LeaPlusSearchResult:SetText("Type an option name or description.")
		return
	end
	if query ~= LeaPlusSearchLastQuery then
		LeaPlusSearchLastQuery = query
		LeaPlusSearchIndex = 0
		LeaPlusSearchMatches = {}
		local option, button
		for option, button in pairs(LeaPlusCheckButtons) do
			local haystack = string.lower(tostring(option) .. " " ..
				tostring(button.label or "") .. " " .. tostring(button.tip or ""))
			if string.find(haystack, query, 1, true) then
				table.insert(LeaPlusSearchMatches, {option = option, button = button})
			end
		end
		table.sort(LeaPlusSearchMatches, function(a, b)
			return tostring(a.button.label or a.option) < tostring(b.button.label or b.option)
		end)
	end
	local count = table.getn(LeaPlusSearchMatches)
	if count == 0 then
		LeaPlusSearchResult:SetText("No option found for: " .. query)
		return
	end
	LeaPlusSearchIndex = LeaPlusSearchIndex + 1
	if LeaPlusSearchIndex > count then LeaPlusSearchIndex = 1 end
	local match = LeaPlusSearchMatches[LeaPlusSearchIndex]
	local button = match.button
	LeaPlus_ShowPage(button.pageNumber or 1)
	local state = LeaPlus_IsOn(match.option) and "|cff55dd55ON|r" or "|cffff7777OFF|r"
	LeaPlusSearchResult:SetText(tostring(LeaPlusSearchIndex) .. "/" .. tostring(count) ..
		"  " .. tostring(button.label or match.option) .. "  [" .. state .. "]  - " ..
		tostring(button.pageName or "Options"))
	LeaPlusSearchBox:ClearFocus()
end

function LeaPlus_ToggleHelp()
	if not LeaPlusHelpFrame then return end
	if LeaPlusHelpFrame:IsShown() then LeaPlusHelpFrame:Hide()
	else LeaPlusHelpFrame:Show() end
end

function LeaPlus_CreateHelp()
	if LeaPlusHelpFrame then return end
	local frame = CreateFrame("Frame", "LeaPlusHelpFrame", UIParent)
	frame:SetWidth(560)
	frame:SetHeight(455)
	frame:SetPoint("CENTER", UIParent, "CENTER", 0, 20)
	frame:SetFrameStrata("DIALOG")
	frame:SetMovable(true)
	frame:EnableMouse(true)
	frame:RegisterForDrag("LeftButton")
	frame:SetScript("OnDragStart", function(self) local owner = LeaPlus_HandlerSelf(self); if owner then owner:StartMoving() end end)
	frame:SetScript("OnDragStop", function(self) local owner = LeaPlus_HandlerSelf(self); if owner then owner:StopMovingOrSizing() end end)
	frame:SetBackdrop({
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tile = true, tileSize = 16, edgeSize = 16,
		insets = {left = 5, right = 5, top = 5, bottom = 5}
	})
	frame:SetBackdropColor(0.015, 0.018, 0.022, 0.98)
	frame:SetBackdropBorderColor(LeaPlus_UnpackColor(LEAPLUS_THEME.border))
	local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
	title:SetPoint("TOPLEFT", frame, "TOPLEFT", 18, -16)
	title:SetText("Leatrix Plus - " .. LEAPLUS_CLIENT_NAME .. " Help")
	title:SetTextColor(LeaPlus_UnpackColor(LEAPLUS_THEME.accent))
	local close = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
	close:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -4, -4)
	close:SetScript("OnClick", function() LeaPlusHelpFrame:Hide() end)
	local rule = frame:CreateTexture(nil, "ARTWORK")
	rule:SetPoint("TOPLEFT", frame, "TOPLEFT", 16, -43)
	rule:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -16, -43)
	rule:SetHeight(1)
	rule:SetTexture(LeaPlus_UnpackColor(LEAPLUS_THEME.border))
	local body = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
	body:SetPoint("TOPLEFT", frame, "TOPLEFT", 20, -58)
	body:SetWidth(520)
	body:SetHeight(372)
	body:SetJustifyH("LEFT")
	body:SetJustifyV("TOP")
	body:SetText(
		"|cffffcc33QUICK START|r\n" ..
		"- Use Search on the main window to find an option by name or description. Find/Enter cycles matches.\n" ..
		"- The result shows ON or OFF and opens the option's tab. Checked means enabled.\n" ..
		"- First installation applies Recommended automatically. Interaction, social and battleground automation stays Off.\n\n" ..
		"|cffffcc33AUTOMATION SAFETY|r\n" ..
		"- Hold Shift while opening a quest, gossip or merchant window to bypass automation once.\n" ..
		"- Automate quests turns in completed quests first, then accepts available quests.\n" ..
		"- With Zygor loaded, Follow active guide only appears automatically. Hold Alt while opening an NPC to allow side-quest pickups once.\n" ..
		"- Reward-choice quests and quests requiring payment stop for manual input.\n\n" ..
		"|cffffcc33SAVE CHARACTER (.save)|r\n" ..
		"- Find it with Search: save character. It is on the Tools tab and is included in Recommended.\n" ..
		"- When enabled, valuable loot or a battleground win schedules the private-server .save command.\n" ..
		"- If the server says the command is unsupported, LTP turns this option Off automatically.\n\n" ..
		"|cffffcc33USEFUL CONTROLS|r\n" ..
		"- /ltp opens this options window. /ltp queststatus reports quest selection data. /reload or /rl reloads the UI.\n" ..
		"- Hover any option for its full description. Turn all off restores a safe disabled profile."
	)
	frame:Hide()
	LeaPlusHelpFrame = frame
	table.insert(UISpecialFrames, "LeaPlusHelpFrame")
end

function LeaPlus_SaveKeyword()
	if not LeaPlusDB or not LeaPlusKeywordBox then return end
	local keyword = LeaPlusKeywordBox:GetText() or ""
	keyword = string.gsub(keyword, "%s", "")
	if keyword == "" then keyword = "inv" end
	LeaPlusDB.InvKey = string.lower(keyword)
	LeaPlusKeywordBox:SetText(LeaPlusDB.InvKey)
	LeaPlusKeywordBox:ClearFocus()
	LeaPlus_Print("Whisper invite keyword set to |cffffffff" .. LeaPlusDB.InvKey .. "|r.")
end

function LeaPlus_ResetOptions()
	if not LeaPlusDB then return end
	local i
	for i = 1, table.getn(LeaPlusOptionKeys) do
		LeaPlusDB[LeaPlusOptionKeys[i]] = "Off"
	end
	LeaPlusDB.InvKey = "inv"
	LeaPlusDB.MinimapScale = 1
	LeaPlusDB.RepeatQuestKey = nil
	LeaPlusDB.RepeatQuestName = nil
	LeaPlusRepeatQuestActive = nil
	LeaPlusPrivateSaveAt = nil
	LeaPlusStackTasks = {}
	LeaPlusStackUntil = 0
	LeaPlus_ApplyAll()
	LeaPlus_UpdateOptions()
	LeaPlus_Print("All options have been turned off.")
end

local function LeaPlus_SetRecommendedValues()
	local i
	for i = 1, table.getn(LeaPlusOptionKeys) do
		LeaPlusDB[LeaPlusOptionKeys[i]] = "Off"
	end
	for i = 1, table.getn(LeaPlusRecommendedKeys) do
		LeaPlusDB[LeaPlusRecommendedKeys[i]] = "On"
	end
end

function LeaPlus_RecommendedOptions()
	if not LeaPlusDB then return end
	LeaPlus_SetRecommendedValues()
	LeaPlus_ApplyAll()
	LeaPlus_UpdateOptions()
	LeaPlus_Print("Recommended starter settings applied, including automatic .save. Interaction, social and battleground automation remains off.")
end

local function LeaPlus_CreatePage(parent, title)
	local page = CreateFrame("Frame", nil, parent)
	page:SetPoint("TOPLEFT", parent, "TOPLEFT", 12, -125)
	page:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", -12, 50)
	local heading = page:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
	heading:SetPoint("TOPLEFT", page, "TOPLEFT", 18, -12)
	heading:SetText(title)
	heading:SetTextColor(LeaPlus_UnpackColor(LEAPLUS_THEME.accent))
	local rule = page:CreateTexture(nil, "ARTWORK")
	rule:SetPoint("TOPLEFT", page, "TOPLEFT", 18, -36)
	rule:SetPoint("TOPRIGHT", page, "TOPRIGHT", -18, -36)
	rule:SetHeight(1)
	rule:SetTexture(LeaPlus_UnpackColor(LEAPLUS_THEME.border))
	table.insert(LeaPlusPages, page)
	return page
end

local function LeaPlus_CreateOptions()
	if LeaPlusOptionsFrame then return end

	local frame = CreateFrame("Frame", "LeaPlusOptionsFrame", UIParent)
	frame:SetWidth(760)
	frame:SetHeight(555)
	frame:SetPoint("CENTER", UIParent, "CENTER", 0, 20)
	frame:SetFrameStrata("DIALOG")
	frame:SetMovable(true)
	frame:EnableMouse(true)
	frame:RegisterForDrag("LeftButton")
	frame:SetScript("OnDragStart", function(self) local owner = LeaPlus_HandlerSelf(self); if owner then owner:StartMoving() end end)
	frame:SetScript("OnDragStop", function(self) local owner = LeaPlus_HandlerSelf(self); if owner then owner:StopMovingOrSizing() end end)
	frame:SetScript("OnShow", LeaPlus_UpdateOptions)
	frame:SetBackdrop({
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tile = true, tileSize = 16, edgeSize = 14,
		insets = {left = 4, right = 4, top = 4, bottom = 4}
	})
	frame:SetBackdropColor(0.015, 0.018, 0.022, 0.96)
	frame:SetBackdropBorderColor(LeaPlus_UnpackColor(LEAPLUS_THEME.border))
	frame:Hide()
	local topGlow = frame:CreateTexture(nil, "ARTWORK")
	topGlow:SetPoint("TOPLEFT", frame, "TOPLEFT", 12, -10)
	topGlow:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -12, -10)
	topGlow:SetHeight(2)
	topGlow:SetTexture(LeaPlus_UnpackColor(LEAPLUS_THEME.accent))

	local close = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
	close:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -5, -5)

	local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
	title:SetPoint("TOP", frame, "TOP", 0, -20)
	title:SetText("LEATRIX PLUS  -  " .. string.upper(LEAPLUS_CLIENT_NAME) .. " ALL-IN-ONE")
	title:SetTextColor(LeaPlus_UnpackColor(LEAPLUS_THEME.accent))

	local version = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
	version:SetPoint("TOP", title, "BOTTOM", 0, -5)
	version:SetText("Version " .. LEAPLUS_VERSION .. "  -  |cff55ff77Developed by Tim|r  -  /ltp to toggle")
	version:SetTextColor(0.78, 0.74, 0.65)

	local page1 = LeaPlus_CreatePage(frame, "Automation and social")
	local page2 = LeaPlus_CreatePage(frame, "Interface and chat")
	local page3 = LeaPlus_CreatePage(frame, "System")
	local page4 = LeaPlus_CreatePage(frame, "Battleground automation")
	local page5 = LeaPlus_CreatePage(frame, "Loot, rolls and bags")
	local page6 = LeaPlus_CreatePage(frame, "Extra tools")

	local tabNames = {"Automation", "Interface", "System", "Battlegrounds", "Loot & Bags", "Tools"}
	local i
	for i = 1, 6 do
		local tab = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
		tab:SetWidth(108)
		tab:SetHeight(23)
		tab:SetPoint("TOPLEFT", frame, "TOPLEFT", 43 + ((i - 1) * 113), -91)
		tab:SetText(tabNames[i])
		tab.pageNumber = i
		LeaPlus_StyleButton(tab)
		tab:SetScript("OnClick", function(self) local owner = LeaPlus_HandlerSelf(self); if owner then LeaPlus_ShowPage(owner.pageNumber) end end)
		LeaPlusPages[i].tab = tab
	end

	local automation = {
		{"AutomateQuests", "Automate quests", "Processes one quest action per refreshed NPC dialog. Turns in completed quests first, then accepts available quests. Reward-choice and payment quests stop for you."},
		{"GuideAwareQuests", "Follow active guide only", "Shown automatically when compatible Zygor is loaded. Limits automated quest pickups to the current and upcoming guide steps. Hold Alt while opening an NPC to allow side-quest pickups once."},
		{"AutomateGossip", "Automate gossip", "Skips a single banker, taxi, trainer or vendor option. Hold Alt for other single gossip options."},
		{"AutoAcceptSummon", "Accept summons", "Accepts summon requests automatically while you are not in combat."},
		{"AutoAcceptRes", "Accept resurrection", "Accepts resurrection requests automatically while you are not in combat."},
		{"AutoReleasePvP", "Release in battlegrounds", "Releases your spirit automatically in active battlegrounds unless a soulstone is available."},
		{"AutoSellJunk", "Sell junk automatically", "Sells grey-quality bag items when a merchant opens. Hold Shift to bypass it."},
		{"AutoRepairGear", "Repair automatically", "Repairs all equipment at repair merchants. Hold Shift to bypass it."},
		{"NoDuelRequests", "Block stranger duels", "Declines duel requests unless the player is a friend or guild member."},
		{"NoPartyInvites", "Block stranger party invites", "Declines party invites unless the player is a friend or guild member."},
		{"AcceptPartyFriends", "Accept parties from friends", "Accepts party invites from friends and guild members."},
		{"AcceptPartyStrangers", "Accept parties from strangers", "Accepts unknown-player party invites too. Exclusive with blocking stranger invites."},
		{"PausePartyAcceptInBG", "Pause party auto-accept in BGs", "Does not auto-accept invites while in a battleground or while a queue is ready/active."},
		{"InviteFromWhisper", "Invite from whisper", "Invites a player who whispers the configured keyword when you can invite."}
	}

	local interface = {
		{"ExpandedQuestLog", "Expanded quest log", "Shows the Blizzard quest list and quest details side by side. Automatically stands down when pfUI or another expanded quest-log addon controls the frame. Disabling it restores the original layout after /reload."},
		{"FlightTimer", "Show flight timer", "Shows a movable flight progress bar. The first trip estimates and measures a route; later trips use the learned duration for an accurate countdown. Drag to move it while flying or right-click it to reset."},
		{"UseArrowKeysInChat", "Use arrow keys in chat", "Lets the arrow keys move through the chat edit box without holding Alt."},
		{"NoStickyChat", "Disable sticky chat", "Stops common chat types from remaining selected after a message."},
		{"NoChatFade", "Disable chat fade", "Prevents chat text from fading away."},
		{"MaxChatHstory", "Increase chat history", "Raises the history limit of each chat window to 4096 lines."},
		{"NoCombatLogTab", "Hide combat log", "Hides the default second chat window and its tab."},
		{"NoChatButtons", "Hide chat buttons", "Hides the menu and scroll buttons beside the first chat frame."},
		{"MoveChatEditBoxToTop", "Move chat edit box to top", "Moves the chat typing box above the first chat window."},
		{"HideErrorMessages", "Hide red error messages", "Hides messages such as Out of range in the center of the screen."},
		{"HideZoneText", "Hide zone text", "Hides large zone and sub-zone announcements."},
		{"MinimapMod", "Minimap mousewheel zoom", "Uses the mousewheel to zoom and hides the default minimap zoom buttons."},
		{"NoGryphons", "Hide action-bar gryphons", "Hides the decorative gryphons beside the main action bar."},
		{"NoClassBar", "Hide stance bar", "Hides the stance, form or aura bar."},
		{"ShowEnemyPlates", "Always show enemy nameplates", "Turns enemy nameplates on when you log in or change zone."},
		{"ShowFriendlyPlates", "Always show friendly nameplates", "Turns friendly nameplates on when you log in or change zone."},
		{"HideUncheckedPlates", "Hide unchecked nameplates", "Turns a nameplate category off when its Always show option is unchecked."}
	}

	local system = {
		{"NoScreenGlow", "Disable screen glow", "Disables the full-screen glow shader."},
		{"NoScreenEffects", "Disable death effects", "Disables the grey death-screen shader."},
		{"MaxCameraZoom", "Maximum camera zoom", "Raises the Vanilla camera-distance maximum from 15 to 50."},
		{"FasterLooting", "Faster auto-loot", "Immediately loots every slot when the normal auto-loot condition is active."},
		{"StandAndDismount", "Stand and dismount", "Automatically stands or removes a mount buff when an action fails for that reason."}
	}

	local battleground = {
		{"AutoQueueBG", "Queue when battlemaster opens", "Queues for the battleground shown by a battlemaster. Group leaders queue the group."},
		{"AutoEnterBG", "Enter battleground automatically", "Accepts a ready battleground queue automatically. Use only when you truly want every ready queue."},
		{"AutoLeaveBG", "Leave finished battleground", "Leaves automatically after the client reports a battleground winner."},
		{"AnnounceBGQueue", "Announce group queue status", "Repeats the system queue confirmation to your party or raid when you are leader."},
		{"BlockBGQuestShare", "Block quest shares in battlegrounds", "Declines shared-quest confirmation popups while inside a battleground."}
	}

	local lootbags = {
		{"LootAtCursor", "Open loot under cursor", "Moves the normal loot window to the mouse cursor and keeps it aligned as slots disappear."},
		{"ImprovedBagRightClick", "Improved bag right-click", "Right-clicks attach bag items to trade, mail and auction sell windows when possible."},
		{"EasyStackSplit", "Easy stack split and merge", "Shift-right-click once to open stack mode, adjust with Ctrl/Alt, then Shift-right-click a stack."},
		{"ZGNeed", "ZG coins and bijous: Need", "Automatically rolls Need on Zul'Gurub coins and Hakkari bijous. Exclusive with Greed and Pass."},
		{"ZGGreed", "ZG coins and bijous: Greed", "Automatically rolls Greed on Zul'Gurub coins and Hakkari bijous."},
		{"ZGPass", "ZG coins and bijous: Pass", "Automatically passes on Zul'Gurub coins and Hakkari bijous."},
		{"GreenNeed", "Ctrl+Alt green rolls: Need", "With Special key combinations enabled, Ctrl+Alt rolls Need on visible uncommon items."},
		{"GreenGreed", "Ctrl+Alt green rolls: Greed", "With Special key combinations enabled, Ctrl+Alt rolls Greed on visible uncommon items."},
		{"GreenPass", "Ctrl+Alt green rolls: Pass", "With Special key combinations enabled, Ctrl+Alt passes visible uncommon items."}
	}

	local tools = {
		{"RepeatableQuestAssist", "Repeatable quest recorder", "Hold Shift while selecting a repeatable quest once. Later visits replay that quest automatically. /ltp repeat clear forgets it."},
		{"SpecialKeyCombos", "LazyPig special key combinations", "Ctrl+Shift follows, Alt+Shift inspects/bids, Ctrl+Alt trades/confirms/sends, and all three modifiers log out."},
		{"PrivateServerSave", "Save character automatically (.save)", "Private-server character save from LazyPig. Sends .save after valuable loot or a battleground win and turns itself off if rejected."},
		{"MuteWorldDungeon", "Mute World in dungeons", "Removes the World channel from chat frames while in a Vanilla dungeon, then restores it."},
		{"MuteWorldRaid", "Mute World in raids", "Removes the World channel from chat frames while in a Vanilla raid, then restores it."},
		{"MuteWorldBG", "Mute World in battlegrounds", "Removes the World channel from chat frames while in a battleground, then restores it."},
		{"MuteWorldAlways", "Mute World everywhere", "Removes the World channel from chat frames until this option is disabled."},
		{"FilterDuplicateChat", "Filter repeated public chat", "Hides identical repeated say, yell, emote and channel messages from the same player for 70 seconds."},
		{"FilterUncommonRolls", "Hide other uncommon roll spam", "Filters other players' green-quality loot-roll messages."},
		{"FilterRareRolls", "Hide other rare roll spam", "Filters other players' blue-quality loot-roll messages."},
		{"FilterLowLoot", "Hide low-value loot spam", "Filters other players' grey and white loot plus shared-money messages."},
		{"RemoveSalvationAlways", "Remove Salvation always", "Cancels Blessing or Greater Blessing of Salvation whenever it appears."},
		{"RemoveSalvationTank", "Remove Salvation while tanking", "Cancels Salvation for a shield Warrior or a Druid in Bear/Dire Bear Form."}
	}

	local optionIndex = 0
	local function AddOptionList(page, list, pageNumber, pageName)
		local count = table.getn(list)
		local leftCount = math.floor((count + 1) / 2)
		local n
		for n = 1, count do
			optionIndex = optionIndex + 1
			local column = 0
			local row = n - 1
			if n > leftCount then
				column = 1
				row = n - leftCount - 1
			end
			local check = LeaPlus_CreateCheckbox(page, optionIndex, list[n][1], list[n][2], list[n][3], 24 + column * 360, -45 - row * 36)
			check.pageNumber = pageNumber
			check.pageName = pageName
		end
	end

	AddOptionList(page1, automation, 1, "Automation")
	AddOptionList(page2, interface, 2, "Interface")
	AddOptionList(page3, system, 3, "System")
	AddOptionList(page4, battleground, 4, "Battlegrounds")
	AddOptionList(page5, lootbags, 5, "Loot & Bags")
	AddOptionList(page6, tools, 6, "Tools")

	local searchLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
	searchLabel:SetPoint("TOPLEFT", frame, "TOPLEFT", 26, -61)
	searchLabel:SetText("Search")
	searchLabel:SetTextColor(1.0, 0.78, 0.12)
	LeaPlusSearchBox = CreateFrame("EditBox", "LeaPlusSearchBox", frame)
	LeaPlusSearchBox:SetWidth(210)
	LeaPlusSearchBox:SetHeight(24)
	LeaPlusSearchBox:SetPoint("TOPLEFT", frame, "TOPLEFT", 82, -54)
	LeaPlusSearchBox:SetFontObject(ChatFontNormal)
	LeaPlusSearchBox:SetAutoFocus(false)
	LeaPlusSearchBox:SetMaxLetters(60)
	LeaPlusSearchBox:SetTextInsets(7, 7, 0, 0)
	LeaPlusSearchBox:SetBackdrop({
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tile = true, tileSize = 16, edgeSize = 12,
		insets = {left = 3, right = 3, top = 3, bottom = 3}
	})
	LeaPlusSearchBox:SetScript("OnEnterPressed", LeaPlus_FindOption)
	LeaPlusSearchBox:SetScript("OnEscapePressed", function(self) local owner = LeaPlus_HandlerSelf(self); if owner then owner:ClearFocus() end end)
	local find = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
	LeaPlus_StyleButton(find)
	find:SetWidth(58)
	find:SetHeight(24)
	find:SetPoint("LEFT", LeaPlusSearchBox, "RIGHT", 7, 0)
	find:SetText("Find")
	find:SetScript("OnClick", LeaPlus_FindOption)
	LeaPlusSearchResult = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
	LeaPlusSearchResult:SetPoint("LEFT", find, "RIGHT", 10, 0)
	LeaPlusSearchResult:SetWidth(292)
	LeaPlusSearchResult:SetJustifyH("LEFT")
	LeaPlusSearchResult:SetText("Type an option name or description.")
	LeaPlusSearchResult:SetTextColor(0.82, 0.76, 0.64)
	LeaPlus_CreateHelp()
	local help = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
	LeaPlus_StyleButton(help)
	help:SetWidth(62)
	help:SetHeight(24)
	help:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -18, -54)
	help:SetText("Help")
	help:SetScript("OnClick", LeaPlus_ToggleHelp)

	local keywordLabel = page1:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	keywordLabel:SetPoint("BOTTOMLEFT", page1, "BOTTOMLEFT", 349, 52)
	keywordLabel:SetText("Whisper invite keyword")
	keywordLabel:SetTextColor(1.0, 0.78, 0.12)

	local keyword = CreateFrame("EditBox", "LeaPlusKeywordBox", page1)
	keyword:SetWidth(180)
	keyword:SetHeight(26)
	keyword:SetPoint("TOPLEFT", keywordLabel, "BOTTOMLEFT", 0, -5)
	keyword:SetFontObject(ChatFontNormal)
	keyword:SetAutoFocus(false)
	keyword:SetMaxLetters(20)
	keyword:SetTextInsets(7, 7, 0, 0)
	keyword:SetBackdrop({
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tile = true, tileSize = 16, edgeSize = 12,
		insets = {left = 3, right = 3, top = 3, bottom = 3}
	})
	keyword:SetScript("OnEnterPressed", LeaPlus_SaveKeyword)
	keyword:SetScript("OnEscapePressed", function(self) local owner = LeaPlus_HandlerSelf(self); if owner then owner:ClearFocus() end end)

	local saveKeyword = CreateFrame("Button", nil, page1, "UIPanelButtonTemplate")
	LeaPlus_StyleButton(saveKeyword)
	saveKeyword:SetWidth(70)
	saveKeyword:SetHeight(24)
	saveKeyword:SetPoint("LEFT", keyword, "RIGHT", 8, 0)
	saveKeyword:SetText("Save")
	saveKeyword:SetScript("OnClick", LeaPlus_SaveKeyword)

	LeaPlusScaleText = page2:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	LeaPlusScaleText:SetPoint("BOTTOMLEFT", page2, "BOTTOMLEFT", 24, 24)
	LeaPlusScaleText:SetTextColor(1.0, 0.78, 0.12)

	local scaleDown = CreateFrame("Button", nil, page2, "UIPanelButtonTemplate")
	LeaPlus_StyleButton(scaleDown)
	scaleDown:SetWidth(34)
	scaleDown:SetHeight(24)
	scaleDown:SetPoint("LEFT", LeaPlusScaleText, "RIGHT", 15, 0)
	scaleDown:SetText("-")
	scaleDown:SetScript("OnClick", function() LeaPlus_ChangeMinimapScale(-0.05) end)

	local scaleUp = CreateFrame("Button", nil, page2, "UIPanelButtonTemplate")
	LeaPlus_StyleButton(scaleUp)
	scaleUp:SetWidth(34)
	scaleUp:SetHeight(24)
	scaleUp:SetPoint("LEFT", scaleDown, "RIGHT", 5, 0)
	scaleUp:SetText("+")
	scaleUp:SetScript("OnClick", function() LeaPlus_ChangeMinimapScale(0.05) end)

	local systemNote = page3:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
	systemNote:SetPoint("BOTTOMLEFT", page3, "BOTTOMLEFT", 24, 28)
	systemNote:SetWidth(590)
	systemNote:SetJustifyH("LEFT")
	systemNote:SetText("First installation applies the Recommended preset. Hold Shift while opening quest, gossip or merchant windows to bypass automation for that interaction.")

	local battleNote = page4:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
	battleNote:SetPoint("BOTTOMLEFT", page4, "BOTTOMLEFT", 24, 28)
	battleNote:SetWidth(680)
	battleNote:SetJustifyH("LEFT")
	battleNote:SetText("WSG helpers are in Key Bindings: target the enemy flag carrier, or drop the flag / remove Slow Fall.")
	battleNote:SetTextColor(0.82, 0.76, 0.64)

	local lootNote = page5:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
	lootNote:SetPoint("BOTTOMLEFT", page5, "BOTTOMLEFT", 24, 28)
	lootNote:SetWidth(680)
	lootNote:SetJustifyH("LEFT")
	lootNote:SetText("Roll choices are mutually exclusive. All imported LazyPig actions remain Off until you enable them here.")
	lootNote:SetTextColor(0.82, 0.76, 0.64)

	local reset = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
	LeaPlus_StyleButton(reset)
	reset:SetWidth(100)
	reset:SetHeight(24)
	reset:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 22, 18)
	reset:SetText("Turn all off")
	reset:SetScript("OnClick", LeaPlus_ResetOptions)

	local recommended = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
	LeaPlus_StyleButton(recommended, true)
	recommended:SetWidth(125)
	recommended:SetHeight(24)
	recommended:SetPoint("LEFT", reset, "RIGHT", 7, 0)
	recommended:SetText("Recommended")
	recommended:SetScript("OnClick", LeaPlus_RecommendedOptions)
	recommended:SetScript("OnEnter", function(self)
		local owner = LeaPlus_HandlerSelf(self)
		GameTooltip:SetOwner(owner, "ANCHOR_TOP")
		GameTooltip:SetText("Recommended starter preset")
		GameTooltip:AddLine("Applies the first-use preset, including automatic .save. Interaction, social and battleground automation stays Off.", 1, 1, 1, 1)
		GameTooltip:Show()
	end)
	recommended:SetScript("OnLeave", function() GameTooltip:Hide() end)

	LeaPlusStatusText = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
	LeaPlusStatusText:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 270, 23)
	LeaPlusStatusText:SetWidth(460)
	LeaPlusStatusText:SetJustifyH("RIGHT")
	LeaPlusStatusText:SetTextColor(0.82, 0.76, 0.64)

	table.insert(UISpecialFrames, "LeaPlusOptionsFrame")
	LeaPlus_ShowPage(1)
end

function LeaPlus_ToggleOptions()
	if not LeaPlusOptionsFrame then LeaPlus_CreateOptions() end
	if LeaPlusOptionsFrame:IsShown() then LeaPlusOptionsFrame:Hide()
	else LeaPlusOptionsFrame:Show() end
end

function LeaPlus_UpdateMinimapButtonPosition()
	if not LeaPlusMinimapButton or not Minimap or not LeaPlusDB then return end
	local x = LeaPlusDB.MinimapButtonX or -56
	local y = LeaPlusDB.MinimapButtonY or 56
	LeaPlusMinimapButton:ClearAllPoints()
	LeaPlusMinimapButton:SetPoint("CENTER", Minimap, "CENTER", x, y)
end

function LeaPlus_MinimapButton_OnUpdate(self)
	self = LeaPlus_HandlerSelf(self)
	if not self or not self.dragging or not Minimap or not UIParent then return end
	local cursorX, cursorY = GetCursorPosition()
	local scale = UIParent:GetEffectiveScale() or 1
	cursorX = cursorX / scale
	cursorY = cursorY / scale
	local centerX, centerY = Minimap:GetCenter()
	if not centerX or not centerY then return end
	local deltaX = cursorX - centerX
	local deltaY = cursorY - centerY
	local distance = math.sqrt((deltaX * deltaX) + (deltaY * deltaY))
	if distance < 1 then return end
	local width = Minimap:GetWidth() or 140
	local radius = (width / 2) + 8
	LeaPlusDB.MinimapButtonX = (deltaX / distance) * radius
	LeaPlusDB.MinimapButtonY = (deltaY / distance) * radius
	self.wasDragged = true
	LeaPlus_UpdateMinimapButtonPosition()
end

function LeaPlus_MinimapButton_OnClick(self, button)
	self = LeaPlus_HandlerSelf(self)
	button = LeaPlus_HandlerArg(button, arg1)
	if not self then return end
	if button == "RightButton" then
		LeaPlusDB.MinimapButtonX = -56
		LeaPlusDB.MinimapButtonY = 56
		self.wasDragged = nil
		LeaPlus_UpdateMinimapButtonPosition()
		LeaPlus_Print("Minimap button position reset.")
	elseif self.wasDragged then
		self.wasDragged = nil
	else
		LeaPlus_ToggleOptions()
	end
end

local function LeaPlus_CreateMinimapButton()
	if LeaPlusMinimapButton or not Minimap then return end
	local button = CreateFrame("Button", "LeaPlusMinimapButton", Minimap)
	button:SetWidth(30)
	button:SetHeight(30)
	button:EnableMouse(true)
	button:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	button:RegisterForDrag("LeftButton")
	button:SetNormalTexture("Interface\\Icons\\INV_Misc_Gear_01")
	button:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square")
	button:SetScript("OnClick", LeaPlus_MinimapButton_OnClick)
	button:SetScript("OnDragStart", function(self) local owner = LeaPlus_HandlerSelf(self); if owner then owner.dragging = true; owner.wasDragged = nil end end)
	button:SetScript("OnDragStop", function(self) local owner = LeaPlus_HandlerSelf(self); if owner then owner.dragging = nil end end)
	button:SetScript("OnUpdate", LeaPlus_MinimapButton_OnUpdate)
	button:SetScript("OnEnter", function(self)
		local owner = LeaPlus_HandlerSelf(self)
		GameTooltip:SetOwner(owner, "ANCHOR_LEFT")
		GameTooltip:SetText("Leatrix Plus " .. LEAPLUS_CLIENT_NAME)
		GameTooltip:AddLine("Left-click: options", 1, 1, 1, 1)
		GameTooltip:AddLine("Drag: move around minimap rim", 1, 1, 1, 1)
		GameTooltip:AddLine("Right-click: reset position", 1, 1, 1, 1)
		GameTooltip:Show()
	end)
	button:SetScript("OnLeave", function() GameTooltip:Hide() end)
	LeaPlus_UpdateMinimapButtonPosition()
end

local function LeaPlus_CanInvite()
	if GetNumRaidMembers and GetNumRaidMembers() > 0 then
		if IsPartyLeader and IsPartyLeader() then return true end
		if IsRaidLeader and IsRaidLeader() then return true end
		if IsRaidOfficer and IsRaidOfficer() then return true end
		return nil
	end
	if GetNumPartyMembers() > 0 then
		return UnitIsPartyLeader("player")
	end
	return true
end

local function LeaPlus_HandleWhisper(message, author)
	if not LeaPlus_IsOn("InviteFromWhisper") or not message or not author then return end
	local wanted = string.lower(LeaPlusDB.InvKey or "inv")
	local received = string.lower(message)
	received = string.gsub(received, "^%s+", "")
	received = string.gsub(received, "%s+$", "")
	if received == wanted and LeaPlus_CanInvite() then
		InviteByName(author)
		LeaPlus_Print("Invited " .. author .. " from whisper keyword.")
	end
end

local function LeaPlus_HandlePartyInvite(inviter)
	local known = LeaPlus_IsKnownPlayer(inviter)
	local paused = LeaPlus_IsOn("PausePartyAcceptInBG") and LeaPlusIsQueuedOrInBG and LeaPlusIsQueuedOrInBG()
	local shouldAccept = (known and LeaPlus_IsOn("AcceptPartyFriends"))
		or (not known and LeaPlus_IsOn("AcceptPartyStrangers"))
	if shouldAccept and not paused then
		AcceptGroup()
		StaticPopup_Hide("PARTY_INVITE")
		LeaPlus_Print("Accepted party invite from " .. (inviter or "player") .. ".")
	elseif not known and LeaPlus_IsOn("NoPartyInvites") then
		DeclineGroup()
		StaticPopup_Hide("PARTY_INVITE")
		LeaPlus_Print("Blocked party invite from " .. (inviter or "unknown player") .. ".")
	end
end

local function LeaPlus_HandleDuel(challenger)
	if LeaPlus_IsOn("NoDuelRequests") and not LeaPlus_IsKnownPlayer(challenger) then
		CancelDuel()
		StaticPopup_Hide("DUEL_REQUESTED")
		LeaPlus_Print("Blocked duel request from " .. (challenger or "unknown player") .. ".")
	end
end

local function LeaPlus_QuestRequiresGold()
	if GetQuestMoneyToGet then
		local cost = GetQuestMoneyToGet()
		if cost and cost > 0 then return true end
	end
	return nil
end

-- Vanilla's gossip API returns active quests as title/level pairs and does not
-- expose their completion state. Cross-reference the quest log so an NPC with
-- several active quests can still turn in every completed one in sequence.
local function LeaPlus_NormalizeQuestTitle(title)
	title = string.lower(tostring(title or ""))
	title = string.gsub(title, "|c%x%x%x%x%x%x%x%x", "")
	title = string.gsub(title, "|r", "")
	title = string.gsub(title, "^%s+", "")
	title = string.gsub(title, "%s+$", "")
	return title
end

local function LeaPlus_QuestLogComplete(wantedTitle)
	if not wantedTitle or not GetNumQuestLogEntries or not GetQuestLogTitle then return nil end
	local wanted = LeaPlus_NormalizeQuestTitle(wantedTitle)
	local i
	for i = 1, GetNumQuestLogEntries() do
		local title, level, tag, isHeader, isCollapsed, isComplete = GetQuestLogTitle(i)
		if title and not isHeader and LeaPlus_NormalizeQuestTitle(title) == wanted then
			if isComplete == true or isComplete == 1 then return true end
			-- Some private 1.12 clients leave the aggregate completion flag nil.
			-- In that case, all finished objective rows are equivalent evidence.
			local count = GetNumQuestLeaderBoards and (GetNumQuestLeaderBoards(i) or 0) or 0
			if count > 0 then
				local allDone = true
				local objective
				for objective = 1, count do
					local text, objectiveType, finished = GetQuestLogLeaderBoard(objective, i)
					if finished ~= true and finished ~= 1 then allDone = nil break end
				end
				if allDone then return true end
			end
			return nil
		end
	end
	return nil
end

-- Delivery and talk-to quests frequently have no leaderboard rows. Some 1.12
-- private clients leave their aggregate completion flag nil even while the NPC
-- is ready to finish them. Treat a matching zero-objective quest as the next
-- best turn-in candidate, after every explicitly completed quest.
local function LeaPlus_QuestLogDeliveryCandidate(wantedTitle)
	if not wantedTitle or not GetNumQuestLogEntries or not GetQuestLogTitle then return nil end
	local wanted = LeaPlus_NormalizeQuestTitle(wantedTitle)
	local i
	for i = 1, GetNumQuestLogEntries() do
		local title, level, tag, isHeader = GetQuestLogTitle(i)
		if title and not isHeader and LeaPlus_NormalizeQuestTitle(title) == wanted then
			local count = GetNumQuestLeaderBoards and (GetNumQuestLeaderBoards(i) or 0) or 0
			return count == 0
		end
	end
	return nil
end

-- Private 1.12 cores disagree on the width of each gossip quest record.
-- Some return title/level pairs while others append trivial/complete flags.
-- Quest titles are the stable string fields, so discover rows from those
-- instead of indexing the raw tuple with a hard-coded stride.
local function LeaPlus_GossipQuestRows(values)
	local rows = {}
	local position
	for position = 1, table.getn(values) do
		if type(values[position]) == "string" and values[position] ~= "" then
			local row = {title = values[position], index = table.getn(rows) + 1}
			if type(values[position + 1]) == "number" then row.level = values[position + 1] end
			-- Vanilla returns title, level, isLowLevel, isComplete for each
			-- active gossip quest.  Delivery quests can have no leaderboard rows,
			-- so this fourth field is sometimes the only completion evidence.
			row.complete = values[position + 3] == true or values[position + 3] == 1
			rows[table.getn(rows) + 1] = row
		end
	end
	return rows
end

local function LeaPlus_SelectQuest(eventName)
	local shiftState = IsShiftKeyDown and IsShiftKeyDown()
	if not LeaPlus_IsOn("AutomateQuests") or shiftState == true or shiftState == 1 then return nil end
	local i
	local function GuideAllowsPickup(title)
		if not LeaPlus_IsOn("GuideAwareQuests") then return true end
		local altState = IsAltKeyDown and IsAltKeyDown()
		if altState == true or altState == 1 then return true end
		local provider = getglobal and getglobal("ZygorClassic_ShouldAcceptQuest308")
		if type(provider) ~= "function" then return true end
		local ok, allowed = pcall(provider, title)
		if not ok then return true end
		return allowed == true or allowed == 1
	end
	if eventName == "QUEST_GREETING" then
		for i = 1, GetNumActiveQuests() do
			local title, complete = GetActiveTitle(i)
			if title and (complete == true or complete == 1 or LeaPlus_QuestLogComplete(title)) then
				SelectActiveQuest(i)
				return true
			end
		end
		for i = 1, GetNumActiveQuests() do
			local title = GetActiveTitle(i)
			if title and LeaPlus_QuestLogDeliveryCandidate(title) then
				SelectActiveQuest(i)
				return true
			end
		end
		if GetNumAvailableQuests() > 0 then
			for i = 1, GetNumAvailableQuests() do
				local title = GetAvailableTitle(i)
				if title and GuideAllowsPickup(title) then
					SelectAvailableQuest(i)
					return true
				end
			end
		elseif GetNumActiveQuests() >= 1 then
			-- Vanilla may hide quest-log entries under collapsed headers, leaving
			-- no completion evidence for a multi-turn-in greeting. Opening the first
			-- active quest is still the safest useful fallback and matches the stock
			-- single-active behavior below.
			SelectActiveQuest(1)
			return true
		end
	elseif eventName == "GOSSIP_SHOW" then
		local available = {GetGossipAvailableQuests()}
		local active = {GetGossipActiveQuests()}
		local availableRows = LeaPlus_GossipQuestRows(available)
		local activeRows = LeaPlus_GossipQuestRows(active)
		-- Turn-ins take priority over pickups. After a reward, Vanilla reopens
		-- gossip and this loop selects the next completed quest automatically.
		for i = 1, table.getn(activeRows) do
			if activeRows[i].complete or LeaPlus_QuestLogComplete(activeRows[i].title) then
				SelectGossipActiveQuest(activeRows[i].index)
				return true
			end
		end
		-- On clients that omit the gossip completion flag, prefer talk/delivery
		-- quests with no objectives over an unfinished collection quest in row 1.
		for i = 1, table.getn(activeRows) do
			if LeaPlus_QuestLogDeliveryCandidate(activeRows[i].title) then
				SelectGossipActiveQuest(activeRows[i].index)
				return true
			end
		end
		if table.getn(availableRows) > 0 then
			for i = 1, table.getn(availableRows) do
				if GuideAllowsPickup(availableRows[i].title) then
					SelectGossipAvailableQuest(availableRows[i].index)
					return true
				end
			end
		end
		-- Never open an incomplete active quest as a fallback. Doing so traps
		-- mixed NPC dialogs on progress pages such as Filthy Paws and prevents
		-- the player from reaching a different completed turn-in.
	end
	return nil
end

-- ALL-IN-ONE 16: queue one quest-dialog action after a short stabilization
-- window. Both native events and the private-client visible-panel fallback use
-- this path, so neither can race against stale quest indices.
local function LeaPlus_QueueQuestDialog(eventName)
	LeaPlusQuestPendingEvent = eventName
	LeaPlusQuestPendingDelay = 0.30
end

-- Some private 1.12 clients display the stock quest panels without delivering
-- QUEST_GREETING/GOSSIP_SHOW to addon-created frames. Poll the visible panels
-- and act once per quest-list signature. A changed list after a reward naturally
-- selects the next completed quest without repeatedly clicking one unchanged row.
local function LeaPlus_CheckQuestPanels()
	if not LeaPlus_IsOn("AutomateQuests") then
		LeaPlusQuestGreetingSignature = nil
		LeaPlusGossipSignature = nil
		return
	end
	local shiftState = IsShiftKeyDown and IsShiftKeyDown()
	if shiftState == true or shiftState == 1 then return end
	local greetingState = nil
	if QuestFrameGreetingPanel then
		if QuestFrameGreetingPanel.IsVisible then greetingState = QuestFrameGreetingPanel:IsVisible()
		elseif QuestFrameGreetingPanel.IsShown then greetingState = QuestFrameGreetingPanel:IsShown() end
	end
	local greetingVisible = greetingState == true or greetingState == 1
	if greetingVisible then
		local signature = tostring(GetNumActiveQuests and GetNumActiveQuests() or 0) .. ":" ..
			tostring(GetNumAvailableQuests and GetNumAvailableQuests() or 0)
		local i
		for i = 1, (GetNumActiveQuests and GetNumActiveQuests() or 0) do
			signature = signature .. ":A=" .. tostring(GetActiveTitle(i) or "")
		end
		for i = 1, (GetNumAvailableQuests and GetNumAvailableQuests() or 0) do
			signature = signature .. ":N=" .. tostring(GetAvailableTitle(i) or "")
		end
		if signature ~= LeaPlusQuestGreetingSignature then
			LeaPlusQuestGreetingSignature = signature
			LeaPlus_QueueQuestDialog("QUEST_GREETING")
		end
	else
		LeaPlusQuestGreetingSignature = nil
	end

	local gossipState = nil
	if GossipFrameGreetingPanel then
		if GossipFrameGreetingPanel.IsVisible then gossipState = GossipFrameGreetingPanel:IsVisible()
		elseif GossipFrameGreetingPanel.IsShown then gossipState = GossipFrameGreetingPanel:IsShown() end
	end
	local gossipVisible = gossipState == true or gossipState == 1
	if gossipVisible and GetGossipActiveQuests and GetGossipAvailableQuests then
		local active = {GetGossipActiveQuests()}
		local available = {GetGossipAvailableQuests()}
		local signature = tostring(table.getn(active)) .. ":" .. tostring(table.getn(available))
		local i
		for i = 1, table.getn(active) do signature = signature .. ":A=" .. tostring(active[i]) end
		for i = 1, table.getn(available) do signature = signature .. ":N=" .. tostring(available[i]) end
		if signature ~= LeaPlusGossipSignature then
			LeaPlusGossipSignature = signature
			LeaPlus_QueueQuestDialog("GOSSIP_SHOW")
		end
	else
		LeaPlusGossipSignature = nil
	end
end

function LeaPlus_QuestStatus()
	local activeCount = GetNumActiveQuests and (GetNumActiveQuests() or 0) or 0
	local availableCount = GetNumAvailableQuests and (GetNumAvailableQuests() or 0) or 0
	LeaPlus_Print("quest selector: greeting active=" .. tostring(activeCount) ..
		", available=" .. tostring(availableCount) .. ".")
	local i
	for i = 1, activeCount do
		local title, apiComplete = GetActiveTitle(i)
		local logComplete = LeaPlus_QuestLogComplete(title)
		LeaPlus_Print("active " .. tostring(i) .. ": " .. tostring(title or "?") ..
			"; API=" .. tostring(apiComplete) .. "; quest log=" .. tostring(logComplete) ..
			"; delivery=" .. tostring(LeaPlus_QuestLogDeliveryCandidate(title)) .. ".")
	end
	if GetGossipActiveQuests then
		local gossip = {GetGossipActiveQuests()}
		LeaPlus_Print("gossip active raw fields=" .. tostring(table.getn(gossip)) ..
			" (Vanilla normally uses title/level pairs).")
	end
end

local function LeaPlus_HandleGossip()
	if not LeaPlus_IsOn("AutomateGossip") or IsShiftKeyDown() then return end
	local options = {GetGossipOptions()}
	local count = math.floor(table.getn(options) / 2)
	if count ~= 1 then return end
	local optionType = options[2]
	if not optionType then return end
	optionType = string.lower(optionType)
	if IsAltKeyDown() or optionType == "banker" or optionType == "taxi"
		or optionType == "trainer" or optionType == "vendor" then
		SelectGossipOption(1)
	end
end

local function LeaPlus_HandleQuestEvent(eventName)
	if not LeaPlus_IsOn("AutomateQuests") or IsShiftKeyDown() then return end
	if eventName == "QUEST_DETAIL" then
		AcceptQuest()
	elseif eventName == "QUEST_ACCEPT_CONFIRM" and ConfirmAcceptQuest then
		ConfirmAcceptQuest()
		StaticPopup_Hide("QUEST_ACCEPT")
	elseif eventName == "QUEST_PROGRESS" then
		if IsQuestCompletable and not IsQuestCompletable() then return end
		if LeaPlus_QuestRequiresGold() then return end
		CompleteQuest()
	elseif eventName == "QUEST_COMPLETE" then
		if LeaPlus_QuestRequiresGold() then return end
		local choices = GetNumQuestChoices()
		if choices <= 1 then GetQuestReward(choices) end
	end
end

local function LeaPlus_FindGreyItem()
	local bag, slot
	for bag = 0, 4 do
		for slot = 1, GetContainerNumSlots(bag) do
			local key = bag .. ":" .. slot
			if not LeaPlusMerchantProcessed[key] then
				local link = GetContainerItemLink(bag, slot)
				if link and string.find(link, "ff9d9d9d") then
					LeaPlusMerchantProcessed[key] = true
					local texture, count, locked = GetContainerItemInfo(bag, slot)
					if not locked then return bag, slot end
				end
			end
		end
	end
	return nil, nil
end

local function LeaPlus_DoRepair()
	if LeaPlusMerchantRepairDone or not LeaPlus_IsOn("AutoRepairGear") then return end
	LeaPlusMerchantRepairDone = true
	if CanMerchantRepair and CanMerchantRepair() then
		local cost = GetRepairAllCost()
		if cost and cost > 0 then
			if cost <= GetMoney() then
				RepairAllItems()
				LeaPlus_Print("Repaired equipment for " .. LeaPlus_MoneyString(cost) .. ".")
			else
				LeaPlus_Print("Not enough money to repair equipment (" .. LeaPlus_MoneyString(cost) .. ").")
			end
		end
	end
end

local function LeaPlus_FinishMerchant()
	LeaPlusMerchantActive = nil
	if LeaPlusMerchantSold > 0 then
		LeaPlus_Print("Sold " .. LeaPlusMerchantSold .. " junk item stack(s).")
	end
	LeaPlus_DoRepair()
end

local function LeaPlus_StartMerchant()
	LeaPlusMerchantActive = nil
	LeaPlusMerchantProcessed = {}
	LeaPlusMerchantSold = 0
	LeaPlusMerchantRepairDone = nil
	LeaPlusMerchantTick = 0
	if IsShiftKeyDown() then return end
	if LeaPlus_IsOn("AutoSellJunk") then
		LeaPlusMerchantActive = true
	else
		LeaPlus_DoRepair()
	end
end

local function LeaPlus_MerchantUpdate()
	if not LeaPlusMerchantActive then return end
	local now = GetTime()
	if now < LeaPlusMerchantTick then return end
	LeaPlusMerchantTick = now + 0.15
	if not MerchantFrame or not MerchantFrame:IsShown() then
		LeaPlusMerchantActive = nil
		return
	end
	local bag, slot = LeaPlus_FindGreyItem()
	if bag and slot then
		ClearCursor()
		UseContainerItem(bag, slot)
		LeaPlusMerchantSold = LeaPlusMerchantSold + 1
	else
		LeaPlus_FinishMerchant()
	end
end

local function LeaPlus_InBattleground()
	local queues = MAX_BATTLEFIELD_QUEUES or 3
	local i
	for i = 1, queues do
		local status = GetBattlefieldStatus(i)
		if status == "active" then return true end
	end
	return nil
end

LeaPlusIsQueuedOrInBG = function()
	local queues = MAX_BATTLEFIELD_QUEUES or 3
	local i
	for i = 1, queues do
		local status = GetBattlefieldStatus(i)
		if status == "queued" or status == "confirm" or status == "active" then return true end
	end
	return nil
end

local LeaPlusRaidZones = {
	"Molten Core", "Blackwing Lair", "Zul'Gurub", "Ahn'Qiraj",
	"Onyxia's Lair", "Ruins of Ahn'Qiraj", "Temple of Ahn'Qiraj",
	"Naxxramas", "Blackrock Spire"
}

local LeaPlusDungeonZones = {
	"Ragefire Chasm", "The Deadmines", "Wailing Caverns", "Shadowfang Keep",
	"The Stockade", "Blackfathom Deeps", "Gnomeregan", "Razorfen Kraul",
	"Scarlet Monastery", "Razorfen Downs", "Uldaman", "Zul'Farrak",
	"Maraudon", "The Temple of Atal'Hakkar", "Sunken Temple",
	"Blackrock Depths", "Dire Maul", "Stratholme", "Scholomance"
}

local function LeaPlus_ZoneInList(list)
	if not GetRealZoneText then return nil end
	local zone = GetRealZoneText()
	local i
	for i = 1, table.getn(list) do
		if zone == list[i] then return true end
	end
	return nil
end

local function LeaPlus_InRaidZone()
	return LeaPlus_ZoneInList(LeaPlusRaidZones)
end

local function LeaPlus_InDungeonZone()
	return LeaPlus_ZoneInList(LeaPlusDungeonZones)
end

local function LeaPlus_InBattlegroundZone()
	if LeaPlus_InBattleground() then return true end
	if not GetRealZoneText then return nil end
	local zone = GetRealZoneText()
	return zone == "Warsong Gulch" or zone == "Arathi Basin" or zone == "Alterac Valley"
end

local function LeaPlus_ChatHasChannel(chatFrame, channelName)
	if not chatFrame or not chatFrame.channelList or not channelName then return nil end
	local key, value
	for key, value in pairs(chatFrame.channelList) do
		if value and string.lower(value) == string.lower(channelName) then return true end
	end
	return nil
end

LeaPlusApplyWorldChannel = function()
	if not LeaPlusDB or not GetChannelName then return end
	local shouldMute = LeaPlus_IsOn("MuteWorldAlways")
		or (LeaPlus_IsOn("MuteWorldDungeon") and LeaPlus_InDungeonZone())
		or (LeaPlus_IsOn("MuteWorldRaid") and LeaPlus_InRaidZone())
		or (LeaPlus_IsOn("MuteWorldBG") and LeaPlus_InBattlegroundZone())
	local id, name = GetChannelName("world")
	if id and id > 0 and name then LeaPlusWorldChannelName = name end
	name = name or LeaPlusWorldChannelName
	local chatCount = NUM_CHAT_WINDOWS or 7
	local i
	if shouldMute and name and ChatFrame_RemoveChannel then
		for i = 1, chatCount do
			local chatFrame = getglobal("ChatFrame" .. i)
			if chatFrame and LeaPlus_ChatHasChannel(chatFrame, name) then
				LeaPlusWorldFrames["ChatFrame" .. i] = true
				ChatFrame_RemoveChannel(chatFrame, name)
			end
		end
	elseif not shouldMute and name and ChatFrame_AddChannel then
		local frameName, wasShown
		for frameName, wasShown in pairs(LeaPlusWorldFrames) do
			local chatFrame = getglobal(frameName)
			if wasShown and chatFrame and not LeaPlus_ChatHasChannel(chatFrame, name) then
				ChatFrame_AddChannel(chatFrame, name)
			end
		end
		LeaPlusWorldFrames = {}
	end
end

LeaPlusApplyNameplates = function()
	if not LeaPlusDB then return end
	local controlling = LeaPlus_IsOn("ShowEnemyPlates")
		or LeaPlus_IsOn("ShowFriendlyPlates") or LeaPlus_IsOn("HideUncheckedPlates")
	if controlling then
		if LeaPlus_IsOn("ShowEnemyPlates") then
			if ShowNameplates then ShowNameplates() end
		elseif LeaPlus_IsOn("HideUncheckedPlates") and HideNameplates then
			HideNameplates()
		end
		if LeaPlus_IsOn("ShowFriendlyPlates") then
			if ShowFriendNameplates then ShowFriendNameplates() end
		elseif LeaPlus_IsOn("HideUncheckedPlates") and HideFriendNameplates then
			HideFriendNameplates()
		end
		LeaPlusApplied.Nameplates = true
	elseif LeaPlusApplied.Nameplates then
		if LeaPlusInitialEnemyPlates == "1" then
			if ShowNameplates then ShowNameplates() end
		elseif HideNameplates then HideNameplates() end
		if LeaPlusInitialFriendlyPlates == "1" then
			if ShowFriendNameplates then ShowFriendNameplates() end
		elseif HideFriendNameplates then HideFriendNameplates() end
		LeaPlusApplied.Nameplates = nil
	end
end

local function LeaPlus_GetRollMode(prefix)
	if LeaPlus_IsOn(prefix .. "Need") then return 1 end
	if LeaPlus_IsOn(prefix .. "Greed") then return 2 end
	if LeaPlus_IsOn(prefix .. "Pass") then return 0 end
	return nil
end

local function LeaPlus_RollLabel(mode)
	if mode == 1 then return "Need" end
	if mode == 2 then return "Greed" end
	return "Pass"
end

local function LeaPlus_HandleZGRoll(rollID)
	local mode = LeaPlus_GetRollMode("ZG")
	if mode == nil or not GetLootRollItemInfo or not RollOnLoot then return end
	local texture, name = GetLootRollItemInfo(rollID)
	if name and (string.find(name, "Hakkari Bijou") or string.find(name, "Coin")) then
		RollOnLoot(rollID, mode)
		LeaPlus_Print(LeaPlus_RollLabel(mode) .. " selected for " .. name .. ".")
	end
end

local function LeaPlus_HandleGreenRolls()
	local mode = LeaPlus_GetRollMode("Green")
	if mode == nil or not GetLootRollItemInfo or not RollOnLoot then return nil end
	local count = NUM_GROUP_LOOT_FRAMES or 4
	local i
	local handled = nil
	for i = 1, count do
		local frame = getglobal("GroupLootFrame" .. i)
		if frame and frame:IsVisible() and frame.rollID then
			local texture, name, itemCount, quality = GetLootRollItemInfo(frame.rollID)
			if quality == 2 then
				RollOnLoot(frame.rollID, mode)
				LeaPlus_Print(LeaPlus_RollLabel(mode) .. " selected for " .. (name or "uncommon item") .. ".")
				handled = true
			end
		end
	end
	return handled
end

local function LeaPlus_IsBearForm()
	if not GetNumShapeshiftForms or not GetShapeshiftFormInfo then return nil end
	local className, classToken = UnitClass("player")
	if classToken ~= "DRUID" and className ~= "Druid" then return nil end
	local i
	for i = 1, GetNumShapeshiftForms() do
		local texture, name, active = GetShapeshiftFormInfo(i)
		if active and (name == "Bear Form" or name == "Dire Bear Form") then return true end
	end
	return nil
end

local function LeaPlus_HasShield()
	if not GetInventorySlotInfo or not GetInventoryItemLink or not GetItemInfo then return nil end
	local className, classToken = UnitClass("player")
	if classToken ~= "WARRIOR" and className ~= "Warrior" then return nil end
	local slot = GetInventorySlotInfo("SecondaryHandSlot")
	local link = GetInventoryItemLink("player", slot)
	if not link then return nil end
	local itemName, itemLink, quality, level, requiredLevel, itemType, itemSubType = GetItemInfo(link)
	return itemType == "Shields" or itemSubType == "Shields"
end

LeaPlusCheckSalvation = function()
	if not LeaPlus_IsOn("RemoveSalvationAlways") and not LeaPlus_IsOn("RemoveSalvationTank") then return end
	if LeaPlus_IsOn("RemoveSalvationTank") and not LeaPlus_HasShield() and not LeaPlus_IsBearForm() then return end
	local i
	for i = 0, 31 do
		local buffIndex = GetPlayerBuff(i)
		if buffIndex and buffIndex >= 0 then
			local texture = GetPlayerBuffTexture(buffIndex)
			if texture then
				local lower = string.lower(texture)
				if string.find(lower, "sealofsalvation") or string.find(lower, "greaterblessingofsalvation") then
					CancelPlayerBuff(buffIndex)
					LeaPlus_Print("Removed Blessing of Salvation.")
					return
				end
			end
		end
	end
end

local function LeaPlus_TrackWSGCarrier(message)
	if not message or not UnitFactionGroup then return end
	local lower = string.lower(message)
	local faction = UnitFactionGroup("player")
	if not faction then return end
	local flag = "the " .. string.lower(faction) .. " flag"
	if string.find(lower, flag .. " was picked up by ") then
		local startAt, endAt, carrier = string.find(lower, flag .. " was picked up by (.+)!")
		if carrier then LeaPlusWSGCarrier = carrier end
	elseif string.find(lower, flag .. " was dropped") or string.find(lower, "captured " .. flag) then
		LeaPlusWSGCarrier = nil
	end
end

function LeaPlus_TargetFlagCarrier()
	if ClearTarget then ClearTarget() end
	if not LeaPlusWSGCarrier then
		LeaPlus_Print("No enemy Warsong flag carrier is currently tracked.")
		return
	end
	TargetByName(LeaPlusWSGCarrier, true)
	if not UnitExists("target") then
		LeaPlus_Print("Flag carrier is out of targeting range: " .. string.upper(LeaPlusWSGCarrier) .. ".")
	end
end

function LeaPlus_DropWSGFlag()
	if not LeaPlusItemTooltip then return end
	local i
	for i = 0, 31 do
		local buffIndex = GetPlayerBuff(i)
		if buffIndex and buffIndex >= 0 then
			LeaPlusItemTooltip:SetPlayerBuff(buffIndex)
			local line1 = getglobal("LeaPlusItemTooltipTextLeft1")
			local line2 = getglobal("LeaPlusItemTooltipTextLeft2")
			local text1 = line1 and line1:GetText() or ""
			local text2 = line2 and line2:GetText() or ""
			if string.find(text1, "Warsong Flag") or string.find(text1, "Slow Fall")
				or string.find(text2, "You feel light") then
				CancelPlayerBuff(buffIndex)
			end
		end
	end
end

function LeaPlus_DuelOrTargetFlagCarrier()
	if GetRealZoneText and GetRealZoneText() == "Warsong Gulch" then
		LeaPlus_TargetFlagCarrier()
		return
	end
	local i
	for i = 1, (STATICPOPUP_NUMDIALOGS or 4) do
		local popup = getglobal("StaticPopup" .. i)
		if popup and popup:IsShown() and popup.which == "DUEL_REQUESTED" then
			CancelDuel()
			return
		end
	end
	if UnitExists("target") and UnitIsFriend("target", "player") and StartDuel then
		StartDuel(UnitName("target"))
	end
end

local function LeaPlus_IsGroupLeader()
	if IsPartyLeader and IsPartyLeader() then return true end
	if UnitIsPartyLeader and UnitIsPartyLeader("player") then return true end
	if IsRaidLeader and IsRaidLeader() then return true end
	return nil
end

local function LeaPlus_QueueBattleground()
	if not LeaPlus_IsOn("AutoQueueBG") or not JoinBattlefield then return end
	if IsShiftKeyDown() and AcceptBattlefieldPort then
		local queues = MAX_BATTLEFIELD_QUEUES or 3
		local i
		for i = 1, queues do
			local status = GetBattlefieldStatus(i)
			if status == "queued" or status == "confirm" then AcceptBattlefieldPort(i, nil) end
		end
	end
	if ((GetNumPartyMembers and GetNumPartyMembers() > 0)
		or (GetNumRaidMembers and GetNumRaidMembers() > 0)) and LeaPlus_IsGroupLeader() then
		JoinBattlefield(0, 1)
	else
		JoinBattlefield(0)
	end
	if ClearTarget then ClearTarget() end
	if BattlefieldFrameCancelButton then BattlefieldFrameCancelButton:Click() end
end

local function LeaPlus_HandleBattlegroundStatus()
	local active = nil
	local queues = MAX_BATTLEFIELD_QUEUES or 3
	local i
	for i = 1, queues do
		local status = GetBattlefieldStatus(i)
		if status == "confirm" and LeaPlus_IsOn("AutoEnterBG") and AcceptBattlefieldPort then
			AcceptBattlefieldPort(i, true)
			StaticPopup_Hide("CONFIRM_BATTLEFIELD_ENTRY")
		elseif status == "active" then
			active = true
		end
	end
	local winner = GetBattlefieldWinner and GetBattlefieldWinner()
	if active and winner == nil then LeaPlusBGLeaveDone = nil end
	if winner ~= nil and LeaPlus_IsOn("AutoLeaveBG") and not LeaPlusBGLeaveDone and LeaveBattlefield then
		LeaPlusBGLeaveDone = true
		if LeaPlus_IsOn("PrivateServerSave") then LeaPlusPrivateSaveAt = GetTime() + 15 end
		LeaveBattlefield()
	end
end

local function LeaPlus_AnnounceQueue(message)
	if not LeaPlus_IsOn("AnnounceBGQueue") or not message or not string.find(message, "Queued") then return end
	if not LeaPlus_IsGroupLeader() then return end
	if GetNumRaidMembers and GetNumRaidMembers() > 0 then
		SendChatMessage(message, "RAID")
	elseif GetNumPartyMembers and GetNumPartyMembers() > 0 then
		SendChatMessage(message, "PARTY")
	end
end

local function LeaPlus_SchedulePrivateSaveFromLoot(message)
	if not LeaPlus_IsOn("PrivateServerSave") or not message then return end
	if (string.find(message, "You won") or string.find(message, "You receive"))
		and (string.find(message, "cffa335ee") or string.find(message, "cff0070dd")
			or string.find(message, "cffff8000"))
		and not string.find(message, "Bijou") and not string.find(message, "Idol")
		and not string.find(message, "Shard") then
		LeaPlusPrivateSaveAt = GetTime() + 3
	end
end

local function LeaPlus_UpdatePrivateSave()
	if not LeaPlusPrivateSaveAt or GetTime() < LeaPlusPrivateSaveAt then return end
	if not LeaPlus_IsOn("PrivateServerSave") or LeaPlusPrivateSaveDisabled then
		LeaPlusPrivateSaveAt = nil
		return
	end
	if UnitAffectingCombat("player") then return end
	LeaPlusPrivateSaveAt = nil
	LeaPlusPrivateSaveSentAt = GetTime()
	SendChatMessage(".save", "SAY")
	LeaPlus_Print("Requested a private-server character save.")
end

local function LeaPlus_HandleSaveRejection(message)
	if not message or not LeaPlus_IsOn("PrivateServerSave") then return end
	if GetTime() - LeaPlusPrivateSaveSentAt < 2 and string.find(message, "There is no such command") then
		LeaPlusPrivateSaveDisabled = true
		LeaPlusDB.PrivateServerSave = "Off"
		LeaPlus_UpdateOptions()
		LeaPlus_Print(".save is unsupported on this server, so its automation was disabled.")
	end
end

local function LeaPlus_MakeQuestKey(title, level)
	if not title then return nil end
	return title .. "\031" .. tostring(level or "")
end

local function LeaPlus_RecordRepeatQuest(title, level)
	if not LeaPlus_IsOn("RepeatableQuestAssist") or not IsShiftKeyDown() or not title then return end
	LeaPlusDB.RepeatQuestKey = LeaPlus_MakeQuestKey(title, level)
	LeaPlusDB.RepeatQuestName = title
	LeaPlusRepeatQuestActive = true
	LeaPlus_Print("Recorded repeatable quest: |cffffffff" .. title .. "|r.")
	LeaPlus_UpdateOptions()
end

function LeaPlus_SelectGossipActiveQuest_Hook(index)
	local values = {GetGossipActiveQuests()}
	local position = ((index or 1) - 1) * 2 + 1
	LeaPlus_RecordRepeatQuest(values[position], values[position + 1])
	return LeaPlusOriginalSelectGossipActiveQuest(index)
end


function LeaPlus_SelectGossipAvailableQuest_Hook(index)
	local values = {GetGossipAvailableQuests()}
	local position = ((index or 1) - 1) * 2 + 1
	LeaPlus_RecordRepeatQuest(values[position], values[position + 1])
	return LeaPlusOriginalSelectGossipAvailableQuest(index)
end


function LeaPlus_SelectActiveQuest_Hook(index)
	local title = GetActiveTitle(index)
	local level = GetActiveLevel and GetActiveLevel(index) or ""
	LeaPlus_RecordRepeatQuest(title, level)
	return LeaPlusOriginalSelectActiveQuest(index)
end


function LeaPlus_SelectAvailableQuest_Hook(index)
	local title = GetAvailableTitle(index)
	local level = GetAvailableLevel and GetAvailableLevel(index) or ""
	LeaPlus_RecordRepeatQuest(title, level)
	return LeaPlusOriginalSelectAvailableQuest(index)
end


local function LeaPlus_TryRepeatQuest(eventName)
	if not LeaPlus_IsOn("RepeatableQuestAssist") or not LeaPlusDB.RepeatQuestKey or IsShiftKeyDown() then return nil end
	local i
	if eventName == "GOSSIP_SHOW" then
		local active = {GetGossipActiveQuests()}
		for i = 1, table.getn(active), 2 do
			if LeaPlus_MakeQuestKey(active[i], active[i + 1]) == LeaPlusDB.RepeatQuestKey then
				LeaPlusRepeatQuestActive = true
				LeaPlusOriginalSelectGossipActiveQuest(math.floor((i + 1) / 2))
				return true
			end
		end
		local available = {GetGossipAvailableQuests()}
		for i = 1, table.getn(available), 2 do
			if LeaPlus_MakeQuestKey(available[i], available[i + 1]) == LeaPlusDB.RepeatQuestKey then
				LeaPlusRepeatQuestActive = true
				LeaPlusOriginalSelectGossipAvailableQuest(math.floor((i + 1) / 2))
				return true
			end
		end
	elseif eventName == "QUEST_GREETING" then
		for i = 1, GetNumActiveQuests() do
			local level = GetActiveLevel and GetActiveLevel(i) or ""
			if LeaPlus_MakeQuestKey(GetActiveTitle(i), level) == LeaPlusDB.RepeatQuestKey then
				LeaPlusRepeatQuestActive = true
				LeaPlusOriginalSelectActiveQuest(i)
				return true
			end
		end
		for i = 1, GetNumAvailableQuests() do
			local level = GetAvailableLevel and GetAvailableLevel(i) or ""
			if LeaPlus_MakeQuestKey(GetAvailableTitle(i), level) == LeaPlusDB.RepeatQuestKey then
				LeaPlusRepeatQuestActive = true
				LeaPlusOriginalSelectAvailableQuest(i)
				return true
			end
		end
	end
	return nil
end

local function LeaPlus_HandleRepeatQuestStep(eventName)
	if not LeaPlus_IsOn("RepeatableQuestAssist") or not LeaPlusRepeatQuestActive then return nil end
	if eventName == "QUEST_DETAIL" then
		AcceptQuest()
		return true
	elseif eventName == "QUEST_PROGRESS" then
		if not IsQuestCompletable or IsQuestCompletable() then CompleteQuest() end
		return true
	elseif eventName == "QUEST_COMPLETE" then
		if GetNumQuestChoices() == 0 then
			GetQuestReward(0)
			LeaPlusRepeatQuestActive = nil
		end
		return true
	end
	return nil
end

local function LeaPlus_PositionLootFrame()
	if not LeaPlus_IsOn("LootAtCursor") or not LootFrame or not GetCursorPosition then return end
	local x, y = GetCursorPosition()
	local scale = LootFrame:GetEffectiveScale() or 1
	x = x / scale
	y = y / scale
	LootFrame:ClearAllPoints()
	local visible = 0
	local i
	for i = 1, (LOOTFRAME_NUMBUTTONS or 4) do
		local button = getglobal("LootButton" .. i)
		if button and button:IsVisible() then visible = i end
	end
	if visible > 0 then
		LootFrame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", x - 42, y + 56 + (40 * visible))
	elseif GetNumLootItems and GetNumLootItems() == 0 then
		if HideUIPanel then HideUIPanel(LootFrame) else LootFrame:Hide() end
	else
		LootFrame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", x - 173, y + 25)
	end
end

function LeaPlus_LootFrame_OnEvent(selfOrEvent, eventName, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10)
	local owner = nil
	if type(selfOrEvent) == "string" then
		eventName = selfOrEvent
		LeaPlusOriginalLootFrameOnEvent(eventName)
	else
		owner = selfOrEvent
		LeaPlusOriginalLootFrameOnEvent(owner, eventName, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10)
	end
	if eventName == "LOOT_SLOT_CLEARED" then LeaPlus_PositionLootFrame() end
end


function LeaPlus_LootFrame_Update()
	LeaPlusOriginalLootFrameUpdate()
	LeaPlus_PositionLootFrame()
end


local function LeaPlus_FilterChatEvent(owner, eventName, message, author)
	if (eventName == "CHAT_MSG_LOOT" or eventName == "CHAT_MSG_MONEY") and message then
		local fromPlayer = string.find(message, "You ") or string.find(message, "Your ")
		if not fromPlayer and LeaPlus_IsOn("FilterUncommonRolls") and string.find(message, "1eff00") then return true end
		if not fromPlayer and LeaPlus_IsOn("FilterRareRolls") and string.find(message, "0070dd") then return true end
		if LeaPlus_IsOn("FilterLowLoot") then
			if (not fromPlayer and (string.find(message, "9d9d9d") or string.find(message, "ffffff")))
				or string.find(message, "Your share of the loot") then return true end
		end
	end
	if not LeaPlus_IsOn("FilterDuplicateChat") or not message or not author then return nil end
	if author == UnitName("player") then return nil end
	if eventName ~= "CHAT_MSG_SAY" and eventName ~= "CHAT_MSG_YELL"
		and eventName ~= "CHAT_MSG_CHANNEL" and eventName ~= "CHAT_MSG_EMOTE" then return nil end
	local frameName = owner and owner.GetName and owner:GetName() or "default"
	if not LeaPlusChatHistory[frameName] then LeaPlusChatHistory[frameName] = {} end
	local key = LeaPlus_NormalizeName(author) .. "\031" .. message
	local now = GetTime()
	local oldKey, oldTime
	for oldKey, oldTime in pairs(LeaPlusChatHistory[frameName]) do
		if now - oldTime >= 70 then LeaPlusChatHistory[frameName][oldKey] = nil end
	end
	local previous = LeaPlusChatHistory[frameName][key]
	LeaPlusChatHistory[frameName][key] = now
	if previous and now - previous < 70 then return true end
	return nil
end

function LeaPlus_ChatFrame_OnEvent(selfOrEvent, eventName, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10)
	local owner, message, author
	if type(selfOrEvent) == "string" then
		eventName = selfOrEvent
		owner = this
		message = arg1
		author = arg2
		if LeaPlus_FilterChatEvent(owner, eventName, message, author) then return end
		return LeaPlusOriginalChatFrameOnEvent(eventName)
	end
	owner = selfOrEvent
	message = a1
	author = a2
	if LeaPlus_FilterChatEvent(owner, eventName, message, author) then return end
	return LeaPlusOriginalChatFrameOnEvent(owner, eventName, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10)
end


local function LeaPlus_ItemID(link)
	if not link then return nil end
	local startAt, endAt, id = string.find(link, "item:(%d+)")
	return tonumber(id)
end

local function LeaPlus_ItemIsTradeable(bag, slot)
	if not LeaPlusItemTooltip then return true end
	local i
	for i = 1, 20 do
		local line = getglobal("LeaPlusItemTooltipTextLeft" .. i)
		if line then line:SetText("") end
	end
	LeaPlusItemTooltip:SetBagItem(bag, slot)
	local lines = LeaPlusItemTooltip:NumLines() or 0
	for i = 1, lines do
		local line = getglobal("LeaPlusItemTooltipTextLeft" .. i)
		local text = line and line:GetText()
		if text == ITEM_SOULBOUND or text == ITEM_BIND_QUEST or text == ITEM_CONJURED then return nil end
	end
	return true
end

local function LeaPlus_ShowStackMode()
	if not LeaPlusStackText then return end
	if LeaPlusStackUntil > GetTime() then
		LeaPlusStackText:SetText("|cffffcc33STACK AMOUNT|r  " .. LeaPlusStackAmount .. "   |cffb8b0a0Ctrl -   Alt +|r")
		LeaPlusStackText:Show()
	else
		LeaPlusStackText:Hide()
	end
end

local function LeaPlus_FindEmptyBagSlot()
	local bag, slot
	for bag = 0, 4 do
		for slot = 1, GetContainerNumSlots(bag) do
			if not GetContainerItemLink(bag, slot) then return bag, slot end
		end
	end
	return nil, nil
end

local function LeaPlus_AddStackTask(sourceBag, sourceSlot, destBag, destSlot, count, whole)
	local task = {sourceBag = sourceBag, sourceSlot = sourceSlot, destBag = destBag,
		destSlot = destSlot, count = count, whole = whole}
	table.insert(LeaPlusStackTasks, task)
end

local function LeaPlus_BuildStackTasks(bag, slot)
	local link = GetContainerItemLink(bag, slot)
	local itemID = LeaPlus_ItemID(link)
	local texture, count, locked = GetContainerItemInfo(bag, slot)
	if not itemID or not count or locked then return end
	local itemName, itemLink, quality, level, requiredLevel, itemType, itemSubType, maxStack = GetItemInfo(itemID)
	maxStack = maxStack or 100
	local wanted = LeaPlusStackAmount
	if wanted > maxStack then wanted = maxStack end
	if wanted < 1 then wanted = 1 end
	if count == wanted then
		LeaPlus_Print("That stack already contains " .. wanted .. ".")
		return
	end
	if count > wanted then
		local destBag, destSlot = LeaPlus_FindEmptyBagSlot()
		if not destBag then
			LeaPlus_Print("No empty bag slot is available for the split stack.")
			return
		end
		LeaPlus_AddStackTask(bag, slot, destBag, destSlot, wanted, nil)
	else
		local needed = wanted - count
		local otherBag, otherSlot
		for otherBag = 0, 4 do
			for otherSlot = 1, GetContainerNumSlots(otherBag) do
				if needed > 0 and not (otherBag == bag and otherSlot == slot)
					and LeaPlus_ItemID(GetContainerItemLink(otherBag, otherSlot)) == itemID then
					local otherTexture, otherCount, otherLocked = GetContainerItemInfo(otherBag, otherSlot)
					if otherCount and not otherLocked then
						local take = otherCount
						if take > needed then take = needed end
						LeaPlus_AddStackTask(otherBag, otherSlot, bag, slot, take, take == otherCount)
						needed = needed - take
					end
				end
			end
		end
		if needed > 0 then
			LeaPlusStackTasks = {}
			LeaPlus_Print("Not enough matching items to build a stack of " .. wanted .. ".")
			return
		end
	end
	LeaPlus_Print("Building a stack of " .. wanted .. ".")
end

local function LeaPlus_HandleEasyStackClick(bag, slot)
	if not LeaPlus_IsOn("EasyStackSplit") or not IsShiftKeyDown() or IsAltKeyDown() then return nil end
	if GetTime() >= LeaPlusStackUntil then
		LeaPlusStackAmount = 1
		LeaPlusStackUntil = GetTime() + 9
		LeaPlus_ShowStackMode()
		return true
	end
	LeaPlusStackUntil = GetTime() + 9
	LeaPlus_BuildStackTasks(bag, slot)
	LeaPlus_ShowStackMode()
	return true
end

local function LeaPlus_UpdateStackTasks()
	if LeaPlusStackUntil > 0 and GetTime() >= LeaPlusStackUntil then
		LeaPlusStackUntil = 0
		LeaPlus_ShowStackMode()
	end
	if LeaPlusStackUntil > GetTime() and GetTime() >= LeaPlusStackAdjustAt then
		local alt = IsAltKeyDown()
		local control = IsControlKeyDown()
		if alt and not control and LeaPlusStackAmount < 100 then
			LeaPlusStackAmount = LeaPlusStackAmount + 1
			LeaPlusStackAdjustAt = GetTime() + 0.12
			LeaPlusStackUntil = GetTime() + 9
			LeaPlus_ShowStackMode()
		elseif control and not alt and LeaPlusStackAmount > 1 then
			LeaPlusStackAmount = LeaPlusStackAmount - 1
			LeaPlusStackAdjustAt = GetTime() + 0.12
			LeaPlusStackUntil = GetTime() + 9
			LeaPlus_ShowStackMode()
		end
	end
	if table.getn(LeaPlusStackTasks) == 0 or CursorHasItem() then return end
	local task = LeaPlusStackTasks[1]
	local sourceTexture, sourceCount, sourceLocked = GetContainerItemInfo(task.sourceBag, task.sourceSlot)
	local destTexture, destCount, destLocked = GetContainerItemInfo(task.destBag, task.destSlot)
	if sourceLocked or destLocked then return end
	if not sourceCount then
		table.remove(LeaPlusStackTasks, 1)
		return
	end
	if task.whole or task.count >= sourceCount then
		PickupContainerItem(task.sourceBag, task.sourceSlot)
	else
		SplitContainerItem(task.sourceBag, task.sourceSlot, task.count)
	end
	PickupContainerItem(task.destBag, task.destSlot)
	if CursorHasItem() then ClearCursor() end
	table.remove(LeaPlusStackTasks, 1)
end

function LeaPlus_UseContainerItem_Hook(bag, slot)
	if LeaPlus_HandleEasyStackClick(bag, slot) then return end
	if LeaPlus_IsOn("ImprovedBagRightClick") and not IsShiftKeyDown() and not IsAltKeyDown() then
		if LeaPlusTradeOpen and LeaPlus_ItemIsTradeable(bag, slot) then
			PickupContainerItem(bag, slot)
			local tradeSlot = TradeFrame_GetAvailableSlot and TradeFrame_GetAvailableSlot()
			if tradeSlot and ClickTradeButton then ClickTradeButton(tradeSlot) end
			if CursorHasItem() then ClearCursor() end
			return
		elseif LeaPlusMailOpen and LeaPlus_ItemIsTradeable(bag, slot) then
			if InboxFrame and InboxFrame:IsVisible() and MailFrameTab_OnClick then MailFrameTab_OnClick(2) end
			if SendMailFrame and SendMailFrame:IsVisible() and ClickSendMailItemButton then
				PickupContainerItem(bag, slot)
				ClickSendMailItemButton()
				if CursorHasItem() then ClearCursor() end
			end
			return
		elseif LeaPlusAuctionOpen and LeaPlus_ItemIsTradeable(bag, slot) then
			if AuctionFrameAuctions and not AuctionFrameAuctions:IsVisible() and AuctionFrameTab3 then AuctionFrameTab3:Click() end
			if ClickAuctionSellItemButton then
				PickupContainerItem(bag, slot)
				ClickAuctionSellItemButton()
				if CursorHasItem() then ClearCursor() end
			end
			return
		end
	end
	return LeaPlusOriginalUseContainerItem(bag, slot)
end


local function LeaPlus_ClickSafePopup()
	local i
	for i = 1, (STATICPOPUP_NUMDIALOGS or 4) do
		local popup = getglobal("StaticPopup" .. i)
		if popup and popup:IsShown() and popup.which == "DEATH" and HasSoulstone and HasSoulstone() then
			local soulstone = getglobal("StaticPopup" .. i .. "Button2")
			if soulstone then soulstone:Click() return true end
		elseif popup and popup:IsShown() and popup.which ~= "CONFIRM_SUMMON"
			and popup.which ~= "CONFIRM_BATTLEFIELD_ENTRY" and popup.which ~= "CAMP"
			and popup.which ~= "AREA_SPIRIT_HEAL" and popup.which ~= "DEATH" then
			local button = getglobal("StaticPopup" .. i .. "Button1")
			if button then button:Click() return true end
		end
	end
	return nil
end

local function LeaPlus_HandleSpecialCombos()
	if not LeaPlus_IsOn("SpecialKeyCombos") or LeaPlusStackUntil > GetTime() then
		LeaPlusLastCombo = ""
		return
	end
	local control = IsControlKeyDown()
	local alt = IsAltKeyDown()
	local shift = IsShiftKeyDown()
	if shift and not control and not alt and UnitExists("target") and UnitIsUnit("player", "target") then
		if not LeaPlusSelfShiftAt then LeaPlusSelfShiftAt = GetTime() end
		if GetTime() - LeaPlusSelfShiftAt >= 3 and BattlefieldFrame then
			BattlefieldFrame:Show()
			LeaPlusSelfShiftAt = GetTime()
		end
	else
		LeaPlusSelfShiftAt = nil
	end
	local combo = ""
	if control and alt and shift then combo = "CAS"
	elseif control and alt then combo = "CA"
	elseif control and shift then combo = "CS"
	elseif alt and shift then combo = "AS" end
	if combo == "" then LeaPlusLastCombo = "" return end
	if combo == LeaPlusLastCombo or GetTime() < LeaPlusComboReadyAt then return end
	LeaPlusLastCombo = combo
	LeaPlusComboReadyAt = GetTime() + 0.75
	if combo == "CAS" then
		Logout()
	elseif combo == "CS" then
		if UnitExists("target") and UnitIsPlayer("target") and UnitIsFriend("target", "player") then FollowUnit("target") end
	elseif combo == "AS" then
		if LeaPlusAuctionOpen and AuctionFrameBrowse and AuctionFrameBrowse:IsVisible() and BrowseBidButton then
			BrowseBidButton:Click()
		elseif UnitExists("target") and UnitIsPlayer("target") then
			InspectUnit("target")
		end
	elseif combo == "CA" then
		if LeaPlus_HandleGreenRolls() then return end
		if LeaPlusTradeOpen and AcceptTrade then
			AcceptTrade()
		elseif UnitExists("target") and UnitIsPlayer("target") and UnitIsFriend("target", "player")
			and not UnitIsUnit("player", "target") and CheckInteractDistance("target", 2) and InitiateTrade then
			InitiateTrade("target")
		elseif LeaPlusAuctionOpen and AuctionFrameAuctions and AuctionFrameAuctions:IsVisible() and AuctionsCreateAuctionButton then
			AuctionsCreateAuctionButton:Click()
		elseif LeaPlusAuctionOpen and AuctionFrameBrowse and AuctionFrameBrowse:IsVisible() and BrowseBuyoutButton then
			BrowseBuyoutButton:Click()
		elseif LeaPlusMailOpen and SendMailFrame and SendMailFrame:IsVisible() and SendMailMailButton then
			SendMailMailButton:Click()
		elseif LeaPlusMailOpen and OpenMailFrame and OpenMailFrame:IsVisible() and OpenMailMoneyButton then
			OpenMailMoneyButton:Click()
		else
			LeaPlus_ClickSafePopup()
		end
	end
end

local function LeaPlus_BlockBGQuestPopup()
	if not LeaPlus_IsOn("BlockBGQuestShare") or not LeaPlus_InBattlegroundZone() then return end
	if GetTime() < LeaPlusPopupCheckAt then return end
	LeaPlusPopupCheckAt = GetTime() + 0.20
	local i
	for i = 1, (STATICPOPUP_NUMDIALOGS or 4) do
		local popup = getglobal("StaticPopup" .. i)
		if popup and popup:IsShown() and popup.which == "QUEST_ACCEPT" then
			popup:Hide()
			if DeclineQuest then DeclineQuest() end
			LeaPlus_Print("Blocked a shared quest in the battleground.")
		end
	end
end

local function LeaPlus_InstallHooks()
	if not LeaPlusOriginalUseContainerItem and type(UseContainerItem) == "function" then
		LeaPlusOriginalUseContainerItem = UseContainerItem
		UseContainerItem = LeaPlus_UseContainerItem_Hook
	end
	if not LeaPlusOriginalLootFrameOnEvent and type(LootFrame_OnEvent) == "function" then
		LeaPlusOriginalLootFrameOnEvent = LootFrame_OnEvent
		LootFrame_OnEvent = LeaPlus_LootFrame_OnEvent
	end
	if not LeaPlusOriginalLootFrameUpdate and type(LootFrame_Update) == "function" then
		LeaPlusOriginalLootFrameUpdate = LootFrame_Update
		LootFrame_Update = LeaPlus_LootFrame_Update
	end
	if not LeaPlusOriginalChatFrameOnEvent and type(ChatFrame_OnEvent) == "function" then
		LeaPlusOriginalChatFrameOnEvent = ChatFrame_OnEvent
		ChatFrame_OnEvent = LeaPlus_ChatFrame_OnEvent
	end
	if not LeaPlusOriginalSelectGossipActiveQuest and type(SelectGossipActiveQuest) == "function" then
		LeaPlusOriginalSelectGossipActiveQuest = SelectGossipActiveQuest
		SelectGossipActiveQuest = LeaPlus_SelectGossipActiveQuest_Hook
	end
	if not LeaPlusOriginalSelectGossipAvailableQuest and type(SelectGossipAvailableQuest) == "function" then
		LeaPlusOriginalSelectGossipAvailableQuest = SelectGossipAvailableQuest
		SelectGossipAvailableQuest = LeaPlus_SelectGossipAvailableQuest_Hook
	end
	if not LeaPlusOriginalSelectActiveQuest and type(SelectActiveQuest) == "function" then
		LeaPlusOriginalSelectActiveQuest = SelectActiveQuest
		SelectActiveQuest = LeaPlus_SelectActiveQuest_Hook
	end
	if not LeaPlusOriginalSelectAvailableQuest and type(SelectAvailableQuest) == "function" then
		LeaPlusOriginalSelectAvailableQuest = SelectAvailableQuest
		SelectAvailableQuest = LeaPlus_SelectAvailableQuest_Hook
	end
	if not LeaPlusOriginalTakeTaxiNode and type(TakeTaxiNode) == "function" then
		LeaPlusOriginalTakeTaxiNode = TakeTaxiNode
		TakeTaxiNode = LeaPlus_TakeTaxiNode_Hook
	end
end

local function LeaPlus_WantsAutoLoot()
	if not LeaPlus_IsOn("FasterLooting") then return end
	-- Stock 1.12 clients commonly return 1/nil for modifier APIs, while some
	-- private-client builds return 1/0. In Lua, zero is truthy, so normalize it
	-- explicitly or an ordinary right-click can look like Shift is held.
	local shiftState = IsShiftKeyDown and IsShiftKeyDown()
	local shiftDown = shiftState == true or shiftState == 1
	local autoLootSetting = LeaPlus_SafeGetCVar("autoLootDefault")
	local autoLoot = nil
	if autoLootSetting == nil then
		autoLoot = shiftDown
	else
		autoLoot = autoLootSetting == "1"
		if shiftDown then autoLoot = not autoLoot end
	end
	return autoLoot
end

local function LeaPlus_UpdateFastLoot()
	if not LeaPlusLootPending then return end
	local now = GetTime()
	if now < LeaPlusLootNextAt then return end
	if now > LeaPlusLootStopAt or not LeaPlus_IsOn("FasterLooting") then
		LeaPlusLootPending = nil
		return
	end
	LeaPlusLootNextAt = now + 0.05
	local count = GetNumLootItems()
	if count == 0 then
		if now - LeaPlusLootStartedAt > 0.20 then LeaPlusLootPending = nil end
		return
	end
	local i
	for i = count, 1, -1 do
		local locked = nil
		if GetLootSlotInfo then
			local texture, item, quantity, quality
			texture, item, quantity, quality, locked = GetLootSlotInfo(i)
		end
		if not locked then LootSlot(i) end
	end
end

local function LeaPlus_FastLoot()
	if not LeaPlus_WantsAutoLoot() then
		LeaPlusLootPending = nil
		return
	end
	local now = GetTime()
	LeaPlusLootPending = true
	LeaPlusLootStartedAt = now
	LeaPlusLootNextAt = now
	LeaPlusLootStopAt = now + 1.50
	LeaPlus_UpdateFastLoot()
end

-- Some 1.12/private-server clients do not reliably deliver LOOT_OPENED to
-- addon-created frames. The stock LootFrame still becomes visible, so detect
-- that edge as a second event source. Once seen, keep it latched until the
-- window closes so releasing Shift cannot turn a manual-loot session automatic.
local function LeaPlus_CheckLootWindow()
	if not LootFrame or not GetNumLootItems then return end
	local shownState = nil
	if LootFrame.IsVisible then shownState = LootFrame:IsVisible()
	elseif LootFrame.IsShown then shownState = LootFrame:IsShown() end
	local shown = shownState == true or shownState == 1
	local open = shown and GetNumLootItems() > 0
	if open and not LeaPlusLootFrameWasOpen then
		LeaPlusLootFrameWasOpen = true
		LeaPlus_FastLoot()
	elseif not shown then
		LeaPlusLootFrameWasOpen = nil
	end
end

local function LeaPlus_IsDismountError(message)
	if not message then return nil end
	if message == ERR_ATTACK_MOUNTED or message == ERR_TAXIPLAYERALREADYMOUNTED
		or message == SPELL_FAILED_NOT_MOUNTED then return true end
	local lower = string.lower(message)
	if string.find(lower, "mounted") then return true end
	return nil
end

local function LeaPlus_Dismount()
	-- TBC/WotLK expose player auras through UnitBuff instead of the indexed
	-- Vanilla player-buff API. Prefer that route when available.
	if UnitBuff and CancelUnitBuff then
		local i
		for i = 1, 40 do
			local name, rank, texture = UnitBuff("player", i)
			if not name then break end
			local lowerName = string.lower(name or "")
			local lowerTexture = string.lower(texture or "")
			if string.find(lowerTexture, "mount") or string.find(lowerTexture, "horse")
				or string.find(lowerTexture, "kodo") or string.find(lowerTexture, "raptor")
				or string.find(lowerTexture, "mechanostrider") or string.find(lowerName, "mount") then
				CancelUnitBuff("player", i)
				return
			end
		end
	end
	if not LeaPlusMountTooltip then return end
	if not GetPlayerBuff or not CancelPlayerBuff then return end
	local i
	for i = 0, 31 do
		local buffIndex = GetPlayerBuff(i)
		if buffIndex and buffIndex >= 0 then
			LeaPlusMountTooltip:SetPlayerBuff(buffIndex)
			local line = getglobal("LeaPlusMountTooltipTextLeft2")
			local description = nil
			if line then description = line:GetText() end
			local texture = GetPlayerBuffTexture(i)
			local mountLike = nil
			if description then
				local lower = string.lower(description)
				if string.find(lower, "speed") and string.find(lower, "%%") then mountLike = true end
			end
			if texture then
				local lowerTexture = string.lower(texture)
				if string.find(lowerTexture, "mount") or string.find(lowerTexture, "horse")
					or string.find(lowerTexture, "kodo") or string.find(lowerTexture, "raptor")
					or string.find(lowerTexture, "mechanostrider") then mountLike = true end
			end
			if mountLike then
				CancelPlayerBuff(i)
				return
			end
		end
	end
end

local function LeaPlus_HandleUIError(message)
	if not LeaPlus_IsOn("StandAndDismount") then return end
	if message == SPELL_FAILED_NOT_STANDING then
		SitOrStand()
	elseif LeaPlus_IsDismountError(message) then
		LeaPlus_Dismount()
	end
end

local function LeaPlus_RegisterRuntimeEvents(frame)
	local events = {
		"PLAYER_LOGIN", "QUEST_GREETING", "GOSSIP_SHOW", "QUEST_DETAIL",
		"QUEST_ACCEPT_CONFIRM", "QUEST_PROGRESS", "QUEST_COMPLETE",
		"CONFIRM_SUMMON", "RESURRECT_REQUEST", "PLAYER_DEAD",
		"MERCHANT_SHOW", "MERCHANT_CLOSED", "PARTY_INVITE_REQUEST",
		"DUEL_REQUESTED", "CHAT_MSG_WHISPER", "LOOT_OPENED", "LOOT_CLOSED",
		"UI_ERROR_MESSAGE", "UPDATE_BATTLEFIELD_STATUS", "BATTLEFIELDS_SHOW",
		"CHAT_MSG_BG_SYSTEM_ALLIANCE", "CHAT_MSG_BG_SYSTEM_HORDE",
		"CHAT_MSG_BG_SYSTEM_NEUTRAL", "CHAT_MSG_SYSTEM", "CHAT_MSG_LOOT",
		"START_LOOT_ROLL", "ZONE_CHANGED_NEW_AREA", "PLAYER_UNGHOST",
		"TRADE_SHOW", "TRADE_CLOSED", "MAIL_SHOW", "MAIL_CLOSED",
		"AUCTION_HOUSE_SHOW", "AUCTION_HOUSE_CLOSED", "BANKFRAME_OPENED",
		"BANKFRAME_CLOSED", "PLAYER_AURAS_CHANGED", "UPDATE_BONUS_ACTIONBAR",
			"UNIT_INVENTORY_CHANGED", "PLAYER_CONTROL_LOST", "PLAYER_CONTROL_GAINED"
	}
	if LEAPLUS_INTERFACE >= 20000 then
		events[table.getn(events) + 1] = "UNIT_AURA"
		events[table.getn(events) + 1] = "PLAYER_ENTERING_WORLD"
	end
	local i
	for i = 1, table.getn(events) do pcall(frame.RegisterEvent, frame, events[i]) end
end

LeaPlus_ProcessQuestDialog = function(eventName)
	if eventName == "GOSSIP_SHOW" then
		if not LeaPlus_TryRepeatQuest(eventName) and not LeaPlus_SelectQuest(eventName) then
			LeaPlus_HandleGossip()
		end
	elseif eventName == "QUEST_GREETING" then
		if not LeaPlus_TryRepeatQuest(eventName) then LeaPlus_SelectQuest(eventName) end
	elseif eventName == "QUEST_DETAIL" or eventName == "QUEST_ACCEPT_CONFIRM"
		or eventName == "QUEST_PROGRESS" or eventName == "QUEST_COMPLETE" then
		if eventName == "QUEST_ACCEPT_CONFIRM" and LeaPlus_IsOn("BlockBGQuestShare")
			and LeaPlus_InBattlegroundZone() then
			if DeclineQuest then DeclineQuest() end
			StaticPopup_Hide("QUEST_ACCEPT")
		else
			if not LeaPlus_HandleRepeatQuestStep(eventName) then LeaPlus_HandleQuestEvent(eventName) end
		end
	end
end

local function LeaPlus_UpdateQuestDialog(elapsed)
	if not LeaPlusQuestPendingEvent then return end
	elapsed = LeaPlus_HandlerArg(elapsed, arg1) or 0
	LeaPlusQuestPendingDelay = LeaPlusQuestPendingDelay - elapsed
	if LeaPlusQuestPendingDelay > 0 then return end
	local eventName = LeaPlusQuestPendingEvent
	LeaPlusQuestPendingEvent = nil
	LeaPlusQuestPendingDelay = 0
	LeaPlus_ProcessQuestDialog(eventName)
end

local function LeaPlus_Initialize(frame)
	if LeaPlusInitialized then return end
	LeaPlusInitialized = true
	local freshInstall = type(LeaPlusDB) ~= "table"
	if type(LeaPlusDB) ~= "table" then LeaPlusDB = {} end
	if type(LeaPlusDB.FlightTimes) ~= "table" then LeaPlusDB.FlightTimes = {} end
	if type(LeaPlusDB.FlightBarX) ~= "number" then LeaPlusDB.FlightBarX = 0 end
	if type(LeaPlusDB.FlightBarY) ~= "number" then LeaPlusDB.FlightBarY = 0 end
	-- ALL-IN-ONE 10 removes the unsupported right-click auto-loot experiment.
	LeaPlusDB.AlwaysAutoLoot = nil
	local key, default
	for key, default in pairs(LeaPlusDefaults) do
		if LeaPlusDB[key] ~= "On" and LeaPlusDB[key] ~= "Off" then
			LeaPlusDB[key] = default
		end
	end
	if freshInstall then LeaPlus_SetRecommendedValues() end
	if type(LeaPlusDB.InvKey) ~= "string" or LeaPlusDB.InvKey == "" then LeaPlusDB.InvKey = "inv" end
	if type(LeaPlusDB.MinimapScale) ~= "number" then LeaPlusDB.MinimapScale = 1 end
	if LeaPlusDB.MinimapScale < 0.70 or LeaPlusDB.MinimapScale > 1.50 then LeaPlusDB.MinimapScale = 1 end
	if type(LeaPlusDB.MinimapButtonX) ~= "number" or type(LeaPlusDB.MinimapButtonY) ~= "number" then
		LeaPlusDB.MinimapButtonX = -56
		LeaPlusDB.MinimapButtonY = 56
	end
	if type(LeaPlusDB.RepeatQuestKey) ~= "string" then LeaPlusDB.RepeatQuestKey = nil end
	if type(LeaPlusDB.RepeatQuestName) ~= "string" then LeaPlusDB.RepeatQuestName = nil end
	LeaPlusInitialEnemyPlates = LeaPlus_SafeGetCVar("nameplateShowEnemies")
	LeaPlusInitialFriendlyPlates = LeaPlus_SafeGetCVar("nameplateShowFriends")

	LeaPlusMountTooltip = CreateFrame("GameTooltip", "LeaPlusMountTooltip", UIParent, "GameTooltipTemplate")
	LeaPlusMountTooltip:SetOwner(UIParent, "ANCHOR_NONE")
	LeaPlusItemTooltip = CreateFrame("GameTooltip", "LeaPlusItemTooltip", UIParent, "GameTooltipTemplate")
	LeaPlusItemTooltip:SetOwner(UIParent, "ANCHOR_NONE")
	LeaPlusStackText = UIParent:CreateFontString("LeaPlusStackText", "OVERLAY", "GameFontNormalLarge")
	LeaPlusStackText:SetPoint("CENTER", UIParent, "CENTER", 0, 90)
	LeaPlusStackText:Hide()
	LeaPlus_InstallHooks()
	LeaPlus_CreateOptions()
	LeaPlus_CreateMinimapButton()
	LeaPlus_RegisterRuntimeEvents(frame)
	if freshInstall then
		LeaPlus_UpdateOptions()
		LeaPlus_Print("first-use Recommended preset applied, including automatic .save.")
	end
	LeaPlus_Print("loaded. Type |cffffffff/ltp|r for options.")
end

function LeaPlus_OnEvent(eventName, eventArg1, eventArg2)
	if eventName == "VARIABLES_LOADED" then
		LeaPlus_Initialize(LeaPlusEventFrame)
		return
	end
	if not LeaPlusInitialized then return end

	if eventName == "PLAYER_LOGIN" then
		if GuildRoster and IsInGuild and IsInGuild() then GuildRoster() end
		LeaPlus_ApplyAll()
		LeaPlus_HandleBattlegroundStatus()
	elseif eventName == "PLAYER_CONTROL_LOST" then
		if LeaPlusFlightActive then LeaPlusFlightActive.offTaxiSince = nil end
		if LeaPlusFlightPending then LeaPlus_BeginFlight() end
	elseif eventName == "PLAYER_CONTROL_GAINED" then
		-- Confirm the landing in the update loop. Some multi-leg taxi routes
		-- briefly emit this event between nodes while the flight continues.
		if LeaPlusFlightActive and not LeaPlusFlightActive.offTaxiSince then
			LeaPlusFlightActive.offTaxiSince = GetTime()
		end
	elseif eventName == "GOSSIP_SHOW" or eventName == "QUEST_GREETING" then
		LeaPlus_QueueQuestDialog(eventName)
	elseif eventName == "QUEST_DETAIL" or eventName == "QUEST_ACCEPT_CONFIRM"
		or eventName == "QUEST_PROGRESS" or eventName == "QUEST_COMPLETE" then
		LeaPlus_QueueQuestDialog(eventName)
	elseif eventName == "CONFIRM_SUMMON" then
		if LeaPlus_IsOn("AutoAcceptSummon") and not UnitAffectingCombat("player") then
			ConfirmSummon()
			StaticPopup_Hide("CONFIRM_SUMMON")
		end
	elseif eventName == "RESURRECT_REQUEST" then
		if LeaPlus_IsOn("AutoAcceptRes") and not UnitAffectingCombat("player") then
			AcceptResurrect()
			StaticPopup_Hide("RESURRECT")
			StaticPopup_Hide("RESURRECT_NO_TIMER")
			StaticPopup_Hide("RESURRECT_NO_SICKNESS")
		end
	elseif eventName == "PLAYER_DEAD" then
		if LeaPlus_IsOn("AutoReleasePvP") and LeaPlus_InBattleground() then
			if not HasSoulstone or not HasSoulstone() then RepopMe() end
		end
	elseif eventName == "MERCHANT_SHOW" then
		LeaPlus_StartMerchant()
	elseif eventName == "MERCHANT_CLOSED" then
		LeaPlusMerchantActive = nil
	elseif eventName == "TRADE_SHOW" then
		LeaPlusTradeOpen = true
	elseif eventName == "TRADE_CLOSED" then
		LeaPlusTradeOpen = nil
	elseif eventName == "MAIL_SHOW" then
		LeaPlusMailOpen = true
	elseif eventName == "MAIL_CLOSED" then
		LeaPlusMailOpen = nil
	elseif eventName == "AUCTION_HOUSE_SHOW" then
		LeaPlusAuctionOpen = true
	elseif eventName == "AUCTION_HOUSE_CLOSED" then
		LeaPlusAuctionOpen = nil
	elseif eventName == "BANKFRAME_OPENED" then
		LeaPlusBankOpen = true
	elseif eventName == "BANKFRAME_CLOSED" then
		LeaPlusBankOpen = nil
	elseif eventName == "PARTY_INVITE_REQUEST" then
		LeaPlus_HandlePartyInvite(LeaPlus_HandlerArg(eventArg1, arg1))
	elseif eventName == "DUEL_REQUESTED" then
		LeaPlus_HandleDuel(LeaPlus_HandlerArg(eventArg1, arg1))
	elseif eventName == "CHAT_MSG_WHISPER" then
		LeaPlus_HandleWhisper(LeaPlus_HandlerArg(eventArg1, arg1), LeaPlus_HandlerArg(eventArg2, arg2))
	elseif eventName == "LOOT_OPENED" then
		LeaPlusLootFrameWasOpen = true
		LeaPlus_FastLoot()
	elseif eventName == "LOOT_CLOSED" then
		LeaPlusLootPending = nil
		LeaPlusLootFrameWasOpen = nil
	elseif eventName == "UI_ERROR_MESSAGE" then
		LeaPlus_HandleUIError(LeaPlus_HandlerArg(eventArg1, arg1))
	elseif eventName == "UPDATE_BATTLEFIELD_STATUS" then
		LeaPlus_HandleBattlegroundStatus()
	elseif eventName == "BATTLEFIELDS_SHOW" then
		LeaPlus_QueueBattleground()
	elseif eventName == "CHAT_MSG_BG_SYSTEM_ALLIANCE" or eventName == "CHAT_MSG_BG_SYSTEM_HORDE" then
		LeaPlus_TrackWSGCarrier(LeaPlus_HandlerArg(eventArg1, arg1))
	elseif eventName == "CHAT_MSG_BG_SYSTEM_NEUTRAL" then
		LeaPlus_HandleBattlegroundStatus()
	elseif eventName == "CHAT_MSG_SYSTEM" then
		LeaPlus_AnnounceQueue(LeaPlus_HandlerArg(eventArg1, arg1))
		LeaPlus_HandleSaveRejection(LeaPlus_HandlerArg(eventArg1, arg1))
	elseif eventName == "CHAT_MSG_LOOT" then
		LeaPlus_SchedulePrivateSaveFromLoot(LeaPlus_HandlerArg(eventArg1, arg1))
	elseif eventName == "START_LOOT_ROLL" then
		LeaPlus_HandleZGRoll(LeaPlus_HandlerArg(eventArg1, arg1))
	elseif eventName == "ZONE_CHANGED_NEW_AREA" or eventName == "PLAYER_UNGHOST"
		or eventName == "PLAYER_ENTERING_WORLD" then
		if eventName == "ZONE_CHANGED_NEW_AREA" and GetRealZoneText and GetRealZoneText() ~= "Warsong Gulch" then
			LeaPlusWSGCarrier = nil
		end
		LeaPlus_ApplyAll()
		LeaPlus_HandleBattlegroundStatus()
	elseif eventName == "PLAYER_AURAS_CHANGED" or eventName == "UNIT_AURA"
		or eventName == "UPDATE_BONUS_ACTIONBAR"
		or eventName == "UNIT_INVENTORY_CHANGED" then
		LeaPlusCheckSalvation()
	end
end

function LeaPlus_OnUpdate(self, elapsed)
	elapsed = LeaPlus_HandlerArg(elapsed, arg1) or 0
	LeaPlus_UpdateQuestDialog(elapsed)
	LeaPlus_MerchantUpdate()
	LeaPlus_CheckQuestPanels()
	LeaPlus_CheckLootWindow()
	LeaPlus_UpdateFastLoot()
	LeaPlus_UpdateStackTasks()
	LeaPlus_HandleSpecialCombos()
	LeaPlus_UpdatePrivateSave()
	LeaPlus_BlockBGQuestPopup()
	LeaPlus_UpdateFlightTimer()
end

function LeaPlus_SlashCommand(message)
	message = message or ""
	message = string.gsub(message, "^%s+", "")
	message = string.gsub(message, "%s+$", "")
	local lower = string.lower(message)
	if lower == "" then
		LeaPlus_ToggleOptions()
	elseif lower == "help" then
		LeaPlus_Print("/ltp - options; /ltp keyword WORD - invite keyword; /ltp repeat - recorded quest; /ltp repeat clear - forget it; /ltp queststatus - quest selector data; /ltp reset - turn everything off.")
	elseif lower == "queststatus" then
		LeaPlus_QuestStatus()
	elseif lower == "reset" then
		LeaPlus_ResetOptions()
	elseif lower == "repeat" then
		LeaPlus_Print("Recorded repeatable quest: |cffffffff" .. (LeaPlusDB.RepeatQuestName or "none") .. "|r.")
	elseif lower == "repeat clear" then
		LeaPlusDB.RepeatQuestKey = nil
		LeaPlusDB.RepeatQuestName = nil
		LeaPlusRepeatQuestActive = nil
		LeaPlus_UpdateOptions()
		LeaPlus_Print("Forgot the recorded repeatable quest.")
	elseif string.sub(lower, 1, 8) == "keyword " then
		local keyword = string.sub(message, 9)
		keyword = string.gsub(keyword, "%s", "")
		if keyword ~= "" then
			LeaPlusDB.InvKey = string.lower(keyword)
			LeaPlus_Print("Whisper invite keyword set to |cffffffff" .. LeaPlusDB.InvKey .. "|r.")
			LeaPlus_UpdateOptions()
		end
	else
		LeaPlus_Print("Unknown command. Type |cffffffff/ltp help|r.")
	end
end

BINDING_HEADER_LEATRIXPLUS = "Leatrix Plus " .. LEAPLUS_CLIENT_NAME
BINDING_NAME_LEAPLUSLOGOUT = "Logout"
BINDING_NAME_LEAPLUSUNSTUCK = "Unstuck"
BINDING_NAME_LEAPLUSRELOAD = "Reload UI"
BINDING_NAME_LEAPLUSDUEL = "Target WSG flag carrier / Duel"
BINDING_NAME_LEAPLUSWSGDROP = "Drop WSG flag / Remove Slow Fall"
BINDING_NAME_LEAPLUSMENU = "Open Leatrix Plus"

function LeaPlus_ReloadUI()
	ReloadUI()
end

SLASH_LEAPLUSRELOAD1 = "/reload"
SLASH_LEAPLUSRELOAD2 = "/rl"
SLASH_LEAPLUSRELOAD3 = "/reloadui"
SlashCmdList["LEAPLUSRELOAD"] = LeaPlus_ReloadUI

SLASH_LEATRIXPLUS1121 = "/ltp"
SLASH_LEATRIXPLUS1122 = "/leatrix"
SlashCmdList["LEATRIXPLUS112"] = LeaPlus_SlashCommand

LeaPlusEventFrame = CreateFrame("Frame", "LeaPlusEventFrame", UIParent)
LeaPlusEventFrame:RegisterEvent("VARIABLES_LOADED")
LeaPlusEventFrame:SetScript("OnEvent", function(self, eventName, a1, a2)
	eventName = eventName or event
	LeaPlus_OnEvent(eventName, a1, a2)
end)
LeaPlusEventFrame:SetScript("OnUpdate", LeaPlus_OnUpdate)
