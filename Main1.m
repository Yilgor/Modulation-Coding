%% INITIALISATION

close all;
B = 0.3;
Fsym = 1e6;
T = 1/Fsym;
M = 6;
Fs = M*Fsym;
Nbps = 2;
Ns = 1000;
N = Nbps*Ns;
taps = 101;
ratio = 20;
modulation = 'qam';

%%Generates Random bits sequence

bits_tx = randi([0,1],[N,1]);


%% Mapping bits into symbols

symb_tx = mapping(bits_tx,Nbps,modulation);


%% Constellation diagramm of sent symbols
figure
plot(symb_tx,'rp','color','red');
title('Constellation Diagramm of Intitial symbols','color','blue');
xlim([-2 2]);
xlabel('Real Part','color','blue')
ylabel('Imaginary Part','color','blue')
ylim([-2,2]);

%% upsampling

    symb_tx_ups = upsample(symb_tx,M);
    
    
%% Filtering

[t,h,f,H] = nysquist_filter(B,Fs,T,taps);

%% 1st Convolution
    es = conv(symb_tx_ups,h);
%% Computation of the signal energy

En = energy(es,T);

%% Noise additon
er = es + noise(ratio,En,N,Fs,length(es));


%% 2nd Convolution
    normalization = max(real(conv(h, h)));
    
    symb_rx_ups = conv(er,fliplr(h))./normalization;
    
    symb_rx_ups = symb_rx_ups(taps:end -(taps-1));
    
 %% downsampling
 
        symb_rx = downsample(symb_rx_ups,M);
       
        
   %% Constellation diagramm of received symbols
figure
plot(symb_rx,'rp','color','red');
title('Constellation Diagramm of received symbols','color','blue');
xlabel('Real Part','color','blue')
ylabel('Imaginary Part','color','blue')
xlim([-2 2]);
ylim([-2,2]);     

BER(h,es,Fs,En,N,normalization,M,Nbps,modulation,bits_tx,taps);

