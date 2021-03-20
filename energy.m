function En = energy(es,Tsym)
            En=0;
           for i =1 : length(es)
               En = En + norm(es(i))^2*Tsym;
           end