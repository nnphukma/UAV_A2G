function cfg = config(project_root)
%CONFIG Shared simulation settings. Change values HERE, not in models/.
% Parameters below are PROVISIONAL until Member 1 verifies source applicability.
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

    % Illustrative parameter sets widely quoted with the Al-Hourani model.
    % These MUST be verified by Member 1 and the exact frequency/environment
    % applicability documented before numbers are used in the final report.
    cfg.environments.urban = struct( ...
        'a', 9.61, 'b', 0.16, 'eta_los_dB', 1.0, 'eta_nlos_dB', 20.0);
    cfg.environments.suburban = struct( ...
        'a', 4.88, 'b', 0.43, 'eta_los_dB', 0.1, 'eta_nlos_dB', 21.0);
    cfg.params_reviewed = false;
end
