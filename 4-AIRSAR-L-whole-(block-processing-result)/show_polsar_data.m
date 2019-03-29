
% show the result of the dual-domain filter 

load T3mat_dd
% Remark:T3mat = cat(3,T11,T12_real,T12_imag,T13_real,T13_imag,T22,T23_real,T23_imag,T33);
z = fPauliImShow(T3mat_dd);
imwrite(z,'T3mat_dd_2.tif','tiff','Resolution',300);