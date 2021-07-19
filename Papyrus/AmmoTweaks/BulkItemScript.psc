scriptname AmmoTweaks:BulkItemScript extends ObjectReference
{for vendor bulk items}


LeveledItem Property pOutputItem auto Const mandatory


Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
	if akNewContainer == Game.GetPlayer() as ObjectReference
		akNewContainer.AddItem(pOutputItem, 1, true)
		akNewContainer.RemoveItem(self, 1, true)
	endIf
EndEvent
