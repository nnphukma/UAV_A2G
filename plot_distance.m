
clc;
clear;
close all;

% Doc du lieu
T = readtable(fullfile('results', 'csv', 'distance.csv'));

% Sap xep theo khoang cach ngang
T = sortrows(T, 'r_m');

% Tao thu muc luu bieu do neu chua co
if ~exist(fullfile('results', 'figures'), 'dir')
    mkdir(fullfile('results', 'figures'));
end

% Ve bieu do
figure('Color', 'w', 'Position', [100 100 900 550]);

plot(T.r_m, T.fspl_dB, '--', ...
    'LineWidth', 2);
hold on;

plot(T.r_m, T.pl_avg_dB, '-', ...
    'LineWidth', 2);

grid on;
box on;

xlabel('Horizontal distance r (m)');
ylabel('Path Loss (dB)');

title('A2G Path Loss vs Horizontal Distance');

legend('Free Space Path Loss (FSPL)', ...
       'Average A2G Path Loss', ...
       'Location', 'best');

set(gca, 'FontSize', 12);

% Luu hinh
exportgraphics(gcf, ...
    fullfile('results', 'figures', 'pathloss_distance.png'), ...
    'Resolution', 300);

fprintf('Da ve va luu bieu do thanh cong!\n');
