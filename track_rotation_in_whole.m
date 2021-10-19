%%Step5: Rotates cargo localizations based on the phase angle of the cluster
function track_rotation_in_whole
clc
clear
fold_name='C:\G Drive Back Up\TAMHSC\Figure for ms\Programs to upload\Track\green3\';
file_name='track_cen_wrt_whole';
file_name2='rot_angle';
angle=load([fold_name file_name2 '.txt']);
num_pore=25; % total number pores you picked
for w=1:1:num_pore
track_raw=load([fold_name file_name num2str(w) '.txt']);
if isempty(track_raw)==1
    all=[];
else
id=track_raw(:,1);
fr=track_raw(:,2);
x=track_raw(:,3);
y=track_raw(:,4);
z=track_raw(:,5);
sig1=track_raw(:,6);
sig2=track_raw(:,7);
int=track_raw(:,8);
offset=track_raw(:,9);
bkgstd=track_raw(:,10);
uncert=track_raw(:,11);
xx=x.*cosd(angle(w))+y.*sind(angle(w));
yy=-x.*sind(angle(w))+y.*cosd(angle(w));
all=[id,fr,xx,yy,z,sig1,sig2,int,offset,bkgstd,uncert];
end
save([fold_name 'track to whole rotated' num2str(w) '.txt'],'-ascii','-TABS','all');
end
end