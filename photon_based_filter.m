%step-1: Retains only those localizations for which the photon count was ≥ 1000
function photon_based_filter
clc
clear
fold_name='C:\G Drive Back Up\TAMHSC\Figure for ms\Programs to upload\Track\green3\';
file_name='all green spots';
all_spots=load([fold_name file_name '.csv']);
int=all_spots(:,8);
   ind=find(int>1000);
   spots_filtered=all_spots(ind,:);
save([fold_name 'spots_photon_filtered.txt'],'-ascii','-TABS','spots_filtered');
end