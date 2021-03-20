function [t,h,f,H] = nysquist_filter(B,Fs,T,taps)

step = Fs/taps;
Ts = 1/Fs;

max_f = ((taps-1)/2)*step;
min_f = -max_f;
f = linspace(min_f,max_f,taps);
t = (-(taps-1)/2)*Ts :Ts:((taps-1)/2)*Ts;
A1 = (1-B)/(2*T);
A2 = (1+B)/(2*T);

H = ones(1, taps) .* (sqrt(T / 2 * (1 + cos(pi * T / B * (abs(f) - A1)))));
H(abs(f) < A1) = sqrt(T);
H(abs(f) > A2) = 0;
h = fftshift(ifft(ifftshift(H))); 
h = h./h((taps+1)/2);


figure

plot(t,h,'color','blue');
title(' 1/2 Nyquist Filter ')
xlabel('time t','color','blue')
ylabel(' Amplitude','color','blue')
xlim( [(-(taps-1)/2)*2*Ts , ((taps-1)/2)*2*Ts]);
ylim([-1, 1]);
grid

end

