%step-2: Transforms the green channel coordinates into the red channel coordinate system
function green_localization_in_red_channel
clc
clear
b=-18; % difference between mean z value of red and green channel
fold_name='C:\G Drive Back Up\TAMHSC\Figure for ms\Programs to upload\Track\green3\';
file_name='spots_photon_filtered';
all_green=load([fold_name file_name '.txt']);
transfer_mat=load([fold_name 'g2r_transfer_matrix.txt']);
id=all_green(:,1);
fr=all_green(:,2);
x=all_green(:,3);
y=all_green(:,4);
z=all_green(:,5);
sig1=all_green(:,6);
sig2=all_green(:,7);
int=all_green(:,8);
offset=all_green(:,9);
bkgstd=all_green(:,10);
uncert=all_green(:,11);
x_calib=((x.*transfer_mat(1,1))+(y.*transfer_mat(2,1)))+transfer_mat(3,1);
y_calib=((x.*transfer_mat(1,2))+(y.*transfer_mat(2,2)))+transfer_mat(3,2);
z_calib=z+b;
all_green_calib=[id,fr,x_calib,y_calib,z_calib,sig1,sig2,int,offset,bkgstd,uncert];
save([fold_name file_name '_calib.txt'],'-ascii','-TABS','all_green_calib');
end
