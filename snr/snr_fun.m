% This function mixes signal and noise at given snr levels

% Input:
% sig - vector with signal
% noi - vector with noise
% snr_val - vector with snr-levels [dB]
%
% Output:
% out_mat : Matrix with noisy signals at all requested snr's. Row i
% contains noisy signal at snr-level requested by snr_val(i).
%
% Example
% sig = [-0.2, 0.4 ..]; line vector containing signal
% noi = [0.1, 0.2,..]; line vector containing noise
% snr_val = [20, 10]; snr-levels in dB
% [out_mat] = snr_fun(sig, noi, snr_val)

function [out_mat] = snr_fun(sig, noi, snr_val)

% Loop over requested snr-levels
for i=1:1:length(snr_val)
    
    % Get current SNR value
    snr_mod = snr_val(i); 
    
    % Get amplification factor for signal. Using power snr method.
    log_amp = snr_mod/10 + log10(mean(noi.^2)) - log10(mean(sig.^2));
    amp_factor = sqrt(10^log_amp);
    out_mat(i,:) = sig.*amp_factor + noi;
    
    % Verification step
    deb = round(snr(sig.*amp_factor, noi));
    assert(deb == snr_mod,'Critical: SNR is not correct.')
    
    % Output, Normalization -1 to 1
    out_mat(i,:) = out_mat(i,:)/max(abs(out_mat(i,:)));
end
