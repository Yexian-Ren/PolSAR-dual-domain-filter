function Patch2D = getPatch2D(pic)

[m, n] = size(pic);
N = m*n;

pic2 = padarray(pic,[1 1],'symmetric');

p11 = pic2(1:end-2,1:end-2);
d11 = reshape(p11,N,1);
p12 = pic2(1:end-2,2:end-1);
d12 = reshape(p12,N,1);
p13 = pic2(1:end-2,3:end);
d13 = reshape(p13,N,1);

p21 = pic2(2:end-1,1:end-2);
d21 = reshape(p21,N,1);
p22 = pic;
d22 = reshape(p22,N,1);
p23 = pic2(2:end-1,3:end);
d23 = reshape(p23,N,1);

p31 = pic2(3:end,1:end-2);
d31 = reshape(p31,N,1);
p32 = pic2(3:end,2:end-1);
d32 = reshape(p32,N,1);
p33 = pic2(3:end,3:end);
d33 = reshape(p33,N,1);

Patch2D = [d11,d12,d13,d21,d22,d23,d31,d32,d33];

end