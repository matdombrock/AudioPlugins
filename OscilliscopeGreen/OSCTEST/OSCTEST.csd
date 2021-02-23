<Cabbage>
form caption("Oscilliscope Green") size(640,600), colour(33, 33, 33), pluginid("def1")
signaldisplay bounds(20, 0, 600, 600), colour("cyan"), backgroundcolour(33, 33, 33), displaytype("waveform"), signalvariable("aSig")
checkbox bounds(25,25,25,25) channel("Freeze") value(1) colour:1("Cyan")

</Cabbage>
</Cabbage>
<CsoundSynthesizer>
<CsOptions>
-n -d -+rtmidi=NULL -M0 -m0d  --displays
</CsOptions>
<CsInstruments>
; Initialize the global variables. 
ksmps = 32
nchnls = 2
0dbfs = 1

gaC = 0

instr 1
kFreeze chnget "Freeze"

a1 inch 1
a2 inch 2

outs a1, a2
aSig = a1 + a2 /2
if changed(k(aSig)) == 1 && kFreeze == 1 then
    display aSig, 0.1, 4
endif 

endin


</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
;starts instrument 1 and runs it for a week
i1 0 [60*60*24*7] 
</CsScore>
</CsoundSynthesizer>
