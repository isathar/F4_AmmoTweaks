scriptname AmmoTweaks:ATHUDManagerScript extends Quest
{handles ammotype + condition hud elements}


;/hud widget properties/;
Group HudWidget
	string Property 			sHUDWidgetID = 		"AmmoTweaks/CNDHUD.swf" auto const
	float Property 				fHUDWidgetTX = 		998.0 	auto const
	float Property 				fHUDWidgetTY = 		560.0 	auto const
	float Property 				fHUDWidgetTX_PA = 	1024.0 	auto const
	float Property 				fHUDWidgetTY_PA = 	420.0 	auto const
	float Property 				fHUDWidgetTScale = 	1.0 	auto
	
	float Property 				fHUDWidgetTXMod = 	0.0 	auto hidden
	float Property 				fHUDWidgetTYMod = 	0.0 	auto hidden
	float Property 				fHUDWidgetTXMod_PA = 0.0 	auto hidden
	float Property 				fHUDWidgetTYMod_PA = 0.0 auto hidden
	bool Property 				bHUDWidgetLoaded = 	false 	auto hidden
	bool Property 				bHUDWidgetVisible = false 	auto hidden
EndGroup

Group HUDKeywords
	Keyword Property 			isPowerArmorFrame 		auto const mandatory
	Keyword Property 			pHasItemCondition 		auto const mandatory
	Keyword Property 			pHasAmmoType 			auto const mandatory
EndGroup

Group HUDSettings
	GlobalVariable Property 	pToggleHUDGlobal 		auto const mandatory
	{toggle for hud widgets}
	GlobalVariable Property 	pToggleHUDCNDGlobal 	auto const mandatory
	{toggle for CND widget 0=off,1=bar,2=icon,3=bar+icon}
	GlobalVariable Property 	pToggleHUDATGlobal 		auto const mandatory
	{toggle for AmmoType widget 0=off,1=text}
	GlobalVariable Property		pHUDRefreshTime			auto const mandatory
	{time between hud updates}
	GlobalVariable Property		pHUDHideTime			auto const mandatory
	{time to wait before hiding the widget}
	
	GlobalVariable Property		pWeapConditionToggle 	auto const mandatory
	{holds condition system enabled status}
EndGroup

ReferenceAlias Property 		pPlayerAlias 			auto const mandatory


;/command ID for ammo type/;
int 	iWidgetCommand_AT = 		1 		const
;/command ID for condition bar/;
int 	iWidgetCommand_CND = 		2 		const
;/command ID for condition icon/;
int 	iWidgetCommand_Icon = 		3 		const

;/widget update timer/;
int 	iTimerID_HUD = 				8 		const
float	fTimerTime_HUD = 			1.0

;/time of inactivity before hiding widget/;
float 	fTimeToHideHUD = 			10.0
;/time since last update/;
float 	fAccumulatedTime = 			0.0

;/update values/;
bool 	bForceCNDUpdate = 			false
bool 	bForceATUpdate = 			false
int 	iCNDFrame_Cur = 			25
int 	iCNDFrame_Last = 			-1
int 	iCNDIcon_Cur = 				4
int 	iCNDIcon_Last = 			-1
string 	sHUDAmmoType_Cur = 			" "
string 	sHUDAmmoType_Last = 		"  "

;/cached visibility toggles/;
bool 	bUseCondIcon = 				false
bool 	bUseATIcon = 				false
bool 	bToggleHUDShowCND = 		true
bool 	bToggleHUDShowAT = 			true
bool 	bUsePowerArmorHUD = 		false
bool 	bPowerArmorHUDOn = 			false
bool 	bWeaponHasCondition = 		false
bool 	bWeaponHasAmmoMod = 		false

;/ ref to hud /;
HUDFramework hud = none


