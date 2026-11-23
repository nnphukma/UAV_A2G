function T = scenario_distance(cfg)
%SCENARIO_DISTANCE Sweep horizontal distance at a fixed UAV altitude.
    T = make_result_table('distance', cfg.base_environment, cfg, ...
        cfg.distance_grid_m, cfg.h_baseline_m);
    writetable(T, fullfile(cfg.csv_dir, 'distance.csv'));
end
