function [Wn, SNRin] = NoiseIn(S, F, Fs, Alpha, Bt, N)
    
    % INPUT
        % S = Signal d'entr�.
        % F = Fr�quence symbole.
        % Fs = Fr�quence d'�chantillonnage Matlab.
        % Alpha => Relaton Eb = No*Alpha avec Alpha donn� en dB.
        % Bt = Bande passante.
        % N = Nombre de symboles �mis.
    % OUTPUT
        % Wn = Bruit blanc additif gaussien.
        % SNRin = Rapport puissance de signal sur 
        % puissance de bruit � l�entr�e du d�modulateur.
        
    % Fonction simulant le bruit blanc additif gaussien (AWGN) 
    % � l'entr�e du d�modulateur.
    % (plus pr�cis�ment, en sortie du modulateur FM).
    
    %%%%%% Calcul de la puissance du signal re�u � l'entr� du recepteur Pe.
    Pe = sum(S.^2)/length(S);
    %Pe = sum(S.^2)/Fs;
    %Pe = (1/Fs)*trapz(S.^2);
    
    %%%%%% Calcul de la puissance du bruit Pn.
    Eb = Pe/F;
        % Eb = L'�nergie d'un bit.
        % 1/F = T = Dur�e d'un bit.
    No = Eb/(10^(Alpha/10));
        % No = Densit� spectrale de puissance ([No] = W/Hz).
        % Alpha [dB] = 10*log10(Eb/No)
        % <=> Eb/No = 10^(Alpha/10)
        % <=> No = Eb/(10^(Alpha/10))
    Pn = (No/2)*Fs;

    %%%%%% Calcul de SNRin
    SNRin = 10*log10(Pe/No*Bt);
        % SNRin est donn� en dB.

    %%%%%% Calcul du signal bruit�.
    Wn = sqrt(Pn)*randn([1, N*Fs/F]);
        % Le bruit est de m�me longueur que le signal d'entr�
        % pour pouvoir les additionner.

end