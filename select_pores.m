% Step5:selecting cluster as good NPCs based on their height and diameter
% and number of points in a cluster
function select_pores
clc
clear
fold_name='C:\G Drive Back Up\TAMHSC\Figure for ms\Programs to upload\Pore\11192020\cell2\red3\unfixed fit\';
file_name='cluster';
file_name1='clusterheight';
file_name2='clusterdiameter';
file_name3='clusterz_center';
file_name4='clusterx_center';
file_name5='clustery_center';
file_name6='pore';
height=load([fold_name file_name1 '.txt']);
diameter=load([fold_name file_name2 '.txt']);
z_center=load([fold_name file_name3 '.txt']);
x_center=load([fold_name file_name4 '.txt']);
y_center=load([fold_name file_name5 '.txt']);
num_cluster=22; % number of clusters you analyzed
cluster_sel=[];
for i=1:1:num_cluster
    cl=load([fold_name num2str(i) file_name '.txt']);
    num_pt=length(cl(:,1));
    if height(i)>40 && height(i)<65 && diameter(i)>80 && diameter(i)<135 && z_center(i)>-200 && z_center(i)<200 && num_pt>9
       cluster_sel1=i;
    else
    cluster_sel1=[];
    end
    cluster_sel=[cluster_sel;cluster_sel1]
end
x=[];
y=[];
z=[];
d=[];
h=[];
for j=1:1:length(cluster_sel)
    k=cluster_sel(j);
    pore=load([fold_name num2str(k) file_name '.txt']);
    hei=height(k);
    dia=diameter(k);
    z_cen=z_center(k);
    x_cen=x_center(k);
    y_cen=y_center(k);
    h=[h;hei];
    d=[d;dia];
    z=[z;z_cen];
    x=[x;x_cen];
    y=[y;y_cen];
    save([fold_name num2str(j) 'pore.txt'],'-ascii','-TABS','pore');
end
save([fold_name file_name6 'height.txt'],'-ascii','-TABS','h');
save([fold_name file_name6 'diameter.txt'],'-ascii','-TABS','d');
save([fold_name file_name6 'x_center.txt'],'-ascii','-TABS','x');
save([fold_name file_name6 'y_center.txt'],'-ascii','-TABS','y');
save([fold_name file_name6 'z_center.txt'],'-ascii','-TABS','z');
end