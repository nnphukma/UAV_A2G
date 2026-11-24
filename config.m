function cfg = config(project_root)
%CONFIG Shared simulation settings. Change values HERE, not in models/.
% Environment values cross-checked with Bor-Yaliniz et al. (2018), Table I,
% as provided by Member 1. They are literature model parameters, NOT field measurements.
% f_Hz = 2.4e9 is a scenario assumption, not empirical validation at 2.4 GHz.
    if nargin < 1 || isempty(project_root)
        project_root = fileparts(mfilename('fullpath'));
    end
    cfg.project_root = project_root;
    cfg.csv_dir = fullfile(project_root, 'results', 'csv');
    cfg.figures_dir = fullfile(project_root, 'results', 'figures');

    % Agreed study assumptions (not hardware specifications).
    cfg.f_Hz = 2.4e9;           % Carrier frequency (Hz), assumed scenario
    cfg.hg_m = 1.5;            % Ground station antenna height (m)
    cfg.h_baseline_m = 100;    % Fixed UAV altitude for distance sweep (m)
    cfg.r_baseline_m = 500;    % Fixed horizontal range for altitude sweep (m)
    cfg.distance_grid_m = linspace(100, 3000, 201).';
    cfg.altitude_grid_m = linspace(20, 300, 201).';
    cfg.base_environment = 'urban';
    cfg.environment_names = {'urban', 'suburban'};

    % Fixed literature environment parameters from Member 1's verified handover:
    % Bor-Yaliniz, El-Keyi, Yanikomeroglu, IEEE TWC 2018, Table I.
    % DOI: 10.1109/TWC.2018.2874230
    % a, b: dimensionless; eta_los_dB, eta_nlos_dB: dB.
    cfg.environments.urban = struct( ...
        'a', 9.61, 'b', 0.16, 'eta_los_dB', 1.0, 'eta_nlos_dB', 20.0);
    cfg.environments.suburban = struct( ...
        'a', 4.88, 'b', 0.43, 'eta_los_dB', 0.1, 'eta_nlos_dB', 21.0);
    cfg.params_reviewed = true; % Table I values and units cross-checked
    cfg.parameter_source = 'Bor-Yaliniz et al. (2018), Table I';
    cfg.parameter_source_doi = '10.1109/TWC.2018.2874230';
    cfg.frequency_is_assumed = true; % NOT a field-validated 2.4 GHz setup
end
