%% step3: Manually select the pores, upon running the program a window will open with scatter plots. Select the pores as rectangle. 
%% Double click inside the rectangle to save a pore. Repeat the process until you are done selecting all the pores. Once you
%% are done save the picture and then close the figure. This will show an error in the end but ignore it.
function separate_pores
clc
clear
fold_name='C:\G Drive Back Up\TAMHSC\Figure for ms\Programs to upload\Pore\11192020\cell2\red3\';
file_name='roi_all_combine';
pixel_size=11.8;
all=load([fold_name file_name '.txt']);
id=all(:,1);
fr=all(:,2);
xx=all(:,3);
yy=all(:,4);
zz=all(:,5);
sig1=all(:,6);
sig2=all(:,7);
int=all(:,8);
offset=all(:,9);
bkgstd=all(:,10);
uncert=all(:,11);
set(gca,'fontsize',16)
plot(xx,yy,'b.')
k=1;
button=1;
while button==1
%% select rectangular
h=imrect;
position=wait(h)
rectangle('position',[position(1),position(2),position(3),position(4)],'edgecolor','g');
text(round(position(1))+44,round(position(2))+44,num2str(k),'color','r');
[i,j]=find(xx>position(1) & xx<position(1)+position(3) & yy>position(2) & yy<position(2)+position(4)); % finding the spots you select as elliptical boxes
id_roi=id(i);
fr_roi=fr(i)
x_roi=xx(i)*pixel_size;
y_roi=yy(i)*pixel_size;
z_roi=zz(i);
sig1_roi=sig1(i);
sig2_roi=sig2(i);
int_roi=int(i);
offset_roi=offset(i);
bkgstd_roi=bkgstd(i);
uncert_roi=uncert(i);
pore=[id_roi,fr_roi,x_roi,y_roi,z_roi,sig1_roi,sig2_roi,int_roi,offset_roi,bkgstd_roi,uncert_roi];
save([fold_name num2str(k) 'cluster.txt'],'-ascii','-TABS','pore');
k=k+1;
end
end