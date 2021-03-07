function [Wn] = NoiseIn(S, F, Fs, SNR, Bt, N)
    
    % INPUT
        % S = Input signal
        % F = Symbol frequency.
        % Fs = Sample frequency
        % SNR => Relation 2E = No*SNR with SNR given in dB.
        % Bt = Bandwidth
        % N = Number of symbol
    % OUTPUT
        % Wn = Additive White Gaussian Noise (AWGN)
        % SNRin = Input SNR
        
    % Fonction simulant le bruit blanc additif gaussien (AWGN) 
    % à l'entrée du démodulateur.
    % (plus précisément, en sortie du modulateur FM).
    
    %%%%%% Calcul de la puissance du signal reçu à l'entré du recepteur Pe.
    %Pe = sum(S.^2)/length(S);
    Pe = sum(S.^2)/Fs;
    %Pe = (1/Fs)*trapz(S.^2);
    
    %%%%%% Calcul de la puissance du bruit Pn.
    Eb = Pe/F;
        % Eb = L'énergie d'un bit.
        % 1/F = T = Durée d'un bit.
    No = Eb/(10^(SNR/10));
        % No = Densité spectrale de puissance ([No] = W/Hz).
        % SNR [dB] = 10*log10(Eb/No)
        % <=> Eb/No = 10^(SNR/10)
        % <=> No = Eb/(10^(SNR/10))
    Pn = (No/2)*Fs;

    %%%%%% Calcul du signal bruité.
    Wn = sqrt(Pn)*randn([1, N*Fs/F]);
        % Le bruit est de même longueur que le signal d'entré
        % pour pouvoir les additionner.

end