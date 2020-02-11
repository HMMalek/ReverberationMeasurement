
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File purpose:                                                           %
% Plotting the RT30 and the RT60 curve from the impulse response of the   %
% room which is given from a log sweep and its recording in the room      %
% This code uses the functions "f_deconvolution.m", "f_trimming_silence.m"%
% and "f_calcul_RT30.m"                                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;close all;clear all; 
%loading the measuring signal and the recorded one
[reference, Fs] = audioread('LogSweep_20_20000_48k_16-bit-15dBFS.wav'); 
[response, responseFs] = audioread('190611-Acquisition Signals/Log sweep/cleaned/RecordAudix_logsweep-15dBFS-20-20k-MurLong.wav');
%plotting the signals 
figure, plot(reference), title('The measuring signal'), 
grid on, xlabel('Number of samples'), ylabel('Magnitude');
figure, plot(response), title('The recorded signal'),
grid on,xlabel('Number of samples'), ylabel('Magnitude');

%extracting the RIR
out=f_deconvolution(reference, response);
figure, plot(out),grid on, title ('Deconvolution result: RIR '),
xlabel(' Number of samples'), ylabel('Magnitude');
%pre-processing the RIR
out= out./ max(out);                     %magnitude normalization

coeff=0.0075; %0.023 
out=f_trimming_silence(out, coeff);     %removal of the silent parts
figure, plot(out); title('after truncation');

%defining 1/3 octave frequencies
CentralFreq = 1000 * 2.^(-3:1/3:4)';  %10 values ( -3:1/3:4 for  full range 125-16k )
RT30=zeros(length(CentralFreq),1);
for k=1: length(CentralFreq)
  Fc1= CentralFreq(k)/power(2,1/3);
  Fc2= CentralFreq(k)*power(2,1/3);
  RT30(k)= f_calcul_RT30(Fc1,Fc2,out,Fs);
end

%plotting the RT60 and RT30
RT60=RT30*2;
figure, grid on,plot(CentralFreq,RT30),
xlabel('Frequency (Hz)'), ylabel('RT30 (s)');title('RT30 Matlab'),
figure, grid on,plot(CentralFreq,RT60),title('RT60 MATLAB'),
xlabel('Frequency (Hz)'),  ylabel('RT60 (s)');


