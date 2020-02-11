
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function [Outsignal]= f_trimming_silence(InSignal, Coeff)               %
% removes the silent parts within a given signal                         %
% Inputs:                                                                 %
%  Insignal: the signal to be processed                                   %
%  Coeff: the coeff is a minimum value, samples                           %
%  with magnitude lower than the minimum value will be omitted            %
% Output:                                                                 %
%  Outsignal: the input signal after silence parts removal                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Outsignal]= f_trimming_silence(InSignal, Coeff)

%%plotting the input signal and its envelope
% figure,grid on, plot(InSignal);
% title('Original Signal + Envelope'),
% xlabel('Number of samples'), ylabel('Magnitude');

%%Find the envelope by taking a moving max operation
coeff1=500; %coeff : how true is the envelope compared to the signal
envelope = imdilate(abs(InSignal), true(coeff1, 1));

% hold on;
% plot(envelope, 'r-'); legend('Data', 'Envelope');
% xl = xlim();  %Save the x axis length so we can apply it to the edit plot

%%Find the quiet parts.
quietParts = envelope < Coeff; 

%%Cut out quiet parts and plot.
yEdited = InSignal;       %Initialize
yEdited(quietParts) = []; %remove the quiet parts

% figure, grid on, plot(yEdited),
% xlabel('Number of samples'), ylabel('Magnitude');
% title('Edited Signal; silence removal and amplitude normalization');
% xlim(xl);                 %Make it plot over the same time range as the original
Outsignal=yEdited;
end