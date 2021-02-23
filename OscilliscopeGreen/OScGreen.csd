<Cabbage>
form size(420, 260), colour(37,37,37) caption("DEEP NOISE"), pluginID("plu1") guirefresh(64)
;groupbox bounds(20, 12, 233, 112), text("groupbox")    
#define SLIDER colour(57, 191, 149) textboxcolour(0, 0, 0, 255) textboxoutlinecolour(0, 0, 0, 255) trackercolour(74, 247, 193) trackerinsideradius(0.8) valuetextbox(1)
rslider bounds(10, 35, 100, 100), channel("size") text("SIZE") range(0, 1, 1, 1, 0.01) $SLIDER
rslider bounds(110, 35, 100, 100), channel("fco") text("LPC") range(1, 22000, 18000, 1, 1) $SLIDER
    rslider bounds(180, 35, 60, 60), channel("res") text("RES") range(0, 1, 0, 1, 0.01) $SLIDER
rslider bounds(220, 35, 100, 100), channel("gain") text("GAIN"), range(0, 1, 1, 1, 0.001) $SLIDER
rslider bounds(310, 35, 100, 100), channel("pitchm") text("PITCH"), range(0, 10, 1, 1, 1) $SLIDER

rslider bounds(10, 135, 100, 100), channel("LFO CPS") text("CPS"), range(0, 256, 0, 1, 0.01) $SLIDER
rslider bounds(110, 135, 100, 100), channel("LFO Amp") text("LFO AMP"), range(0, 1, 1, 1, 0.01) $SLIDER

checkbox bounds(210, 140, 200, 25) channel("Clamp") colour:1(74, 247, 193) text("CLAMP") value(1)



signaldisplay bounds(210, 180, 200, 60), colour(74, 247, 193), backgroundcolour(33, 33, 33), displaytype("waveform"), signalvariable("aSig") zoom(-1)
checkbox bounds(210, 180, 200, 5) identchannel("Overdrive") colour:1(255, 100, 100) text() value(0)

;label bounds(210, 160, 200, 25) text("LFO") identchannel("Var Text") fontcolour(74, 247, 193)
;label bounds(210, 180, 200, 25) text("LFO") identchannel("Size Text") fontcolour(74, 247, 193)
</Cabbage>
<CsoundSynthesizer>
<CsOptions>
-n -d -+rtmidi=NULL -M0 -m0d  --displays
</CsOptions>
<CsInstruments>
;sr = 44100
ksmps = 64
nchnls = 2
0dbfs=1

gaOutL init
gaOutR init

gkCFeed =0

instr 1
    kFdBack chnget "size"
    kFco chnget "fco"
    kRes chnget "res"
    kGain chnget "gain"
    iPitchm chnget "pitchm"
    kLFA chnget "LFO Amp"
    kLFC chnget "LFO CPS"
    kClm chnget "Clamp"
    aInL inch 1
    aInR inch 2
    
    kLFO lfo kLFA,kLFC, 0
    
    kCFeed = kFdBack+kLFO
    gkCFeed = kCFeed
    ;printk2 kLFO
;    SText2 sprintfk "text(\"%f\")", kCFeed
;    chnset SText2, "Size Text"
;    SText1 sprintfk "text(\"+-%.2f\")", kFdBack+kLFA
;    chnset SText1, "Var Text"
    ;printk2 kCFeed
    
    kTest = kCFeed
    kod = 0
    if kTest > 1 then
        kod = 1
    endif
    
    SText1 sprintfk "value(\"%d\")", kod
    chnset SText1, "Overdrive"
    
    gaOutL, gaOutR reverbsc aInL, aInR, kCFeed, kFco, sr, iPitchm
    if kClm == 1 then
        gaOutL clip gaOutL, 2, 0.9
        gaOutR clip gaOutL, 2, 0.9
    endif
;    if aOutL > 1 then
;        aOutL = 1
;    endif
;    if aOutR > 1 then
;        aOutR = 1
;    endif
    gaOutL = gaOutL*kGain
    gaOutR = gaOutR*kGain
    
    aLPL moogladder gaOutL, kFco, kRes
    aLPR moogladder gaOutL, kFco, kRes
    
    outs aLPL, aLPR
;    if(kFdBack > 1) then
;        kFdBack = kFdBack-0.0001;
;        chnset kFdBack, "size"
;        printk2 kFdBack;
;    endif
    
endin

instr 2
aSig = gaOutL + gaOutR /2
kSig = gkCFeed
if changed(k(aSig)) == 1 then
    display aSig, 0.1, 4
endif 
endin

</CsInstruments>  
<CsScore>
f1 0 1024 10 1
i1 0 z
i2 0 [60*60*24*7] 
</CsScore>
</CsoundSynthesizer>