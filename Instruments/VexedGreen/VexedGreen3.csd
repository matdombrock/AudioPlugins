; http://www.csounds.com/manual/html/vco2.html bounds(0, 0, 0, 0)


; 57, 191, 149 - blue 1
; 50, 173, 134 - blue 2
; 28, 148, 110 - blue 3
; 74, 148, 124 - blue 4
; 29, 204, 148 - white
; 153, 144, 148 - grey
; 74, 247, 193 - pink

<Cabbage>
form caption("VEXED GREEN") size(555, 620), colour(33,33,33), pluginID("def1")

image bounds(0, 0, 555, 620), channel("image1"), colour(123, 34, 143) file("vexedgreen.jpg")
;image bounds(10, 10, 540, 540), channel("image1"), colour(33, 33, 33)

keyboard bounds(20, 450, 518, 95), keywidth(25), keyseperatorcolour("White"), whitenotecolour(75,75,75),blacknotecolour(200,200,200), mouseoverkeycolour(50, 173, 134), keydowncolour(74, 148, 124), arrowbackgroundcolour("Grey"), arrowcolour("White")

; ADSR
rslider bounds(25, 25, 100, 100), channel("Attack") colour(57, 191, 149) range(0.01, 10, 0.01, 1, 0.01) text("-ATK-") textboxcolour(0, 0, 0, 255) textboxoutlinecolour(0, 0, 0, 255) trackercolour(74, 247, 193) trackerinsideradius(0.8) valuetextbox(1)
rslider bounds(125, 25, 100, 100), channel("Decay") colour(57, 191, 149) range(0, 10, 0.5, 1, 0.01) text("-DEC-") textboxcolour(0, 0, 0, 255) textboxoutlinecolour(0, 0, 0, 255) trackercolour(74, 247, 193) trackerinsideradius(0.8) valuetextbox(1)
rslider bounds(225, 25, 100, 100), channel("Sustain") colour(57, 191, 149) range(0, 1, 0.5, 1, 0.01) text("-SUS-") textboxcolour(0, 0, 0, 255) textboxoutlinecolour(0, 0, 0, 255) trackercolour(74, 247, 193) trackerinsideradius(0.8) valuetextbox(1)
rslider bounds(325, 25, 100, 100), channel("Release") colour(57, 191, 149) range(0, 10, 1, 1, 0.01) text("-REL-") textboxcolour(0, 0, 0, 255) textboxoutlinecolour(0, 0, 0, 255) trackercolour(74, 247, 193) trackerinsideradius(0.8) valuetextbox(1)

; Voices
rslider bounds(125, 235, 100, 100), channel("Voices") colour(28, 148, 110) range(1, 3, 1, 1, 1) text("-VCS-") textboxcolour(0, 0, 0, 255) textboxoutlinecolour(0, 0, 0, 255) trackercolour(74, 247, 193) trackerinsideradius(0.8) valuetextbox(1)
rslider bounds(325, 235, 100, 100), channel("Detune Voices") colour(28, 148, 110) range(-100, 100, 5, 1, 1) text("-DTV-") textboxcolour(0, 0, 0, 255) textboxoutlinecolour(0, 0, 0, 255) trackercolour(74, 247, 193) trackerinsideradius(0.8) valuetextbox(1)
rslider bounds(225, 235, 100, 100), channel("Phase") colour(28, 148, 110) range(0, 1, 0.5, 1, 0.01) text("-PHS-") textboxcolour(0, 0, 0, 255) textboxoutlinecolour(0, 0, 0, 255) trackercolour(74, 247, 193) trackerinsideradius(0.8) valuetextbox(1)

; Low Pass
rslider bounds(125, 125, 100, 100), channel("LP Cutoff") identchannel("CutoffID") colour(50, 173, 134, 255) range(0, 22000, 2000, 0.5, 0.01) text("-LPC-") textboxcolour(0, 0, 0, 255) textboxoutlinecolour(0, 0, 0, 255) trackercolour(74, 247, 193, 255) trackerinsideradius(0.8) valuetextbox(1)
rslider bounds(225, 125, 100, 100), channel("Resonance") identchannel("ResonanceID") colour(50, 173, 134, 255) range(0, 1, 0.7, 1, 0.01) text("-RES-") textboxcolour(0, 0, 0, 255) textboxoutlinecolour(0, 0, 0, 255) trackercolour(74, 247, 193, 255) trackerinsideradius(0.8) valuetextbox(1)
rslider bounds(325, 125, 100, 100), channel("Amplitude") identchannel("AmplitudeID") colour(50, 173, 134, 255) range(0, 1, 0.7, 1, 0.01) text("-AMP-") textboxcolour(0, 0, 0, 255) textboxoutlinecolour(0, 0, 0, 255) trackercolour(74, 247, 193, 255) trackerinsideradius(0.8) valuetextbox(1)
checkbox bounds(95, 165, 24, 24), channel("Bypass Filter"),value(1),colour:1(74, 247, 193, 255)

