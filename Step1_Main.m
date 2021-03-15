% Fs = 20000;             % Sampling frequency
% F = 500;                % Symbol frequency
% N_Random = 1000;        % Number of symbol
% BinaryRandom = randi([0 1], 1, N_Random);
% MessageRandom = repelem(2*(BinaryRandom)-1, 1, Fs/F);

clear all;
clc;

Fsym = 1e6; %% Cutoff frequency / symbol frequency
B = 0.3; % Roll-off factor for the nysquist filter
taps = 57; % Number of taps
M = 10; % upsampling factor Should be larger than 1
Fs = M*Fsym; % sampling frequency
Nbps = 4; % Number of bits per symbol (16-QAM)
Ns = 128; %number of symbols
T = 1e-6;
bit_tx = randi([0,1],Ns,1); % random sequence of bits

symb_tx = mapping(bit_tx,Nbps,'qam'); % Symbol mapping

symb_tx_upsampled = upsample(symb_tx,M); % the upsample function inserts M-1 zeros between symbols

[h,t,H,f] = nysquist_filter(T,B,taps,Fs); % the root-raised cosine filter

es = conv(symb_tx_upsampled,h); % signal

 % ration EB/N0
for ratio = 1:20


W = NoiseIn(es,Fs,ratio,length(bit_tx)); % Noise vector

er= es+(W); %received signal


y = conv(er,fliplr(h)); %matched filter

ynoedge = y(taps : length(y) - (taps -1));
ydown = downsample(ynoedge,M);

bdemapping = demapping(ydown,Nbps,'qam');

Ber = sum (mod(bit_tx +bdemapping,2));
BER(ratio) =Ber/length(bit_tx);

end

%% Plots

%Window
figure
subplot(2,1,1)
plot(t,real(h.*h))
hold on
%stem(t,real(h))
xlabel('Time (s)')
ylabel('Amplitude')
legend("Filter impulse response");

subplot(2,1,2)
plot(f,H.*H)
xlabel('Frequency (Hz)')
ylabel('Amplitude')

%Transmitted Signal
t1 = 0:1/Fs:(length(es)-1)/(Fs);
t2 = 0:1/Fs:(length(y)-1)/(Fs);

figure
subplot(3,1,1)
plot(t1,real(es))
title('1st 1/2 Nyquist Filter')
xlabel('Time (s)')
ylabel('A')
legend('e_s')
subplot(3,1,2)
plot(t1,real(er))
title('1st 1/2 Nyquist Filter + Noise')
xlabel('Time (s)')
ylabel('A')
legend('e_r')
subplot(3,1,3)
plot(t2,real(y)); hold on
title('2nd 1/2 Nyquist Filter')
xlabel('Time (s)')
ylabel('A')
legend('y')

%I/O
figure
subplot(1,2,1)
zplane(symb_tx); grid on
xlim([-1.5 1.5]);
ylim([-1.5 1.5]);
title('Input');
subplot(1,2,2)
zplane(ydown); grid on
xlim([-1.5 1.5]);
ylim([-1.5 1.5]);
title('Output');

%Bit Error Rate
figure
semilogy(BER); grid on

title('QAM');
xlabel('SNR (dB)');
ylabel('BER');