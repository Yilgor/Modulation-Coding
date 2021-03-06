Fs = 20000;             % Sampling frequency
F = 500;                % Symbol frequency
N_Random = 1000;        % Number of symbol
BinaryRandom = randi([0 1], 1, N_Random);
MessageRandom = repelem(2*(BinaryRandom)-1, 1, Fs/F);