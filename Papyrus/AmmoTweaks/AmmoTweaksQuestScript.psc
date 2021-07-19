Scriptname AmmoTweaks:AmmoTweaksQuestScript extends Quest
{handles ammo swap event, weapon repair/improvement, general init}


AmmoTweaks:SharedDefinitions Property 		pDefsQuest			auto const mandatory
{shared defs quest link}
AmmoTweaks:ATHUDManagerScript Property 		pHUDQuest			auto const mandatory
{HUDManager quest link}

; player weapon ref
ObjectReference Property 					pCurrentWeapon = none		auto hidden

ObjectReference Property 					pSwapWeapon = none			auto hidden


; custom events
CustomEvent PlayerSwapAmmoEvent
CustomEvent PlayerFieldRepairEvent

CustomEvent PlayerSwapAmmoEvent_Alt

bool Property 								bSwapInProgress = false 	auto hidden


;**** Functions

; external access to script
AmmoTweaks:AmmoTweaksQuestScript Function GetScript() Global
	return Game.GetFormFromFile(9905, "AmmoTweaks_Core.esp") as AmmoTweaks:AmmoTweaksQuestScript
EndFunction


;**** Custom Events

; Ammo Swapping Event - player trigger
Function SendPlayerSwapAmmoEvent(bool bIsPlayerWeap)
	var[] args = New Var[1]
	args[0] = bIsPlayerWeap
	self.SendCustomEvent("PlayerSwapAmmoEvent", args)
EndFunction

; Weapon Repair Event - player trigger
Function SendPlayerFieldRepairEvent(int iRepairAmount, Potion repairItem=none)
	var[] args = New Var[2]
	args[0] = iRepairAmount
	args[1] = repairItem
	self.SendCustomEvent("PlayerFieldRepairEvent", args)
EndFunction


; public custom event access
Function PlayerSwapAmmo()
	SendPlayerSwapAmmoEvent(false)
EndFunction

Function PlayerSwapAmmo_Alt()
	SendPlayerSwapAmmoEvent(true)
EndFunction

Function PlayerFieldRepairWeapon(int iRepairAmount, Potion repairItem=none)
	SendPlayerFieldRepairEvent(iRepairAmount, repairItem)
EndFunction


Function WeaponAttachMod(ObjectMod newMod, Message successMsg=none, Message failureMsg=none, bool bUpdate=false)
	if pCurrentWeapon != none
		if newMod != none
			Actor PlayerActor = Game.GetPlayer()
			Weapon weapBase = pCurrentWeapon.GetBaseObject() as Weapon
			Weapon weapCheck = PlayerActor.GetEquippedWeapon()
			
			if weapBase == weapCheck
				if pCurrentWeapon.AttachMod(newMod)
					if successMsg as bool
						successMsg.Show()
					endIf
				else
					if failureMsg as bool
						failureMsg.Show()
					endIf
				endIf
				
				if bUpdate
					PlayerActor.UnequipItem(weapBase,false,true)
					Utility.Wait(0.1)
					PlayerActor.EquipItem(weapBase,false,true)
				endIf
			else
				pCurrentWeapon = none
			endIf
		endIf
	endIf
EndFunction


Function ShowConditionMessage(float fCurCond=0.0, float fMaxcond=1.0)
	if pHUDQuest.IsHUDEnabled()
		if fMaxCond > 0.0
			UpdateConditionWidget(fCurCond, fMaxcond)
		else
			UpdateConditionWidget(0.0, 1.0)
		endIf
	else
		pDefsQuest.pConditionDisplayMsg.show(fCurCond, fMaxcond)
	endIf
	
EndFunction


ObjectMod Function GetConditionMod(int iType, int iCondition)
	ObjectMod newMod = none
	if iType == 0
		; ballistic
		newMod = pDefsQuest.pConditionMods_B[iCondition]
	elseif iType == 1
		; energy
		newMod = pDefsQuest.pConditionMods_E[iCondition]
	elseif iType == 2
		; melee
		newMod = pDefsQuest.pConditionMods_M[iCondition]
	else
		; launcher
		newMod = pDefsQuest.pConditionMods_L[iCondition]
	endIf
	return newMod
EndFunction


Function UpdateThrownMod(Actor akSource, Weapon weapSource)
	ObjectMod tempMod = pDefsQuest.GetNextAvailableThrownMod(akSource, weapSource)
	if tempMod != none
		WeaponAttachMod(tempMod)
	endIf
EndFunction


; weapon ref handling - mostly obselete, will be replaced
ObjectReference Function GetWeaponRef()
	return pCurrentWeapon
EndFunction

Function SetWeaponRef(ObjectReference tempWeap)
	pCurrentWeapon = tempWeap
	if !(tempWeap as bool)
		pHUDQuest.ToggleHUDWidgetVisible(false)
	else
		pHUDQuest.ToggleHUDWidgetVisible(true)
	endIf
EndFunction


Function SubWeaponCondition()
	if pCurrentWeapon != none
		AmmoTweaks:WeaponManagerScript tempWeap = pCurrentWeapon as AmmoTweaks:WeaponManagerScript
		if tempWeap
			tempWeap.ReduceWeaponCondition()
		endIf
	endIf
EndFunction


; v1.07: **** HUD widget interaction for HUDFramework

; updates condition bar/text
bool Function UpdateConditionWidget(float fCurCond=0.0, float fMaxcond=1.0)
	return pHUDQuest.UpdateConditionWidget(fCurCond, fMaxcond)
EndFunction

; updates ammotype text
bool Function UpdateATWidget(string sAmmoType=" ")
	return pHUDQuest.UpdateATWidget(sAmmoType)
EndFunction


Function ToggleHudWidgets(bool bToggle)
	pHUDQuest.ToggleHudWidgets(bToggle)
EndFunction

; registers + loads widgets
Function InitHUDWidgets()
	pHUDQuest.InitHUDWidgets()
EndFunction

Function ToggleHUDCondition(int iNewVal)
	pHUDQuest.SwitchConditionDispMode(iNewVal)
EndFunction

Function ToggleHUDAmmoType(int iNewVal)
	pHUDQuest.SwitchAmmoTypeDispMode(iNewVal)
EndFunction

Function SetHUDRefreshTime(float fNewTime)
	
EndFunction

Function SetHUDHideTime(float fNewTime)
	
EndFunction



; v1.08: **** update HUD widget position properies for Power Armor
Function UpdateHUDWidgetPosDefaults()
	pHUDQuest.SetPropertyValue("fHUDWidgetTY_PA", 420.0)
	pHUDQuest.SetPropertyValue("fHUDWidgetTX_PA", 1024.0)
	pHUDQuest.SetPropertyValue("fHUDWidgetTYMod_PA", 0.0)
EndFunction

