%% Determines the angle of rotation for the cluster by fitting the angle distribution histogram  
%% to a sinusoidal function with a period of 45° and a variable phase
function pore_rotation_step4_fitting
clc
clear
fold_name='C:\G Drive Back Up\TAMHSC\Figure for ms\Programs to upload\Pore\11192020\cell2\red3\unfixed fit\Pore rotation\';
file_name='phase_norm';
func=inline('9^(-1)+20.6^(-1)*cosd(8*(x-p))','p','x');
num_pore=8; % This is the total number of pores you have analyzed
theo=0:0.1:45;
for w=1:1:num_pore
pore_rot=load([fold_name num2str(w) file_name '.txt']);
phase=pore_rot(:,1);
frequency=pore_rot(:,2);
%% Fitting
angl(w)=lsqcurvefit(func,10,phase,frequency);
if angl(w)<0
    angle(w)=angl(w)+45;
else
    angle(w)=angl(w);
end
ang=angle(w)
phase_theo=func(ang,theo);
plot(phase,frequency,'or',theo,phase_theo,'b')
set(gca,'FontSize',20)
xlabel('angle (degree)','FontSize',20)
ylabel('frequency','FontSize',20)
pause(1)
close
end
rotation=angle';
save([fold_name 'rot_angle.txt'],'-ascii','-TABS','rotation');
end