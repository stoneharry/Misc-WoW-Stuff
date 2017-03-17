---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
myGetActionTexture=myGetActionTexture or GetActionTexture;
function GetActionTexture(action)
	texture = myGetActionTexture(action);
	if(texture and string.find(texture,"INV_Misc_QuestionMark")) then
		local type,id=GetActionInfo(action);
		if type=="item" then _,_,_,_,_,_,_,_,_,texture = GetItemInfo(id);
		elseif type=="macro" then --do nothing
		else texture = string.gsub(texture,"INV_Misc_QuestionMark","INV_Misc_Gem_Topaz_02" );
		end
	end
	return texture;
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
myGetContainerItemInfo=myGetContainerItemInfo or GetContainerItemInfo;
function GetContainerItemInfo(index,id)
	local texture,itemCount,locked,quality,readable=myGetContainerItemInfo(index,id);
	if(texture and string.find(texture,"INV_Misc_QuestionMark"))then
		local itemlink = GetContainerItemLink(index,id);
		if(itemlink) then _,_,_,_,_,_,_,_,_,texture = GetItemInfo(itemlink)
		end
	end
	return texture,itemCount,locked,quality,readable;
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
myGetInventoryItemTexture=myGetInventoryItemTexture or GetInventoryItemTexture;
GetInventoryItemTexture=function(...)
	local texture=myGetInventoryItemTexture(...);
	local p,id=...;
	if p=="player" and id>19 and id<24 and not texture then
		local itemlink = GetInventoryItemLink(p,id) 
		if(itemlink) then _,_,_,_,_,_,_,_,_,texture = GetItemInfo(itemlink)
		end
	end
	return texture;
end
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------