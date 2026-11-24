clc;
clear;
close all;

dataFolder = fullfile('results', 'csv');

files = {
    'distance.csv'
    'altitude.csv'
    'environment.csv'
};

for k = 1:length(files)
    filePath = fullfile(dataFolder, files{k});

    fprintf('\n====================================\n');
    fprintf('KIEM TRA FILE: %s\n', files{k});
    fprintf('====================================\n');

    if ~isfile(filePath)
        fprintf('CHUA TIM THAY FILE!\n');
        continue;
    end

    T = readtable(filePath);
    fprintf('Kich thuoc bang: %d hang x %d cot\n', height(T), width(T));
    fprintf('Ten cac cot du lieu:\n');
    disp(T.Properties.VariableNames);
    disp(head(T, 5));
end