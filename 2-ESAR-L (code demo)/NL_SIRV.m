function [Mmat,Pmat,diedai_num2] = NL_SIRV(T3mat,Mmat0,Pmat0,th_d,r,alpha)

% initialization
[m n ch]=size(T3mat);
Mmat = zeros(m,n,ch);
Pmat = zeros(m,n);

% iterations of fixed-point
diedai_num2 = zeros(m,n);
% number of screened samples
select_num = zeros(m,n);

% get patches
Patch3 = getPatch3D(T3mat);
MMPatch3 = getPatch3D(Mmat0);
PPPatch2 = getPatch2D(Pmat0);

x = waitbar(0,'polarimetric domain filtering');

for ii=1:m
    waitbar(ii/m)
    for jj=1:n
        
        % Find all the samples of the search window
        x1 = max(1,ii-r);
        x2 = min(m,ii+r);
        y1 = max(1,jj-r);
        y2 = min(n,jj+r);
        
        IndexSetX = repmat([x1:1:x2]',1,(y2-y1+1));
        IndexSetY = repmat([y1:1:y2],(x2-x1+1),1);
        
        Index = sub2ind([m,n],IndexSetX,IndexSetY);
        Index = Index(:);
        
        tmp1_Patch = Patch3(Index,:,:);
        
        %Cen_Patch = Patch3(sub2ind([m,n],ii,jj),:,:);
        Mcen_patch = MMPatch3(sub2ind([m,n],ii,jj),:,:);
        Mpatch2 = MMPatch3(Index,:,:);
        
        Pcen_patch = PPPatch2(sub2ind([m,n],ii,jj),:);
        Ppatch2 = PPPatch2(Index,:);
        
        [tmp2_Patch,select_num(ii,jj)] = Patch_match(th_d,Mcen_patch,Mpatch2,Pcen_patch,Ppatch2,tmp1_Patch,alpha);

        T3data = tmp2_Patch(:,:,5);

        [Mmat(ii,jj,:),Pmat(ii,jj),diedai_num2(ii,jj)] = dataSIRVestimator(T3mat(ii,jj,:),T3data);
        
    end
end

close(x)

%save select_num select_num
figure
imshow(select_num)
title('the number of samples')
colormap(jet)
colorbar
set(gca,'CLim',[0,(2*r+1)*(2*r+1)]);

end

function [select_Patch,Select_Num] = Patch_match(th_d,Mcen_patch,Mpatch2,Pcen_patch,Ppatch2,Patch,alpha)

N = size(Ppatch2,1);

Mpatch1 = repmat(Mcen_patch,N,1);

Ppatch1 = repmat(Pcen_patch,N,1);

d = patchSDsirv6(Mpatch1,Mpatch2,Ppatch1,Ppatch2,alpha);

index = find(d<th_d);

if length(index)<3

[d2,ind] = sort(d);

index = ind(1); % index=ind(1:4); %force the estimated coherency matrix to be full rank

end

Select_Num = length(index);

select_Patch = Patch(index,:,:);

end








            
                
                   
                
                
                
 
                
 
 
