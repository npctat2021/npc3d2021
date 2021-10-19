% Calculation of the angle (0-90º) of each point in a pore relative to the centroid
function pore_rotation_step1
clc
clear
fold_name='C:\G Drive Back Up\TAMHSC\Figure for ms\Programs to upload\Pore\11192020\cell2\red3\unfixed fit\Pore rotation\';
file_name1='porebisquare';
file_name2='porex_center';
file_name3='porey_center';
pore_center_x=load([fold_name file_name2 '.txt']);
pore_center_y=load([fold_name file_name3 '.txt']);
num_pore=8; % number of pores being analyzed
for l=1:1:num_pore
data_pore=load([fold_name num2str(l) file_name1 '.txt']);
x=data_pore(:,3);
y=data_pore(:,4);
int=data_pore(:,8);
x_centered=x-pore_center_x(l);
y_centered=y-pore_center_y(l);
rot_ninety=atan(y_centered./x_centered).*(180/pi);
pore_ninety_normalized=[rot_ninety,int];
save([fold_name num2str(l) 'pore_ninety_normalized.txt'],'-ascii','-TABS','pore_ninety_normalized');
end
end