%step-5: Translate center of pores to (x,y,z=0,0,0)
function centering_pore_step5
clc
clear
fold_name='C:\G Drive Back Up\TAMHSC\Figure for ms\Programs to upload\Pore\11192020\cell2\red3\unfixed fit\Pore rotation\';
file_name='pore';
file_name1='porebisquare';
num_pore=8; %for total how many pores you want
pore_all_z_center=load([fold_name file_name 'z_center.txt']);
pore_all_x_center=load([fold_name file_name 'x_center.txt']);
pore_all_y_center=load([fold_name file_name 'y_center.txt']);
for i=1:num_pore
    pore=load([fold_name num2str(i) file_name1 '.txt']);
    id=pore(:,1);fr=pore(:,2);x=pore(:,3);y=pore(:,4);z=pore(:,5);sig1=pore(:,6);sig2=pore(:,7);
    int=pore(:,8);offset=pore(:,9);bkgstd=pore(:,10);uncert=pore(:,11);
    x_centered=x-pore_all_x_center(i);
    y_centered=y-pore_all_y_center(i);
    z_centered=z-pore_all_z_center(i);
    pore_centered=[id,fr,x_centered,y_centered,z_centered,sig1,sig2,int,offset,bkgstd,uncert];
    save([fold_name num2str(i) 'pore_centered.txt'],'-ascii','-TABS','pore_centered');
    end
end