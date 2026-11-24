
clc;
clear;
close all;

% Doc du lieu kich ban altitude
T = readtable(fullfile('results', 'csv', 'altitude.csv'));

% Sap xep theo do cao UAV
T = sortrows(T, 'h_m');

% Tao thu muc luu hinh neu chua co
if ~exist(fullfile('results', 'figures'), 'dir')
    mkdir(fullfile('results', 'figures'));
end

% Ve bieu do
figure('Color', 'w', 'Position', [100 100 900 550]);

plot(T.h_m, T.p_los, '-', ...
    'LineWidth', 2);

grid on;
box on;

xlabel('UAV altitude h (m)');
ylabel('Line-of-Sight Probability');

title('LoS Probability vs UAV Altitude');

ylim([0 1]);
xlim([min(T.h_m) max(T.h_m)]);

set(gca, 'FontSize', 12);

% Luu bieu do
exportgraphics(gcf, ...
    fullfile('results', 'figures', 'los_altitude.png'), ...
    'Resolution', 300);

fprintf('Da ve bieu do LoS thanh cong!\n');
