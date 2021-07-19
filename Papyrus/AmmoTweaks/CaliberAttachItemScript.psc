scriptName AmmoTweaks:CaliberAttachItemScript extends ActiveMagicEffect
{handles adding/removing caliber keywords to/from the currently equipped weapon}


Message Property pMainMessage			auto Const mandatory
Message Property pAddMessage			auto Const mandatory
Message Property pRemoveMessage			auto Const mandatory

Keyword[] Property pAttachKeywords		auto Const mandatory

AmmoTweaks:AmmoTweaksQuestScript Property AmmoTweaksQuest auto Const mandatory


;**** Events

;/ init /;
Event OnEffectStart(Actor akTarget, Actor akCaster)
	if akTarget == Game.GetPlayer()
		ObjectReference weapRef = AmmoTweaksQuest.GetWeaponRef()
		if weapRef as bool
			int menuVar1 = pMainMessage.Show()
			int menuVar2 = -1
			if menuVar1 == 0
				menuVar2 = pAddMessage.Show()
				if menuVar2 < pAttachKeywords.length
					if !(weapRef.HasKeyword(pAttachKeywords[menuVar2]))
						weapRef.AddKeyword(pAttachKeywords[menuVar2])
					endIf
				endIf
				
			elseif menuVar1 == 1
				menuVar2 = pRemoveMessage.Show()
				if menuVar2 < pAttachKeywords.length
					if weapRef.HasKeyword(pAttachKeywords[menuVar2])
						weapRef.RemoveKeyword(pAttachKeywords[menuVar2])
					endIf
				endIf
				
			endIf
		endIf
	endIf
EndEvent
