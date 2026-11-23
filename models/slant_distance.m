function d_m = slant_distance(r_m, h_m, hg_m)
%SLANT_DISTANCE 3-D link distance in meters. Elementwise/vectorized.
    validateattributes(r_m, {'numeric'}, {'real','finite','nonnegative'});
    validateattributes(h_m, {'numeric'}, {'real','finite'});
    validateattributes(hg_m, {'numeric'}, {'real','finite'});
    if any(h_m(:) < hg_m(:))
        error('A2G:Geometry', 'Assume UAV altitude h_m >= ground antenna height hg_m.');
    end
    d_m = hypot(r_m, h_m - hg_m);
end
