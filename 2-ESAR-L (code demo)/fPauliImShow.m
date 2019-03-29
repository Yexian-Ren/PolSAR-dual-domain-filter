function z = fPauliImShow(varargin)

data = varargin{1};
n = 2;
if nargin ==2
    n = varargin{2};
end

z(:,:,3) = data(:,:,1)./(mean2(data(:,:,1))*n);
z(:,:,1) = data(:,:,6)./(mean2(data(:,:,6))*n);
z(:,:,2) = data(:,:,9)./(mean2(data(:,:,9))*n);

figure;imshow(z);

