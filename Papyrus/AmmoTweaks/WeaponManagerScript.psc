scriptname AmmoTweaks:WeaponManagerScript extends ObjectReference
{handles weapon ref for player ammo switching, condition management, AV requirements}


Group WeaponCondition
	float Property 					fMaxWeapCondition = 	100.0 			auto Const
	{max condition for this weapon}
	
	; updated + saved while running:
	float Property 					fCurWeaponCondition = 	-1.0			auto hidden
	{current condition - **SAVED}
	int Property					iCurConditionIndex = 	-1				auto hidden
	{mod index for current condition - **SAVED}
	float Property 					fConditionMult = 		1.0				auto hidden
	{cached condition multiplier for faster access}
EndGroup

Group WeaponRequirements
	ActorValue Property 			pRequiredValue = 		none			auto const
	{required attribute/AV}
	float Property 					fSpecialReq = 			0.0				auto Const
	{minimum required value for this weapon}
	bool Property					bSubPowerArmor = 		false			auto Const
	{substitute power armor for av requirement}
EndGroup


int Property 						iWpnType = 				0				auto Const
{0=ballistic, 1=energy, 2=melee, 3=launcher}

AmmoTweaks:AmmoTweaksQuestScript Property pAmmoTweaksQuest					auto Const mandatory
{manager quest link}


string sFireEvent = 		"WeaponFire" 				Const
string sReloadEvent = 		"ReloadComplete" 			Const


; cached values to speed up events    *saved
bool bWeapCondition = 		false
bool bHeavyWeapon = 		false


; init weapon events
Event OnEquipped(Actor akActor)
	if akActor == Game.GetPlayer()
		bool bRestrictWeap = true
		pAmmoTweaksQuest.SetWeaponRef(self as ObjectReference)
		
		; check weapon requirements
		if (pAmmoTweaksQuest.pDefsQuest.pHeavyRestrictedGlobal.GetValue() > 0.0)
			bHeavyWeapon = HasKeyword(pAmmoTweaksQuest.pDefsQuest.pHeavyWeaponKeyword)
			if bHeavyWeapon
				bRestrictWeap = PlayerMeetsRequirements(akActor)
			endIf
		endIf
		
		if !bRestrictWeap
			; unequip weapon if requirements are not met
			akActor.UnequipItem(self.GetBaseObject(), false, true)
		else
			bWeapCondition = (pAmmoTweaksQuest.pDefsQuest.pConditionEnabled.GetValue() > 0.0)
			
			; set up condition events and variables
			if bWeapCondition
				; register events if this is a ranged weapon
				if iWpnType != 2
					RegisterForAnimationEvent(akActor, sFireEvent)
					RegisterForAnimationEvent(akActor, sReloadEvent)
				endIf
				
				; check if the weapon needs its condition updated
				GetNewWeapcondition(akActor)
				
			else
				if iCurConditionIndex != 1
					iCurConditionIndex = 1
					AttachMod(pAmmoTweaksQuest.GetConditionMod(iWpnType, 1))
				endIf
			endIf
		endIf
	endIf
EndEvent


; clear weapon events
Event OnUnequipped(Actor akActor)
	if akActor == Game.GetPlayer()
		if bWeapCondition
			if !HasKeyword(pAmmoTweaksQuest.pDefsQuest.pMeleeKeyword)
				UnRegisterForAnimationEvent(akActor, sFireEvent)
				UnRegisterForAnimationEvent(akActor, sReloadEvent)
			endIf
		endIf
	endIf
EndEvent


; listens for weapon fire and reload events for casings + condition
Event OnAnimationEvent(ObjectReference akSource, string asEventName)
	if akSource == Game.GetPlayer() as ObjectReference
		Actor tempPlayer = akSource as Actor
		if asEventName == sFireEvent
			; ranged weapon
			if iCurConditionIndex == 4
				; the weapon is broken - destroy or unequip
				if (pAmmoTweaksQuest.pDefsQuest.pWeaponBreakingGlobal.GetValue() < 1.0)
					pAmmoTweaksQuest.SetWeaponRef(none)
					tempPlayer.UnequipItem(self.GetBaseObject(), false, true)
				else
					tempPlayer.RemoveItem(self.GetBaseObject(), 1)
				endIf
			else
				if fCurWeaponCondition > 0.0
					fCurWeaponCondition = math.max(0.0, fCurWeaponCondition - fConditionMult)
					pAmmoTweaksQuest.UpdateConditionWidget(fCurWeaponCondition, fMaxWeapCondition)
				else
					GetNewWeapcondition(tempPlayer)
				endIf
				
			endIf
			
		elseif asEventName == sReloadEvent
			; ranged weapon - update condition mod
			GetNewWeapcondition(tempPlayer)
		endIf
	endIf
EndEvent


