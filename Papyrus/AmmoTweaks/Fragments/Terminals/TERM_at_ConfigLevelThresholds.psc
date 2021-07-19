;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname AmmoTweaks:Fragments:Terminals:TERM_at_ConfigLevelThresholds Extends Terminal Hidden Const

;BEGIN FRAGMENT Fragment_Terminal_01
Function Fragment_Terminal_01(ObjectReference akTerminalRef)
;BEGIN CODE
pSharedDefs.Menu_EditNumber(pEditMsg, pThresholdLvl1, (pThresholdLvl2.GetValue() - 1.0), 0.0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_02
Function Fragment_Terminal_02(ObjectReference akTerminalRef)
;BEGIN CODE
pSharedDefs.Menu_EditNumber(pEditMsg, pThresholdLvl2, (pThresholdLvl3.GetValue() - 1.0), pThresholdLvl1.GetValue())
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_03
Function Fragment_Terminal_03(ObjectReference akTerminalRef)
;BEGIN CODE
pSharedDefs.Menu_EditNumber(pEditMsg, pThresholdLvl3, (pThresholdLvl4.GetValue() - 1.0), pThresholdLvl2.GetValue())
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_04
Function Fragment_Terminal_04(ObjectReference akTerminalRef)
;BEGIN CODE
pSharedDefs.Menu_EditNumber(pEditMsg, pThresholdLvl4, 999999.0, pThresholdLvl3.GetValue())
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_05
Function Fragment_Terminal_05(ObjectReference akTerminalRef)
;BEGIN CODE
pThresholdLvl1.SetValue(2500)
pThresholdLvl2.SetValue(8000)
pThresholdLvl3.SetValue(16000)
pThresholdLvl4.SetValue(35000)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

AmmoTweaks:SharedDefinitions Property pSharedDefs Auto Const Mandatory

GlobalVariable Property pThresholdLvl1 Auto Const Mandatory

GlobalVariable Property pThresholdLvl2 Auto Const Mandatory

GlobalVariable Property pThresholdLvl3 Auto Const Mandatory

GlobalVariable Property pThresholdLvl4 Auto Const Mandatory

Message Property pEditMsg Auto Const Mandatory
