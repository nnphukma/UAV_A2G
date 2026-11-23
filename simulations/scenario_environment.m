function T = scenario_environment(cfg)
%SCENARIO_ENVIRONMENT Compare environments over identical range geometry.
    T = [];
    for k = 1:numel(cfg.environment_names)
        env_name = cfg.environment_names{k};
        Ti = make_result_table('environment', env_name, cfg, ...
            cfg.distance_grid_m, cfg.h_baseline_m);
        if k == 1
            T = Ti;
        else
            T = [T; Ti]; %#ok<AGROW>
        end
    end
    writetable(T, fullfile(cfg.csv_dir, 'environment.csv'));
end