; updates weapon condition mods + variables
Function GetNewWeapcondition(Actor akActor)
	int i = 0
	int iFound = -1
	bool bReqsCheck = true
	
	; recheck player requirements to account for chems/buffs/power armor
	if (pAmmoTweaksQuest.pDefsQuest.pHeavyRestrictedGlobal.GetValue() > 0.0)
		bReqsCheck = PlayerMeetsRequirements(akActor)
	endIf
	
	if !bReqsCheck
		akActor.UnequipItem(self)
		
	else
		fConditionMult = pAmmoTweaksQuest.pDefsQuest.pConditionMult.GetValue()
		
		; find the index of current condition mod
		while i < pAmmoTweaksQuest.pDefsQuest.pConditionKeywords.length
			if HasKeyword(pAmmoTweaksQuest.pDefsQuest.pConditionKeywords[i])
				iFound = i
				i = pAmmoTweaksQuest.pDefsQuest.pConditionKeywords.length
			endIf
			i += 1
		endWhile
		
		if iFound < 0
			; no condition mod found, attach a random one
			iFound = Utility.RandomInt(0,3)
			if iFound == 0
				fCurWeaponCondition = utility.RandomFloat(fMaxWeapCondition * 1.01, fMaxWeapCondition * 1.2)
			elseif iFound == 1
				fCurWeaponCondition = utility.RandomFloat(fMaxWeapCondition * 0.81, fMaxWeapCondition)
			elseif iFound == 2
				fCurWeaponCondition = utility.RandomFloat(fMaxWeapCondition * 0.61, fMaxWeapCondition * 0.8)
			else
				fCurWeaponCondition = utility.RandomFloat(fMaxWeapCondition * 0.05, fMaxWeapCondition * 0.6)
			endIf
			iCurConditionIndex = iFound
			AttachMod(pAmmoTweaksQuest.GetConditionMod(iWpnType, iFound))
			
		else
			if iFound < iCurConditionIndex
				; the weapon has been repaired since the last check
				if iFound == 0
					fCurWeaponCondition = fMaxWeapCondition * 1.2
				elseif iFound == 1
					fCurWeaponCondition = fMaxWeapCondition
				elseif iFound == 2
					fCurWeaponCondition = fMaxWeapCondition * 0.8
				elseif iFound == 3
					fCurWeaponCondition = fMaxWeapCondition * 0.6
				endIf
				iCurConditionIndex = iFound
				
			else
				if fCurWeaponCondition < 0.0
					; new weapon without condition: random condition within found range
					if iFound == 0
						fCurWeaponCondition = utility.RandomFloat(fMaxWeapCondition * 1.01, fMaxWeapCondition * 1.2)
					elseif iFound == 1
						fCurWeaponCondition = utility.RandomFloat(fMaxWeapCondition * 0.81, fMaxWeapCondition)
					elseif iFound == 2
						fCurWeaponCondition = utility.RandomFloat(fMaxWeapCondition * 0.61, fMaxWeapCondition * 0.8)
					elseif iFound == 3
						fCurWeaponCondition = utility.RandomFloat(fMaxWeapCondition * 0.05, fMaxWeapCondition * 0.6)
					elseif iFound == 4
						fCurWeaponCondition = 0.0
					endIf
					
				elseif fCurWeaponCondition > fMaxWeapCondition
					; improved
					if iFound != 0
						iCurConditionIndex = 0
						AttachMod(pAmmoTweaksQuest.GetConditionMod(iWpnType, 0))
					endIf
				elseif fCurWeaponCondition > (fMaxWeapCondition * 0.8)
					; good
					if iFound != 1
						iCurConditionIndex = 1
						AttachMod(pAmmoTweaksQuest.GetConditionMod(iWpnType, 1))
					endIf
				elseif fCurWeaponCondition > (fMaxWeapCondition * 0.6)
					; worn
					if iFound != 2
						iCurConditionIndex = 2
						AttachMod(pAmmoTweaksQuest.GetConditionMod(iWpnType, 2))
					endIf
				elseif fCurWeaponCondition > 0.0
					; weathered
					if iFound != 3
						iCurConditionIndex = 3
						AttachMod(pAmmoTweaksQuest.GetConditionMod(iWpnType, 3))
					endIf
				else
					; broken weapon
					fCurWeaponCondition = 0.0
					if iFound != 4
						iCurConditionIndex = 4
						AttachMod(pAmmoTweaksQuest.GetConditionMod(iWpnType, 4))
					endIf
				endIf
			endIf
			
		endIf
		
		if iCurConditionIndex == 4
			; unequip weapon if it's broken
			if (pAmmoTweaksQuest.pDefsQuest.pWeaponBreakingGlobal.GetValue() < 1.0)
				akActor.UnequipItem(self.GetBaseObject(), false, true)
			else
				akActor.RemoveItem(self.GetBaseObject(), 1)
			endIf
		endIf
		
		pAmmoTweaksQuest.ShowConditionMessage(fCurWeaponCondition, fMaxWeapCondition)
	endIf
EndFunction


; checks player attribute/av against required value
bool Function PlayerMeetsRequirements(Actor akActor)
	bool bMeetsReqs = true
	if pRequiredValue as bool
		float tempVal = akActor.GetValue(pRequiredValue)
		if tempVal < fSpecialReq
			if bSubPowerArmor
				if !(akActor.IsInPowerArmor())
					pAmmoTweaksQuest.pDefsQuest.pStrReqMessage.Show(tempVal, fSpecialReq)
					bMeetsReqs = false
				endIf
			else 
				pAmmoTweaksQuest.pDefsQuest.pStrReqMessage.Show(tempVal, fSpecialReq)
				bMeetsReqs = false
			endIf
		endIf
	endIf
	return bMeetsReqs
EndFunction


Function ReduceWeaponCondition()
	fCurWeaponCondition = math.max(0.0, fCurWeaponCondition - fConditionMult)
	GetNewWeapcondition(Game.GetPlayer())
EndFunction
