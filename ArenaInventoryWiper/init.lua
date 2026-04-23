dofile_once("data/scripts/lib/utilities.lua")


print("mod loaded")

local playermoney = 0

local newbiome = false

local IsEnteringHolyMountain = false
local player = nil
local players = nil

function OnBiomeConfigLoaded()
newbiome = true
GamePrint("newbiome")
end	


function OnWorldPreUpdate()
player = EntityGetWithTag("player_unit")[1]
	if ( not IsPlayer( player ) ) then 
		players = EntityGetWithTag("player_unit")
		for i = 1, #EntityGetWithTag("player_unit") do
			if ( IsPlayer( players[i] ) ) then
			player = players[i]
			end
		end
	end
	
	if( player and newbiome) then		
		newbiome = false		
		Clear_Inventory()
		GamePrint("Removing all spells from inventory")
	end
	
end
			
	
		
		
function Clear_Inventory()

	local inventory = nil
	
	local player_child_entities = EntityGetAllChildren( player )
	if ( player_child_entities ~= nil ) then
		for i,child_entity in ipairs( player_child_entities ) do
			local child_entity_name = EntityGetName( child_entity )
			if ( child_entity_name == "inventory_full" ) then
				inventory = child_entity
			end
		end
	end
			
	if ( inventory ~= nil ) then
		local inventory_items = EntityGetAllChildren( inventory )
				
		if inventory_items ~= nil then
			for i,item_entity in ipairs( inventory_items ) do
				GameKillInventoryItem ( player, item_entity )
			end
					
		end
	end
end