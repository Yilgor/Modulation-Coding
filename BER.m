function BER(h,es,Fs,En,N,normalization,M,Nbps,modulation,bits_tx,taps)

        BER = zeros(13,1);
        EbNo = 1:20;
        for i = 1: length(EbNo)
            
            er = es + noise(EbNo(i),En,N,Fs,length(es));
            symb_rx_ups = conv(er,fliplr(h))./normalization;
            symb_rx_ups = symb_rx_ups(taps:end -(taps-1));
            symb_rx = downsample(symb_rx_ups,M);
            
            bits_demapped = demapping(symb_rx,Nbps,modulation);
            
            [num,ratio] = biterr(bits_tx,bits_demapped);
            BER(i) = ratio;
            
            
        end
        
       % [BER_Theory,ser] =  berawgn(EbNo,modulation,Nbps);
        
        figure
        semilogy(EbNo,BER,'*')
        title ('BER as a function of energy per bit EB/N0');
        xlabel('EB/N0')
        ylabel('BER')
       
        
            
            