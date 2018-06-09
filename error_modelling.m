
function[  ] = error_modelling(d )
%%%Following data refered from Performance modelling and analysis of
%%%void-handling methodologies in underwater wireless sensor networks By
%%%Rodolf W. L. coutinho Computer networks , Elsevier 2017

k=1.7
% message size
m=400
% frequency in KHz
f=24;

% Thorp's absorption coefficient
af1=(0.11*f*f)/(1+(f*f));
af2=(44*f*f)/(4100+(f*f));
af3=2.75*(10^(-4))*f*f;
af=af1+af2+af3+0.003;

%%%%%%%Finding SNR%%%%%%%%%
%%%%%%%Refered from void handling using Geo-Opportunistic routing%%%%%%%%%
%%%%%%%underwater wireless sensor networks, Ug 2017 computer end electrical engineering ,elsevier%%%%%%%%%%%%%%%%%%%%%%%

SNR= ((d^k) * (af)^(d));
% Probability of bit error over distance d
prob = 0.5 *(1- sqrt(snr/(1+snr)));
end