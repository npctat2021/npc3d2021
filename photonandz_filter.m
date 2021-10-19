%% Step1: Applying photon and z filter
function photonandz_filter
clc
clear
pixel_size=11.8; %% unit nm
fold_name='C:\G Drive Back Up\TAMHSC\Figure for ms\Programs to upload\Pore\11192020\cell2\red3\';
all=load([fold_name 'raw image data' '.csv']); % this is the data table obtained from thunderstorm
zz=all(:,5); % column vector of z (nm)
int=all(:,8); % column vector of intensity (photon)
ind=find(zz>-300 & zz<300); % provide a range in z for clean picture
roi_z_filtered=all(ind,:);
int1=roi_z_filtered(:,8); % column vector of intensity (photon)
ind2=find(int1>3000);
roi_z_filtered_photon=roi_z_filtered(ind2,:);
save([fold_name 'roi_photon_filtered.txt'],'-ascii','-TABS','roi_z_filtered_photon');
end
