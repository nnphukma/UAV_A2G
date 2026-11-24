
clc;
clear;
close all;

% Duong dan den thu muc du lieu
dataFolder = fullfile('results', 'csv');

files = {
    'distance.csv'
    'altitude.csv'
    'environment.csv'
};

for k = 1:length(files)

    filePath = fullfile(dataFolder, files{k});

    fprintf('\n====================================\n');
    fprintf('KIEM TRA: %s\n', files{k});
    fprintf('====================================\n');

    if ~isfile(filePath)
        fprintf('KHONG TIM THAY FILE!\n');
        continue;
    end

    T = readtable(filePath);

    % 1. Kiem tra kich thuoc
    fprintf('So hang: %d\n', height(T));
    fprintf('So cot: %d\n', width(T));

    % 2. Kiem tra gia tri thieu
    missingCount = sum(ismissing(T), 'all');
    fprintf('So gia tri thieu: %d\n', missingCount);

    % 3. Kiem tra xac suat LoS
    fprintf('p_los nho nhat: %.5f\n', min(T.p_los));
    fprintf('p_los lon nhat: %.5f\n', max(T.p_los));

    % 4. Kiem tra khoang cach
    fprintf('d_m nho nhat: %.3f m\n', min(T.d_m));
    fprintf('d_m lon nhat: %.3f m\n', max(T.d_m));

    % 5. Liet ke moi truong
    fprintf('Cac moi truong:\n');
    disp(unique(string(T.environment)));

    % 6. Kiem tra dieu kien co ban
    assert(all(T.d_m > 0), 'Loi: khoang cach khong hop le');
    assert(all(T.p_los >= 0 & T.p_los <= 1), ...
        'Loi: xac suat LoS nam ngoai [0,1]');
    assert(all(isfinite(T.fspl_dB)), ...
        'Loi: FSPL co gia tri khong hop le');
    assert(all(isfinite(T.pl_avg_dB)), ...
        'Loi: Path Loss co gia tri khong hop le');

    fprintf('KET LUAN: Cac kiem tra co ban da dat.\n');

end
