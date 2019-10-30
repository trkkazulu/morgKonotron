<Cabbage>
form caption("Morg Konotron") size(500, 240), colour(0,0,0, 20), pluginid("def1")
keyboard bounds(8, 124, 480, 100)

rslider bounds(116, 8, 90, 90) range(1, 20000, 10000, 1, 0.001), text("CutOff"), channel("cutoff")
rslider bounds(206, 8, 90, 90) range(0, 1, 0.473, 1, 0.001), text("Peak"),channel("peak")
rslider bounds(306, 8, 90, 90) range(1, 10, 0.473, 1, 0.001), text("Rate"), channel("rate")
rslider bounds(406, 8, 90, 90) range(0, 1, 0.473, 1, 0.001), text("Inten"),channel("intens")
checkbox bounds(2, 26, 100, 30)text("LFO Mod") channel("enableLFO"), radiogroup("99") value(1) colour:1(144, 38, 38, 255)
checkbox bounds(2, 56, 100, 30)text("Pitch Mod")channel("enablePitch"), radiogroup("99") colour:1(156, 32, 32, 255)
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

;instrument will be triggered by keyboard widget
instr SimpleSynth, 1
    iFreq = p4       
    kEnv madsr .1, .2, .6, 1
    
  
    
    kLFO lfo chnget:k("intens"), chnget:k("rate"), 5
    
       if chnget:k("enableLFO") == 1 then 
       
        aVco vco2 p5*kEnv, iFreq
       aLp moogladder aVco,chnget:k("cutoff")*kLFO, chnget:k("peak")       
       else 
       aVco vco2 p5*kEnv, iFreq*kLFO
       aLp moogladder aVco,chnget:k("cutoff"), chnget:k("peak")
       
        endif
    
    outs aLp, aLp
    
endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
</CsScore>
</CsoundSynthesizer>
