% Hashing function for the kinetic schemes

function name = get_name(SC, max_NR, min_NR)

    max_NR = max_NR + 1;

    [NS, NR] = size(SC);
    
    name = 0;
    for j = min_NR:NR
        for i = 1:NS
            if SC(i,j) == -1
                name = name + i*10^(2*(max_NR-j)-1);
            elseif SC(i,j) == 1
                name = name + i*10^(2*(max_NR-j)-2);
            end
        end
    end

end