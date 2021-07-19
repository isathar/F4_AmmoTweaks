scriptname AmmoTweaks:LoadAmmoScript extends ObjectReference
{for ammo reloading crafting dummy items}


Group CraftingItem
{crafting output}
	Form Property 			pAmmoItem 					auto Const mandatory
	{ammo item to craft}
	int Property 			iOutAmount	 				auto Const mandatory
	{number of items to craft}
EndGroup

Group CraftingXP
{crafting xp  *optional}
	float Property 			fXPAmount = 		0.0 	auto Const
	{amount of XP to add}
	GlobalVariable Property pCraftingXP = 		none 	auto Const
	{type of XP to add to}
	Message Property 		pCraftXPMsg = 		none 	auto Const
	{message to display}
EndGroup


;/ add iOutAmount pAmmoItems to the player's inventory, increment XP /;
Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
	if akNewContainer == Game.GetPlayer() as ObjectReference
		akNewContainer.AddItem(pAmmoItem, iOutAmount, true)
		;/ Crafting XP stuff - disabled for now /;
		
		;/
		if fXPAmount > 0.0
			if pCraftingXP as bool
				float fTotalXP = fXPAmount + (pCraftingXP.GetValue())
				pCraftingXP.SetValue(fTotalXP)
				if pCraftXPMsg as bool
					pCraftXPMsg.Show(fTotalXP)
				endIf
			endIf
		endIf
		/;
	endIf
	akNewContainer.RemoveItem(self, 1, true)
EndEvent
