% Function to be fed to lsqnonlin

function yy = lsqerror(SC, k, w_exp, exp_times)

    w0 = [0.11; 0.35; 0.278; 0.199; 0.063; 0];

    [NS, NR] = size(SC);
    
    % w_exp [times, species]
    t_step = 0.01;          % [h]
    tau = exp_times(end);   % [h]
    
    opt = odeset("AbsTol", 1e-9, "RelTol", 1e-8);
    [~, w] = ode23s(@(t,w)ode(t, w, SC, k, NS, NR), 0:t_step:tau, w0, opt);
    
    yy = zeros(3, NS);
     
    yy(1, :) = w(exp_times(1)/t_step+1, :) - w_exp(1, :); 
    yy(2, :) = w(exp_times(2)/t_step+1, :) - w_exp(2, :); 
    yy(3, :) = w(exp_times(3)/t_step+1, :) - w_exp(3, :); 
        
    yy = yy(:);
    
end