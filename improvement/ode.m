% ODE system to be integrated

function yy = ode(~, w, SC, k, NS, NR)

  r = zeros(1,NR);
    for i = 1:NR
        for j = 1:NS 
            if SC(j,i) == -1
                r(i) = k(i)*w(j);
            end
        end
    end
    
    yy = SC*r';
    
end