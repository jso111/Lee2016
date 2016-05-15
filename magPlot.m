%% magPlot(freq, mag, titleStr, xlabelStr, ylabelStr, yRange) plot 
%  a tuning curve of 'mag' as a function of 'freq' with a title,
%  xlabel, ylabel, and y axis range specified by the following paratmers
function magPlot(freq, mag, titleStr, xlabelStr, ylabelStr, yRange)

fontSize=12; lineWidth=2.5; Logscale=1;
cmap=jet(3*8); cmap=cmap(end/3+1:-1:1,:);
if sum(sum(isfinite(mag)))~=0
    for i=8:-1:1
        magTemp=mag(isfinite(mag(:,i)),i);
        freq2=freq(isfinite(mag(:,i)));
        plot(freq2/1e3,magTemp,'linewidth',lineWidth,'Color',cmap(i,:)); hold on;
    end
    hold off;
    if isfinite(yRange)
        axis([2 14 yRange]);
    else
        axis([2 14 5e-2 1e3]);
    end
    set(gca,'YScale','log','fontsize',fontSize);
    set(gca,'Xtick',2:2:12,'Ytick',10.^(-1:3));
    
    if Logscale, set(gca,'XScale','log');
    else set(gca,'XScale','linear');
    end
    title(titleStr); xlabel(xlabelStr); ylabel(ylabelStr);
    pause(0.2);
end

end