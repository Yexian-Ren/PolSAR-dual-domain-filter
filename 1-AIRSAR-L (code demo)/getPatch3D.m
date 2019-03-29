function Patch3D = getPatch3D(T3mat)

[m, n, ch] = size(T3mat);
N = m*n;

T3mat2 = padarray(T3mat,[1 1],'symmetric');

p11 = T3mat2(1:end-2,1:end-2,:);
d11 = reshape(p11,N,9);
p12 = T3mat2(1:end-2,2:end-1,:);
d12 = reshape(p12,N,9);
p13 = T3mat2(1:end-2,3:end,:);
d13 = reshape(p13,N,9);

p21 = T3mat2(2:end-1,1:end-2,:);
d21 = reshape(p21,N,9);
p22 = T3mat;
d22 = reshape(p22,N,9);
p23 = T3mat2(2:end-1,3:end,:);
d23 = reshape(p23,N,9);

p31 = T3mat2(3:end,1:end-2,:);
d31 = reshape(p31,N,9);
p32 = T3mat2(3:end,2:end-1,:);
d32 = reshape(p32,N,9);
p33 = T3mat2(3:end,3:end,:);
d33 = reshape(p33,N,9);

Patch3D = cat(3,d11,d12,d13,d21,d22,d23,d31,d32,d33);

end