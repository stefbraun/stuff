% test snr function

sig = sin(0:0.1:10);
noi = 0.1*sin(5*[0:0.1:10]);
snr_val = 10;

out_mat = snr_fun(sig, noi, snr_val);
csum = round(sum(out_mat), 4);
assert(csum == 13.8264)