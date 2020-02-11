
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function[RT30]= f_calcul_RT30(Fc1,Fc2,h,Fs)                             %
% calculates the TR30 for a given frequency band using the impulse        %
% response of a room                                                      %
% Inputs:                                                                 %
%   Fc1: cutting freqency 1                                               %
%   Fc2: cutting frequency 2                                              %
%   h: the impulse response of the room                                   %
%   Fs: sampling frequency                                                %
% Output:                                                                 %
%   RT30: reverberation time RT30                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function[RT30] =  f_calcul_RT30(Fc1, Fc2,h,Fs)

%filtering the impulse response with a bandpass
d=designfilt('bandpassiir','FilterOrder',6, ...
 'HalfPowerFrequency1',Fc1,'HalfPowerFrequency2',Fc2, ...
 'SampleRate',Fs);
hfiltered= filter(d,h);

%%enveloppe extraction
hilbertTransform=(hilbert(hfiltered));           %calculating the analytic signal
AmpHilbertTransform= abs(hilbertTransform);      %extracting the enveloppe

%%schroeder integration
td= length(AmpHilbertTransform);
L(td:-1:1)=(cumsum(AmpHilbertTransform(end:-1:1))/sum(AmpHilbertTransform(1:end)));
figure, plot(L)
%%Energy conversion
E= 20.0*log10(L/max(L));
% figure, hold on, plot(E),

%%removing the null parts from the energy curve
for j=1:length(E)
   if (E(j)<-0.5)
       break;
   end
end
E=E(j:length(E));

%%linear approximation
x=(1:1:length(E));  %defining a set of values from the energy to apply to the approximation
y=E(x);
p=polyfit(x,y,1); %assimilate the curve to a polynomial of first degree: y=A*x+B
y2=polyval(p,x);  %calculate the values of the polynomial to plot it
% plot(E),plot(x,y2); hold off;
% legend('energy curve','reduced energy curve no 0','linear appro');

%calculating the RT30
level=-35;                     %defining the level of energy decrease for which RT30 to be calculated 
RT5=(-5/p(1))/Fs;
RT35= (level/p(1))/Fs;         %finding the sample number corresponding to the decrease level dB
RT30= RT35-RT5;              %Calculate the TR30 and return it
end
