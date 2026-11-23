function run_tests()
%RUN_TESTS Lightweight tests, no Unit Test Framework toolbox required.
    root = fileparts(fileparts(mfilename('fullpath')));
    addpath(root);
    addpath(fullfile(root,'models'));
    addpath(fullfile(root,'simulations'));
    cfg = config(root);
    if ~exist(cfg.csv_dir,'dir'), mkdir(cfg.csv_dir); end
    ntests = 0;

    assert(abs(slant_distance(3,4,0)-5) < 1e-12); ntests=ntests+1;
    assert(abs(elevation_angle(1,1,0)-45) < 1e-12); ntests=ntests+1;
    assert(abs(elevation_angle(0,1,0)-90) < 1e-12); ntests=ntests+1;
    assert(abs(fspl_db(2.4e9,1000)-100.052) < 0.02); ntests=ntests+1;
    assert(abs((fspl_db(2.4e9,1000)-fspl_db(2.4e9,100))-20) < 1e-10); ntests=ntests+1;
    p = los_probability([0 30 60 90], 9.61, 0.16);
    assert(all(diff(p)>0) && all(p>0) && all(p<1)); ntests=ntests+1;
    assert(abs(average_pathloss(90,1,1,20)-91) < 1e-12); ntests=ntests+1;
    assert(abs(average_pathloss(90,0,1,20)-110) < 1e-12); ntests=ntests+1;
    assert(abs(average_pathloss(90,0.5,1,20)-100.5) < 1e-12); ntests=ntests+1;
    assert(abs(received_power(20,2,2,1,1,100)+78)<1e-12); ntests=ntests+1;
    z = evaluate_a2g(cfg.f_Hz, 500, 100, cfg.hg_m, cfg.environments.urban);
    assert(z.p_los>0 && z.p_los<1 && z.pl_avg_dB>=z.fspl_dB); ntests=ntests+1;

    T1 = scenario_distance(cfg);
    T2 = scenario_altitude(cfg);
    T3 = scenario_environment(cfg);
    assert(height(T1)==201 && height(T2)==201 && height(T3)==402); ntests=ntests+1;
    cols = {'scenario','environment','f_Hz','h_m','hg_m','r_m', ...
        'd_m','theta_deg','fspl_dB','p_los','pl_avg_dB'};
    assert(isequal(T1.Properties.VariableNames,cols)); ntests=ntests+1;
    assert(all(isfinite(T1.pl_avg_dB)) && all(isfinite(T2.p_los)) ...
        && all(T3.p_los>=0) && all(T3.p_los<=1)); ntests=ntests+1;
    fprintf('PASS: %d checks; test CSV written to results/csv.\n', ntests);
end
