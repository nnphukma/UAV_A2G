function pl_avg_dB = average_pathloss(fspl_dB, p_los, eta_los_dB, eta_nlos_dB)
%AVERAGE_PATHLOSS Probability-weighted path loss in dB (model assumption).
    validateattributes(fspl_dB, {'numeric'}, {'real','finite'});
    validateattributes(p_los, {'numeric'}, {'real','finite'});
    validateattributes(eta_los_dB, {'numeric'}, {'real','finite','scalar'});
    validateattributes(eta_nlos_dB, {'numeric'}, {'real','finite','scalar'});
    if any(p_los(:) < 0 | p_los(:) > 1)
        error('A2G:Probability', 'p_los must be in [0, 1].');
    end
    pl_los_dB = fspl_dB + eta_los_dB;
    pl_nlos_dB = fspl_dB + eta_nlos_dB;
    pl_avg_dB = p_los .* pl_los_dB + (1 - p_los) .* pl_nlos_dB;
end
