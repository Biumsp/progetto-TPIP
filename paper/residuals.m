function residuals(yy, tt_exp, T)

    figure
    plot(tt_exp, yy, '*')
    titleInfo = sprintf('T = %.0f [°C]', T-273.15);
    title(titleInfo)
    xlim([0.5, 4.5])
    ylim([-0.03, 0.03])
    ylabel("Residual")
    xlabel("time [h]")
    legend("VR", "AR", "GO", "KE", "NAP", "GAS")

end