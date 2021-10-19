% Calculation of the angle (0-45º) of each point in a pore in a cluster relative to the centroid
function pore_rotation_step2
clc
clear
fold_name='C:\G Drive Back Up\TAMHSC\Figure for ms\Programs to upload\Pore\11192020\cell2\red3\unfixed fit\Pore rotation\';
file_name='pore_ninety_normalized';
num_pore=8;
for l=1:1:num_pore
data_pore_ninety=load([fold_name num2str(l) file_name '.txt']);
ninety=data_pore_ninety(:,1);
int_rel=data_pore_ninety(:,2)./3000;
fortyfive=[];
for m=1:1:length(ninety)
    if ninety(m)<-45
        fortyfive(m)=ninety(m)+90;
    elseif ninety(m)>=-45 && ninety(m)<0
        fortyfive(m)=ninety(m)+45;
    elseif ninety(m)>=0 && ninety(m)<45
        fortyfive(m)=ninety(m);
    elseif ninety(m)>=45
        fortyfive(m)=ninety(m)-45;
    else
        fortyfive(m)=0;
    end
end
fortyfive=fortyfive';
    pore_fortyfive=[fortyfive,int_rel];
    save([fold_name num2str(l) 'pore_fortyfive.txt'],'-ascii','-TABS','pore_fortyfive');
end
end