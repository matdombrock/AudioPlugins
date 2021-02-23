; TODO
; Midi passthrough
<Cabbage>
form caption("MIDI SANITY") size(300, 280), colour(37,33,37), pluginid("def1")

label bounds(0, 10, 300, 20), text("MIDI CHANNEL") fontcolour(180,180,180)
nslider bounds(20, 30, 260, 30) channel("MIDI CHANNEL") range(1, 16, 1, 1, 1) colour(128, 124, 161)

label bounds(0, 60, 300, 20), text("CC") identchannel("CC NAME") fontcolour(180,180,180)
label bounds(0, 80, 300, 20), text("---") identchannel("CC VAL") fontcolour(144, 209, 209)

label bounds(0, 110, 300, 20), text("MIDI NOTE VALUE") fontcolour(180,180,180)
label bounds(0, 130, 300, 20), text("---") identchannel("MIDI NOTE") fontcolour(177, 147, 209)

label bounds(0, 160, 300, 20), text("MIDI NOTE VELOCITY") fontcolour(180,180,180)
label bounds(0, 180, 300, 20), text("---") identchannel("MIDI VEL") fontcolour(193, 116, 209)

label bounds(0, 210, 300, 20), text("MIDI NOTE PITCH BEND")  fontcolour(180,180,180)
label bounds(0, 230, 300, 20), text("---") identchannel("MIDI PB") fontcolour(209, 84, 209)

checkbox bounds(0,250,300,30) identchannel("MIDI ON"), colour:1(201, 100, 209)


</Cabbage>
<CsoundSynthesizer>
<CsOptions>
-n -d -+rtmidi=NULL -M0 -m0d --midi-key-cps=4 --midi-velocity-amp=5
</CsOptions>
<CsInstruments>
; Initialize the global variables. 
ksmps = 32
nchnls = 2
0dbfs = 1

opcode CtrlRead,0,iii
    prints "ctrl read\n"
    ichan,icount,ilast	xin
    kval	ctrl7	ichan,icount,0,127
    if changed(kval)==1 then
        SVal sprintfk "text( \"%d\")", kval
        chnset	SVal,"CC VAL"
        SNum sprintf "text( \"CC %d [%d]\")", icount, ichan
        chnset	SNum,"CC NAME"
        printk2 kval
        print ichan
    endif
    if icount<ilast then
        CtrlRead	ichan,icount+1,ilast
    endif
endop


;instrument will be triggered by keyboard widget
instr 1

    ikey init 0						;initialize key number
    ivel init 0						;initialize velocity
    midinoteonkey ikey, ivel				;MIDI note number value 
    Snote sprintf "text( \"%d\")", ikey
    chnset Snote, "MIDI NOTE"
    Svel sprintf "text( \"%d\")", ivel
    chnset Svel, "MIDI VEL"

    if (ikey>0) then
        chnset "value(1)", "MIDI ON"
    else
        chnset "value(0)", "MIDI ON"
    endif

    kbnd pchbend 0, 127	
    printk2 kbnd
    Spb sprintfk "text( \"%d\")", kbnd
    chnset Spb, "MIDI PB"
    ;
    ; Read CC
    ;
    kchnl chnget "MIDI CHANNEL"
    kchnl init 1

    if changed(kchnl)==1 then
      reinit RESTART
    endif
    RESTART:
        CtrlRead	i(kchnl),0,127
    rireturn
endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
i1 0 10000
</CsScore>
</CsoundSynthesizer>
