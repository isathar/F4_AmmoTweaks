scriptname AmmoTweaks:PlayerAliasScript extends ReferenceAlias
{handles mod update on load for now}


AmmoTweaks:SharedDefinitions Property 		pDefsQuest			auto const mandatory


Event OnLoad()
	utility.wait(5.0)
	pDefsQuest.SetPropertyValueNoWait("fCurrentModVersion", 1.8)
	pDefsQuest.CheckModUpdate()
EndEvent
