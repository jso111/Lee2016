%% magPlot(freq, mag, titleStr, xlabelStr, ylabelStr, yRange) plot 
%  a tuning curve of 'mag' as a function of 'freq' with a title,
%  xlabel, ylabel, and y axis range specified by the following paratmers
function magPlot_3(freq, mag, nPol, titleStr, xlabelStr, ylabelStr, yRange, magSE)

fontSize=12; lineWidth=2.5; Logscale=1;
cmap=jet(3*8); cmap=cmap(end/3+1:-1:1,:);
% cmap=repmat([1 1 1],[8,1]); cmap=cmap.*repmat(linspace(0.8,0.2,8)',[1,3]);
if sum(sum(isfinite(mag)))~=0
    for i=8:-1:1
        if sum(isfinite(mag(:,i)))>0
            magTemp=mag(isfinite(mag(:,i)),i);            
            freq2=freq(isfinite(mag(:,i)))/1e3;
            % plot markers
            if isempty(magSE)
                plot(freq2,magTemp,'o','LineWidth',1,...
                    'MarkerEdgeColor',cmap(i,:),...
                    'MarkerSize',1,'Color',cmap(i,:)); hold on;
            else
                magSETemp=magSE(isfinite(mag(:,i)),i);
                errorbar(freq2,magTemp,magSETemp,'o','color',cmap(i,:),...
                    'linewidth',1,'MarkerEdgeColor','none'); hold on;
            end
        end
    end
    for i=8:-1:1
        if sum(isfinite(mag(:,i)))>0
            if i<3
                nPolAdj=nPol;
            else
                nPolAdj=nPol;
            end
            magTemp=mag(isfinite(mag(:,i)),i);
            freq2=freq(isfinite(mag(:,i)))/1e3;
            if nPolAdj>0
                % plot fitted lines
                coeff=polyfit((freq2),log10(magTemp'),nPolAdj);
                freqPol=linspace(freq2(1),freq2(end),100);freqPol=(freqPol);
                magPol=zeros(size(freqPol));
                for j=0:nPolAdj
                    magPol=magPol+coeff(nPolAdj-j+1)*freqPol.^j;
                end
                plot(freqPol,10.^magPol,'-','LineWidth',lineWidth,...
                        'Color',cmap(i,:)); hold on;
            else
                % plot the raw data
                plot(freq2,magTemp,'-','LineWidth',lineWidth,...
                    'Color',cmap(i,:)); hold on;
            end
        end
    end
    hold off;
    if isfinite(yRange)
        axis([2 14 yRange]);
    else
        axis([2 14 5e-2 1e3]);
    end
    set(gca,'YScale','log','fontsize',fontSize);
    set(gca,'Xtick',2:2:12,'Ytick',10.^(-2:6));
    
    if Logscale, set(gca,'XScale','log');
    else set(gca,'XScale','linear');
    end
    title(titleStr); xlabel(xlabelStr); ylabel(ylabelStr);
    pause(0.1);
end

end