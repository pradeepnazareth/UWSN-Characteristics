function[  ] = error_modelling(d )
k=1.5
% message size
m=50
% frequency
f= 100;

% Thorp's absorption coefficient
af1=(0.11*f*f)/(1+(f*f));
af2=(44*f*f)/(4100+(f*f));
af3=2.75*(10^(-4))*f*f;
af=af1+af2+af3+0.003;

% SNR computation
snr= ((d.^k) * (af.^d));

% Packet delivery probability
prob = 0.5 *(1- sqrt(snr/(1+snr)));
end