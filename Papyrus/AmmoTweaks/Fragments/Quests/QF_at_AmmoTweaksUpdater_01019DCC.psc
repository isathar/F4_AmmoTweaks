;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname AmmoTweaks:Fragments:quests:QF_at_AmmoTweaksUpdater_01019DCC Extends Quest Hidden Const

;BEGIN FRAGMENT Fragment_Stage_0000_Item_00
Function Fragment_Stage_0000_Item_00()
;BEGIN CODE
utility.wait(30.0)
float fCurVersion = pVersionGlobal.GetValue()
if fCurVersion < fNewVersion
    pUpdateMsg.Show(fNewVersion)
    pSharedDefs.RunModUpdate(fCurVersion)
    pVersionGlobal.SetValue(fNewVersion)
endIf
Stop()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Float Property fNewVersion = 1.0 Auto Const Mandatory
{version to update to}

GlobalVariable Property pVersionGlobal Auto Const Mandatory
{global holding current version}

Message Property pUpdateMsg Auto Const Mandatory
{message to show}

AmmoTweaks:SharedDefinitions Property pSharedDefs Auto Const Mandatory
{ammotweaks quest shared}
