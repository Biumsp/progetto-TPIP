function gpp(t, w, tt_exp, ww_exp, T)

    [~,NS] = size(w);
    
    figure
    hold on 
    plot(t, w)

    symbol = ['X', '*', '^', 's', '+', 'o'];
    for mm = 1:NS
        p = plot(tt_exp, ww_exp(:, mm), symbol(mm));
        p.MarkerEdgeColor = 'black';
    end

    titleInfo = sprintf('T = %.0f [°C]', T-273.15);
    title(titleInfo)
    ylabel("mass fraction [-]")
    xlabel("time [h]")
    legend("VR", "AR", "GO", "KE", "NAP", "GAS")
    
end