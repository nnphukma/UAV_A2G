
%% =========================================================
%  PLOT_RESULTS.M
%  UAV Ground Station - Urban vs Suburban
%  Ve bieu do chenh lech va thong ke Path Loss
%% =========================================================

clear;
clc;
close all;

%% 1. KHAI BAO DUONG DAN

csvFile = fullfile('results', 'csv', 'environment.csv');
figureDir = fullfile('results', 'figures');

% Tao thu muc figures neu chua ton tai
if ~exist(figureDir, 'dir')
    mkdir(figureDir);
end

%% 2. DOC DU LIEU CSV

if ~isfile(csvFile)
    error('Khong tim thay file: %s', csvFile);
end

T = readtable(csvFile);

% Kiem tra cac cot can thiet
requiredColumns = {'environment', 'r_m', 'pl_avg_dB'};

for k = 1:length(requiredColumns)
    if ~ismember(requiredColumns{k}, T.Properties.VariableNames)
        error('Thieu cot du lieu: %s', requiredColumns{k});
    end
end

%% 3. TACH DU LIEU URBAN VA SUBURBAN

env = lower(strtrim(string(T.environment)));

urban = T(env == "urban", :);
suburban = T(env == "suburban", :);

% Lay khoang cach va Path Loss
rUrban = urban.r_m;
plUrban = urban.pl_avg_dB;

rSuburban = suburban.r_m;
plSuburban = suburban.pl_avg_dB;

% Loai bo du lieu khong hop le
validUrban = isfinite(rUrban) & isfinite(plUrban);
validSuburban = isfinite(rSuburban) & isfinite(plSuburban);

rUrban = rUrban(validUrban);
plUrban = plUrban(validUrban);

rSuburban = rSuburban(validSuburban);
plSuburban = plSuburban(validSuburban);

%% 4. SAP XEP THEO KHOANG CACH

[rUrban, idxU] = sort(rUrban);
plUrban = plUrban(idxU);

[rSuburban, idxS] = sort(rSuburban);
plSuburban = plSuburban(idxS);

%% 5. KIEM TRA VA GHEP CAC DIEM TUONG UNG

if length(rUrban) ~= length(rSuburban)
    error('So diem Urban va Suburban khong bang nhau.');
end

if any(abs(rUrban - rSuburban) > 1e-6)
    error('Khoang cach Urban va Suburban khong trung khop.');
end

r = rUrban;

%% =========================================================
%  BIEU DO 2: CHENH LECH PATH LOSS
%% =========================================================

difference = plUrban - plSuburban;

figure('Color', 'w', 'Position', [100 100 1000 600]);

plot(r, difference, 'b-', 'LineWidth', 1.8);
hold on;

yline(0, 'r--', 'LineWidth', 1.5);

grid on;
box on;

xlabel('Horizontal Distance (m)', 'FontSize', 12);
ylabel('Path Loss Difference (dB)', 'FontSize', 12);

title('Path Loss Difference: Urban - Suburban', ...
    'FontSize', 14, 'FontWeight', 'bold');

legend('Urban - Suburban', 'Zero Difference', ...
    'Location', 'best');

set(gca, 'FontSize', 11);

exportgraphics(gcf, ...
    fullfile(figureDir, 'pathloss_difference.png'), ...
    'Resolution', 300);

%% =========================================================
%  BIEU DO 3: SO SANH PATH LOSS TRUNG BINH
%% =========================================================

meanUrban = mean(plUrban);
meanSuburban = mean(plSuburban);

meanValues = [meanUrban, meanSuburban];

figure('Color', 'w', 'Position', [150 150 800 550]);

bar(meanValues);

grid on;
box on;

xticks(1:2);
xticklabels({'Urban', 'Suburban'});

ylabel('Average Path Loss (dB)', 'FontSize', 12);

title('Average Path Loss Comparison', ...
    'FontSize', 14, 'FontWeight', 'bold');

set(gca, 'FontSize', 11);

% Hien thi gia tri tren dau cot
for k = 1:2
    text(k, meanValues(k), sprintf('%.2f dB', meanValues(k)), ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'bottom', ...
        'FontSize', 11);
end

ylim([0, max(meanValues) * 1.15]);

exportgraphics(gcf, ...
    fullfile(figureDir, 'pathloss_statistics.png'), ...
    'Resolution', 300);

%% =========================================================
%  6. IN KET QUA THONG KE
%% =========================================================

fprintf('\n===== PATH LOSS STATISTICS =====\n');

fprintf('Urban mean Path Loss: %.4f dB\n', meanUrban);
fprintf('Suburban mean Path Loss: %.4f dB\n', meanSuburban);

fprintf('Mean difference: %.4f dB\n', ...
    mean(difference));

fprintf('Minimum difference: %.4f dB\n', ...
    min(difference));

fprintf('Maximum difference: %.4f dB\n', ...
    max(difference));

fprintf('Urban > Suburban: %d/%d points\n', ...
    sum(difference > 0), length(difference));

fprintf('\n===== EXPORT COMPLETED =====\n');

fprintf('Saved: pathloss_difference.png\n');
fprintf('Saved: pathloss_statistics.png\n');
fprintf('Output directory: %s\n', figureDir);

%% =========================================================
%  END OF SCRIPT
%% =========================================================
