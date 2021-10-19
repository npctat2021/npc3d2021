%step-3: Identifies all cargo localizations within a 400 nm cube centered on an NPC centroid
function track_localize_whole_roi
clc
clear
fold_name='C:\G Drive Back Up\TAMHSC\Figure for ms\Programs to upload\Track\green3\';
file_name='spots_photon_filtered_calib';
half_thickness=200; % half thickness of the pore
radius_error=200; % radius+uncertainty
num_pore=25; % total number pores you picked
all_track_calibrated=load([fold_name file_name '.txt']);
z=all_track_calibrated(:,5);
x_center=load([fold_name 'porex_center.txt']);
y_center=load([fold_name 'porey_center.txt']);
z_center=load([fold_name 'porez_center.txt']);
for i=1:num_pore 
   % first filtering
   ind1=find(z>z_center(i)-half_thickness & z<z_center(i)+half_thickness);
   track1=all_track_calibrated(ind1,:);
   xx=track1(:,3);
   % second filtering
   ind2=find(xx>x_center(i)-radius_error & xx<x_center(i)+radius_error);
   track2=track1(ind2,:);
   yy=track2(:,4);
   % third filtering
   ind3=find(yy>y_center(i)-radius_error & yy<y_center(i)+radius_error);
   track3=track2(ind3,:);
save([fold_name 'track to whole' num2str(i) '.txt'],'-ascii','-TABS','track3');
end
end