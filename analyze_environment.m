
clc;
clear;
close all;

% Doc du lieu
T = readtable(fullfile('results', 'csv', 'environment.csv'));

% Chuan hoa ten moi truong
env = lower(strtrim(string(T.environment)));

U = T(env == "urban", :);
S = T(env == "suburban", :);

% Sap xep theo khoang cach ngang
U = sortrows(U, 'r_m');
S = sortrows(S, 'r_m');

% Kiem tra so diem
fprintf('So diem Urban: %d\n', height(U));
fprintf('So diem Suburban: %d\n', height(S));

assert(height(U) == height(S), ...
    'So diem cua hai moi truong khong bang nhau');

% Kiem tra hinh hoc va tan so co trung khop khong
geometryMatch = ...
    isequal(U.r_m, S.r_m) && ...
    isequal(U.h_m, S.h_m) && ...
    isequal(U.hg_m, S.hg_m) && ...
    isequal(U.f_Hz, S.f_Hz);

fprintf('\nThong so hinh hoc va tan so trung khop: %d\n', ...
    geometryMatch);

assert(geometryMatch, ...
    'Hai moi truong khong co cung dieu kien mo phong');

% Tinh chenh lech Path Loss
deltaPL = U.pl_avg_dB - S.pl_avg_dB;

fprintf('\n===== SO SANH PATH LOSS =====\n');
fprintf('Chenh lech trung binh: %.4f dB\n', mean(deltaPL));
fprintf('Chenh lech nho nhat: %.4f dB\n', min(deltaPL));
fprintf('Chenh lech lon nhat: %.4f dB\n', max(deltaPL));

fprintf('So diem Urban co Path Loss lon hon: %d/%d\n', ...
    sum(deltaPL > 0), length(deltaPL));

% Kiem tra xu huong
fprintf('\n===== KIEM TRA XU HUONG =====\n');
fprintf('Urban tang theo khoang cach: %d\n', ...
    all(diff(U.pl_avg_dB) > 0));

fprintf('Suburban tang theo khoang cach: %d\n', ...
    all(diff(S.pl_avg_dB) > 0));
