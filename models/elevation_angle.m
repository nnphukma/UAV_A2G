function theta_deg = elevation_angle(r_m, h_m, hg_m)
%ELEVATION_ANGLE Ground station to UAV elevation angle, in DEGREES.
    validateattributes(r_m, {'numeric'}, {'real','finite','nonnegative'});
    validateattributes(h_m, {'numeric'}, {'real','finite'});
    validateattributes(hg_m, {'numeric'}, {'real','finite'});
    if any(h_m(:) < hg_m(:))
        error('A2G:Geometry', 'Assume UAV altitude h_m >= hg_m.');
    end
    if any((r_m(:) == 0) & ((h_m(:) - hg_m(:)) == 0))
        error('A2G:UndefinedAngle', 'Co-located antennas give an undefined angle.');
    end
    theta_deg = atan2d(h_m - hg_m, r_m);
end
