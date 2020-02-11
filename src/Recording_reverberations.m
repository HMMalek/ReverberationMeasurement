%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File purpose:        Recording the reverberations                       %
% Method: 
% Measuring the background noise in a room and determine in which         %
% frequency band it is concentrated : if it's high frequency, we measure  %
% it's level, if it's beyond a certain threshold, the measurment is       %
% cancelled, otherwise, we go through with it                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all;clc;clear all;
maxlevel=-60;      %defining the highest accepted noise level -45 
F=48000;           %defining the sampling frequency
duration=2;        %the duration for which the noise is measured
nbit=24;           % bits per sample
mode=1;            % 1 = mono , 2 = stereo
% enregistrement = audiorecorder(F,nbit, mode,1); %Define the audio recorder
% record(enregistrement);                         % Beginning of the recording
% pause(duration);                                % The microphone gets to measure the reverberation time for n secondes
% st=getaudiodata(enregistrement);                %Store recorded audio signal in numeric array 
% BackgroundNoise = st(:,1);
% % [BackgroundNoise,F]=audioread('testNoise2.wav');%testing file
% %finding the frequency range of the noise 
% T=1/F;
% L=length(BackgroundNoise); 
% t = (0:L-1)*T; 
% f=F*(0:(L/2))/L;
% noF= fft(BackgroundNoise);          %calculating the fourier transform of the noise 
% y=abs(noF/L);
% y2=y(1:L/2+1);
% y2(2:end-1)=2*y2(2:end-1);
% figure, plot(f,y2);xlabel('f(Hz)'); %plotting the frequency domain of the noise
% title('frequency domain');
% %initialization of variables
% %k is the indicator of noise in high frequencies, 0: no noise , 1: noise
% j=1;   k=0;     
% m=max(y2)/20;                    % defining the smallest peak value(threshold)
% for i=1:length(f)
%    if ((y2(i))>m)&& f(i)>1000 %finding the peaks in the magnitude corresponding to high frequencies
%         freq(j)=f(i);         %storing the frequency 
%         level(j)= y2(i);      %storing the corresponding level
%         j=j+1; k=1;
%    end
% end
% %measure the level of the noise in high frequencies
% if (k==1)
%         disp('noise in high frequencies');
%     noiselevel=20*log10(max(level)); %get the highest noise level
%     if (noiselevel>maxlevel)
%         disp('impossible measurement');
%     end
%  else
% Audio file with sample frequency to be used
[y, Fs] = audioread('LogSweep_20_20000_48k_16-bit-15dBFS.wav');
HP = audioplayer(y,Fs);  %Define the audio player
n = 1;                   %recording time after the end of the signal
enregistrement = audiorecorder(Fs,nbit, mode,2); 
record(enregistrement);  % Beginning of the recording
playblocking(HP);        % Playing the audio file until the end
 pause(n);                % The microphone gets to measure the reverberation time for n secondes
x=getaudiodata(enregistrement); %Store recorded audio signal in numeric array 
Audix = x(:,1);
tAudix = (0:length(Audix)-1)/Fs; %defining the time axis for the recorded signal
tSource = (0:length(y)-1)/Fs;   % defining the time axis or the source signal
audiowrite('RecordAudix_logsweep_Corner.wav',Audix,Fs); %storing the recorded signal
% plotting the source signal and the measured signal
figure(1),
subplot(2,1,1);
plot(tAudix,Audix);title('Recorded signal'),
xlabel('temps (s)'),ylabel('amplitude');
subplot(2,1,2);
plot(tSource,y);title('Source signal');
xlabel('temps (s)'); ylabel('amplitude');
% end


