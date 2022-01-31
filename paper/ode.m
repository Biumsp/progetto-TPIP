% Integration of the ODE system

% Data --------------------------------------------------------------------

% Species: rows
% Reactions: columns
% [VR; AR; GO; KE; NAP; GAS]

% Stoichiometry
SC = [-1, 0, 0, 0, 0, 0;
       1,-1, 0, 0,-1, 0;
       0, 1,-1, 0, 0, 0;
       0, 0, 1,-1, 1,-1;
       0, 0, 0, 1, 0, 0;
       0, 0, 0, 0, 0, 1];
   
[NS, NR] = size(SC);
   
% Kinetics
Ea = [41.15, 19.21, 19.35, 14.07, 232.01, 5.35]*4186;           % [J/mol]
A  = [8.127e12, 3.197e5, 3.156e5, 1.358e3, 6.542e69, 4.184];    % [1/h]
R  = 8.314462;                                                  % [J/mol/K]
k_arr  = A.*exp(-Ea/R/T);                                           % [1/h]

k_s = [0.1383, 0.1168, 0.1026, 0.0263, 0.5e-8, 0.0685;
     0.2338, 0.1493, 0.1324, 0.0314, 0.227e-7, 0.0726;
     0.3546, 0.1812, 0.1598, 0.0363, 0.973e-6, 0.0774];
 
k = k_s(ii, :);
 
% format short 
%abs((k_arr - k(ii, :))./k_arr)*100

% Initial Conditions
w0 = [0.11; 0.35; 0.278; 0.199; 0.063; 0];

% Parameters
tau = 4;                % h

% Integration -------------------------------------------------------------
opt = odeset("AbsTol", 1e-12, "RelTol", 1e-9);
opt = [];
[t, w] = ode45(@(t,w)funk(t, w, SC, k, NS, NR), 0:0.01:tau, w0, opt);

% Auxiliary functions -----------------------------------------------------
function yy = funk(~, w, SC, k, NS, NR)
    
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