%% phasePlot(freq, phase, titleStr, xlabelStr, ylabelStr, yRange) plot 
%  a tuning curve of 'phase (cycle)' as a function of 'freq' with a title,
%  xlabel, ylabel, and y axis range specified by the following paratmers
function phasePlot(freq, phase, titleStr, xlabelStr, ylabelStr, yRange)

fontSize=12; lineWidth=2.5; Logscale=1;
cmap=jet(3*8); cmap=cmap(end/3+1:-1:1,:);
if sum(sum(isfinite(phase)))~=0
    for i=8:-1:1
        phaseTemp=phase(isfinite(phase(:,i)),i);
        freq2=freq(isfinite(phase(:,i)));
        plot(freq2/1e3,phaseTemp,'linewidth',lineWidth,'Color',cmap(i,:)); hold on;
    end
    hold off;
    if isfinite(yRange)
        axis([2 14 yRange]);
    else
        axis([2 14 -8 1]);
    end
    set(gca,'YScale','linear','fontsize',fontSize);
    set(gca,'Xtick',2:2:12,'Ytick',-10:0.5:2);
    
    if Logscale, set(gca,'XScale','log');
    else set(gca,'XScale','linear');
    end
    title(titleStr); xlabel(xlabelStr); ylabel(ylabelStr);
    pause(0.2);
end

end