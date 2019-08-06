clear;clc;close all;

%%  SIRV-based PolSAR dual-domain filter 
% The algorithm was designed and written by Yexian Ren (2018-3-1~4-1 V0.5 2018-4-30 V1) 
% More details can be referred to the paper 
% Ren et al. "SIRV-Based High-Resolution PolSAR Image Speckle Suppression via Dual-Domain Filtering" ,IEEE Trans. Geosci. Remote Sens. 
% If you have any comments, or questions, please contact Yexian Ren at renyexian@foxmail.com
% or QQ:2538715345

% main function
%% load PolSAR data
% T3mat = cat(3,T11,T12_real,T12_imag,T13_real,T13_imag,T22,T23_real,T23_imag,T33);
load T3mat
z = fPauliImShow(T3mat);
imwrite(z,'T3mat.tif','tiff','Resolution',300);
% z = fPolRGBshow(T3mat,5);
% imwrite(z,'T3mat.tif','tiff','Resolution',300);

%% set parameters
% window radius
r = 7;%fixed

% Please select some representative areas to calculate the cut-off threshold
% x and y are the top left corner locations of the selected non-textured homogeneous regions
% and then a 15*15 window is opened to calculate the cut-off threshold.
x=[34,73,44,104]';
y=[195,40,260,47]';%Input coordinates of non-textured homogeneous regions
alpha = 0.6;%fixed

% Parameter for SAR-POTDF
% theoretic ENL = 3*the number of the looks of the original PolSAR data
% empirical value
look = 4; %real number of the looks of the original PolSAR data
if look == 1
    L = 2.75;%fixed
elseif look == 4
    L = 7.5;
    %It may need to be adjusted according to the real multi-look SAR data
end

%% -----initial estimation------
% Stage 1: initial estimation
% patchSIRVestimator:approximate 3*3 SIRV estimator
[Mmat_prior,Pmat0] = patchSIRVestimator(T3mat);
Pmat_prior = SAR_POTDF(Pmat0,'ENL',L);
% determination of cut-off threshold
th_d = GetThreshold(x,y,Mmat_prior,Pmat_prior,alpha);

%% ----- dual-domain filtering----
% Stage 2: polarimetric domain filtering
[Mmat_dd,Pmat1,diedai_num2] = NL_SIRV(T3mat,Mmat_prior,Pmat_prior,th_d,r,alpha);

% Stage 3; texture domain filtering
Pmat_dd = SAR_POTDF(Pmat1,'ENL',L);

% reconstruct the T3 matrix
T3mat_dd = repmat(Pmat_dd,1,1,9)./3.*Mmat_dd;

%% experimental data storage
save Mmat_dd Mmat_dd
z = fPolRGBshow(Mmat_dd,5);
imwrite(z,'Mmat_dd.tif','tiff','Resolution',300);

save Pmat_dd Pmat_dd
z = fIntensityshow(Pmat_dd,5);
imwrite(z,'Pmat_dd.tif','tiff','Resolution',300);

save T3mat_dd T3mat_dd
% z = fPolRGBshow(T3mat_dd,5);
% imwrite(z,'T3mat_dd.tif','tiff','Resolution',300);
z = fPauliImShow(T3mat_dd);
imwrite(z,'T3mat_dd_2.tif','tiff','Resolution',300);

%%  simple evaluation
[ratio,enl2,entropy,alpha,A,y] = basis_filter_evaluate(T3mat,T3mat_dd,2);
