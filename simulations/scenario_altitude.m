function T = scenario_altitude(cfg)
%SCENARIO_ALTITUDE Sweep UAV altitude at a fixed horizontal distance.
    T = make_result_table('altitude', cfg.base_environment, cfg, ...
        cfg.r_baseline_m, cfg.altitude_grid_m);
    writetable(T, fullfile(cfg.csv_dir, 'altitude.csv'));
end
