function finalize_member2()
%FINALIZE_MEMBER2 One-command verification + final MATLAB CSV handover.
% MATLAB R2024b, base MATLAB only. Run from any Current Folder:
%   cd('E:\htvt\code\UAV_A2G_MATLAB_ThanhVien2_BanChot')
%   finalize_member2
%
% Successful execution writes:
%   results/csv/{distance,altitude,environment}.csv
%   results/logs/member2_verification.txt
%   deliverables/UAV_A2G_BanGiao_ThanhVien3_MATLAB.zip
%
% The archive contains actual, freshly created MATLAB CSV output,
% not the independently calculated reference CSVs supplied earlier.

    root = fileparts(mfilename('fullpath'));
    addpath(root, fullfile(root,'models'), fullfile(root,'simulations'), ...
        fullfile(root,'tests'));
    fprintf('\n=== A2G | THANH VIEN 2 | HOAN TAT BAN GIAO ===\n');
    fprintf('Project: %s\n', root);

    % 1. Execute mathematical and schema tests. If any fail, stop here.
    fprintf('\n[1/4] Running unit tests ...\n');
    run_tests();

    % 2. Regenerate authoritative CSVs from MATLAB code.
    fprintf('\n[2/4] Running scenarios and generating CSVs ...\n');
    main();

    % 3. Independently validate exported CSV table layouts and values.
    fprintf('\n[3/4] Validating three CSV exports ...\n');
    csv_dir = fullfile(root,'results','csv');
    D = readtable(fullfile(csv_dir,'distance.csv'));
    A = readtable(fullfile(csv_dir,'altitude.csv'));
    E = readtable(fullfile(csv_dir,'environment.csv'));
    columns = {'scenario','environment','f_Hz','h_m','hg_m', ...
               'r_m','d_m','theta_deg','fspl_dB','p_los','pl_avg_dB'};
    assert(isequal([height(D) height(A) height(E)], [201 201 402]), ...
        'Unexpected CSV row counts.');
    assert(isequal(D.Properties.VariableNames, columns) && ...
           isequal(A.Properties.VariableNames, columns) && ...
           isequal(E.Properties.VariableNames, columns), ...
        'CSV column names/order do not match contract.');
    assert(all(strcmp(D.scenario,'distance')) && ...
           all(strcmp(A.scenario,'altitude')) && ...
           all(strcmp(E.scenario,'environment')), ...
        'Unexpected scenario values.');
    assert(sum(strcmp(E.environment,'urban')) == 201 && ...
           sum(strcmp(E.environment,'suburban')) == 201, ...
        'Environment rows not 201+201.');
    fields = {'d_m','theta_deg','fspl_dB','p_los','pl_avg_dB'};
    Ts = {D,A,E};
    for j = 1:numel(Ts)
        t = Ts{j};
        for k = 1:numel(fields)
            assert(all(isfinite(t.(fields{k}))), 'Non-finite value found in output CSV.');
        end
        assert(all(t.p_los >= 0 & t.p_los <= 1), 'LoS probability outside [0,1].');
        assert(all(t.d_m > 0), 'Slant distance must be positive.');
        assert(all(t.pl_avg_dB >= t.fspl_dB - 1e-10), ...
            'Mean path loss unexpectedly below FSPL.');
    end
    fprintf('PASS: CSV schema, 804 rows, environment groups, finite values, constraints.\n');

    % 4. Create factual proof of this MATLAB execution and handover zip.
    fprintf('\n[4/4] Recording verification and creating handover ZIP ...\n');
    log_dir = fullfile(root,'results','logs');
    deliver_dir = fullfile(root,'deliverables');
    if ~exist(log_dir,'dir'), mkdir(log_dir); end
    if ~exist(deliver_dir,'dir'), mkdir(deliver_dir); end
    log_path = fullfile(log_dir,'member2_verification.txt');
    fid = fopen(log_path, 'w');
    if fid == -1
        error('A2G:LogOpen', 'Unable to create verification log.');
    end
    fprintf(fid, 'A2G MEMBER 2 - MATLAB EXECUTION VERIFICATION\n');
    fprintf(fid, 'Created by finalize_member2.m (not generated in advance)\n');
    fprintf(fid, 'Timestamp: %s\n', datestr(now, 31));
    fprintf(fid, 'MATLAB version: %s\n', version());
    fprintf(fid, 'Project root: %s\n', root);
    fprintf(fid, 'run_tests.m: PASSED (script completed without an error)\n');
    fprintf(fid, 'main.m: PASSED (script completed without an error)\n');
    fprintf(fid, 'CSV validation: PASSED\n');
    fprintf(fid, 'Rows: distance=201, altitude=201, environment=402, total=804\n');
    fprintf(fid, 'Environment values: Urban [9.61,0.16,1.0,20]; Suburban [4.88,0.43,0.1,21]\n');
    fprintf(fid, 'Literature: Bor-Yaliniz et al. (2018), Table I, per Member 1 handover.\n');
    fprintf(fid, 'f_Hz=2.4e9 is a study assumption, not field validation.\n');
    fprintf(fid, 'Files are MATLAB-generated analytical simulation outputs, not field measurements.\n');
    fclose(fid);

    package_files = { ...
        fullfile('results','csv','distance.csv'), ...
        fullfile('results','csv','altitude.csv'), ...
        fullfile('results','csv','environment.csv'), ...
        fullfile('results','logs','member2_verification.txt'), ...
        fullfile('docs','parameters.md'), ...
        fullfile('docs','references.md'), ...
        fullfile('docs','CSV_SCHEMA.md'), ...
        fullfile('docs','member2_handover.md'), ...
        fullfile('simulations','plot_results.m') ...
        };
    archive = fullfile(deliver_dir,'UAV_A2G_BanGiao_ThanhVien3_MATLAB.zip');
    if exist(archive,'file') == 2, delete(archive); end
    zip(archive,package_files,root);
    assert(exist(archive,'file') == 2, 'ZIP creation failed.');

    fprintf('\n============================================\n');
    fprintf('HOAN TAT THANH VIEN 2 - PASS\n');
    fprintf('CSV folder: %s\n', csv_dir);
    fprintf('Verification log: %s\n', log_path);
    fprintf('HANDOVER ZIP: %s\n', archive);
    fprintf('Gui file ZIP nay cho thanh vien 3.\n');
    fprintf('============================================\n');
end
