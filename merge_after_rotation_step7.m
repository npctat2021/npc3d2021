% Merges all the data from all clusters
function merge_after_rotation_step7
clc
clear
fold_name='C:\G Drive Back Up\TAMHSC\Figure for ms\Programs to upload\Pore\11192020\cell2\red3\unfixed fit\Pore rotation\';
file_name='pore';
file_name1=' pore_rotated';
num_pore=8; %for total how many pores you want
pore_all_z_center=load([fold_name file_name 'z_center.txt']);
pore_all_x_center=load([fold_name file_name 'x_center.txt']);
pore_all_y_center=load([fold_name file_name 'y_center.txt']);
pore=[];
for i=1:num_pore
    pore1=load([fold_name num2str(i) file_name1 '.txt']);
    pore=[pore;pore1];
end
save([fold_name 'pore_merged_rotated.txt'],'-ascii','-TABS','pore');
end