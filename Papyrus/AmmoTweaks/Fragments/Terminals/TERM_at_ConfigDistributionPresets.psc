;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname AmmoTweaks:Fragments:Terminals:TERM_at_ConfigDistributionPresets Extends Terminal Hidden Const

;BEGIN FRAGMENT Fragment_Terminal_01
Function Fragment_Terminal_01(ObjectReference akTerminalRef)
;BEGIN CODE
pSharedDefs.SetItemDistributionPreset(0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_02
Function Fragment_Terminal_02(ObjectReference akTerminalRef)
;BEGIN CODE
pSharedDefs.SetItemDistributionPreset(1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_03
Function Fragment_Terminal_03(ObjectReference akTerminalRef)
;BEGIN CODE
pSharedDefs.SetItemDistributionPreset(2)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

AmmoTweaks:SharedDefinitions Property pSharedDefs Auto Const Mandatory
