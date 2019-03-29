function th_d = GetThreshold(x,y,Mprior,Pprior,alpha)

% Open 15*15 window in a selected non-texture region  to determine the approximate value of the threshold.
% You can choose several different regions to calculate the mean value of the threshold.

%% input:
% x,y: coordinates of the upper left corner of square window
% Mprior; normalized coherence matrix prior , (m*n)*9
% Pprior: texture prior, (m*n)
% alpha: the mixing ratio of polarization information and texture

%% output:
% th_d; the cut_off threshold for polarimetric domain filtering

%% initialization
lx = length(x);
th_tmp = zeros(lx,1);

%%
for i0 = 1:lx
    M = Mprior(x(i0):x(i0)+14,y(i0):y(i0)+14,:);
    P = Pprior(x(i0):x(i0)+14,y(i0):y(i0)+14);
    
    [m,n] = size(P);
    N = m*n;
    Laplace_d = zeros(N,N);
    
    Ppatch2 = getPatch2D(P);
    Mpatch2 = getPatch3D(M);
    
    for i1 = 1:N
        Mpatch1 = repmat(Mpatch2(i1,:,:),N,1,1);
        Ppatch1 = repmat(Ppatch2(i1,:,:),N,1,1);
        d = patchSDsirv6(Mpatch1,Mpatch2,Ppatch1,Ppatch2,alpha);
        Laplace_d(:,i1) = d;
    end
    
    data = sort(Laplace_d(:));
    N2 = length(data);
    th_tmp(i0) = data(round(0.9*N2));
    
end

% If the selected areas are homogeneous regions of the same kind of object
% th_d = mean(th_tmp);

%If the selected objects are homogeneous regions of different types of objects
th_d = max(th_tmp);

end