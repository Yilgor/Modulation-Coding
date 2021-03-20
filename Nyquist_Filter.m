function [h,t,H,f] = Nyquist_Filter(T,B,taps,Fs)

step = Fs/(taps+1);
fmax = step*(taps-1)/2;
fmin = -fmax;
f = fmin:step:fmax;
l = length(f);
H = zeros(size(f));

for i = 1 : (l +1)/2
    if abs(f(i)) <= (1-B)/(2*T)
        H(i) = sqrt(T);
        H(l-i+1) = H(i); %% by symmetry
    elseif abs(f(i)) <= (1+B)/(2*T)
        H(i) = sqrt((T/2)*(1 + cos((pi*T/B)*(abs(f(i)) + (B-1)/(2*T)))));
        H(l-i+1) = H(i);
    else
        H(i) = 0;
        H(l-i+1) = H(i);
    end
end

h = fftshift(ifft(ifftshift(H)));
t = (-(taps-1)/2:(taps -1)/2)*(1/Fs);
h = h/h((length(h) +1 )/2); %normalisation

end