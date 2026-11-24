function T = make_result_table(scenario_name, environment_name, cfg, r_m, h_m)
%MAKE_RESULT_TABLE Shared CSV schema for all simulation scenarios.
% Output columns match the frozen member-2/member-3 contract.
    n = max(numel(r_m), numel(h_m));
    r_m = as_column_of_length(r_m, n, 'r_m');
    h_m = as_column_of_length(h_m, n, 'h_m');
    hg_m = repmat(cfg.hg_m, n, 1);
    f_Hz = repmat(cfg.f_Hz, n, 1);
    env = cfg.environments.(environment_name);
    v = evaluate_a2g(f_Hz, r_m, h_m, hg_m, env);
    scenario = repmat({scenario_name}, n, 1);
    environment = repmat({environment_name}, n, 1);
    T = table(scenario, environment, f_Hz, h_m, hg_m, r_m, ...
        v.d_m(:), v.theta_deg(:), v.fspl_dB(:), v.p_los(:), ...
        v.pl_avg_dB(:), ...
        'VariableNames', {'scenario','environment','f_Hz','h_m', ...
        'hg_m','r_m','d_m','theta_deg','fspl_dB','p_los','pl_avg_dB'});
end

function x = as_column_of_length(x, n, variable_name)
    if isscalar(x)
        x = repmat(x, n, 1);
    elseif numel(x) == n
        x = x(:);
    else
        error('A2G:DataShape', '%s must be scalar or have %d elements.', ...
            variable_name, n);
    end
end
