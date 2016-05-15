%% phasePlot(freq, phase, titleStr, xlabelStr, ylabelStr, yRange) plot 
%  a tuning curve of 'phase (cycle)' as a function of 'freq' with a title,
%  xlabel, ylabel, and y axis range specified by the following paratmers
function phasePlot_3(freq, phase, nPol, titleStr, xlabelStr, ylabelStr, yRange, phaseSE)

fontSize=12; lineWidth=2.5; Logscale=1;
cmap=jet(3*8); cmap=cmap(end/3+1:-1:1,:);
% cmap=repmat([1 1 1],[8,1]); cmap=cmap.*repmat(linspace(0.8,0.2,8)',[1,3]);
if sum(sum(isfinite(phase)))~=0
    for i=8:-1:1
        if sum(isfinite(phase(:,i)))>0
            phaseTemp=phase(isfinite(phase(:,i)),i);
            freq2=freq(isfinite(phase(:,i)))/1e3;
            % plot markers
            if isempty(phaseSE)
                plot(freq2,phaseTemp,'o','LineWidth',1,...
                    'MarkerEdgeColor',cmap(i,:),...
                    'MarkerSize',1,'Color',cmap(i,:)); hold on;
            else
                phaseSETemp=phaseSE(isfinite(phase(:,i)),i);
                errorbar(freq2,phaseTemp,phaseSETemp,'o','color',cmap(i,:),...
                    'linewidth',1,'MarkerEdgeColor','none'); hold on;
            end
        end
    end
    for i=8:-1:1
        if sum(isfinite(phase(:,i)))>0
            if i<4
                nPolAdj=nPol-1;
            else
                nPolAdj=nPol;
            end
            phaseTemp=phase(isfinite(phase(:,i)),i);
            freq2=freq(isfinite(phase(:,i)))/1e3;
            if nPolAdj>0
                % plot fitted lines
                coeff=polyfit((freq2),phaseTemp',nPolAdj);
                freqPol=linspace(freq2(1),freq2(end),100);freqPol=(freqPol);
                phasePol=zeros(size(freqPol));
                for j=0:nPolAdj
                    phasePol=phasePol+coeff(nPolAdj-j+1)*freqPol.^j;
                end
                plot(freqPol,phasePol,'-','LineWidth',lineWidth,...
                    'Color',cmap(i,:)); hold on;
            else
                % plot the raw data
                plot(freq2,phaseTemp,'-','LineWidth',lineWidth,...
                    'Color',cmap(i,:)); hold on;
            end
        end
    end
    hold off;
    if isfinite(yRange)
        axis([2 14 yRange]);
    else
        axis([2 14 -8 1]);
    end
    set(gca,'YScale','linear','fontsize',fontSize);
    set(gca,'Xtick',2:2:12,'Ytick',-10:0.5:3);
    
    if Logscale, set(gca,'XScale','log');
    else set(gca,'XScale','linear');
    end
    title(titleStr); xlabel(xlabelStr); ylabel(ylabelStr);
    pause(0.1);
end

end