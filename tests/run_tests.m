function run_tests()
%RUN_TESTS Deterministic checks for the 7-day A2G study, base MATLAB only.
% Note: scenario_* writes results/csv/*.csv as a side effect.
    root = fileparts(fileparts(mfilename('fullpath')));
    addpath(root);
    addpath(fullfile(root, 'models'));
    addpath(fullfile(root, 'simulations'));
    cfg = config(root);
    if ~exist(cfg.csv_dir, 'dir'), mkdir(cfg.csv_dir); end
    count = 0;

    assert(abs(slant_distance(3, 4, 0) - 5) < 1e-12); count=count+1;
    assert(abs(elevation_angle(1, 1, 0) - 45) < 1e-12); count=count+1;
    assert(abs(elevation_angle(0, 1, 0) - 90) < 1e-12); count=count+1;
    assert(abs(fspl_db(2.4e9, 1000) - 100.052) < 0.02); count=count+1;
    assert(abs(fspl_db(2.4e9, 1000) - fspl_db(2.4e9, 100) - 20) < 1e-10); count=count+1;
    p = los_probability([0 30 60 90], 9.61, 0.16);
    assert(all(diff(p)>0) && all(p>0) && all(p<1)); count=count+1;
    assert(abs(average_pathloss(90, 1, 1, 20) - 91) < 1e-12); count=count+1;
    assert(abs(average_pathloss(90, 0, 1, 20) - 110) < 1e-12); count=count+1;
    assert(abs(average_pathloss(90, 0.5, 1, 20) - 100.5) < 1e-12); count=count+1;
    assert(abs(received_power(20, 2, 2, 1, 1, 100) + 78) < 1e-12); count=count+1;

    % Source-verified handover (Member 1, Bor-Yaliniz 2018 Table I).
    assert(cfg.params_reviewed == true); count=count+1;
    assert(cfg.f_Hz == 2.4e9 && cfg.hg_m == 1.5 && ...
           cfg.h_baseline_m == 100 && cfg.r_baseline_m == 500); count=count+1;
    assert(isequal([cfg.environments.urban.a cfg.environments.urban.b ...
        cfg.environments.urban.eta_los_dB cfg.environments.urban.eta_nlos_dB], ...
        [9.61, 0.16, 1.0, 20.0])); count=count+1;
    assert(isequal([cfg.environments.suburban.a cfg.environments.suburban.b ...
        cfg.environments.suburban.eta_los_dB cfg.environments.suburban.eta_nlos_dB], ...
        [4.88, 0.43, 0.1, 21])); count=count+1;
    assert(cfg.distance_grid_m(1) == 100 && cfg.distance_grid_m(end) == 3000 ...
        && cfg.altitude_grid_m(1) == 20 && cfg.altitude_grid_m(end) == 300); count=count+1;

    % Independent numerical benchmark at r=500m, h=100m, f=2.4GHz.
    u = evaluate_a2g(cfg.f_Hz, 500, 100, cfg.hg_m, cfg.environments.urban);
    s = evaluate_a2g(cfg.f_Hz, 500, 100, cfg.hg_m, cfg.environments.suburban);
    assert(abs(u.d_m - 509.6098998253468) < 1e-8); count=count+1;
    assert(abs(u.theta_deg - 11.1445612394305) < 1e-8); count=count+1;
    assert(abs(u.fspl_dB - 94.1967651788371) < 1e-7); count=count+1;
    assert(abs(u.p_los - 0.117401115420157) < 1e-9); count=count+1;
    assert(abs(u.pl_avg_dB - 111.966143985854) < 1e-7); count=count+1;
    assert(abs(s.pl_avg_dB - 99.4826608162963) < 1e-7); count=count+1;
    assert(s.pl_avg_dB < u.pl_avg_dB); count=count+1;

    T1 = scenario_distance(cfg);
    T2 = scenario_altitude(cfg);
    T3 = scenario_environment(cfg);
    assert(height(T1)==201 && height(T2)==201 && height(T3)==402); count=count+1;
    cols = {'scenario','environment','f_Hz','h_m','hg_m','r_m', ...
        'd_m','theta_deg','fspl_dB','p_los','pl_avg_dB'};
    assert(isequal(T1.Properties.VariableNames, cols) ...
        && isequal(T2.Properties.VariableNames, cols) ...
        && isequal(T3.Properties.VariableNames, cols)); count=count+1;
    assert(all(isfinite(T1.pl_avg_dB)) && all(isfinite(T2.pl_avg_dB)) ...
        && all(isfinite(T3.pl_avg_dB))); count=count+1;
    assert(all(T1.p_los>=0 & T1.p_los<=1) ...
        && all(T2.p_los>=0 & T2.p_los<=1) ...
        && all(T3.p_los>=0 & T3.p_los<=1)); count=count+1;
    assert(all(T3.r_m(1:201) == T3.r_m(202:end)) ...
        && all(T3.h_m == cfg.h_baseline_m)); count=count+1;
    assert(exist(fullfile(cfg.csv_dir, 'distance.csv'), 'file')==2 ...
        && exist(fullfile(cfg.csv_dir, 'altitude.csv'), 'file')==2 ...
        && exist(fullfile(cfg.csv_dir, 'environment.csv'), 'file')==2); count=count+1;
    fprintf('PASS: %d checks. Three scenario CSVs written to %s\n', count, cfg.csv_dir);
end
