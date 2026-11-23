function main()
%MAIN Run all three A2G study scenarios; write reproducible CSV outputs.
% In MATLAB Current Folder, type: main
    project_root = fileparts(mfilename('fullpath'));
    addpath(fullfile(project_root, 'models'));
    addpath(fullfile(project_root, 'simulations'));
    cfg = config(project_root);
    if ~exist(cfg.csv_dir, 'dir')
        mkdir(cfg.csv_dir);
    end
    if ~exist(cfg.figures_dir, 'dir')
        mkdir(cfg.figures_dir);
    end
    if ~cfg.params_reviewed
        warning('A2G:ProvisionalParameters', ...
            ['Environment parameters are PROVISIONAL. ' ...
             'Member 1 must verify the original source and applicability.']);
    end

    td = scenario_distance(cfg);
    ta = scenario_altitude(cfg);
    te = scenario_environment(cfg);
    fprintf('Generated %d + %d + %d = %d CSV data rows.\n', ...
        height(td), height(ta), height(te), ...
        height(td) + height(ta) + height(te));
    fprintf('CSV folder: %s\n', cfg.csv_dir);
    fprintf('To draw figures separately, run: plot_results\n');
end