; LFO
rslider bounds(425, 25, 100, 100), channel("LFO Freqency") colour(74, 148, 124) range(0, 10, 0, 1, 0.01) text("-LFO-") textboxcolour(0, 0, 0, 255) textboxoutlinecolour(0, 0, 0, 255) trackercolour(74, 247, 193) trackerinsideradius(0.8) valuetextbox(1)
rslider bounds(425, 125, 100, 100), channel("LFO Amplitude") colour(74, 148, 124) range(0, 1, 0.5, 1, 0.01) text("-LFA-") textboxcolour(0, 0, 0, 255) textboxoutlinecolour(0, 0, 0, 255) trackercolour(74, 247, 193) trackerinsideradius(0.8) valuetextbox(1)
combobox bounds(438, 238, 75, 22), channel("LFO Map"), items("LPC","DTA"), colour(20,20,20), fontcolour("White")

; Misc
rslider bounds(225, 338, 100, 100), channel("Analog Detune") colour(29, 204, 148) range(0, 2, 0, 1, 0.01) text("-ALG-") textboxcolour(0, 0, 0, 255) textboxoutlinecolour(0, 0, 0, 255) trackercolour(74, 247, 193) trackerinsideradius(0.8) valuetextbox(1)
rslider bounds(25, 236, 100, 100), channel("Pulse Width") identchannel("Pulse WidthID") colour(255, 192, 203, 255) range(0, 1, 0.5, 1, 0.01) text("-PWM-") textboxcolour(0, 0, 0, 255) textboxoutlinecolour(0, 0, 0, 255) trackercolour(74, 247, 193, 255) trackerinsideradius(0.8) valuetextbox(1)
rslider bounds(22, 338, 100, 100), channel("Detune All") colour(29, 204, 148) range(-100, 100, 0, 1, 1) text("-DTA-") textboxcolour(0, 0, 0, 255) textboxoutlinecolour(0, 0, 0, 255) trackercolour(74, 247, 193) trackerinsideradius(0.8) valuetextbox(1)
rslider bounds(120, 338, 100, 100), channel("Velocity Mod") colour(29, 204, 148) range(0, 1, 0.5, 1, 0.01) text("-VEL-") textboxcolour(0, 0, 0, 255) textboxoutlinecolour(0, 0, 0, 255) trackercolour(74, 247, 193) trackerinsideradius(0.8) valuetextbox(1)
combobox bounds(335, 350, 150, 20), channel("Mode"), items("SAW","SQ","TRI", "SQ/PWM", "SAW/TRI/RMP","PULSE","4 * x * (1 - x)"), colour(20,20,20), fontcolour("White")

</Cabbage>
<CsoundSynthesizer>
<CsOptions>
-n -d -+rtmidi=NULL -M0 -m0d --midi-key-cps=4 --midi-velocity-amp=5
</CsOptions>
<CsInstruments>
; Initialize the global variables. 
;sr = 48000; Let host set sample rate
ksmps = 32
nchnls = 2
0dbfs = 1

giOneit init 0; Instrument 1 iteration count
giTwoit init 0; Instrument 2 iteration count

;instrument will be triggered by keyboard widget
instr 1

;
; Log Iterations
;
SRunComment sprintfk "---Inst 1 Run %d---\r", giOneit
prints SRunComment
giOneit = giOneit + 1

;
; Setup Inputs
;
; Midi Level
iFreq = p4
iAmp = p5
; Instrument level
iAtt chnget "Attack"
iDec chnget "Decay"
iSus chnget "Sustain"
iRel chnget "Release"
iMod chnget "Mode"
iVel chnget "Velocity Mod"
; Control level
kRes chnget "Resonance"
kLpc chnget "LP Cutoff"
kAmp chnget "Amplitude"
kPwm chnget "Pulse Width"
kPhs chnget "Phase"
kVcs chnget "Voices"
kDtv chnget "Detune Voices"
kDta chnget "Detune All"
kBft chnget "Bypass Filter"
kAna chnget "Analog Detune"
;kLFOFreq chnget "LFO Freqency"; Disabled for now

