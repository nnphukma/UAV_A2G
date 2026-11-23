function out = evaluate_a2g(f_Hz, r_m, h_m, hg_m, env)
%EVALUATE_A2G Stateless model; env fields: a, b, eta_los_dB, eta_nlos_dB.
    out.d_m = slant_distance(r_m, h_m, hg_m);
    out.theta_deg = elevation_angle(r_m, h_m, hg_m);
    out.fspl_dB = fspl_db(f_Hz, out.d_m);
    out.p_los = los_probability(out.theta_deg, env.a, env.b);
    out.pl_avg_dB = average_pathloss(out.fspl_dB, out.p_los, ...
        env.eta_los_dB, env.eta_nlos_dB);
end
