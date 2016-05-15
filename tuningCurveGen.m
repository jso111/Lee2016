%% This program re-generates the figure 2 and 3 in the paper
clear all;

%% import vibration data (5-D: freq, amplitude, structure, direction, mousetype)
% freq: 2:0.5:13 kHz (size 23)
% amplitude: 10:10:80 dB SPL (size 8)
% structure: 'BM', 'RL', 'TM' (size 3)
% direction: 'transverse', 'radial' (size 2)
% mousetype: 'CBA Live', 'CBA Dead' (size2)
data = load('vibData'); 

[numF, numA, numStructs, numDir, numMtype]=size(data.mag_fig2);
freq = (2:0.5:13)*1e3; 
amplitude = 10:10:80;
structure = {'BM','RL','TM'};
direction = {'transverse','radial'};
mousetype = {'CBA live','CBA dead'};

%% Generate each column of the Figure 2 (representative tuning curves from a live/dead CBA mouse)
structureIdx = 3; % 1: 'BM', 2: 'RL', 3: 'TM'
directionIdx = 2; % 1: 'Transverse', 2: 'Radial'

figure(1); set(gcf,'Position', [50 700 350 260]); clf;
magPlot(freq, squeeze(data.mag_fig2(:,:,structureIdx, directionIdx, 1)), ...
    '','','',[]); set(gca,'ytick',10.^(-1:2)); grid on; grid minor;
xlabel('Frequency (kHz)'); ylabel('Displacement (nm)');

figure(2); set(gcf,'Position', [50 500 350 260]); clf;
magPlot(freq, squeeze(data.mag_fig2(:,:,structureIdx, directionIdx, 2)), ...
    '','','',[]); set(gca,'ytick',10.^(-1:2)); grid on; grid minor;
xlabel('Frequency (kHz)'); ylabel('Displacement (nm)');

figure(3); set(gcf,'Position', [50 300 350 260]); clf;
magPlot(freq, squeeze(data.mag_fig2(:,:,structureIdx, directionIdx, 1))./data.magME, ...
'','','',[1.1e-1 2e4]); grid on; set(gca,'ytick',10.^(0:5)); grid minor; 
xlabel('Frequency (kHz)'); ylabel('Gain (re: middle ear)');

figure(4); set(gcf,'Position', [50 200 350 180]); clf;
phasePlot(freq, squeeze(data.phase_fig2(:,:,structureIdx, directionIdx, 1))/2/pi, ...
    '', '', '',[-5 0.5]); grid on; set(gca,'Xtick',2:2:12,'Ytick',-4:1:2);
xlabel('Frequency (kHz)'); ylabel('Phase (cycle)');

figure(5); set(gcf,'Position', [50 50 350 180]); clf;
phasePlot(freq, squeeze(data.phase_fig2(:,:,structureIdx, directionIdx, 2))/2/pi, ...
    '', '', '',[-5 0.5]); grid on; set(gca,'Xtick',2:2:12,'Ytick',-4:1:2);
xlabel('Frequency (kHz)'); ylabel('Phase (cycle)');


%% Generate each column of the Figure 3 (averaged tuning curves from live/dead CBA mice)
structureIdx = 3; % 1: 'BM', 2: 'RL', 3: 'TM'
directionIdx = 2; % 1: 'Transverse', 2: 'Radial'

figure(6); set(gcf,'Position', [50 700 350 260]); clf;
magPlotAve(freq, squeeze(data.magAve_fig3(:,:,structureIdx, directionIdx, 1)), ...
    0,'','','',[],data.magSE_fig3(:,:,structureIdx, directionIdx, 1)); 
set(gca,'ytick',10.^(-1:2)); grid on; grid minor;
xlabel('Frequency (kHz)'); ylabel('Displacement (nm)');

figure(7); set(gcf,'Position', [50 500 350 260]); clf;
magPlotAve(freq, squeeze(data.magAve_fig3(:,:,structureIdx, directionIdx, 2)), ...
    0,'','','',[],data.magSE_fig3(:,:,structureIdx, directionIdx, 2)); 
set(gca,'ytick',10.^(-1:2)); grid on; grid minor;
xlabel('Frequency (kHz)'); ylabel('Displacement (nm)');