;
; Set Mode
;
iVcoMode = 0
; These are reordered for UX reasons
if (iMod == 1) then
    iVcomode = 0; Saw
endif
if (iMod == 2) then
    iVcomode = 10; Square wave (no PWM, faster)
endif
if (iMod == 3) then
    iVcomode = 12; Triangle (no ramp, faster)
endif
if (iMod == 4) then
    iVcomode = 2; Square / PWM
endif
if (iMod == 5) then
    iVcomode = 4; Saw / Tri / Ramp
endif
if (iMod == 6) then
    iVcomode = 6; Pulse (not normalized)
endif
if (iMod == 7) then; 4 * x * (1 - x) (i.e. integrated sawtooth)
    iVcomode = 8
endif
print iVcomode

;
; Calulate Amplitude
;
iCAmp = iAmp + iVel
if (iCAmp > 1) then; Clamp not required but creates crazy 'overdrive' without
    iCAmp = 1
endif
print iCAmp

;
; Setup Envelope 
;
kEnv madsr iAtt, iDec, iSus, iRel 

;
; Calculate Frequency
;

kLFO lfo kAna, 1, 0
kCFreq = iFreq + kDta + (1-kLFO); (1-kLFO) normalizes around 1 instead of just adding


;
; Setup Voices
;
aOut vco2 iCAmp, kCFreq,iVcomode + 16, kPwm, kPhs
aCOut = aOut
if (kVcs > 1) then; Add voice 2
    aOut2 vco2 iCAmp, kCFreq-kDtv,iVcomode + 16, kPwm, kPhs/2
    aCOut = aCOut + aOut2
endif
if (kVcs > 2) then; Add voice 3
    aOut3 vco2 iCAmp, kCFreq+kDtv,iVcomode + 16, kPwm, kPhs/3
    aCOut = aCOut + aOut3
endif

;
; Bypass Filter
;
kBft chnget "Bypass Filter"
aCOutL = 0
aCOutR = 0
if (kBft = 1) then; Filter is on
    ; Setting channels is buggy when not playing keys
;    chnset "active(1)", "CutoffID"
;    chnset "active(1)", "ResonanceID"
    aLP moogladder aCOut, kLpc, kRes
    outs kAmp*(aLP*kEnv), kAmp*(aLP*kEnv)
else; Filter is off
;    chnset "active(0)", "CutoffID"
;    chnset "active(0)", "ResonanceID"
    aCOutL = aCOut*kEnv
    aCOutR = aCOut*kEnv
endif

;
; Send Output
;
outs aCOutL, aCOutR

endin

instr 100; UI Updater
prints "---instr 2 run---\r"


;
; Bypass Filter UI
;
kBut1 chnget "Bypass Filter"
if (kBut1==1) then
    print 777
    chnset "active(1) colour(50, 173, 134)", "CutoffID"
    chnset "active(1) colour(50, 173, 134)", "ResonanceID"
    chnset "active(1) colour(50, 173, 134)", "AmplitudeID"
else
    print 666
    chnset "active(0) colour(\"Grey\")", "CutoffID"
    chnset "active(0) colour(\"Grey\")", "ResonanceID"     
    chnset "active(0) colour(\"Grey\")", "AmplitudeID" 
endif

;
; Mode Context UI
;

kMod chnget "Mode"
; These are reordered for UX reasons
if (kMod == 4) || (kMod == 5) then
    chnset "active(1) colour(29, 204, 148)", "Pulse WidthID"
else
    chnset "active(0) colour(\"Grey\")", "Pulse WidthID"
endif

endin
</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z; Run intr 1
i100 0 10000; Run instr 100
</CsScore>
</CsoundSynthesizer>
;;;; Voices
;;;; Velocity floor (+-)
;;;; Bypass Filter
;;;; Detune All
;;;; Amp Change color as basic Vu like my keyboard
;;;; Disable Knobs Contextually
;;;; Analog Detune
; Implement LFO (Mapping?)
; Bypass LFO
; Reset To Default Button
; Randomize Button
; Presets?

; UI Rearrange, AMP is part of filter really
; investigate proper voice split