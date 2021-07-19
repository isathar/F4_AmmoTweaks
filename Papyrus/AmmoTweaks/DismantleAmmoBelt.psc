scriptname AmmoTweaks:DismantleAmmoBelt extends ObjectReference
{for converting belt/cell item to single charge item}


Ammo Property 			pBeltItem 					auto Const mandatory
Ammo Property 			pSingleItem 				auto Const mandatory

int Property 			iMaxCharges = 		200 	auto Const


Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
	if akNewContainer == Game.GetPlayer() as ObjectReference
		if akNewContainer.GetItemCount(pBeltItem) > 0
			ObjectReference tempRef = akNewContainer.DropObject(pBeltItem, 1)
			if tempRef as bool
				float fTempHealth = tempRef.GetItemHealthPercent()
				if fTempHealth <= 0.0
					akNewContainer.AddItem(pSingleItem, iMaxCharges)
				else
					akNewContainer.AddItem(pSingleItem, ((fTempHealth * (iMaxCharges as float)) as int))
				endIf
			endIf
		endIf
	endIf
	akNewContainer.RemoveItem(self, 1, true)
EndEvent
