% Reproducing the results of the authors

format longeng
close all
clear variables
clc

load('w_exp.mat')

tt_exp = [1, 2.5, 4];
ww_exp = zeros(3, 6);

T_s = [380, 390, 400]+273.15;
res = zeros(3,1);

for ii = 1:3
    T = T_s(ii);
    for ll = 1:3
        for kk = 1:6
            ww_exp(ll, kk) = w_exp(ii, ll, kk);
        end
    end
    ode
       
    yy = zeros(3, NS);

    yy(1, :) = w(tt_exp(1)/0.01+1, :) - ww_exp(1, :); 
    yy(2, :) = w(tt_exp(2)/0.01+1, :) - ww_exp(2, :); 
    yy(3, :) = w(tt_exp(3)/0.01+1, :) - ww_exp(3, :); 
    
    % Graphical Post-Processing -----------------------------------------------
    
    gpp(t, w, tt_exp, ww_exp, T);
    residuals(yy, tt_exp, T)

    yy = yy(:);
    res(ii) = sum(yy.^2);
    
end

fprintf("Total squared residuals: %f\n", sum(res))



