
clc;
clear;
close all;

% Doc du lieu kich ban altitude
T = readtable(fullfile('results', 'csv', 'altitude.csv'));

% Sap xep theo do cao UAV
T = sortrows(T, 'h_m');

% Tao thu muc luu bieu do
if ~exist(fullfile('results', 'figures'), 'dir')
    mkdir(fullfile('results', 'figures'));
end

% Ve bieu do
figure('Color', 'w', 'Position', [100 100 900 550]);

plot(T.h_m, T.fspl_dB, '--', ...
    'LineWidth', 2);
hold on;

plot(T.h_m, T.pl_avg_dB, '-', ...
    'LineWidth', 2);

grid on;
box on;

xlabel('UAV altitude h (m)');
ylabel('Path Loss (dB)');

title('A2G Path Loss vs UAV Altitude');

legend('Free Space Path Loss (FSPL)', ...
       'Average A2G Path Loss', ...
       'Location', 'best');

set(gca, 'FontSize', 12);

% Luu bieu do
exportgraphics(gcf, ...
    fullfile('results', 'figures', 'pathloss_altitude.png'), ...
    'Resolution', 300);

fprintf('Da ve bieu do Path Loss theo do cao UAV!\n');