;/******** Events /;

;/quest init/;
Event OnInit()
	utility.wait(5.0)
	if Game.IsPluginInstalled("HUDFramework.esm")
		EvaluateHUDConfig()
		if (hud as bool)
			debug.notification("hud quest resuming")
		else
			debug.notification("hud quest initializing")
			InitHUDWidgets()
		endIf
	endIf
EndEvent


; HUD Tick - increments fAccumulatedTime, updates widget
Event OnTimer(int aiTimerID)
	if (hud as bool)
		if aiTimerID == iTimerID_HUD
			if hud.IsWidgetRegistered(sHUDWidgetID)
				bool bUpdate = false
				bUsePowerArmorHUD = (pPlayerAlias.GetRef() as Actor).WornHasKeyword(isPowerArmorFrame)
				if bPowerArmorHUDOn != bUsePowerArmorHUD
					TogglePowerArmorHUD(bUsePowerArmorHUD)
				endIf
				
				if bForceATUpdate
					bForceATUpdate = false
					bUpdate = true
					if bToggleHUDShowAT && bWeaponHasAmmoMod
						if sHUDAmmoType_Cur != sHUDAmmoType_Last
							hud.SendMessageString(sHUDWidgetID, (iWidgetCommand_AT as string), sHUDAmmoType_Cur, abReplaceExisting = false)
							sHUDAmmoType_Last = sHUDAmmoType_Cur
						endIf
					else
						if sHUDAmmoType_Cur != " "
							hud.SendMessageString(sHUDWidgetID, (iWidgetCommand_AT as string), " ", abReplaceExisting = false)
							sHUDAmmoType_Last = " "
						endIf
					endIf
				endIf
				
				if bForceCNDUpdate
					bForceCNDUpdate = false
					bUpdate = true
					if bToggleHUDShowCND && bWeaponHasCondition
						if bUseCondIcon || bUsePowerArmorHUD
							if ((iCNDFrame_Cur != iCNDFrame_Last) || (iCNDIcon_Cur != iCNDIcon_Last))
								hud.SendMessage(sHUDWidgetID, iWidgetCommand_Icon, iCNDFrame_Cur, iCNDIcon_Cur)
								iCNDFrame_Last = iCNDFrame_Cur
							endIf
						else
							if iCNDFrame_Cur != iCNDFrame_Last
								hud.SendMessage(sHUDWidgetID, iWidgetCommand_CND, iCNDFrame_Cur)
								iCNDFrame_Last = iCNDFrame_Cur
							endIf
						endIf
					else
						if (iCNDFrame_Last != 25)
							hud.SendMessage(sHUDWidgetID, iWidgetCommand_Icon, 25, iCNDIcon_Cur)
							iCNDFrame_Last = 25
						endIf
					endIf
				endIf
				
				fAccumulatedTime += fTimerTime_HUD
				if bUpdate || (fTimeToHideHUD <= 0.0)
					ToggleHUDWidgetVisible(true)
				else
					if !((pPlayerAlias.GetRef() as Actor).IsWeaponDrawn())
						fAccumulatedTime = fTimeToHideHUD
					endIf
					
					if fAccumulatedTime >= fTimeToHideHUD
						ToggleHUDWidgetVisible(false)
					endIf
					
				endIf
				
			endIf
			StartTimer(fTimerTime_HUD, iTimerID_HUD)
		endIf
	endIf
EndEvent


; toggles hud style when entering power armor, widget visibility on weapon equip
Event Actor.OnItemEquipped(Actor akSender, Form akBaseObject, ObjectReference akReference)  
	if (hud as bool)
		if akBaseObject as Weapon
			If akSender.WornHasKeyword(pHasItemCondition)
				bWeaponHasCondition = true
			else
				bWeaponHasCondition = false
			endIf
			
			If akSender.WornHasKeyword(pHasAmmoType)
				bWeaponHasAmmoMod = true
			else
				bWeaponHasAmmoMod = false
			endIf
		endIf
		RegisterForRemoteEvent((pPlayerAlias.GetRef() as Actor), "OnItemEquipped")
	endIf
EndEvent



bool Function IsHUDEnabled()
	return (hud as bool)
EndFunction


Function EvaluateHUDConfig()
	float tempVal = pWeapConditionToggle.GetValue()
	if tempVal < 1.0
		bToggleHUDShowCND = false
	elseif tempVal < 2.0
		bToggleHUDShowCND = true
		bUseCondIcon = false
	else
		bToggleHUDShowCND = true
		bUseCondIcon = true
	endIf
	
	tempVal = pToggleHUDATGlobal.GetValue()
	if tempVal < 1.0
		bToggleHUDShowAT = false
	elseif tempVal < 2.0
		bToggleHUDShowAT = true
		bUseATIcon = false
	else
		bToggleHUDShowAT = true
		bUseATIcon = true
	endIf
	
	fTimerTime_HUD = Math.Max(0.5, pHUDRefreshTime.GetValue())
	fTimeToHideHUD = pHUDHideTime.GetValue()
	
	bWeaponHasCondition = (pPlayerAlias.GetRef() as Actor).WornHasKeyword(pHasItemCondition)
	bWeaponHasAmmoMod = (pPlayerAlias.GetRef() as Actor).WornHasKeyword(pHasAmmoType)
EndFunction


Function TogglePowerArmorHUD(bool bToggle)
	if (hud as bool)
		if bToggle
			hud.SetWidgetPosition(sHUDWidgetID, (fHUDWidgetTX_PA + fHUDWidgetTXMod_PA), (fHUDWidgetTY_PA + fHUDWidgetTYMod_PA))
		else
			hud.SetWidgetPosition(sHUDWidgetID, (fHUDWidgetTX + fHUDWidgetTXMod), (fHUDWidgetTY + fHUDWidgetTYMod))
		endIf
		bPowerArmorHUDOn = bToggle
	endIf
EndFunction


; registers and loads widgets
Function InitHUDWidgets()
	if !(hud as bool)
		hud = HUDFramework.GetInstance()
		
		if (hud as bool)
			pToggleHUDGlobal.SetValue(1.0)
			bHUDWidgetVisible = false
			bHUDWidgetLoaded = false
			fAccumulatedTime = 0.0
			
			if !(hud.IsWidgetRegistered(sHUDWidgetID))
				hud.RegisterWidget(Self, sHUDWidgetID, afX = fHUDWidgetTX, afY = fHUDWidgetTY, abLoadNow = True, abAutoLoad = True)
			endIf
			
			RegisterForRemoteEvent((pPlayerAlias.GetRef() as Actor), "OnItemEquipped")
			
			StartTimer(fTimerTime_HUD, iTimerID_HUD)
		endif
	endIf
EndFunction


; unloads and unregisters widgets
Function RemoveHUDWidgets()
	pToggleHUDGlobal.SetValue(0.0)
	if (hud as bool)
		CancelTimer(iTimerID_HUD)
		
		if (hud.IsWidgetRegistered(sHUDWidgetID))
			hud.UnregisterWidget(sHUDWidgetID)
		endIf
		
		bHUDWidgetLoaded = false
		
		UnregisterForRemoteEvent((pPlayerAlias.GetRef() as Actor), "OnItemEquipped")
		
		hud = none
	endIf
EndFunction


; widget load event
Function HUD_WidgetLoaded(string asWidgetID)
	debug.notification(asWidgetID + " loaded")
	if asWidgetID == sHUDWidgetID
		bHUDWidgetLoaded = true
		bHUDWidgetVisible = false
		hud.SetWidgetOpacity(sHUDWidgetID, 0.0)
		hud.SendMessageString(sHUDWidgetID, (iWidgetCommand_AT as string), sHUDAmmoType_Cur, abReplaceExisting = false)
		if bUseCondIcon
			hud.SendMessage(sHUDWidgetID, iWidgetCommand_Icon, iCNDFrame_Cur, iCNDIcon_Cur)
		else
			hud.SendMessage(sHUDWidgetID, iWidgetCommand_CND, iCNDFrame_Cur)
		endIf
	endIf
EndFunction


; updates condition bar/text
bool Function UpdateConditionWidget(float fCurCond=0.0, float fMaxcond=1.0)
	bool bRetVal = false
	if (hud as bool)
		if bHUDWidgetLoaded
			int iFrame = 25
			if fMaxcond > 0.0
				iFrame = Math.Max(1.0, Math.Min(25.0, ((fCurCond / fMaxcond) * 20.0))) as int
			endIf
			
			iCNDFrame_Cur = iFrame
			bForceCNDUpdate = true
			fAccumulatedTime = 0.0
			bRetVal = true
		endIf
	endIf
	return bRetVal
EndFunction


; updates ammotype text
bool Function UpdateATWidget(string sAmmoType=" ")
	bool bRetVal = false
	if (hud as bool)
		if bHUDWidgetLoaded
			sHUDAmmoType_Cur = sAmmoType
			bForceATUpdate = true
			fAccumulatedTime = 0.0
			bRetVal = true
		endIf
	endIf
	return bRetVal
EndFunction


Function ToggleHudWidgets(bool bToggle)
	if bToggle
		InitHUDWidgets()
	else
		RemoveHUDWidgets()
	endIf
EndFunction


Function ToggleHUDWidgetVisible(bool bToggle)
	if bToggle != bHUDWidgetVisible
		hud.SetWidgetOpacity(sHUDWidgetID, bToggle as float)
		bHUDWidgetVisible = bToggle
	endIf
EndFunction


Function SwitchConditionDispMode(int iMode = 0)
	pToggleHUDCNDGlobal.SetValue(iMode)
	if iMode == 0
		bToggleHUDShowCND = false
		bUseCondIcon = false
		iCNDFrame_Cur = 25
		bForceCNDUpdate = true
	elseif iMode == 1
		; standard
		bToggleHUDShowCND = true
		bUseCondIcon = false
		bForceATUpdate = true
	elseif iMode == 2
		; icon
		bToggleHUDShowCND = true
		bUseCondIcon = true
		bForceATUpdate = true
	endIf
EndFunction


Function SwitchAmmoTypeDispMode(int iMode = 0)
	pToggleHUDATGlobal.SetValue(iMode)
	if iMode == 0
		bToggleHUDShowAT = false
		bUseATIcon = false
		sHUDAmmoType_Cur = " "
		bForceATUpdate = true
	elseif iMode == 1
		; standard
		bToggleHUDShowAT = true
		bUseATIcon = false
		bForceATUpdate = true
	elseif iMode == 2
		; icon
		bToggleHUDShowAT = true
		bUseATIcon = true
		bForceATUpdate = true
	endIf
EndFunction


Function SetWidgetRefreshTime(float fNewTime)
	float fOldTime = pHUDRefreshTime.GetValue()
	if fOldTime != fNewTime
		fTimerTime_HUD = fNewTime
		pHUDRefreshTime.SetValue(fNewTime)
	endIf
EndFunction


Function SetWidgetHideTime(float fNewTime)
	float fOldTime = pHUDHideTime.GetValue()
	if fOldTime != fNewTime
		fTimeToHideHUD = fNewTime
		pHUDHideTime.SetValue(fNewTime)
	endIf
EndFunction


; widget translation
Function MoveHUDWidget(float fTransX = 0.0, float fTransY = 0.0)
	float fTmpX = Math.Max(0.0, (fHUDWidgetTX + fTransX))
	float fTmpY = Math.Max(0.0, (fHUDWidgetTY + fTransY))
	fHUDWidgetTXMod = fTmpX
	fHUDWidgetTYMod = fTmpY
	hud.SetWidgetPosition(sHUDWidgetID, fTmpX, fTmpY)
EndFunction


; widget scale
Function ScaleHUDWidget(float fScale = 1.0)
	float fTmpScale = Math.Max(0.05, fScale)
	fHUDWidgetTScale = fScale
	hud.SetWidgetScale(sHUDWidgetID, fScale, fScale)
EndFunction

