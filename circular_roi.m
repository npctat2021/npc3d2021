%% step2: this program picks the rings of nuclear pore from all localization points. This will take a previously saved file wherein the
%% the clustered region informations are stored. In each step of this program you will pick one clustered regions, followed by one click and drawing
%% an ellipse on top of the localized spots. You can resize the ellipse to make it nearly circle if you want and also you can drag it to place 
%% you want. When you are done with placing it properly, double click inside the ellipse to save the position of the ellipse and the points within
%% this ellipse will be automatically saved. Press 1/right click to go to the next clustered region and repeat the same process. Repeat the whole
%% process until you scan all clustered regions. If you don't want to pick a particular clustered region just press 1/right click to go the next.
%% pixel-grid is shown in the plot for the sake of adjusting the size of the ellipse
function circular_roi
clc
clear
pixel_size=11.8; % 10X zoom is applied to make cluster picking easy
fold_name='C:\G Drive Back Up\TAMHSC\Figure for ms\Programs to upload\Pore\11192020\cell2\red3\';
clust_positions=load([fold_name 'cluster details' '.txt']);
clust_x=clust_positions(:,3); % cluster position is x (pixel), pixel size set to 11.8 nm
clust_y=clust_positions(:,4); % cluster position is y (pixel), pixel size set to 11.8 nm
all_z=load([fold_name 'roi_photon_filtered' '.txt']);
xx=all_z(:,12); % column vector of centroid of detected spot in x (pixel), pixel size set to 11.8 nm 
yy=all_z(:,13); % column vector of centroid of detected spot in y (pixel), pixel size set to 11.8 nm
int=all_z(:,8); % column vector of intensity (photon) of detected spot
zz=all_z(:,5); % column vector of z (nm) of detected spots
ind=find(zz>-200 & zz<200); % provide a range in z for clean picture
roi_z_filtered=all_z(ind,:);
id=roi_z_filtered(:,1);
fr=roi_z_filtered(:,2);
zz1=roi_z_filtered(:,5); % this is filtered z values
sig1=roi_z_filtered(:,6);
sig2=roi_z_filtered(:,7);
int1=roi_z_filtered(:,8); % this ia a column vector of x-width values (nm) of detected spots
offset=roi_z_filtered(:,9);
bkgstd=roi_z_filtered(:,10);
uncert=roi_z_filtered(:,11);
xx1=roi_z_filtered(:,12); % this ia a column vector of x values (pixel) of detected spots
yy1=roi_z_filtered(:,13); % this ia a column vector of y values (pixel) of detected spots
roi_all_combine=[];  
for k=1:1:length(clust_x)
x1=clust_x(k)
y1=clust_y(k)
button=1;
while button==1
hold off
set(gca,'fontsize',16)
plot(xx1,yy1,'b.')
xlim([x1-20 x1+20])
ylim([y1-20 y1+20])
xlabel('X Axis (pixels)','fontsize',16);
ylabel('Y Axis (pixels)','fontsize',16);
grid on
% axis equal
title([num2str(k)]);
[xp,yp,bt]=ginput(1);
button=bt;
if button==1
%% select rectangular
h=imellipse;
position=wait(h);
if position(3)==0  %% double click to end
    close;
    break;
end
ellipse_x=position(:,1); % all x-points under the ellipse you drawn
ellipse_y=position(:,2); % all y-points under the ellipse you drawn
pos1=min(ellipse_x);pos2=max(ellipse_x);pos3=min(ellipse_y);pos4=max(ellipse_y);
[i,j]=find(xx1>pos1 & xx1<pos2 & yy1>pos3 & yy1<pos4); % finding the spots you select as elliptical boxes
id_roi=[];
fr_roi=[];
x_roi=[];
y_roi=[];
z_roi=[];
sig1_roi=[];
sig2_roi=[];
int_roi=[];
offset_roi=[];
bkgstd_roi=[];
uncert_roi=[];
k=1;
for w=1:1:length(i) % length(i) is the number of spots you select as elliptical boxes
    id_roi1=id(i(w));
    fr_roi1=fr(i(w));
x_roi(k)=xx1(i(w));
y_roi(k)=yy1(i(w));
z_roi(k)=zz1(i(w));
sig1_roi(k)=sig1(i(w));
sig2_roi(k)=sig2(i(w));
int_roi(k)=int1(i(w));
offset_roi(k)=offset(i(w));
bkgstd_roi(k)=bkgstd(i(w));
uncert_roi(k)=uncert(i(w));
k=k+1;
id_roi=[id_roi,id_roi1];
fr_roi=[fr_roi,fr_roi1];
end
plot(x_roi,y_roi,'b.'); % why the y-values were made (-)ve in the plot
xlabel('X Axis (pixel)')
ylabel('Y Axis(pixel)')
pause(3)
roi_all=[id_roi',fr_roi',x_roi',y_roi',z_roi',sig1_roi',sig2_roi',int_roi',offset_roi',bkgstd_roi',uncert_roi']
roi_all_combine=[roi_all_combine;roi_all];
end
end
end
%% eliminating points which may have counted multiple times
[Mu,ia,ic]=unique(roi_all_combine, 'rows', 'stable'); % Mu is a list of all unique points
save([fold_name 'roi_all_combine.txt'],'-ascii','-TABS','Mu');
end