figure(8); set(gcf,'Position', [50 300 350 260]); clf;
magPlotAve(freq, squeeze(data.magAve_fig3(:,:,structureIdx, directionIdx, 1))./data.magME, ...
    0,'','','',[1.1e-1 2e4],data.magSE_fig3(:,:,structureIdx, directionIdx, 1)./data.magME);
set(gca,'ytick',10.^(0:5)); grid on; grid minor; 
xlabel('Frequency (kHz)'); ylabel('Gain (re: middle ear)');

figure(9); set(gcf,'Position', [50 200 350 180]); clf;
phasePlotAve(freq, squeeze(data.phaseAve_fig3(:,:,structureIdx, directionIdx, 1))/2/pi, ...
    0, '', '', '', [-5 0.5], data.phaseSE_fig3(:,:,structureIdx, directionIdx, 1)/2/pi); 
grid on; set(gca,'Xtick',2:2:12,'Ytick',-4:1:2);
xlabel('Frequency (kHz)'); ylabel('Phase (cycle)');

figure(10); set(gcf,'Position', [50 50 350 180]); clf;
phasePlotAve(freq, squeeze(data.phaseAve_fig3(:,:,structureIdx, directionIdx, 2))/2/pi, ...
    0, '', '', '',[-5 0.5], data.phaseSE_fig3(:,:,structureIdx, directionIdx, 2)/2/pi); 
grid on; set(gca,'Xtick',2:2:12,'Ytick',-4:1:2);
xlabel('Frequency (kHz)'); ylabel('Phase (cycle)');


%% Generate each column of the Figure 5 (averaged tuning curves of ST from CBA live/dead mice)
figure(11); set(gcf,'Position', [50 700 350 260]); clf;
magPlotAve(freq, squeeze(data.magAve_fig5(:,:,1)), ...
    0,'','','',[],data.magSE_fig5(:,:,1)); 
set(gca,'ytick',10.^(-1:2)); grid on; grid minor;
xlabel('Frequency (kHz)'); ylabel('Displacement (nm)');

figure(12); set(gcf,'Position', [50 400 350 260]); clf;
magPlotAve(freq, squeeze(data.magAve_fig5(:,:,2)), ...
    0,'','','',[],data.magSE_fig5(:,:,2)); 
set(gca,'ytick',10.^(-1:2)); grid on; grid minor;
xlabel('Frequency (kHz)'); ylabel('Displacement (nm)');

figure(13); set(gcf,'Position', [350 700 350 260]); clf;
phasePlotAve(freq, squeeze(data.phaseAve_fig5(:,:,1))/2/pi, ...
    0, '', '', '', [-5 0.5], data.phaseSE_fig5(:,:,1)/2/pi); 
grid on; set(gca,'Xtick',2:2:12,'Ytick',-4:1:2);
xlabel('Frequency (kHz)'); ylabel('Phase (cycle)');

figure(14); set(gcf,'Position', [350 400 350 260]); clf;
phasePlotAve(freq, squeeze(data.phaseAve_fig5(:,:,2))/2/pi, ...
    0, '', '', '', [-5 0.5], data.phaseSE_fig5(:,:,2)/2/pi); 
grid on; set(gca,'Xtick',2:2:12,'Ytick',-4:1:2);
xlabel('Frequency (kHz)'); ylabel('Phase (cycle)');


%% Generate each column of the Figure 7 (averaged tuning curves from Tecta mice)
structureIdx = 3; % 1: 'Transverse BM', 2: 'Radial RL', 3: 'Radial TM'

figure(15); set(gcf,'Position', [50 700 350 260]); clf;
magPlotAve(freq, squeeze(data.magAve_fig7(:,:,structureIdx, 1)), ...
    0,'','','',[],data.magSE_fig7(:,:,structureIdx, 1)); 
set(gca,'ytick',10.^(-1:2)); grid on; grid minor;
xlabel('Frequency (kHz)'); ylabel('Displacement (nm)');

figure(16); set(gcf,'Position', [50 500 350 180]); clf;
phasePlotAve(freq, squeeze(data.phaseAve_fig7(:,:,structureIdx, 1))/2/pi, ...
    0, '', '', '', [-5 0.5], data.phaseSE_fig7(:,:,structureIdx, 1)/2/pi); 
grid on; set(gca,'Xtick',2:2:12,'Ytick',-4:1:2);
xlabel('Frequency (kHz)'); ylabel('Phase (cycle)');




