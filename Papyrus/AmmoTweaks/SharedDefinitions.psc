Scriptname AmmoTweaks:SharedDefinitions extends Quest
{general init + structs + shared properties accessed by multiple scripts}


Struct StandardLLAdd
	LeveledItem	liItemBase = 			none
	{base LI's formID}
	LeveledItem liItemAdd = 			none
	{leveled item to add to the list}
	int iItemAdd_Level = 				1
	int iItemAdd_Count = 				1
EndStruct

; access method for external leveled lists
Struct CompatibilityLL
	string 		sFormNameInfo = 		""
	{name of the leveled list to add to - not used, dev note}
	string 		sPluginName_Base = 		"Fallout4.esm"
	{plugin the base LL is located in}
	int 		iFormIndex_Base = 		-1
	{base LL's formID as int}
	LeveledItem liItemAdd = 			none
	{leveled item to add to the list}
	int iItemAdd_Level = 				1
	int iItemAdd_Count = 				1
EndStruct

; access method for external leveled lists between other plugins
Struct DLCXCompatibilityLL
	string 		sFormNameInfo_Base = 	""
	{name of the leveled list to add to - not used, dev note}
	string 		sPluginName_Base = 		"Fallout4.esm"
	{plugin the base LL is located in}
	int 		iFormIndex_Base = 		-1
	{base LL's formID as int}
	string 		sFormNameInfo_Add = 	""
	{name of the form to add - not used, dev note}
	string 		sPluginName_Add = 		"Fallout4.esm"
	{plugin the added LL is located in}
	int 		iFormIndex_Add = 		-1
	{added LL's formID as int}
	int iItemAdd_Level = 				1
	int iItemAdd_Count = 				1
EndStruct


; basic component for crafting recipes
Struct ATRecipeCompo
	Form		CompoForm = 			none
	{component or item to use}
	int 		iCompoCount = 			0
	{number of components to use}
EndStruct

; output for crafting recipes
Struct ATRecipeOutput
	Form		OutputForm = 			none
	{recipe output}
	int 		iOutputCount = 			0
	{number of output items}
	int 		iXPType = 				-1
	{0=none, 1=Ballistic, 2=Energy, 3=Chemical}
	float 		fXPAmount = 			0.0
	{amount of custom XP to award}
EndStruct


; ammo/item distribution preset
Struct DistributionPreset
	float fChanceNone_AmmoVeryCommon =	40.0
	float fChanceNone_AmmoCommon = 		55.0
	float fChanceNone_AmmoUncommon =	65.0
	float fChanceNone_AmmoRare =		72.0
	float fChanceNone_AmmoVeryRare =	85.0
	float fChanceNone_AmmoUltraRare = 	95.0
	
	float fChanceNone_AmmoBoxCommon = 	65.0
	float fChanceNone_AmmoBoxRare =		78.0
	float fChanceNone_AmmoBoxVeryRare = 85.0
	
	float fChanceNone_ShipmentCommon =	55.0
	float fChanceNone_ShipmentRare = 	72.0
	float fChanceNone_ShipmentVeryRare = 85.0
EndStruct


; Properties

Group SharedMessages
{properties needed for installation}
	Message Property 			pModInstalledMessage 				auto Const mandatory
	{install message}
	
	; leveled lists update/setup messages:
	Message Property 			pSetupMsg_LeveledLists 				auto Const mandatory
	{setup/update leveled lists}
	Message Property 			pSetupMsg_LeveledListsSelect		auto Const mandatory
	{setup/update leveled lists selection}
	Message Property 			pSetupMsg_RevertLeveledLists 		auto Const mandatory
	{revert leveled lists warning}
	
	Message Property 			pSwapFailedMsg						auto Const mandatory
	{message to show if ammo swap fails}
EndGroup


; Compatibility forms

Group CompatFormLists
{FormList modifications}
	FormList Property			pTrapHitList_Base 					auto const mandatory
	{TrapProjectileHit list - used to set off traps}
	FormList Property 			pTrapHitList_Custom					auto Const mandatory
	{custom projectiles list}
	
	FormList Property 			pFatManExplosions_Base				auto Const mandatory
	{list linked to fatman explosion default object - used for... something?}
	FormList Property 			pFatManExplosions_Custom			auto Const mandatory
	{custom fatman explosions to add}
	
	InstanceNamingRules Property pNamingRules_BaseGun				auto const mandatory
	{base gun naming rules}
	InstanceNamingRules Property pNamingRules_BaseMelee				auto const mandatory
	{base melee naming rules}
	
	InstanceNamingRules Property pNamingRules_GunCondition			auto const mandatory
	{added gun naming rules}
	InstanceNamingRules Property pNamingRules_GunCaliber			auto const mandatory
	{added gun naming rules}
	InstanceNamingRules Property pNamingRules_MeleeCondition		auto const mandatory
	{added melee naming rules}
	
	;Valdacil's Item Sorting compatibility
	InstanceNamingRules Property pNamingRules_GunConditionVIS		auto const mandatory
	{added gun naming rules}
	InstanceNamingRules Property pNamingRules_GunCaliberVIS			auto const mandatory
	{added gun naming rules}
	InstanceNamingRules Property pNamingRules_MeleeConditionVIS		auto const mandatory
	{added melee naming rules}
	
	Message Property 			pMsgNamingRules						auto Const mandatory
	
	FormList Property 			pHelpManualPC						auto Const mandatory
	FormList Property 			pHelpManualXBox						auto Const mandatory
	FormList Property 			pHelpMessages						auto Const mandatory
EndGroup

Group CompatLeveledLists
{leveled list modifications}
	StandardLLAdd[] Property 	pBaseLLAdd_Ammo4570					auto Const
	StandardLLAdd[] Property 	pBaseLLAdd_Ammo762x39				auto Const
	
	StandardLLAdd[] Property 	pBaseLLAdd_Items					auto Const
	StandardLLAdd[] Property 	pBaseLLAdd_Thrown					auto Const
	StandardLLAdd[] Property 	pBaseLLAdd_ThrownFH					auto Const
	
	CompatibilityLL[] Property 	pBaseLLAdd_DLCFHWeapons				auto Const
	CompatibilityLL[] Property 	pBaseLLAdd_DLCNWWeapons				auto Const
	
	
	StandardLLAdd[] Property 	pBaseLLAdd_AmmoUpdate106			auto Const
	{scrounger ammo}
	
	Message Property 			pMsgEnable4570Ammo					auto Const mandatory
	Message Property 			pMsgEnable762x39Ammo				auto Const mandatory
	
	Message Property 			pMsgAddThrownWeaps					auto Const mandatory
	Message Property 			pMsgAddDLCWeapsFH					auto Const mandatory
	Message Property 			pMsgAddDLCWeapsNW					auto Const mandatory
	
	GlobalVariable Property 	pUse4570Ammo						auto Const mandatory
	GlobalVariable Property 	pUse762x39Ammo						auto Const mandatory
	
	; flag to make sure leveled lists are only added once:
	bool Property 				bLLSetupDone = 			false		auto hidden
	
EndGroup


; weapon settings

Group WeaponCondition
{properties related to weapon condition system}
	GlobalVariable Property 	pConditionEnabled					auto Const mandatory
	{weapon condition toggle}
	GlobalVariable Property 	pConditionMult						auto Const mandatory
	{global multiplier for condition subtracted by shot}
	
	Keyword[] Property 			pConditionKeywords 					auto Const mandatory
	{possible condition keywords}
	Message[] Property 			pConditionMessages					auto Const mandatory
	{messages to display in condition change}
	
	ObjectMod[] Property 		pConditionMods_B					auto Const mandatory
	{condition mods: ballistic}
	ObjectMod[] Property 		pConditionMods_E					auto Const mandatory
	{condition mods: energy}
	ObjectMod[] Property 		pConditionMods_M					auto Const mandatory
	{condition mods: melee}
	ObjectMod[] Property 		pConditionMods_L					auto Const mandatory
	{condition mods: launcher}
	
	GlobalVariable Property		pWeaponBreakingGlobal				auto Const mandatory
	{global toggle for broken weapons being destroyed}
	
	Perk[] Property 			pGunNutPerks						auto const mandatory
	Perk[] Property 			pSciencePerks						auto const mandatory
	Perk[] Property 			pBlacksmithPerks					auto const mandatory
	
	Keyword Property 			pMeleeKeyword						auto Const mandatory
	{keyword to detect melee weapons}
	
	Message Property 			pConditionDisplayMsg				auto Const mandatory
	
EndGroup

Group WeaponRestrictions
	GlobalVariable Property 	pHeavyRestrictedGlobal 				auto Const mandatory
	{global toggle for weapon power armor restriction}
	
	Keyword Property 			pHeavyWeaponKeyword					auto Const mandatory
	{keyword to detect heavy weapons}
	
	Message Property 			pStrReqMessage						auto const mandatory
	Message Property 			pIntReqMessage						auto const mandatory
	
EndGroup

Group ActorValues
	ActorValue Property 		pStrAV 								auto Const mandatory
	{strength - for heavy weapons restrictions}
	ActorValue Property 		pIntAV 								auto Const mandatory
	{intelligence - for energy weapons restrictions}
	ActorValue Property 		pAgiAV 								auto Const mandatory
	{agility - for casings}
	ActorValue Property 		pLukAV 								auto Const mandatory
	{luck - for casings}
EndGroup


Group PlayerAddItems
	Holotape Property 			pConfigHolo 						auto Const mandatory
	Potion Property 			pAmmoSwapItem 						auto Const mandatory
	Potion Property 			pAmmoSwapItem_Alt					auto Const mandatory
EndGroup

Group PlayerThrownWeapons
	ObjectMod[] Property 		pThrowingMods 						auto Const mandatory
	Weapon[] Property 			pThrowingWeaps 						auto Const mandatory
	Message Property 			pThrownSelectMsg 					auto const mandatory
EndGroup

Group ItemDistribution
	DistributionPreset Property pDistributionPreset_Default			auto Const mandatory
	DistributionPreset Property pDistributionPreset_Rare			auto Const mandatory
	DistributionPreset Property pDistributionPreset_Common			auto Const mandatory
	
	GlobalVariable[] Property	pDistributionGlobals				auto Const mandatory
EndGroup

Group DLCCheckGlobals
	GlobalVariable Property 	pDLCAutomatronFound	 				auto Const mandatory
	GlobalVariable Property 	pDLCFarHarborFound	 				auto Const mandatory
	GlobalVariable Property 	pDLCNukaWorldFound	 				auto Const mandatory
EndGroup

Group ModUpdates
	GlobalVariable Property 	pInstalledModVersion	 			auto Const mandatory
	float Property 				fCurrentModVersion = 1.0 			auto
	Message Property 			pModUpdateMessage					auto Const mandatory
EndGroup



ReferenceAlias Property 		pPlayerAlias						auto Const mandatory
{link to player quest alias}


; formid of MQ102 for new game compatibility
int		iMQ102ID = 		117802			Const
string 	sF4MasterName = "Fallout4.esm"	Const

bool bInitStarted = false
bool bNeedsUpdate = false




Event OnQuestInit()
	InitAmmoTweaksQuest()
EndEvent


Function CheckModUpdate()
	utility.wait(5.0)
	float fOldVersion = pInstalledModVersion.GetValue()
	
	if fCurrentModVersion > fOldVersion
		RunModUpdate(fOldVersion)
		pInstalledModVersion.SetValue(fCurrentModVersion)
		pModUpdateMessage.Show(fCurrentModVersion)
	endIf
EndFunction



; external access to script
AmmoTweaks:SharedDefinitions Function GetScript() Global
	return Game.GetFormFromFile(9905, "AmmoTweaks_Core.esp") as AmmoTweaks:SharedDefinitions
EndFunction


; init
Function InitAmmoTweaksQuest()
	SetStage(10)
	Quest tempMQ102 = Game.GetFormFromFile(iMQ102ID, sF4MasterName) as Quest
	if !(tempMQ102.GetStageDone(4))
		RegisterForRemoteEvent(tempMQ102, "OnStageSet")
	else
		UpdateFormLists()
		MergeNamingRules()
		utility.wait(1.0)
		if !bLLSetupDone
			AddLeveledLists()
		endIf
		utility.wait(1.0)
		if pModInstalledMessage.Show() == 0
			ObjectReference PlayerRef = pPlayerAlias.GetRef()
			PlayerRef.AddItem(pConfigHolo, 1, true)
			PlayerRef.AddItem(pAmmoSwapItem, 1, true)
			PlayerRef.AddItem(pAmmoSwapItem_Alt, 1, true)
		endIf
	endIf
EndFunction


Function UpdateAmmoTweaksQuest()
	CleanUpFormLists()
	utility.wait(1.0)
	UpdateFormLists()
EndFunction

Function CleanUpAmmoTweaksQuest()
	CleanUpFormLists()
EndFunction


Event Quest.OnStageSet(Quest akSenderRef, int auiStageID, int auiItemID)
	if auiStageID >= 4
		if !bInitStarted
			bInitStarted = true
			UpdateFormLists()
			MergeNamingRules()
			utility.wait(1.0)
			if !bLLSetupDone
				AddLeveledLists()
			endIf
			utility.wait(1.0)
			if pModInstalledMessage.Show() == 0
				ObjectReference PlayerRef = pPlayerAlias.GetRef()
				PlayerRef.AddItem(pConfigHolo, 1, true)
				PlayerRef.AddItem(pAmmoSwapItem, 1, true)
				PlayerRef.AddItem(pAmmoSwapItem_Alt, 1, true)
			endIf
		endIf
	else
		if !(akSenderRef.GetStageDone(4))
			RegisterForRemoteEvent(akSenderRef, "OnStageSet")
		endIf
	endIf
EndEvent


; handles updates that require additions to leveled lists or formlists
;	- called from Updater Quest
Function RunModUpdate(float fCurVersion)
	int i = 0
	LeveledItem tempLI
	
	; Add the alternate Swap Ammo item, update Scrounger perk leveled lists with new ammo types
	if fCurVersion < 1.06
		if GetStage() < 10
			SetStage(10)
		endIf
		
		Quest tempMQ102 = Game.GetFormFromFile(iMQ102ID, sF4MasterName) as Quest
		if tempMQ102.GetStageDone(4)
			ObjectReference PlayerRef = pPlayerAlias.GetRef()
			; add alternate ammo swap item
			if PlayerRef.GetItemCount(pAmmoSwapItem_Alt) < 1
				PlayerRef.AddItem(pAmmoSwapItem_Alt, 1, true)
			endIf
		endIf
		
		; add scrounger ammo
		while i < pBaseLLAdd_AmmoUpdate106.length
			tempLI = pBaseLLAdd_AmmoUpdate106[i].liItemBase
			if tempLI as bool
				tempLI.AddForm(pBaseLLAdd_AmmoUpdate106[i].liItemAdd, pBaseLLAdd_AmmoUpdate106[i].iItemAdd_Level, pBaseLLAdd_AmmoUpdate106[i].iItemAdd_Count)
			endIf
			i += 1
		endWhile
	endIf
	
EndFunction


; Adds new projectiles to the TrapExplOnHit list to allow them to destroy traps
Function UpdateFormLists()
	int i = 0
	form tempForm
	
	if pTrapHitList_Custom.GetSize() > 0
		i = 0
		while i < pTrapHitList_Custom.GetSize()
			tempForm = pTrapHitList_Custom.GetAt(i)
			if pTrapHitList_Base.Find(tempForm) < 0
				pTrapHitList_Base.AddForm(tempForm)
			endIf
			i += 1
		endWhile
	endIf
	
	i = 0
	tempForm = none
	
	if pTrapHitList_Custom.GetSize() > 0
		i = 0
		while i < pFatManExplosions_Custom.GetSize()
			tempForm = pFatManExplosions_Custom.GetAt(i)
			if pFatManExplosions_Base.Find(tempForm) < 0
				pFatManExplosions_Base.AddForm(tempForm)
			endIf
			i += 1
		endWhile
	endIf
	
	i = 0
	tempForm = none
	if pHelpMessages.GetSize() > 0
		i = 0
		while i < pHelpMessages.GetSize()
			tempForm = pHelpMessages.GetAt(i)
			if pHelpManualPC.Find(tempForm) < 0
				pHelpManualPC.AddForm(tempForm)
			endIf
			i += 1
		endWhile
	endIf
	
EndFunction

; remove new projectiles from the trap hit list
Function CleanUpFormLists()
	int i = 0
	form tempForm
	i = pTrapHitList_Custom.GetSize() - 1
	while i >= 0
		tempForm = pTrapHitList_Custom.GetAt(i)
		if pTrapHitList_Base.Find(tempForm) > -1
			pTrapHitList_Base.RemoveAddedForm(tempForm)
		endIf
		i -= 1
	endWhile
	
	tempForm = none
	i = pFatManExplosions_Custom.GetSize() - 1
	while i >= 0
		tempForm = pFatManExplosions_Custom.GetAt(i)
		if pFatManExplosions_Base.Find(tempForm) > -1
			pFatManExplosions_Base.RemoveAddedForm(tempForm)
		endIf
		i -= 1
	endWhile
	
	tempForm = none
	i = pHelpMessages.GetSize() - 1
	while i >= 0
		tempForm = pHelpMessages.GetAt(i)
		if pHelpManualPC.Find(tempForm) > -1
			pHelpManualPC.RemoveAddedForm(tempForm)
		endIf
		i -= 1
	endWhile
	
EndFunction


; updates instance naming rules to include weapon name additions
Function MergeNamingRules()
	int iMenuVar = pMsgNamingRules.Show()
	if Game.IsPluginInstalled("ValdacilsItemSorting-Weapons.esp")
		if iMenuVar == 0
			; Full
			pNamingRules_BaseGun.MergeWith(pNamingRules_GunCaliberVIS)
			pNamingRules_BaseGun.MergeWith(pNamingRules_GunConditionVIS)
			pNamingRules_BaseMelee.MergeWith(pNamingRules_MeleeConditionVIS)
		elseif iMenuVar == 1
			; Guns Only
			pNamingRules_BaseGun.MergeWith(pNamingRules_GunCaliberVIS)
			pNamingRules_BaseGun.MergeWith(pNamingRules_GunConditionVIS)
		elseif iMenuVar == 2
			; Gun Calibers Only
			pNamingRules_BaseGun.MergeWith(pNamingRules_GunCaliberVIS)
		elseif iMenuVar == 3
			; Gun Condition Only
			pNamingRules_BaseGun.MergeWith(pNamingRules_GunConditionVIS)
		elseif iMenuVar == 4
			; Melee Condition Only
			pNamingRules_BaseMelee.MergeWith(pNamingRules_MeleeConditionVIS)
		elseif iMenuVar == 5
			; All Condition Only
			pNamingRules_BaseGun.MergeWith(pNamingRules_GunConditionVIS)
			pNamingRules_BaseMelee.MergeWith(pNamingRules_MeleeConditionVIS)
		endIf
	else
		if iMenuVar == 0
			; Full
			pNamingRules_BaseGun.MergeWith(pNamingRules_GunCaliber)
			pNamingRules_BaseGun.MergeWith(pNamingRules_GunCondition)
			pNamingRules_BaseMelee.MergeWith(pNamingRules_MeleeCondition)
		elseif iMenuVar == 1
			; Guns Only
			pNamingRules_BaseGun.MergeWith(pNamingRules_GunCaliber)
			pNamingRules_BaseGun.MergeWith(pNamingRules_GunCondition)
		elseif iMenuVar == 2
			; Gun Calibers Only
			pNamingRules_BaseGun.MergeWith(pNamingRules_GunCaliber)
		elseif iMenuVar == 3
			; Gun Condition Only
			pNamingRules_BaseGun.MergeWith(pNamingRules_GunCondition)
		elseif iMenuVar == 4
			; Melee Condition Only
			pNamingRules_BaseMelee.MergeWith(pNamingRules_MeleeCondition)
		elseif iMenuVar == 5
			; All Condition Only
			pNamingRules_BaseGun.MergeWith(pNamingRules_GunCondition)
			pNamingRules_BaseMelee.MergeWith(pNamingRules_MeleeCondition)
		endIf
	endIf
EndFunction


; adds new ammo and items to leveled lists
Function AddLeveledLists()
	LeveledItem tempLI = none
	int i = 0
	bool bAddAmmo = false
	bool bHasAutomatron = Game.IsPluginInstalled("DLCRobot.esm")
	bool bHasFarHarbor = Game.IsPluginInstalled("DLCCoast.esm")
	bool bHasNukaWorld = Game.IsPluginInstalled("DLCNukaWorld.esm")
	
	bLLSetupDone = true
	
	if bHasAutomatron
		pDLCAutomatronFound.SetValue(1.0)
	endIf
	
	; ammo: 45-70 - check for DLC, ask user whether or not to enable custom type
	if bHasFarHarbor
		pDLCFarHarborFound.SetValue(1.0)
		bAddAmmo = true
	else
		if pMsgEnable4570Ammo.Show() == 0
			bAddAmmo = true
		endIf
	endIf
	
	if bAddAmmo
		pUse4570Ammo.SetValue(1.0)
		if pBaseLLAdd_Ammo4570.length > 0
			while i < pBaseLLAdd_Ammo4570.length
				tempLI = pBaseLLAdd_Ammo4570[i].liItemBase
				if tempLI as bool
					tempLI.AddForm(pBaseLLAdd_Ammo4570[i].liItemAdd, pBaseLLAdd_Ammo4570[i].iItemAdd_Level, pBaseLLAdd_Ammo4570[i].iItemAdd_Count)
				endIf
				i += 1
			endWhile
		endIf
	endIf
	
	; ammo: 7.62x39 - check for DLC, ask user whether or not to enable custom type
	bAddAmmo = false
	if bHasNukaWorld
		pDLCNukaWorldFound.SetValue(1.0)
		bAddAmmo = true
	else
		if pMsgEnable762x39Ammo.Show() == 0
			bAddAmmo = true
		endIf
	endIf
	
	if bAddAmmo
		pUse762x39Ammo.SetValue(1.0)
		if pBaseLLAdd_Ammo762x39.length > 0
			while i < pBaseLLAdd_Ammo762x39.length
				tempLI = pBaseLLAdd_Ammo762x39[i].liItemBase
				if tempLI as bool
					tempLI.AddForm(pBaseLLAdd_Ammo762x39[i].liItemAdd, pBaseLLAdd_Ammo762x39[i].iItemAdd_Level, pBaseLLAdd_Ammo762x39[i].iItemAdd_Count)
				endIf
				i += 1
			endWhile
		endIf
	endIf
	
	; items (shipments, ammo boxes)
	if pBaseLLAdd_Items.length > 0
		tempLI = none
		i = 0
		while i < pBaseLLAdd_Items.length
			tempLI = pBaseLLAdd_Items[i].liItemBase
			if tempLI as bool
				tempLI.AddForm(pBaseLLAdd_Items[i].liItemAdd, pBaseLLAdd_Items[i].iItemAdd_Level, pBaseLLAdd_Items[i].iItemAdd_Count)
			endIf
			i += 1
		endWhile
	endIf
	
	; thrown weapons
	if pMsgAddThrownWeaps.Show() == 0
		if pBaseLLAdd_Thrown.length > 0
			tempLI = none
			i = 0
			while i < pBaseLLAdd_Thrown.length
				tempLI = pBaseLLAdd_Thrown[i].liItemBase
				if tempLI as bool
					tempLI.AddForm(pBaseLLAdd_Thrown[i].liItemAdd, pBaseLLAdd_Thrown[i].iItemAdd_Level, pBaseLLAdd_Thrown[i].iItemAdd_Count)
				endIf
				i += 1
			endWhile
		endIf
		
		if bHasFarHarbor
			if pBaseLLAdd_ThrownFH.length > 0
				tempLI = none
				i = 0
				while i < pBaseLLAdd_ThrownFH.length
					tempLI = pBaseLLAdd_ThrownFH[i].liItemBase
					if tempLI as bool
						tempLI.AddForm(pBaseLLAdd_ThrownFH[i].liItemAdd, pBaseLLAdd_ThrownFH[i].iItemAdd_Level, pBaseLLAdd_ThrownFH[i].iItemAdd_Count)
					endIf
					i += 1
				endWhile
			endIf
		endIf
	endIf
	
	; dlc weapons -> commonwealth
	if bHasFarHarbor
		if pMsgAddDLCWeapsFH.Show() == 0
			if pBaseLLAdd_DLCFHWeapons.length > 0
				tempLI = none
				i = 0
				while i < pBaseLLAdd_DLCFHWeapons.length
					if Game.IsPluginInstalled(pBaseLLAdd_DLCFHWeapons[i].sPluginName_Base)
						tempLI = Game.GetFormFromFile(pBaseLLAdd_DLCFHWeapons[i].iFormIndex_Base, pBaseLLAdd_DLCFHWeapons[i].sPluginName_Base) as LeveledItem
						if tempLI as bool
							pBaseLLAdd_DLCFHWeapons[i].liItemAdd.AddForm(tempLI, pBaseLLAdd_DLCFHWeapons[i].iItemAdd_Level, pBaseLLAdd_DLCFHWeapons[i].iItemAdd_Count)
						endIf
					endIf
					i += 1
				endWhile
			endIf
		endIf
	endIf
	
	if bHasNukaWorld
		if pMsgAddDLCWeapsNW.Show() == 0
			if pBaseLLAdd_DLCNWWeapons.length > 0
				tempLI = none
				i = 0
				while i < pBaseLLAdd_DLCNWWeapons.length
					if Game.IsPluginInstalled(pBaseLLAdd_DLCNWWeapons[i].sPluginName_Base)
						tempLI = Game.GetFormFromFile(pBaseLLAdd_DLCNWWeapons[i].iFormIndex_Base, pBaseLLAdd_DLCNWWeapons[i].sPluginName_Base) as LeveledItem
						if tempLI as bool
							pBaseLLAdd_DLCNWWeapons[i].liItemAdd.AddForm(tempLI, pBaseLLAdd_DLCNWWeapons[i].iItemAdd_Level, pBaseLLAdd_DLCNWWeapons[i].iItemAdd_Count)
						endIf
					endIf
					i += 1
				endWhile
			endIf
		endIf
	endIf
	
EndFunction


; removes all script-added items from leveled lists ***affects other mods***
Function CleanLeveledLists()
	
EndFunction


; returns a float value of 0.05 per perk found based on iIndex
float Function GetPerkPercentage(int iIndex)
	float fPerc = 0.0
	
	if iIndex > 0
		int i = 0
		Actor PlayerActor = pPlayerAlias.GetRef() as Actor
		
		If iIndex == 1
			; Gun Nut
			while i < pGunNutPerks.length
				if PlayerActor.HasPerk(pGunNutPerks[i])
					fPerc += 0.05
				endIf
				i += 1
			endWhile
		elseIf iIndex == 2
			; Science!
			while i < pSciencePerks.length
				if PlayerActor.HasPerk(pSciencePerks[i])
					fPerc += 0.05
				endIf
				i += 1
			endWhile
		else
			; Blacksmith
			while i < pBlacksmithPerks.length
				if PlayerActor.HasPerk(pBlacksmithPerks[i])
					fPerc += 0.05
				endIf
				i += 1
			endWhile
		endIf
	endIf
	
	return fPerc
EndFunction


; Throwing Weapons
ObjectMod Function GetNextAvailableThrownMod(Actor tempActor, Weapon curWeap)
	ObjectMod tempMod = none
	bool bFound = false
	
	if curWeap == none
		int iMenuVar = pThrownSelectMsg.Show()
		if iMenuVar > 0
			tempMod = pThrowingMods[iMenuVar]
			bFound = true
		endIf
	else
		int iStart = pThrowingWeaps.Find(curWeap)
		int i = iStart + 1
		while i < pThrowingWeaps.length
			if tempActor.GetItemCount(pThrowingWeaps[i]) > 0
				bFound = true
				tempMod = pThrowingMods[i]
				i = pThrowingWeaps.length
			endIf
			i += 1
		endWhile
		
		if !bFound
			i = 0
			while i < iStart
				if tempActor.GetItemCount(pThrowingWeaps[i]) > 0
					bFound = true
					tempMod = pThrowingMods[i]
					i = pThrowingWeaps.length
				endIf
				i += 1
			endWhile
		endIf
	
		if !bFound
			tempMod = pThrowingMods[0]
		endIf
	endIf
	return tempMod
EndFunction



; for ChanceNone values (100-x)
Function Menu_EditPercentage(Message tempMessage, GlobalVariable tempGlobal, float fMaxVal=100.0)
	float fCurChance = 100.0 - tempGlobal.GetValue()
	float fNewChance = fCurChance
	int iMenuVar = tempMessage.Show(fCurChance)
	
	while iMenuVar < 4
		if iMenuVar == 0
			if fNewChance < fMaxVal
				fNewChance += 1.0
			else
				fNewChance = fMaxVal
			endIf
			
		elseif iMenuVar == 1
			if fNewChance > 0.0
				fNewChance -= 1.0
			else
				fNewChance = 0.0
			endIf
		
		elseif iMenuVar == 2
			if fNewChance <= (fMaxVal * 0.5)
				fNewChance *= 2.0
			else
				fNewChance = (fMaxVal * 0.5)
			endIf
			
		elseif iMenuVar == 3
			if fNewChance > 1.0
				fNewChance *= 0.5
			else
				fNewChance = 0.0
			endIf
		endIf
		iMenuVar = tempMessage.Show(fNewChance)
	endWhile
	
	if fCurChance != fNewChance
		tempGlobal.SetValue(100.0 - fNewChance)
	endIf
EndFunction


Function Menu_EditNumber(Message tempMessage, GlobalVariable tempGlobal, float fMaxVal=100.0, float fMinVal=0.0)
	float fCurChance = 100.0 - tempGlobal.GetValue()
	float fNewChance = fCurChance
	int iMenuVar = tempMessage.Show(fCurChance)
	
	while iMenuVar < 4
		if iMenuVar == 0
			if fNewChance < fMaxVal
				fNewChance += 1.0
			else
				fNewChance = fMaxVal
			endIf
			
		elseif iMenuVar == 1
			if fNewChance > fMinVal
				fNewChance -= 1.0
			else
				fNewChance = fMinVal
			endIf
		
		elseif iMenuVar == 2
			if fNewChance <= (fMaxVal * 0.5)
				fNewChance *= 2.0
			else
				fNewChance = (fMaxVal * 0.5)
			endIf
			
		elseif iMenuVar == 3
			if fNewChance > (fMinVal * 2.0) + 1.0
				fNewChance *= 0.5
			else
				fNewChance = fMinVal
			endIf
		endIf
		iMenuVar = tempMessage.Show(fNewChance)
	endWhile
	
	if fCurChance != fNewChance
		tempGlobal.SetValue(fNewChance)
	endIf
EndFunction


Function SetItemDistributionPreset(int iPreset)
	DistributionPreset tempPreset
	if iPreset == 0
		tempPreset = pDistributionPreset_Rare
	elseif iPreset == 1
		tempPreset = pDistributionPreset_Default
	else
		tempPreset = pDistributionPreset_Common
	endIf
	
	; ammo
	pDistributionGlobals[0].SetValue(tempPreset.fChanceNone_AmmoVeryCommon)
	pDistributionGlobals[1].SetValue(tempPreset.fChanceNone_AmmoCommon)
	pDistributionGlobals[2].SetValue(tempPreset.fChanceNone_AmmoUncommon)
	pDistributionGlobals[3].SetValue(tempPreset.fChanceNone_AmmoRare)
	pDistributionGlobals[4].SetValue(tempPreset.fChanceNone_AmmoVeryRare)
	pDistributionGlobals[5].SetValue(tempPreset.fChanceNone_AmmoUltraRare)
	; ammo boxes
	pDistributionGlobals[6].SetValue(tempPreset.fChanceNone_AmmoBoxCommon)
	pDistributionGlobals[7].SetValue(tempPreset.fChanceNone_AmmoBoxRare)
	pDistributionGlobals[8].SetValue(tempPreset.fChanceNone_AmmoBoxVeryRare)
	; shipments
	pDistributionGlobals[9].SetValue(tempPreset.fChanceNone_ShipmentCommon)
	pDistributionGlobals[10].SetValue(tempPreset.fChanceNone_ShipmentRare)
	pDistributionGlobals[11].SetValue(tempPreset.fChanceNone_ShipmentVeryRare)
EndFunction
