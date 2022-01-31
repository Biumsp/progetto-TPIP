% function to fit the kinetic constants of a given reaction scheme

function [k, res] = fit_k(SC, w_exp, exp_times)
    
    % w_exp [temperature, time, species]

    [NS, NR] = size(SC);
    Nt = length(exp_times);
    
    T_s = [380, 390, 400]+273.15;       % [K]
    
    k = zeros(3, NR);                   % [1/h]
    k_lsq = 0.1*ones(NR,1);             % [1/h]
    
    % residuals
    res = zeros(3,1)+inf;
    
    lower_bounds = zeros(NR,1);
    
    % lsqnonlin options
    algorithm = 'trust-region-reflective';
    options = optimoptions('lsqnonlin','FunctionTolerance',1e-12,...
                           'OptimalityTolerance', 1e-12,...
                           'StepTolerance', 1e-9,...
                           'Algorithm', algorithm,...
                           'Display', 'off');
    
    for i = 1:3
        for start_from_final_value = 1:2
            
            wexp = reshape(w_exp(i,:,:), [Nt, NS]);
            funk = @(kk)lsqerror(SC, kk, wexp, exp_times);
            [k_lsq,resnorm,~,exitflag,out] = lsqnonlin(funk, k_lsq, lower_bounds,[],options);

            k(i, :) = k_lsq;
            res(i) = resnorm; 
            iter = out.iterations;
            
            fprintf("Fitting temperature: %.0f [°C]; iterations: %d\n",...
                             T_s(i)-273.15, iter);
                         
            if exitflag == 1
                break;
            end
            
        end               
    end 
        
        
end

