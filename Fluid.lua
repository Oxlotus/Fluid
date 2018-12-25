---------------------------------
--			F L U I D		   --
--			  1.0.0			   --
---------------------------------

-- Variables
local mod, t = ...
local fluid = LibStub("AceAddon-3.0"):NewAddon("Fluid", "AceConsole-3.0")
local ldb = LibStub("LibDataBroker-1.1"):NewDataObject("LDB", {
	type 	= "launcher",
	icon 	= "Interface\\Icons\\inv_drink_31_embalmingfluid",
	OnClick = function(self, button)
		if button == "RightButton" then
			fluid:Fluid("")
		else
			fluid:Fluid("show")
		end
	end,
	OnTooltipShow = function(tt)
		if tt and tt.AddLine then
			tt:SetText("|cffFFFF00" .. t.enUS["NAME"] .. "|r")
			tt:AddLine("|cff87CEEB" .. t.enUS["DESCRIPTION"] .. "|r")
			tt:AddLine("|cffFFFFFF" .. t.enUS["LCLICK"] .. "|r")
			tt:AddLine("|cffFFFFFF" .. t.enUS["RCLICK"] .. "|r")
			tt:Show()
		end
    end,
})
local icon = LibStub("LibDBIcon-1.0")

-- This executes when the mod is loaded.
function fluid:OnInitialize()
	-- Be a friendly human and thank the end user for downloading and installing the mod, even if it's for a short while.
	fluid:Print(t.enUS["WELCOME"])
	
	-- Create the display, save table, and register the information.
	self.db = LibStub("AceDB-3.0"):New("FluidDB", {
		profile = {
			minimap = {
				hide = false,
			},
		},
	})
	icon:Register("LDB", ldb, self.db.profile.minimap)
	self:RegisterChatCommand("ldb", "Controller")
	
	-- Register slash command(s).
	fluid:RegisterChatCommand("fluid", "Fluid")
	
end

-- This executes when the mod is enabled.
function fluid:OnEnable()
end

-- This executes when the mod is disabled.
function fluid:OnDisable()
end

-- The main function that controls most functionality.
function fluid:Fluid(args)
	if args == "" then
		fluid:Print("\n".. t.enUS["AUTHOR"] .. "\n" .. t.enUS["VERSION"] .. "\n" .. t.enUS["DISCORD"])
	elseif args == "show" then
		-- Create the GUI object, and then all its children components.
		local gui = LibStub("AceGUI-3.0")
		
		-- Create a container frame
		local frame = gui:Create("Frame")
		frame:SetCallback("OnClose", function(widget) gui:Release(widget) end)
		frame:SetTitle(t.enUS["NAME"])
		frame:SetStatusText(t.enUS["PH"])
		frame:SetLayout("Flow")
	end
end

-- The controller function for creating mod objects.
function fluid:Controller()
	self.db.profile.minimap.hide = not self.db.profile.minimap.hide
	if self.db.profile.hide then
		fluidIcon:Hide("LDB")
	else
		fluidIcon:Show("LDB")
	end
end