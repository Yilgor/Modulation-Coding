function [Wn] = NoiseIn(es, Fs, Ratio, l)

    % INPUT
        % es : Input signal.
        % Fs : Symbol frequency.
        % Fsample : Sample frequency.
        % Ratio : Vector of ratios. ratio = Eb/No given in dB.
        % Ns : Number of symbol = Number of encoded bits.

    % OUTPUT
        % Wn : Additive White Gaussian Noise (AWGN).

        % Function that simulates the Additive White Gaussian Noise (AWGN).

    %%%%%% Computation of the power of the input signal.
    %Pe = sum(es.^2)/length(es);
    Pe = (1/Fs)*trapz(abs(es).^2);
        % 1/Fsample = T_sample = Time during which the signal occurs.
        % trapz(abs(es).^2) = Integral of the S.^2

    %%%%%% Computation of the power of the noise.
    Eb = Pe/l;
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
    Pn = No*Fs;
        % Pn2 = 2*No*Fsample;

    %%%%%% Computation of the noise signal.
    %Wn = sqrt(Pn2/2)*randn([1, N*Fs/F])*(1+1i);
    %Wn = sqrt(Pn2/2)*(randn([1, Ns*Fsample/Fs])+1i*randn([1, Ns*Fsample/Fs]));
    Wn = sqrt(Pn/2)*(randn([length(es), 1])+1i*randn([length(es), 1]));
        % Bandpass representation of the signal (noise).
end