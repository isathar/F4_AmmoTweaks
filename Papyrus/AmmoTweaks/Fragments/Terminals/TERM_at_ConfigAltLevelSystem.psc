;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname AmmoTweaks:Fragments:Terminals:TERM_at_ConfigAltLevelSystem Extends Terminal Hidden Const

;BEGIN FRAGMENT Fragment_Terminal_01
Function Fragment_Terminal_01(ObjectReference akTerminalRef)
;BEGIN CODE
float fTmpLvl = 1.0
float fCurXP = pBallisticXP.GetValue()
float fCurThreshold = pThresholdL1.GetValue()

if fCurXP >= pThresholdL4.GetValue()
	fTmpLvl = 5.0
	fCurThreshold = 999999.9
elseif fCurXP >= pThresholdL3.GetValue()
	fTmpLvl = 4.0
	fCurThreshold = pThresholdL4.GetValue()
elseif fCurXP >= pThresholdL2.GetValue()
	fTmpLvl = 3.0
	fCurThreshold = pThresholdL3.GetValue()
elseif fCurXP >= pThresholdL1.GetValue()
	fTmpLvl = 2.0
	fCurThreshold = pThresholdL2.GetValue()
endIf

pXPShowMsg.Show(fCurXP, fCurThreshold, fTmpLvl)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_02
Function Fragment_Terminal_02(ObjectReference akTerminalRef)
;BEGIN CODE
float fTmpLvl = 1.0
float fCurXP = pEnergyXP.GetValue()
float fCurThreshold = pThresholdL1.GetValue()

if fCurXP >= pThresholdL4.GetValue()
	fTmpLvl = 5.0
	fCurThreshold = 999999.9
elseif fCurXP >= pThresholdL3.GetValue()
	fTmpLvl = 4.0
	fCurThreshold = pThresholdL4.GetValue()
elseif fCurXP >= pThresholdL2.GetValue()
	fTmpLvl = 3.0
	fCurThreshold = pThresholdL3.GetValue()
elseif fCurXP >= pThresholdL1.GetValue()
	fTmpLvl = 2.0
	fCurThreshold = pThresholdL2.GetValue()
endIf

pXPShowMsg.Show(fCurXP, fCurThreshold, fTmpLvl)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_03
Function Fragment_Terminal_03(ObjectReference akTerminalRef)
;BEGIN CODE
float fTmpLvl = 1.0
float fCurXP = pExplosivesXP.GetValue()
float fCurThreshold = pThresholdL1.GetValue()

if fCurXP >= pThresholdL4.GetValue()
	fTmpLvl = 5.0
	fCurThreshold = 999999.9
elseif fCurXP >= pThresholdL3.GetValue()
	fTmpLvl = 4.0
	fCurThreshold = pThresholdL4.GetValue()
elseif fCurXP >= pThresholdL2.GetValue()
	fTmpLvl = 3.0
	fCurThreshold = pThresholdL3.GetValue()
elseif fCurXP >= pThresholdL1.GetValue()
	fTmpLvl = 2.0
	fCurThreshold = pThresholdL2.GetValue()
endIf

pXPShowMsg.Show(fCurXP, fCurThreshold, fTmpLvl)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_04
Function Fragment_Terminal_04(ObjectReference akTerminalRef)
;BEGIN CODE
float fTmpLvl = 1.0
float fCurXP = pChemicalXP.GetValue()
float fCurThreshold = pThresholdL1.GetValue()

if fCurXP >= pThresholdL4.GetValue()
	fTmpLvl = 5.0
	fCurThreshold = 999999.9
elseif fCurXP >= pThresholdL3.GetValue()
	fTmpLvl = 4.0
	fCurThreshold = pThresholdL4.GetValue()
elseif fCurXP >= pThresholdL2.GetValue()
	fTmpLvl = 3.0
	fCurThreshold = pThresholdL3.GetValue()
elseif fCurXP >= pThresholdL1.GetValue()
	fTmpLvl = 2.0
	fCurThreshold = pThresholdL2.GetValue()
endIf

pXPShowMsg.Show(fCurXP, fCurThreshold, fTmpLvl)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_06
Function Fragment_Terminal_06(ObjectReference akTerminalRef)
;BEGIN CODE
pBallisticXP.SetValue(0.0)
pEnergyXP.SetValue(0.0)
pExplosivesXP.SetValue(0.0)
pChemicalXP.SetValue(0.0)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Message Property pXPShowMsg Auto Const Mandatory

GlobalVariable Property pBallisticXP Auto Const Mandatory

GlobalVariable Property pEnergyXP Auto Const Mandatory

GlobalVariable Property pExplosivesXP Auto Const Mandatory

GlobalVariable Property pChemicalXP Auto Const Mandatory

GlobalVariable Property pThresholdL1 Auto Const Mandatory

GlobalVariable Property pThresholdL2 Auto Const Mandatory

GlobalVariable Property pThresholdL3 Auto Const Mandatory

GlobalVariable Property pThresholdL4 Auto Const Mandatory
