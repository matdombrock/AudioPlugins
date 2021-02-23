DEEP NOISE
A (potentially overdriven) reverb effect that can amplify the audio signal as it's being reflected. This creates a terrifying distortion effect (Make sure you leave on CLAMP!).

Combine this overdrive with an LFO and it gets even better.   

Controls left to right:
SIZE - Size of the "room" creating the reflection
LPC - Low-pass filter cutoff 
RES - Low-pass filter resolution
GAIN - Controls the output volume
PITCH - "Pitch Spread" of the reverb effect (see: http://www.csounds.com/manual/html/reverbsc.html)
CPS - Cycles per second of the LFO
LFO AMP - Amplitude of the LFO

The LFO is used to modulate the "room size" and cause it to be pushed to a value higher than one. Without the LFO you would would have a constant >1 "room size" which would create feedback loop and nearly instant signal saturation. Because of this, a >1 "room size" is only possible by means of the LFO. 

The logic is this:

The LFO value oscillates between +LFO AMP and -LFO AMP at a rate of CPS.

The current value of the LFO is added to the SIZE variable. 

Setting SIZE to 0.75 and having the LFO AMP set to 0.5 will modulate the "room size" between 0.25 and 1.25 which will give you an "room size >1" ratio of about 1/4.
