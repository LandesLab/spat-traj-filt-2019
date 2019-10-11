% Variable "trjR" should be in the workspace before running this script.
% This variable should be in the form of the output array from Troika,
% where the dimension are 1:Frame #, 2:[x,y,Gwidth], 3:Trajectory #
thd_r =0.34 ; % threshold for filtering pixel size is 64 nm 
trjBin = squeeze(trjR(:,1,:) ~= 0);
trj2 = trjR(:,:,sum(trjBin,1)> 3); % Eliminate all single-frame occurences

[disps,t0s] = trjR_displacements(trj2);

overthd = cellfun(@(xxx)sum(xxx > thd_r)/size(xxx,1),disps);

trjOver = trj2(:,:,overthd~=0);
trjUnder = trj2(:,:,overthd==0);
%Display figure
figure
histogram(overthd,'BinWidth',0.05)
title([num2str(sum(overthd ~=0)/numel(overthd)),'% trj over thd = ',num2str(thd_r)])
xlabel('Fraction of steps in a trj outside thd')
ylabel('Occurrences')
