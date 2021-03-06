function [Wn, SNRin] = NoiseIn(S, F, Fs, Alpha, Bt, N)
    
    % INPUT
        % S = Signal d'entré.
        % F = Fréquence symbole.
        % Fs = Fréquence d'échantillonnage Matlab.
        % Alpha => Relaton Eb = No*Alpha avec Alpha donné en dB.
        % Bt = Bande passante.
        % N = Nombre de symboles émis.
    % OUTPUT
        % Wn = Bruit blanc additif gaussien.
        % SNRin = Rapport puissance de signal sur 
        % puissance de bruit à l’entrée du démodulateur.
        
    % Fonction simulant le bruit blanc additif gaussien (AWGN) 
    % à l'entrée du démodulateur.
    % (plus précisément, en sortie du modulateur FM).
    
    %%%%%% Calcul de la puissance du signal reçu à l'entré du recepteur Pe.
    Pe = sum(S.^2)/length(S);
    %Pe = sum(S.^2)/Fs;
    %Pe = (1/Fs)*trapz(S.^2);
    
    %%%%%% Calcul de la puissance du bruit Pn.
    Eb = Pe/F;
        % Eb = L'énergie d'un bit.
        % 1/F = T = Durée d'un bit.
    No = Eb/(10^(Alpha/10));
        % No = Densité spectrale de puissance ([No] = W/Hz).
        % Alpha [dB] = 10*log10(Eb/No)
        % <=> Eb/No = 10^(Alpha/10)
        % <=> No = Eb/(10^(Alpha/10))
    Pn = (No/2)*Fs;

    %%%%%% Calcul de SNRin
    SNRin = 10*log10(Pe/No*Bt);
        % SNRin est donné en dB.

    %%%%%% Calcul du signal bruité.
    Wn = sqrt(Pn)*randn([1, N*Fs/F]);
        % Le bruit est de même longueur que le signal d'entré
        % pour pouvoir les additionner.

end