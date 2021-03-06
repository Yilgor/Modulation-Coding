%GOAL : implement Nyquist filter transfer function.
    
   % The function takes as input the symbol duration T (number), the frequency vector , and the beta factor.
   
   
    

function H = Nyquist_Filter(T,B,f)
    
        l = length(f) %% to know how much frequencies we have
        H = zeros(size(f)) %% just initialising the vector where we'll put the transfer function
        
        for i = 1 : (l +1)/2 %% we know that the transfer function is symmetric instead of doing
          % a loop that will go trough all frequency, we just can stop to
          % half on the frequency that's why we go from 1 to l +2 /2
            if abs(f(i)) < (1-B)/(2*T)
                
                H(i) = T;
                H(l-i+1) = H(i); %% by symmetry
            elseif abs(f(i)) <= (1+B)/(2*T)
                    H(i) = (T/2)*(1 + cos((pi*T/B)*(abs(f(i)) + (B-1)/(2*T))));
                    H(l-i+1) = H(i);
            else
                        H(i) = 0;
                        H(l-i+1) = H(i);
            end
         
        end
        
       
        %% we now have the transfer function, we've to make the inverse fourier transform of it to get 
        %%the filer
        
        %% You can add the inverse FT by naming it X ( X =...) and modify the begining of the function
        %%like this ( function [H,X]) so it will return H (the transfer
        %%function) and X the filter in time domain.
end
                    
                    
            