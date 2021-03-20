function en = noise(ratio,Es,N,Fs,len_es)

EbNo = 10^(ratio/10);

Eb = Es/N;

Eb = Eb/2;

No = Eb/EbNo;

Np = 2*Fs*No;

en = sqrt(Np/2)*(randn(len_es,1)+1i*randn(len_es,1));