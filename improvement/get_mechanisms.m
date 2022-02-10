% Generation of 7-reactions kinetic mechanisms 

function SC = get_mechanisms()

    % Base mechanism
    base = [-1, 0, 0, 0,-1;
             1,-1, 0, 0, 0;
             0, 1,-1, 0, 0;
             0, 0, 1,-1, 0;
             0, 0, 0, 0, 1;
             0, 0, 0, 1, 0];    
    
    [NS, ~] = size(base);
           
    % List of reactions
    MS = zeros(NS,1);
    
    % Generate all possible reactions
    for i = 1:NS-1
        for j = i+1:NS
            tmp = zeros(NS,1);
            tmp(i,end) = -1;
            tmp(j,end) =  1;
            
            if ~is_in_base(tmp, base)
                MS = [MS tmp];
            end
        end
    end
    
    [~, Nreact] = size(MS);
    
    % Number of combinations of 2 reactions
    combinations = (Nreact^2 - Nreact)/2;
        
    % Preallocate cell-array
    SC = cell(combinations-10, 1);
    
    u = 0;
    for i = 1:Nreact-1
        for j = i+1:Nreact
            u = u + 1;
            if i > 1
                SC{u} = [base MS(:, i) MS(:, j)];
            else
                SC{u} = [base MS(:, j)];
            end                                             
        end 
    end      
    
    
    % Auxiliary Function
    function bool = is_in_base(react, base)
        
        [~, Nbase] = size(base);
        
        bool = 0;
        for kk = 1:Nbase
            bool = bool + isequal(react, base(:, kk));   
        end
        
    end
end