<Cabbage>
form caption("GREENSCIENCE") size(450, 420), colour(33,33,33), pluginID("gsci")
keyboard bounds(14, 260, 413, 95), mouseoverkeycolour("LightBlue"), keydowncolour("White"), whitenotecolour("SkyBlue"), blacknotecolour("Black"), keyseperatorcolour("Green"), arrowcolour("SkyBlue"), arrowbackgroundcolour("Black"), keypressbaseoctave(4), middlec(5), value(36)

rslider bounds(12, 14, 70, 70), channel("attack"), range(0.01, 1, 0.01, 1, .01), text("ATK"), colour("SkyBlue"), trackercolour("HotPink"), trackerinsideradius(0.8), trackeroutsideradius(1), textcolour("SkyBlue")
rslider bounds(82, 14, 70, 70), channel("decay"), range(0, 1, 0.5, 1, .01), text("DEC"), colour("SkyBlue"), trackercolour("HotPink"), trackerinsideradius(0.8), trackeroutsideradius(1), textcolour("SkyBlue")
rslider bounds(152, 14, 70, 70), channel("sustain"), range(0, 1, 0.5, 1, .01), text("SUS"), colour("SkyBlue"), trackercolour("HotPink"), trackerinsideradius(0.8), trackeroutsideradius(1), textcolour("SkyBlue")
rslider bounds(222, 14, 70, 70), channel("release"), range(0, 1, 0.7, 1, .01), text("REL"), colour("SkyBlue"), trackercolour("HotPink"), trackerinsideradius(0.8), trackeroutsideradius(1), textcolour("SkyBlue")
rslider bounds(292, 14, 70, 70), channel("lp cutoff"), range(0, 22000, 2000, 0.275, .01), text("LP"), colour("SkyBlue"), trackercolour("HotPink"), trackerinsideradius(0.8), trackeroutsideradius(1), textcolour("SkyBlue")
rslider bounds(360, 14, 70, 70), channel("resonance"), range(0, 1, 0.7, 1, .01), text("RES"), colour("SkyBlue"), trackercolour("HotPink"), trackerinsideradius(0.8), trackeroutsideradius(1), textcolour("SkyBlue")

rslider bounds(12, 90, 70, 70), channel("tune"), range(0.01, 2, 1, 1, .01), text("*+/*-"), colour("SkyBlue"), trackercolour("HotPink"), trackerinsideradius(0.8), trackeroutsideradius(1), textcolour("SkyBlue")
rslider bounds(82, 90, 70, 70), channel("fine tune"), range(-100, 100, 0, 1, 1), text("+/-"), colour("SkyBlue"), trackercolour("HotPink"), trackerinsideradius(0.8), trackeroutsideradius(1), textcolour("SkyBlue")
rslider bounds(152, 90, 70, 70), channel("velocity"), range(-1, 1, 0, 1, .01), text("VEL"), colour("SkyBlue"), trackercolour("HotPink"), trackerinsideradius(0.8), trackeroutsideradius(1), textcolour("SkyBlue")
rslider bounds(222, 90, 70, 70), channel("MFO freq"), range(-100, 100, 0, 1, .01), text("MFO"), colour("SkyBlue"), trackercolour("HotPink"), trackerinsideradius(0.8), trackeroutsideradius(1), textcolour("SkyBlue")
rslider bounds(292, 90, 70, 70), channel("LFO freq"), range(-1, 1, 0, 1, .01), text("LFO"), colour("SkyBlue"), trackercolour("HotPink"), trackerinsideradius(0.8), trackeroutsideradius(1), textcolour("SkyBlue")
rslider bounds(360, 90, 70, 70), channel("amp"), range(0, 1, 0.7, 1, .01), text("AMP"), colour("SkyBlue"), trackercolour("HotPink"), trackerinsideradius(0.8), trackeroutsideradius(1), textcolour("SkyBlue")


rslider bounds(12, 175, 70, 70), channel("jekyll"), range(0, 1, 0.5, 1, .01), text("JEK"), colour("SkyBlue"), trackercolour("HotPink"), trackerinsideradius(0.8), trackeroutsideradius(1), textcolour("SkyBlue")
rslider bounds(82, 175, 70, 70), channel("hyde"), range(0, 1, 0.5, 1, 0.01), text("HYD"), colour("SkyBlue"), trackercolour("HotPink"), trackerinsideradius(0.8), trackeroutsideradius(1), textcolour("SkyBlue")

checkbox bounds(12, 380, 119, 27), channel("sanity"), value(1) text("JEK"), fontcolour:1("SkyBlue") fontcolour:0("SkyBlue"), colour:1("SkyBlue")
checkbox bounds(120, 380, 119, 27), channel("insanity"), value(1) text("HYD"), fontcolour:1("SkyBlue") fontcolour:0("SkyBlue"), colour:1("HotPink")

image bounds(420, 390, 24, 24), file("donut.png")

;label bounds(160, 174, 250, 30), text("GREEN/SCIENCE"), fontcolour(255, 105, 180, 255)
image bounds(160, 174, 250, 30), file("greenscience.png")
label bounds(160, 210, 250, 12), text("MATHIEU DOMRBROCK 2021")

</Cabbage>
<CsoundSynthesizer>
<CsOptions>
-n -d -+rtmidi=NULL -M0 -m0d --midi-key-cps=4 --midi-velocity-amp=5
</CsOptions>
<CsInstruments>
; Initialize the global variables. 
sr = 44100
ksmps = 32
nchnls = 2
0dbfs = 1


;instrument will be triggeSkyBlue by keyboard widget
instr 1

    iFreq = p4
    iAmp = p5


    iAtt chnget "attack"
    iDec chnget "decay"
    iSus chnget "sustain"
    iRel chnget "release"
    kRes chnget "resonance"
    kCutOff chnget "lp cutoff"

    iTun chnget "tune"
    iIft chnget "fine tune"
    iVel chnget "velocity"

    kMFOFreq chnget "MFO freq"
    kLFOFreq chnget "LFO freq"
    
    kSan chnget "sanity"
    kIns chnget "insanity"
    
    kJek chnget "jekyll"
    kHyd chnget "hyde"
    

    kAmp chnget "amp"
    kMFO lfo 2, kMFOFreq
    kLFO lfo 1, kLFOFreq

    kEnv madsr iAtt, iDec, iSus, iRel 
    aOut vco2 iAmp+iVel, (iFreq*iTun+iIft+(kMFO*500)+(kLFO*100)),0
    aOut2 vco2 iAmp+iVel,iFreq,
    
    
    ax = (aOut*kJek*kIns) + (aOut2*kHyd*kSan)
    
    

    aLP moogladder ax, kCutOff, kRes
    outs kAmp*(aLP*kEnv), kAmp*(aLP*kEnv)

endin



</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
</CsScore>
</CsoundSynthesizer>