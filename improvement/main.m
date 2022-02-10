% Generates kinetic schemes, fits them, selects the best one and plots it
% =========================================================================

clear variables
close all
clc

% Load the experimental data
load('w_exp.mat')

exp_times = [1, 2.5, 4];                        % [h]
T_s = [380, 390, 400]+273.15;                   % [K]
w0 = [0.11; 0.35; 0.278; 0.199; 0.063; 0];      % [-]

% Generate mechanisms -----------------------------------------------------

min_NR=5;
max_NR=7;

SC_s = get_mechanisms();

% Fit each mechanism ------------------------------------------------------

schemes   = zeros(length(SC_s), 1);
residuals = zeros(length(SC_s), 1);
kinetics  = cell(length(SC_s));

for i = 1:length(SC_s)
    
    SC = cell2mat(SC_s(i));
    
    [~, NR] = size(SC);
    name = get_name(SC, max_NR, min_NR);
    
    fprintf("Kinetic mechanism %d: Number of reactions = %d\n",...
             name, NR);
    
    [k_lsq, res] = fit_k(SC, w_exp, exp_times);
    
    fprintf('mean residual = %f; max residual = %f; total residual = %f\n\n',...
             sum(abs(res))/length(res), max(abs(res)), sum(abs(res)));
         
    schemes(i)   = name;
    residuals(i) = sum(abs(res));
    kinetics{i}  = k_lsq;
    
end

% Sort
[residuals, I] = sort(residuals);
schemes = schemes(I);
kinetics = kinetics(I);

save('results', 'schemes', 'residuals', 'kinetics');

fprintf("\nSorted Results\n\n");
fprintf("Scheme %d: residual = %f\n", [schemes residuals]');

% -------------------------------------------------------------------------
% Graphical Post-Processing
% -------------------------------------------------------------------------

% Select the best mechanism
SC = cell2mat(SC_s(I(1)));
[NS, NR] = size(SC);

ww_exp = zeros(length(exp_times), NS);
k = zeros(1, NR);
 
for ii = 1:3
    
    T = T_s(ii);
    for ll = 1:length(exp_times)
        for kk = 1:NR
            k(kk) = k_lsq(ii, kk);
        end
        for uu = 1:NS
            ww_exp(ll, uu) = w_exp(ii, ll, uu);
        end
    end
       
    opt = odeset("AbsTol", 1e-12, "RelTol", 1e-9);
    [t, w] = ode23s(@(t,w)ode(t, w, SC, k, NS, NR),...
                    0:0.001:exp_times(end), w0, opt);
    
    gpp(t, w, exp_times, ww_exp, T);

end