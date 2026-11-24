function p_los = los_probability(theta_deg, a, b)
%LOS_PROBABILITY Al-Hourani logistic LoS model (theta in DEGREES).
    validateattributes(theta_deg, {'numeric'}, {'real','finite'});
    validateattributes(a, {'numeric'}, {'real','finite','positive','scalar'});
    validateattributes(b, {'numeric'}, {'real','finite','positive','scalar'});
    if any(theta_deg(:) < 0 | theta_deg(:) > 90)
        error('A2G:ThetaOutOfRange', 'theta_deg must be between 0 and 90 degrees.');
    end
    p_los = 1 ./ (1 + a .* exp(-b .* (theta_deg - a)));
end
