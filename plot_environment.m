clc;
clear;
close all;

% Doc du lieu so sanh moi truong
T = readtable(fullfile('results', 'csv', 'environment.csv'));

% Tach du lieu Urban va Suburban
env = lower(strtrim(string(T.environment)));

T_urban = T(env == "urban", :);
T_suburban = T(env == "suburban", :);

% Sap xep theo khoang cach ngang
T_urban = sortrows(T_urban, 'r_m');
T_suburban = sortrows(T_suburban, 'r_m');

% Kiem tra du lieu
fprintf('So diem Urban: %d\n', height(T_urban));
fprintf('So diem Suburban: %d\n', height(T_suburban));

assert(~isempty(T_urban), 'Khong co du lieu Urban');
assert(~isempty(T_suburban), 'Khong co du lieu Suburban');

% Tao thu muc luu bieu do
if ~exist(fullfile('results', 'figures'), 'dir')
    mkdir(fullfile('results', 'figures'));
end

% Ve bieu do
figure('Color', 'w', 'Position', [100 100 900 550]);

plot(T_urban.r_m, T_urban.pl_avg_dB, ...
    'LineWidth', 2);
hold on;

plot(T_suburban.r_m, T_suburban.pl_avg_dB, ...
    '--', 'LineWidth', 2);

grid on;
box on;

xlabel('Horizontal distance r (m)');
ylabel('Average A2G Path Loss (dB)');

title('A2G Path Loss Comparison: Urban vs Suburban');

legend('Urban', 'Suburban', 'Location', 'best');

set(gca, 'FontSize', 12);

% Luu hinh
exportgraphics(gcf, ...
    fullfile('results', 'figures', 'environment_comparison.png'), ...
    'Resolution', 300);

fprintf('Da ve bieu do so sanh moi truong!\n');