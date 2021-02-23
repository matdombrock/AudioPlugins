;
; A gain controller with stero IO VU meters
;
<Cabbage>
form caption("GAIN CONTROL") size(230,175), colour(33,33,33), pluginid("gaincontrol") guirefresh(32)
#define SLIDER colour(57, 191, 149) textboxcolour(0, 0, 0, 255) textboxoutlinecolour(0, 0, 0, 255) trackercolour(74, 247, 193) trackerinsideradius(0.8) valuetextbox(1)
#define METER overlaycolour(66,66,66) metercolour:0(255, 0, 0, 255) metercolour:1(57, 191, 149) metercolour:2(74, 247, 193)  outlinethickness(0) 
vmeter bounds(25, 25, 15, 120) channel("in L") value(0) $METER
vmeter bounds(45, 25, 15, 120) channel("in R") value(0) $METER
rslider bounds(65, 25, 100, 100), channel("gain") text("-GAIN-") range(0, 2, 1, 1, 0.01) $SLIDER
label bounds(65, 125, 100, 20), identchannel("gain dB") text("XXX"), fontcolour("white")
vmeter bounds(165, 25, 15, 120) channel("out R") value(0) $METER
vmeter bounds(185, 25, 15, 120) channel("out L") value(0) $METER
checkbox bounds(0, 155, 230, 25), channel("clip") identchannel("clipId") colour:0(66,66,66) colour:1(220, 60, 33) automatable(0) active(0) value(0)
;label bounds(90, 160, 50, 15),  text("CLIPPED"), fontcolour("white")
</Cabbage>
<CsoundSynthesizer>
<CsOptions>
-n -d -+rtmidi=NULL -M0 -m0d 
</CsOptions>
<CsInstruments>
; Initialize the global variables. 
ksmps = 32
nchnls = 2
0dbfs = 1


instr 1

    kGain chnget "gain"

    a1 inch 1
    a2 inch 2
    ; send the output
    ; audio work is done
    outs a1*kGain, a2*kGain

    ; feed meters
    chnset k(abs(a2)), "in R"
    chnset k(abs(a1)), "in L"
    chnset k(abs(a2*kGain)), "out L"
    chnset k(abs(a1*kGain)), "out R"

    ; Calculate gain dB
    kGaindB = 20*log(kGain)
    SgaindB init ""
    SgaindB sprintfk "text(%d dB)", kGaindB
    chnset SgaindB, "gain dB"

    ; Calculate absulte gain for clipping
    kAbsGain1 = k(abs(a1*kGain))
    kAbsGain2 = k(abs(a2*kGain))
    kClip chnget "clip"
    if(kAbsGain1 > 1)||(kAbsGain2 > 1) then
        chnset "value(1) active(1)", "clipId"
    elseif (kClip == 0) then
        chnset "active(0)", "clipId"
    endif

endin

instr 2
    ; instrument 2 runs only one time to set the default value of the clip checkbox
    ; this is a bit of a hack
    ; I'm not sure how to check k rate vars on the init pass
    chnset "value(0) active(0)", "clipId"
endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
;starts instrument 1 and runs it for a week
i1 0 [60*60*24*7] 
i2 0
</CsScore>
</CsoundSynthesizer>
