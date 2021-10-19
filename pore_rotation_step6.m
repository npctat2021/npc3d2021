%% Rotates every point in a cluster by its phase angle
function pore_rotation_step6
clc
clear
fold_name='C:\G Drive Back Up\TAMHSC\Figure for ms\Programs to upload\Pore\11192020\cell2\red3\unfixed fit\Pore rotation\';
file_name='pore_centered';
file_name2='rot_angle';
angle=load([fold_name file_name2 '.txt']);
num_pore=8; % This is the total number of pores you have analyzed
for w=1:1:num_pore
pore_raw=load([fold_name num2str(w) file_name '.txt']);
id=pore_raw(:,1);
fr=pore_raw(:,2);
x=pore_raw(:,3);
y=pore_raw(:,4);
z=pore_raw(:,5);
sig1=pore_raw(:,6);
sig2=pore_raw(:,7);
int=pore_raw(:,8);
offset=pore_raw(:,9);
bkgstd=pore_raw(:,10);
uncert=pore_raw(:,11);
xx=x*cosd(angle(w))+y*sind(angle(w));
yy=-x*sind(angle(w))+y*cosd(angle(w));
all=[id,fr,xx,yy,z,sig1,sig2,int,offset,bkgstd,uncert];
save([fold_name num2str(w) ' pore_rotated.txt'],'-ascii','-TABS','all');
end
end