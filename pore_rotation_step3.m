% Determines the angle distribution histogram (0-45º) of the localizations in each cluster with a bin of 5º
function pore_rotation_step3
clc
clear
fold_name='C:\G Drive Back Up\TAMHSC\Figure for ms\Programs to upload\Pore\11192020\cell2\red3\unfixed fit\Pore rotation\';
file_name='pore_fortyfive';
num_pore=8;
bin_center=[2.5:5:42.5];
bin_start=[0:5:40]';
bin_end=[5:5:45]';
for l=1:1:num_pore
pore_fortyfive=load([fold_name num2str(l) file_name '.txt']);
fortyfive=pore_fortyfive(:,1);
int_rel=pore_fortyfive(:,2);
    p(1)=length(fortyfive(find(fortyfive>=bin_start(1) & fortyfive<bin_end(1))));
    p(2)=length(fortyfive(find(fortyfive>=bin_start(2) & fortyfive<bin_end(2))));
    p(3)=length(fortyfive(find(fortyfive>=bin_start(3) & fortyfive<bin_end(3))));
    p(4)=length(fortyfive(find(fortyfive>=bin_start(4) & fortyfive<bin_end(4))));
    p(5)=length(fortyfive(find(fortyfive>=bin_start(5) & fortyfive<bin_end(5))));
    p(6)=length(fortyfive(find(fortyfive>=bin_start(6) & fortyfive<bin_end(6))));
    p(7)=length(fortyfive(find(fortyfive>=bin_start(7) & fortyfive<bin_end(7))));
    p(8)=length(fortyfive(find(fortyfive>=bin_start(8) & fortyfive<bin_end(8))));
    p(9)=length(fortyfive(find(fortyfive>=bin_start(9) & fortyfive<bin_end(9)))); 
    p1=p./sum(p);
    phase_unnorm=[bin_center',p1'];
    save([fold_name num2str(l) 'phase_unnorm.txt'],'-ascii','-TABS','phase_unnorm');
    %%% Photon Normalized
    pn1=find(fortyfive>=bin_start(1) & fortyfive<bin_end(1));
    pn2=find(fortyfive>=bin_start(2) & fortyfive<bin_end(2));
    pn3=find(fortyfive>=bin_start(3) & fortyfive<bin_end(3));
    pn4=find(fortyfive>=bin_start(4) & fortyfive<bin_end(4));
    pn5=find(fortyfive>=bin_start(5) & fortyfive<bin_end(5));
    pn6=find(fortyfive>=bin_start(6) & fortyfive<bin_end(6));
    pn7=find(fortyfive>=bin_start(7) & fortyfive<bin_end(7));
    pn8=find(fortyfive>=bin_start(8) & fortyfive<bin_end(8));
    pn9=find(fortyfive>=bin_start(9) & fortyfive<bin_end(9));
    int(1)=sum(int_rel(pn1));
    int(2)=sum(int_rel(pn2));
    int(3)=sum(int_rel(pn3));
    int(4)=sum(int_rel(pn4));
    int(5)=sum(int_rel(pn5));
    int(6)=sum(int_rel(pn6));
    int(7)=sum(int_rel(pn7));
    int(8)=sum(int_rel(pn8));
    int(9)=sum(int_rel(pn9));
    total_int=sum(int);
    int_normalized=int./total_int;
    phase_normalized=[bin_center',int_normalized'];
    save([fold_name num2str(l) 'phase_norm.txt'],'-ascii','-TABS','phase_normalized');
end
end