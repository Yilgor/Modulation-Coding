function [Wn] = NoiseIn(S, Fs, Fsample, Ratio, Ns)
    
    % INPUT
        % S       : Input signal.
        % Fs      : Symbol frequency.
        % Fsample : Sample frequency.
        % Ratio   : Vector of ratios. ratio = Eb/No given in dB.
        % Ns      : Number of symbol = Number of encoded bits.
    % OUTPUT
        % Wn      : Additive White Gaussian Noise (AWGN).
        
    % Function that simulates the Additive White Gaussian Noise (AWGN).
    
    %%%%%% Computation of the power of the input signal.
    %Pe = sum(S.^2)/length(S);
    Pe = (1/Fsample)*trapz(abs(S).^2);
    
    %%%%%% Computation of the power of the noise.
    Eb = Pe/Fs;
        % Eb = Energy of one bit.
        % 1/Fs = Ts = Duration of one bit (Symbol duration).
    Eb = Eb/2;
        % Divided by a factor 2 because the power is expressed for a
        % bandpass signal (see slide 32 of "Signal representaton").
    No = Eb./(10.^(Ratio./10));
        % No = Power spectral density ([No] = W/Hz).
        % ratio [dB] = 10*log10(Eb/No)
        % <=> Eb/No = 10^(ratio/10)
        % <=> No = Eb/(10^(ratio/10))
    Pn = 2*No*Fsample;

    %%%%%% Computation of the noise signal.
    %Wn = sqrt(Pn/2)*randn([1, N*Fs/F])*(1+1i);
    Wn = sqrt(Pn/2)*(randn([1, Ns*Fsample/Fs])+1i*randn([1, Ns*Fsample/Fs]));
        % Bandpass representation of the signal (noise).
end