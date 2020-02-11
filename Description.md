

# Measuring reverberation in a room through a log sweep

## Algorithm 

![alt text](https://github.com/HMMalek/ReverberationMeasurement/blob/master/Flowchart.png "Algorithm Flowchart")


## Detailed Description
###  2-1. Extraction of the RIR: Deconvolution
After recording the measuring signal playing in the room, it will be de-convolved with the emitted one in order to obtain the impulse response of the room. <br/> 
Using the following formula:  a *h=b , a being the log sweep, h is the impulse response and b is the recorded signal we can obtain the impulse response as  h=a^(-1)*b . In other words, we are applying the convolution to the inverse of the measuring signal and its recording. Which is equivalent to multiplication in the frequency domain.  <br/> 

### 2-2. Pre-Processing the RIR: Magnitude normalization and Silence removal
For a better performance : 

#### The amplitude of the signal will be normalized. 
 
#### Silence removal: 
The process consists of defining the envelope of the recorded signal (using a moving max filter: imdilate) and then fixing a coefficient for which all values below will be omitted. <br/> 
Constraint on the coefficient for silence removal: removing the silence at the end of a wav file could mean removing echoes.

#### Calculating the RT30:

##### Schroeder’s backwards integration of the envelope: 
The Schroeder’s integration is used to obtain a flat decay curve and is calculated as follows:   Ysch=∫(0-td)(Amp)^2 (τ)dτ. <br/> 

##### Energy decay curve:
Applying a logarithmic conversion of the integrated envelope.

#####	Linear approximation of the energy’s decay curve:
Using a linear approximation, we can assimilate the decay curve to a line represented by an equation of the form Y=A*x+B. We are more interested in the part containing the slope of the equation: Y=A*x.

#####	Finding the RT30:
According to the ISO3382-2 norm the RT30 is calculated by measuring the time of the energy decrease from -5db to -35 db.  <br/> We can find the corresponding number of samples through: Enlevel = A*  x, (A: the slope can be calculated with MATLAB, x number of samples and Enlevel is the energy level) and so the number of samples x=EnLevel/A.
