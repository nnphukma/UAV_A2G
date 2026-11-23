function loss_dB = fspl_db(f_Hz, d_m)
%FSPL_DB Free-space path loss (dB); f_Hz is in Hz and d_m in meters.
    validateattributes(f_Hz, {'numeric'}, {'real','finite','positive'});
    validateattributes(d_m, {'numeric'}, {'real','finite','positive'});
    c = 299792458; % m/s
    loss_dB = 20 .* log10(4 .* pi .* f_Hz .* d_m ./ c);
end
