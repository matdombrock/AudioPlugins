;
; True stereo autopanning with an option to average the stereo channels before panning
;
<Cabbage>
form caption("AUTO PAN") size(230,200), colour(33,33,33), pluginid("gaincontrol") guirefresh(32)
#define SLIDER colour(57, 191, 149) textboxcolour(0, 0, 0, 255) textboxoutlinecolour(0, 0, 0, 255) trackercolour(74, 247, 193) trackerinsideradius(0.8) valuetextbox(1)
#define METER overlaycolour(66,66,66) metercolour:0(255, 0, 0, 255) metercolour:1(57, 191, 149) metercolour:2(74, 247, 193)  outlinethickness(0) 
vmeter bounds(25, 25, 15, 120) channel("in L") value(0) $METER
vmeter bounds(45, 25, 15, 120) channel("in R") value(0) $METER
rslider bounds(55, 25, 75, 75), channel("rate") text("-RATE-") range(0, 10, 1, 1, 0.01) $SLIDER
rslider bounds(95, 65, 75, 75), channel("wet") text("-WET-") range(0, 1, 1, 1, 0.01) $SLIDER
vmeter bounds(165, 25, 15, 120) channel("out R") value(0) $METER
vmeter bounds(185, 25, 15, 120) channel("out L") value(0) $METER
checkbox bounds(25, 155, 100, 25) channel("bypass") text("ACTIVE","BYPASS") colour:1(74, 247, 193)
checkbox bounds(140, 155, 165, 25) channel("avg") text("TRU","AVG") colour:1(74, 247, 193)
combobox bounds(65, 0, 100, 25) channel("lfo type") colour(33,33,33) items("sine", "triangle","square (bipolar)","square (unipolar)", "saw","saw (down)") value(1)
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

    kRate chnget "rate"
    kWet chnget "wet"
    kByp chnget "bypass"
    kAvg chnget "avg"
    kLty chnget "lfo type"
    CreateLFO:
        iLtyc = i(kLty)
        if iLtyc > 0 then
            iLtyc = iLtyc - 1
        endif
        kLfo lfo 1, kRate, iLtyc
    rireturn
    kTrig changed kLty
    if kTrig==1 then
        reinit CreateLFO
    endif
    
    kGainL = abs(kLfo)
    kGainR = 1-abs(kLfo)

    a1 inch 1
    a2 inch 2
    ; send the output
    aWetL = a1*kGainL
    aWetR = a2*kGainR
    if kAvg == 1 then
        aAvg = a1 + a2 / 2
        aWetL = aAvg*kGainL
        aWetR = aAvg*kGainR
    endif
    aOutL = (aWetL*kWet) + (a1-(a1*kWet))
    aOutR = (aWetR*kWet) + (a2-(a2*kWet))
    if kByp == 1 then
        aOutL = a1
        aOutR = a2
    endif
    outs aOutL, aOutR
    ; audio work is done
    
    ; feed meters
    chnset k(abs(a2)), "in R"
    chnset k(abs(a1)), "in L"
    chnset k(abs(aOutL)), "out L"
    chnset k(abs(aOutR)), "out R"

endin

instr 2
    ; instrument 2 runs only one time to set the default value of the clip checkbox
    ; this is a bit of a hack
    ; I'm not sure how to check k rate vars on the init pass
    ;chnset "value(0) active(0)", "clipId"
    kLty chnget "lfo type"
    printk2 kLty
    kTrig changed kLty
    if kTrig==1 then
        event "i", 1, 0, 1
        printk2 kLty
    endif
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
