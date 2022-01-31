% Function to fit the Arrhenius parameters (activation energy and 
% frequency factor) on the kinetic constants obtained at different T

function [Ea, A] = arrhenius(k, T)

    A = [ones(length(k), 1) -1/8.314./T];
    y = log(k);
    
    a = A\y;
    
    A = exp(a(1));
    Ea = a(2);
    
end