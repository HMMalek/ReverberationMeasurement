
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function [out]= f_deconvolution(reference,response)                     % 
% performs the deconvolution between the given signals                    %
% Inputs:                                                                 %
%  refrence, response: the signals used for the devoncolution             %
% Output:                                                                 %
%  out: the result of the deconvolution                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function[out]= f_deconvolution(reference,response)
reference=reference(:,1);
nRef = length(reference);
referenceI = flipud(reference); 
nRes= length(response);
response2=[response ; zeros(nRes-1,1)];
Fresponse=fft(response2);

N=nRef+nRes-1;
nRes2=length(response2);
y= zeros(N+nRes2-nRes,1);

for k= 1:nRes2:nRef
   if k<=(nRef+nRes-1),  Ref1=[referenceI(k:k+nRes2-nRes) ; zeros(nRes2-nRes,1)];
   else Ref1 = [referenceI(k:nRef) ; zeros(nRes2-nRes,1)];
   end;
   Ref2= fft(Ref1);
   Ref3=Ref2 .*Fresponse;
   Ref4=real(ifft(Ref3));
    if (k==1),	y(1:nRes2,1)= Ref4(1:nRes2,1);
               
    else        y(k:k+nRes2-1,1) = y(k:k+nRes2-1,1)+Ref4(1:nRes2,1);
                
    end
    
end
out=y(1:nRef+nRes,1);
end